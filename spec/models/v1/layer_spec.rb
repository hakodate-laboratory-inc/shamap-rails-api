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
#  index_v1_layers_on_map_id           (map_id)
#  index_v1_layers_on_map_id_and_slug  (map_id,slug) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (map_id => v1_maps.id)
#

require "rails_helper"
require "faker"

RSpec.describe V1::Layer, type: :model do
  let(:map) {
    FactoryBot.create(:v1_map, slug: Faker::Address.country_code.downcase.delete(" "))
  }

  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_layer).merge(map_id: map.id)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:invalid_v1_layer).merge(map_id: map.id)
  }

  describe("Basic test") do
    it("is valid") do
      layer = V1::Layer.new(valid_attributes)
      expect(layer).to be_valid
    end

    it("is invalid") do
      layer = V1::Layer.new(invalid_attributes)
      expect(layer).to be_invalid
    end
  end
end
