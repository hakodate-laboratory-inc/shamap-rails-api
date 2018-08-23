# == Schema Information
#
# Table name: v1_maps
#
#  id          :uuid             not null, primary key
#  description :text             not null
#  slug        :string           not null
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_v1_maps_on_slug  (slug) UNIQUE
#

require "rails_helper"

RSpec.describe V1::Map, type: :model do
  let(:valid_attributes) {
    FactoryBot.attributes_for(:v1_map)
  }

  let(:invalid_attributes) {
    FactoryBot.attributes_for(:invalid_v1_map)
  }

  describe("Basic test") do
    it("is valid") do
      map = V1::Map.new(valid_attributes)
      expect(map).to be_valid
    end

    it("is invalid") do
      map = V1::Map.new(invalid_attributes)
      expect(map).to be_invalid
    end
  end
end
