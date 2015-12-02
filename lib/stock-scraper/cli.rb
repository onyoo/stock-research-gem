class CLI
  attr_accessor :tickers, :data_type

  def initialize
    @data_type = ["n","a","b"]
  end

  def call
    start
  end

  def list
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
  end

  def start
    list
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{tickers}&f=#{data_type.join("")}"
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
