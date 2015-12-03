require 'open-uri'
require 'pry'
require 'nokogiri'
require 'csv'
require 'rspec'
require 'pry-doc'

require_relative "../lib/stock-research/cli"
require_relative "../lib/stock-research/version"
require_relative "../lib/stock-research/get_quote"

require 'bundler'
Bundler.require