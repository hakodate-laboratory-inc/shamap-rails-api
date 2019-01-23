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

FactoryBot.define do
  factory :v1_pin, class: "V1::Pin" do
    user { FactoryBot.build(:user) }
    map { FactoryBot.build(:v1_map) }
    layer { FactoryBot.build(:v1_layer) }
    location "POINT(41.814490 140.757198)"
    context { JSON.generate({ text: "hello" }) } # rubocop:disable RSpec/EmptyExampleGroup
  end
end
