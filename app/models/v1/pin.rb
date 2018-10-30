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

  validate :images_validation

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

    def images_validation
      return unless self.images.attached?

      self.images.map do |img|
        next if img.blob.content_type.start_with?("image/")

        img.purge
        errors[:base] << "Wrong format"
      end
    end
end
