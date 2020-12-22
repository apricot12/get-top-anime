# frozen_string_literal: true

require './lib/scraper'

scraper = AnimeList.new
scraper.scraper
scraper.format_json
