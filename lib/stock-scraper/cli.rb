class CLI
  attr_accessor :tickers, :tags, :final_array

  STOCKS = ["AAPL", "GOOG", "MSFT", "NFLX", "TSLA", "IBM", "AMZN", "EBAY", "SBUX", "FB"]
  TAGS_ENGLISH = []

  def initialize 
    @tags = ["n","a","p","o","t8","m","w","v","j1"]
    @length = @tags.length
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
    create_array
    populate_array
    print_stocks
  end

  def create_array
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{tags.join}"
    info = open(url)
    i=1
    @raw_array = []
    open(url) do |f| 
      f.each_line do |l|
        @raw_array << l
##### refractor ############
#          CSV.parse(l) do |row|
#            @final_array << ["#{TAGS_ENGLISH[i]}", row[i]]
#            i+=1
#            z=3
#          end
      end
    end
  end

  def populate_array
    counter = 0
    @final_array = Array.new(@raw_array.count){Array.new(0)}

    TAGS_ENGLISH.each do |tag|          ## it starts a loop for every tag
      @raw_array.each_with_index do |co,i|  ## looks at every company in raw array with it's index
        CSV.parse(co) do |row|        ## parses each company by row
          x = "#{TAGS_ENGLISH[counter]}", row[counter]  ##
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
      while i < (TAGS_ENGLISH.count)
        puts " #{final_array[comp][0+i].join(": $")}"
        i += 1
      end
      comp += 1
    end
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
    
    (tags << gets.strip.split(",")).flatten!
  end
end