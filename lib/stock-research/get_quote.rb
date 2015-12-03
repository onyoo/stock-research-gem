class GetQuote
  attr_accessor :tickers, :tags, :tags_english, :final_array

  def initialize(tickers, tags)
    @tickers, @tags, @tags_english = tickers, tags, []
  end

  def call
    tag_translate
    print_stocks
  end

  def list
    #### eventually lists the day's hottest stocks ####
    puts "\n"
    puts " Most Popular Stocks  |  Trending Stocks ".center(47)
    puts " " + "-" * 45
    puts "\n"
    START_STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
  end

  def currency?(value)
    "#{value.include?('%') || !value.include?(".") ? '' : "$"}" 
  end

  def print_stocks
    counter = 1
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
    open(url) do |file|
      CSV.parse(file) do |row|
        puts "\n" 
        puts "#{row[0]}".center(61)
        puts " " + "-" * 65
        while counter < (tags_english.count)
          puts " #{tags_english[counter]}: #{currency?(row[counter])}#{row[counter]}"
          counter += 1
        end
        counter = 1
      end
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
      when "E"
        tags_english << "Earnings per Share"
      when "D"
        tags_english << "Dividend per Share"
      when "Y"
        tags_english << "Dividend Yield"
      when "R"
        tags_english << "P/E Ratio (Realtime)"
      when "M6"
        tags_english << "Percent Change From 200 Day Moving Average"
      end
    end
  end
end 