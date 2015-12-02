class CLI
<<<<<<< HEAD
  attr_accessor :tickers, :data_type

  def initialize
    @data_type = ["n","a","b"]
=======
  attr_accessor :tickers, :tags

  STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]

  def initialize 
    @tags = %w(napot8mwvj1)
>>>>>>> fffab732bb723502579721772d9f73e3e3f70757
  end

  def call
    start
  end

  def list
<<<<<<< HEAD
#### eventually lists the day's hottest stocks####
    puts ""
    puts "Here are some of the bigger stocks:"
    puts "aapl, goog, nke, tsla"
    puts "Please enter the tickers you want info on. Seperate with commas ','"
    @tickers = gets.strip.strip.upcase.split(",").join("+")

    puts "Thanks. We'll give you the basic info, but please select any other info you may want?"
    puts "Seperate with commas ','"
    puts "e: Earnings per Share"
    puts "y: Dividend Yield"
    puts "d: Dividend per Share"
    puts "m6: Percent Change From 200 Day Moving Average"
    puts "r2: P/E Ratio (Realtime)"
    z = gets.strip.split(",")
    (@data_type << z).flatten!
=======
    #### eventually lists the day's hottest stocks ####
    puts "\n"
    puts " Most Popular Stocks".center(37)
    puts " " + "-" * 35
    puts "\n"
    STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
>>>>>>> fffab732bb723502579721772d9f73e3e3f70757
  end

  def start
    list
<<<<<<< HEAD
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{data_type.join("")}"
=======
    get_tickers
    get_tags
    print_stocks
  end

  def print_stocks
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
>>>>>>> fffab732bb723502579721772d9f73e3e3f70757
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
<<<<<<< HEAD
=======

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
>>>>>>> fffab732bb723502579721772d9f73e3e3f70757
end
