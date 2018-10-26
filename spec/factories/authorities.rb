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

FactoryBot.define do
  factory :authority do
    v1_map nil
    user nil
    authority 1
  end
end
