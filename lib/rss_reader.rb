#!/usr/bin/env ruby
require "rss"
require "open-uri"

# TESTING URL: https://kotaku.com/rss
$urls = []

class RSSReader
    #making url read only
    attr_reader :url

    #default initialize method to get url
    def initialize(url)
        @url = url
    end

    #Creating rss feed: asigning parsed RSS to feed and extracting info from it using method
    def create_rss
        feed = parse_rss_feed
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

def url
    puts "Type the url you want to read news from..."
    get_url = gets.chomp
    if get_url == ""
        get_url = "https://kotaku.com/rss"
    else
        puts "URL gotten"
    end
    reader = RSSReader.new(get_url)
    reader.create_rss
    puts reader.url
    puts "----------------------"
    $urls << get_url
    puts "Urls that have been used so far: #{$urls}"
    puts "----------------------"
end

def get_choice
    puts "Would you like to try another url? y/n"
    choice = gets.chomp.downcase
case choice
when "y"
    url
when "n"
    puts "Exit404"
end
end

url
get_choice



