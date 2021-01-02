require 'nokogiri'
require 'httparty'
require 'json'

class AnimeList
  def scraper
    @animes = []
    page = 0
    user_input
    last_page = @page
    while page <= last_page
      pagin_url = "https://myanimelist.net/topanime.php?limit=#{page}"
      pagin_unpar_pg = HTTParty.get(pagin_url)
      pagin_par_pg = Nokogiri::HTML(pagin_unpar_pg.body)
      @pagin_anime_list = pagin_par_pg.css('tr.ranking-list')
      pagination_anime_list
      page += 50
    end
    format_json
  end

  def valid_input(input)
    (input.to_i >= 50) && (input.to_i % 50 == 0) && (input =~ /^-?[0-9]+$/) && (input != ~ /\s/) && (!input.nil?)
  end

  
private

  def export_to_json
    File.open('../json/anime_list.json', 'w') do |f|
      f.write(@animes.to_json)
    end
  end

  def format_json
    json = JSON.parse File.read '../json/anime_list.json'
    File.open('../json/anime_list.json', 'w') do |list|
      list.write '../json/anime_list.json', JSON.pretty_generate(json)
    end
  end

  def pagination_anime_list
    @pagin_anime_list.each do |anime_listing|
      anime = {
        rank: anime_listing.css('span.lightLink').text,
        name: anime_listing.css('h3.hoverinfo_trigger').text,
        rating: anime_listing.css('span.text.on.score-label').text
      }
      @animes << anime
      export_to_json
    end
  end
end
