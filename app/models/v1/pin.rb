# == Schema Information
#
# Table name: v1_pins
#
#  id         :uuid             not null, primary key
#  context    :jsonb            not null
#  location   :geometry({:srid= not null, point, 0
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  layer_id   :uuid
#  map_id     :uuid
#  user_id    :uuid
#
# Indexes
#
#  index_v1_pins_on_layer_id  (layer_id)
#  index_v1_pins_on_map_id    (map_id)
#  index_v1_pins_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (layer_id => v1_layers.id)
#  fk_rails_...  (map_id => v1_maps.id)
#  fk_rails_...  (user_id => users.id)
#

class V1::Pin < ApplicationRecord
  belongs_to :map, class_name: "V1::Map", inverse_of: "pins"
  belongs_to :layer, class_name: "V1::Layer", inverse_of: "pins"
  belongs_to :user
  has_many_attached :images

  validates :location, presence: true
  validate :context_validation
  validate :images_validation
  validate :context_or_image_validation

  def as_json(options = {})
    super(options.merge({
      methods: [:author, :latlng, :image_url],
    }))
  end

  def author
    {
      id: self.user.id,
      name: self.user.name,
    }
  end

  def latlng
    [self.location.x, self.location.y]
  end

  def image_url
    if self.images.attached?
      {
        full: Rails.application.routes.url_helpers.rails_representation_path(
          self.images.first.variant(auto_orient: true).processed,
          only_path: true,
        ),
        mini: Rails.application.routes.url_helpers.rails_representation_path(
          self.images.first.variant(resize: "500x500", auto_orient: true).processed,
          only_path: true,
        ),
      }
    else
      nil
    end
  end

  private

    def context_validation
      return if self.context.class == Hash

      begin
        self.context = JSON.parse self.context
      rescue
        self.context = {}
        errors[:context] << "context can't parse as json"
      end
    end

    def images_validation
      return unless self.images.attached?

      self.images.map do |img|
        next if img.blob.content_type.start_with?("image/")

        img.purge
        errors[:base] << "Wrong format"
      end
    end

    def context_or_image_validation
      unless images.attached? || context["text"].present?
        errors.add(:base, "Should be contain image or text")
      end
    end
end
