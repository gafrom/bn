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

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
