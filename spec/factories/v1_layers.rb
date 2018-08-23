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

FactoryBot.define do
  factory :v1_layer, class: "V1::Layer" do
    map { FactoryBot.build(:v1_map) }
    name "MyString"
    slug "MyString"
  end
end
