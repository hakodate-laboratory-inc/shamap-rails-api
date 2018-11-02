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

require "rails_helper"

RSpec.describe V1::Pin, type: :model do
  describe "Validation test" do
    let(:pin) {FactoryBot.build(:v1_pin)}

    before do
      pin.context = {}
    end

    context "is success" do
      it "contain context.text" do
        pin.context = {"text": "contain"}
        expect(pin.valid?).to eq true
      end
      it "contain image" do
        pin.images = fixture_file_upload("files/test.jpg", "image/jpg")
        expect(pin.valid?).to eq true
      end
      it "contain context.text and image" do
        pin.context = {"text": "contain"}
        pin.images = fixture_file_upload("files/test.jpg", "image/jpg")
        expect(pin.valid?).to eq true
      end
    end

    context "is fail" do
      it "not contain context.text and image" do
        expect(pin.valid?).to eq false
      end
    end
  end
end
