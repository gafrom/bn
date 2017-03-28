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
#  weight        :integer
#  price         :integer
#  compare_price :integer
#  images        :string           default("{}"), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Product < ApplicationRecord
end
