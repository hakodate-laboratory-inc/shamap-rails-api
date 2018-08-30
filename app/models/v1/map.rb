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

class V1::Map < ApplicationRecord
  has_many :layers, class_name: "V1::Layer", inverse_of: "map", dependent: :destroy
  has_many :pins, class_name: "V1::Pin", inverse_of: "map", dependent: :destroy

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A\w+\z/ }, length: { in: 3..30 }
  validates :description, presence: true

  after_create :create_layer

  def to_param
    slug
  end

  private

    def create_layer
      V1::Layer.create(map: self, name: "main", slug: "main")
    end
end
