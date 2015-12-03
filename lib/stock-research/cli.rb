module StockResearch
  class StockResearch::CLI
    attr_accessor :tickers, :tags

    START_STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]
    

    def initialize 
      @tags = ["N","A","P","O","T8","M","W","V","J1"]
      @tags_english = []
    end

    def list
      #### eventually lists the day's hottest stocks ####
      puts "\n"
      puts " Most Popular Stocks  |  Trending Stocks ".center(47)
      puts " " + "-" * 45
      puts "\n"
      START_STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
    end

    def start
      list
      get_tickers
      get_tags
      GetQuote.new(tickers, tags).call
      try_again
    end

    def try_again
      puts "\n " + "-" * 65
      puts "\n"
      puts "Would you like to start again?\n".center(61)
      input = gets.strip.upcase
      if input == "Y" || input == "YES"
        StockResearch::CLI.new.start
      end
    end

    def get_tickers 
      puts "\n Enter the stock tickers you want more infomation on." 
      puts " Separate tickers with commas ',' or a spaces.\n\n"
      @tickers = gets.strip.strip.upcase.split(",").join("+")
      exit if @tickers.include?("EXIT") || @tickers.empty?
    end

    def get_tags
      puts "\n We'll provide you with the basic information, but please"
      puts " select any additional information you want to view:\n\n"

      # Possibly change the codes to numbers so it's easier for the user to select? 
      puts " e  | Earnings per Share"
      puts " d  | Dividend per Share"
      puts " y  | Dividend Yield"
      puts " r  | P/E Ratio"
      puts " m6 | Percent Change From 200 Day Moving Average\n\n"
      
      (@tags << gets.strip.upcase.split(",")).flatten!
      exit if @tags.include?("EXIT")
    end
  end
end