require './lib/scraper'

def welcome
    puts ''
    puts "**************"
    puts 'WELCOME TO GET-TOP-ANIME'
    puts ''
    puts 'You can choose to get a list of top anime from myanimelist.net simply by inputting your parameters'
    puts ''
end

def user_input
    puts 'Input a multiple of 50 to get top anime in that range'
    input = gets.strip
    until valid_input(input)
        puts "Invalid number entered! Try again."
        input = gets.strip
    end
    @page = input.to_i - 50
end


welcome
scraper = AnimeList.new
scraper.scraper
puts ''
puts 'Fetching & Converting list into readable format...'
puts ''
puts 'DONE!'

