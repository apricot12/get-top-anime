require_relative '../lib/scraper'

describe AnimeList do
    anime = AnimeList.new
    describe "#valid_input" do
        input = '20'
        it 'returns false if input is invalid' do
            expect(anime.valid_input(input)).to eql(false)
        end
    end

    describe "#valid_input" do
        input = '50'
        it 'returns true if input is valid' do
            expect(anime.valid_input(input)).to eql(true)
        end
    end

    describe "#valid_input" do
        input = '#'
        it 'returns false if input is invalid' do
            expect(anime.valid_input(input)).to eql(false)
        end
    end

    describe "#valid_input" do
        input = 'AB'
        it 'returns false if input is invalid' do
            expect(anime.valid_input(input)).to eql(false)
        end
    end

    describe "#valid_input" do
        input = '150'
        it 'returns true if input is valid' do
            expect(anime.valid_input(input)).to eql(true)
        end
    end
end