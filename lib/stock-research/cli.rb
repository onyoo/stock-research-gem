module StockResearch
end
class StockResearch::CLI
  attr_accessor :tickers, :tags, :final_array, :tags_english

  START_STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]
  

  def initialize 
    @tags = ["N","A","P","O","T8","M","W","V","J1"]
    @tags_english = []
  end

  def call
    start
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
    if !tickers.include?("EXIT")
      if !get_tags.include?("EXIT")
        tag_translate
        create_array
        populate_array
        print_stocks
      end
    end
    try_again
  end

  def try_again
    puts "Would you like to start again?\n"
    input = gets.strip.upcase
    if input == "Y" || input == "YES"
      StockResearch::CLI.new.call
    end
  end

  def create_array
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
    info = open(url)
    i=1
    @raw_array = []
    open(url) do |f| 
      f.each_line do |l|
        @raw_array << l
      end
    end
  end

  def populate_array
    counter = 0
    @final_array = Array.new(@raw_array.count){Array.new(0)}

    tags_english.each do |tag|
      @raw_array.each_with_index do |co,i|
        CSV.parse(co) do |row|
          x = "#{tags_english[counter]}", row[counter]
          @final_array[i] << x
        end
      end
      counter += 1
    end
  end

  def print_stocks
    comp = 0
    while comp < @raw_array.count
      puts "\n" 
      puts "#{final_array[comp][0].join(": ")}".center(61)
      puts " " + "-" * 65
      i = 1
      while i < (tags_english.count)
        if final_array[comp][0+i][1].include?("%") || !final_array[comp][0+i][1].include?(".") 
          puts " #{final_array[comp][0+i].join(": ")}"
        else
          puts " #{final_array[comp][0+i].join(": $")}"
        end
        i += 1
      end
      comp += 1
    end
  end

  def tag_translate
    tags.each do |tag|
      case tag
      when "N"
        tags_english << "Name"
      when"A"
        tags_english << "Asking price"
      when"P"
        tags_english << "Previous close"
      when"O"
        tags_english << "Open"
      when"T8"
        tags_english << "1y Target price"
      when"M"
        tags_english << "Days Range"
      when"W"
        tags_english << "52 Week Range"
      when"V"
        tags_english << "Volume"
      when"J1"
        tags_english << "Market Cap"
      when "H0"
        tags_english << "Earnings per Share"
      when "D"
        tags_english << "Dividend per Share"
      when "Y"
        tags_english << "Dividend Yield"
      when "R2"
        tags_english << "P/E Ratio (Realtime)"
      when "M6"
        tags_english << "Percent Change From 200 Day Moving Average"
      end
    end
  end

  def get_tickers 
    puts "\nEnter the stock tickers you want more infomation on." 
    puts "Separate tickers with commas ',' or a space.\n\n"
    @tickers = gets.strip.strip.upcase.split(",").join("+")
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
    
    (@tags << gets.strip.upcase.split(",")).flatten!
  end
end