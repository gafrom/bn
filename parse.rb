require 'httparty'
require 'nokogiri'
require 'open-uri'
require 'byebug'

class Product
  attr_reader :url, :id, :images, :brand

  class << self
    def add(url, name, brand, images = [])
      @all ||= []
      @all << new(url, name, brand, images)
    end

    def all
      @all
    end
  end

  def initialize(url, name, brand, images)
    @url = url
    @images = images
    @brand = brand
    @name = name
  end

  def to_s
    "<product name: '#{@name}', brand: '#{@brand}', images: #{@images.count}>"
  end
end

class Parser
  def initialize(url)
    @url = url
    @page = HTTParty.get @url
    @doc = Nokogiri::HTML @page
  end

  def work
    Product.add @url, name, brand, images
  end

  private

  def name
    node = @doc.css('#container #tab-description h1').first
    node.content.strip
  end

  def images
    @images = []
    @doc.css('ul.carousel li:not(.jc-active) img:first-child').each do |node|
      @images << node.attr('src').sub('/tm/', '/big/')
    end

    @images
  end

  def brand
    node = @doc.css('#container #tab-description p.brand-logo img').first
    node.attr('alt')
  end
end

urls = [
  'https://www.wildberries.ru/catalog/3673448/detail.aspx?targetUrl=GP',
  'https://www.wildberries.ru/catalog/3873754/detail.aspx?targetUrl=BP',
  'https://www.wildberries.ru/catalog/3684844/detail.aspx?targetUrl=GP'
]

urls.each do |url|
  parcer = Parser.new url
  parcer.work
end

puts 'Product.all'
puts Product.all
