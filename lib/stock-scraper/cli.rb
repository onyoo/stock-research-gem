class CLI
  def call
    start
  end

  def list
#### eventually lists the day's hottest stocks####
    puts ""
    puts "here are some of the bigger stocks:"
    puts "aapl, goog, nke, tsla"
    puts "please enter the tickers you want info on."
  end

  def start
    list
    answer = gets.strip.upcase
    url = "http://finance.yahoo.com/d/quotes.csv?s=#{answer}&f=naby"
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
