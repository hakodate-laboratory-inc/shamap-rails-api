# == Schema Information
#
# Table name: authorities
#
#  id         :bigint(8)        not null, primary key
#  authority  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :uuid             not null
#  v1_map_id  :uuid             not null
#
# Indexes
#
#  index_authorities_on_user_id                (user_id)
#  index_authorities_on_v1_map_id              (v1_map_id)
#  index_authorities_on_v1_map_id_and_user_id  (v1_map_id,user_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (v1_map_id => v1_maps.id)
#

require "rails_helper"

RSpec.describe Authority, type: :model do
  describe "Relation test" do
    let(:user) { FactoryBot.create(:user) }
    let(:map) { FactoryBot.create(:v1_map) }
    let(:authority) { FactoryBot.create(:authority, v1_map_id: map.id, user_id: user.id) }

    before do
      user.authorities << authority
    end
    context "relation exist" do
      it "user.maps is equal" do
        expect(user.maps.first).to eq(map)
      end
      it "map.users is equal" do
        expect(map.users.first).to eq(user)
      end
    end

    context "relation deleted" do
      before do
        user.authorities.destroy(authority)
      end
      it "user.maps is not found" do
        expect(user.maps.first).to eq(nil)
      end
      it "map.users is not found" do
        expect(map.users.first).to eq(nil)
      end
    end
  end
end
