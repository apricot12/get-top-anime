# frozen_string_literal: true

require 'nokogiri'
require 'httparty'
require 'csv'

class AnimeList

  def scraper
    url = 'https://myanimelist.net/topanime.php?'
    unpar_pg = HTTParty.get(url)
    par_pg = Nokogiri::HTML(unpar_pg)
    @animes = []
    anime_list = par_pg.css('tr.ranking-list')
    page = 0
    last_page = 950
    while page <= last_page
      pagin_url = "https://myanimelist.net/topanime.php?limit=#{page}"
      puts "#{page}"
      puts ''
      pagin_unpar_pg = HTTParty.get(pagin_url)
      pagin_par_pg = Nokogiri::HTML(pagin_unpar_pg)
      @pagin_anime_list = pagin_par_pg.css('tr.ranking-list')
      pagination_anime_list
      page += 50
    end
  end

  def export_to_csv
      CSV.open("myfile.csv", "w") do |csv|
          csv << @animes
      end
  end
    
  def pagination_anime_list
    @pagin_anime_list.each do |anime_listing|
      anime =  {
        rank: anime_listing.css('span.lightLink').text,
        name: anime_listing.css('h3.hoverinfo_trigger').text,
        rating: anime_listing.css('span.text.on.score-label').text
      } 
      @animes << anime
      export_to_csv
      puts "Added #{anime[:name]}"
      puts ''
    end
  end
end


