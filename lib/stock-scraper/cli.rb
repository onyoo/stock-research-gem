class CLI
  attr_accessor :tickers, :tags, :hash

  STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]
  TAGS_ENGLISH = []
  TAG_VALUES = []

  def initialize 
    @tags = ["n","a","p","o","t8","m","w","v","j1"]
    @origional_length = @tags.length
    @hash = {}
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
    STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
  end

  def start
    list
    get_tickers
    get_tags
    tag_translate
    create_hash
    print_stocks
  end

keys = TAGS_ENGLISH
values = TAG_VALUES

  def create_hash
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
    info = open(url)
    i=0
    TAGS_ENGLISH.each do |tag_name|
      open(url) do |f| 
        f.each_line do |l| 
          CSV.parse(l) do |row|
            @hash["#{TAGS_ENGLISH[i]}"] = row[i]
            binding.pry
            i+=1
          end
        end
      end
      z=4
    end
  end

  def print_stocks
 #   open(url) do |f| 
 #     f.each_line do |l| 
 #       CSV.parse(l) do |row|
 #         puts "\n" 
 #         puts "#{row[0]}".center(61)
 #         puts " " + "-" * 65


 #         puts " Asking price:     $#{row[1]}       Days Range:      $#{row[5]}" 
 #         puts " Previous close:   $#{row[2]}       52 Week Range:   $#{row[6]}"
 #         puts " Open:             $#{row[3]}       Volume:          #{row[7]}"
 #         puts " 1y Target price:  $#{row[4]}       Market Cap:      #{row[8]}"
 #         puts 
 #       end
 #     end
      puts "#{@hash}"
 #   end
  end

  def tag_translate
    tags.each do |tag|
      case tag
      when "n"
        TAGS_ENGLISH << "Name"
      when"a"
        TAGS_ENGLISH << "Asking price"
      when"p"
        TAGS_ENGLISH << "Previous close"
      when"o"
        TAGS_ENGLISH << "Open"
      when"t8"
        TAGS_ENGLISH << "1y Target price"
      when"m"
        TAGS_ENGLISH << "Days Range"
      when"w"
        TAGS_ENGLISH << "52 Week Range"
      when"v"
        TAGS_ENGLISH << "Volume"
      when"j1"
        TAGS_ENGLISH << "Market Cap"
      when "h0"
        TAGS_ENGLISH << "Earnings per Share"
      when "d"
        TAGS_ENGLISH << "Dividend per Share"
      when "y"
        TAGS_ENGLISH << "Dividend Yield"
      when "r2"
        TAGS_ENGLISH << "P/E Ratio (Realtime)"
      when "m6"
        TAGS_ENGLISH << "Percent Change From 200 Day Moving Average"
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
    
    (tags << gets.strip.split(",")).flatten!
  end
end