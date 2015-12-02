class CLI
  attr_accessor :tickers, :tags

  STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]

  def initialize 
    @tags = %w(napot8mwvj1)
  end

  def call
    start
  end

  def list
    #### eventually lists the day's hottest stocks ####
    puts "\n"
    puts " Most Popular Stocks".center(37)
    puts " " + "-" * 35
    puts "\n"
    STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
  end

  def start
    list
    get_tickers
    get_tags
    print_stocks
  end

  def print_stocks
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
    info = open(url)

    open(url) do |f| 
      f.each_line do |l| 
        CSV.parse(l) do |row|
          puts "\n" 
          puts "#{row[0]}".center(61)
          puts " " + "-" * 65
          puts " Asking price:     $#{row[1]}       Days Range:      $#{row[5]}" 
          puts " Previous close:   $#{row[2]}       52 Week Range:   $#{row[6]}"
          puts " Open:             $#{row[3]}       Volume:          #{row[7]}"
          puts " 1y Target price:  $#{row[4]}       Market Cap:      #{row[8]}"
          puts 
        end
      end
    end
  end

  def get_tickers 
    puts "\nEnter the stock tickers you want more infomation on." 
    puts "Separate tickers with commas ',' or a space\n\n"
    @tickers = gets.strip.scan(/\S[a-zA-Z]+/).join("+").upcase # Between {2,4}
  end

  def get_tags
    puts "\nWe'll provide you with the basic information but please"
    puts "select any additional information you want to view:\n\n"

    # Possibly change the codes to numbers so it's easier for the user to select? 
    puts " h0 | Earnings per Share"
    puts " d  | Dividend per Share"
    puts " y  | Dividend Yield"
    puts " r2 | P/E Ratio (Realtime)"
    puts " m6 | Percent Change From 200 Day Moving Average\n\n"
    
    tags << gets.strip
  end
end
