require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
    url = "https://myanimelist.net/topanime.php?"
    unpar_pg = HTTParty.get(url)
    par_pg = Nokogiri::HTML(unpar_pg)
    animes = Array.new
    anime_list = par_pg.css('tr.ranking-list')
    page = 0
    per_page = anime_list.count
    total = 1000
    last_page = 950
    while page <= last_page
        pagin_url = "https://myanimelist.net/topanime.php?limit=#{page}"
        puts pagin_url
        puts "Page: #{page}"
        puts ''
        pagin_unpar_pg = HTTParty.get(pagin_url)
        pagin_par_pg = Nokogiri::HTML(pagin_unpar_pg)
        pagin_anime_list = pagin_par_pg.css('tr.ranking-list')
        pagin_anime_list.each do |anime_listing|
            anime = {
                rank: anime_listing.css('td.rank').text,
                name: anime_listing.css('td.title').text,
                rating: anime_listing.css('td.score').text
            }
            animes << anime
            puts "Added #{anime[:title]}"
            puts ""
        end
        page += 50
    end
    byebug
end

scraper
