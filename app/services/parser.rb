class Parser
  def initialize(url)
    @url = url
    @page = HTTParty.get @url
    @doc = Nokogiri::HTML @page
  end

  def work
    Product.create \
      url: @url,
      title: name,
      brand: brand,
      images: images,
      category: category,
      remote_id: id
  end

  private

  def name
    return @name if @name
    node = @doc.css('#container #tab-description h1').first
    @name = node.content.strip
  end

  def category
    node = @doc.css('#container #tab-description #add-options .j-kit p span').first
    node.content.strip
  end

  def images
    @images = []
    @doc.css('ul.carousel li:not(.jc-active) img:first-child').each do |node|
      @images << node.attr('src').sub('/tm/', '/big/')
    end

    @images
  end

  def price
    node = @doc.css('#container #tab-description #cost #price meta[itemprop="price"]').first
    node.attr('content')
  end

  def id
    node = @doc.css('#container #tab-description #GoodCode').first
    node.content.strip
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
