class ScrapeBbcGoodFoodService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    html_doc = Nokogiri::HTML(open("https://www.bbcgoodfood.com/search/recipes?query=#{@keyword}").read)
    scrape_ingredient(html_doc)
  end

  def scrape_ingredient(html_doc)
    import_recipe = []
    html_doc.search('.node-recipe').first(5).each do |element|
      new_hash = {}
      new_hash[:name] = element.search('.teaser-item__title a').text.strip
      new_hash[:description] = element.search('.field-item').text.strip
      new_hash[:difficulty] = element.search('.teaser-item__info-item--skill-level').text.strip
      new_hash[:prep_time] = element.search('.teaser-item__info-item--total-time').text.strip
      import_recipe << Recipe.new(new_hash)
    end
    return import_recipe
  end
end
