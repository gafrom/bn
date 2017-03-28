# == Schema Information
#
# Table name: products
#
#  id            :integer          not null, primary key
#  slug          :string
#  url           :string
#  title         :string
#  brand         :string
#  vendor        :string
#  category      :string
#  tags          :string
#  remote_id     :integer
#  weight        :integer
#  price         :integer
#  compare_price :integer
#  images        :string           default("{}"), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Product < ApplicationRecord
  before_create :set_slug

  validates :title, :url, :brand, :category, :price, presence: true
  validates :slug, uniqueness: true

  private

  def set_slug
    slug = Translit.convert(name, :english)
                   .downcase.gsub(/[^0-9a-z\s\-]/, '')
                   .strip.gsub(/(\s-\s|-\s|\s+)/, '-')
  end
end
