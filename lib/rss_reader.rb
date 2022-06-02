#!/usr/bin/env ruby
require "rss"
require "open-uri"

# TESTING URL: https://kotaku.com/rss

class RSSReader
    #making url read only
    attr_reader :url

    #default initialize method to get url
    def initialize(url)
        @url = url
    end

    #Creating rss feed: asigning parsed RSS to feed and extracting info from it using method
    def create_rss
        feed = parse_rss_feed#parse_rss_feed(read_rss_feed)
        extract_rss_feed(feed)
    end

    #Checking for URL availability, then reading and parsing the RSS Feed
    def parse_rss_feed
        if URI.open @url
            RSS::Parser.parse(URI.open @url)
        else
            puts "URL not available"
        end
    end

    #Extracting rss feed info and printing it out
    def extract_rss_feed(feed)
        puts "Title of site: #{feed.channel.title}"
        feed.items.each do |item|
            puts "-------------------------"
            puts "Item title: #{item.title}"
            puts "---"
            puts "Item description: #{item.description}"
            puts "---"
            puts "Item link: #{item.link}"
            puts "------------------------"
        end
    end

end

#Prompting user for url and asigning default value
puts "Please enter the url from which you want the news..."
get_url = gets.chomp
if get_url == ""
    get_url = "https://kotaku.com/rss"
else
    puts "URL gotten"
end

#Creating instance of class and printing news onto terminal
reader = RSSReader.new(get_url)

reader.create_rss

#Printing all info and mentioning link at the bottom of the screen
puts reader.url


