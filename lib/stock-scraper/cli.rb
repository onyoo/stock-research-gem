class CLI

  STOCKS = [
    "AAPL",
    "GOOG",
    "MSFT",
    "NFLX",
    "TSLA",
    "IBM",
    "AMZN",
    "EBAY",
    "SBUX",
    "FB"
  ]
  def call
    start
  end

  def list
#### eventually lists the day's hottest stocks####
    puts "\n"
    puts " Most Popular Stocks".center(37)
    puts " " + "-" * 35
    puts "\n"
    STOCKS.each_with_index{ |stock, i| puts " #{i+1}. #{stock}" }
  end

  def start
    list

    begin 
      puts "\n\nEnter the stock ticker you want more info on:"
      answer = gets.strip.upcase
    end until answer.match(/[a-zA-Z]/) && answer.length <= 4

    url = "http://finance.yahoo.com/d/quotes.csv?s=#{answer}&f=nab"
    info = open(url)
    open(url) do |f| 
      f.each_line do |l| 
        CSV.parse(l) do |row| 
          puts row
        end
      end
    end
  end
end
