# == Schema Information
#
# Table name: v1_layers
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  map_id     :uuid
#
# Indexes
#
#  index_v1_layers_on_map_id  (map_id)
#  index_v1_layers_on_slug    (slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (map_id => v1_maps.id)
#

class V1::Layer < ApplicationRecord
  belongs_to :map, class_name: "V1::Map", inverse_of: "layers"

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
