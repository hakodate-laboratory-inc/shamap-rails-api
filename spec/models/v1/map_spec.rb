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

require 'rails_helper'

RSpec.describe V1::Map, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
