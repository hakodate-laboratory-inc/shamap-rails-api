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

FactoryBot.define do
  factory :v1_map, class: 'V1::Map' do
    title "MyString"
    slug "MyString"
    description "MyText"
  end
end
