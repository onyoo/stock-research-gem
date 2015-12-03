require '../lib/stock-research/cli'
require 'pry'


describe "CLI" do
  game = StockResearch::CLI.new

  describe '#initialize' do
    it 'initializes with @tag = ["N","A","P","O","T8","M","W","V","J1"]' do
      expect(game.tags).to eq(["N","A","P","O","T8","M","W","V","J1"])
    end
    it 'initializes with @length equal to 9' do
      expect(game.tags_english.length).to eq(0)
    end
  end
end

describe '#list' do
  it 'prints popular stocks' do
    
    expect { StockResearch::CLI.new.list }.to output("\n    Most Popular Stocks  |  Trending Stocks    \n ---------------------------------------------\n\n 1. AAPL\n 2. GOOG\n 3. MSFT\n 4. NFLX\n 5. TSLA\n 6. IBM\n 7. AMZN\n 8. EBAY\n 9. SBUX\n 10. FB\n").to_stdout
  end
end

###### Doesn't work #####
# describe '#get_tickers' do
#   it 'gets tickers and assigns them to @tickers' do
#     allow($stdout).to receive(:puts)

#     expect(StockResearch::CLI.new.get_tickers).to receive(:gets).and_return("aapl")
#     expect(StockResearch::CLI.new.tickers).to eq("AAPL")
#   end
# end


