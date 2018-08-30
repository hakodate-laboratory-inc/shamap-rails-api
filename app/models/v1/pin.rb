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

  def as_json(options = {})
    super(options.merge({
      methods: [:latlng, :image_url],
    }))
  end

  def latlng
    [self.location.x, self.location.y]
  end

  def image_url
    if self.images.attached?
      Rails.application.routes.url_helpers.rails_blob_path(self.images.first, only_path: true)
    else
      nil
    end
  end
end
