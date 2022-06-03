#!/usr/bin/env ruby
require "rexml/document"
require "open-uri"
include REXML

# TESTING URL: https://kotaku.com/rss

$urls = []

class RSSReader
    #making url read only
    attr_reader :url

    #default initialize method to get url
    def initialize(url)
        @url = url
    end

    #Parsing xml and printing it out
    def parse_rss_feed
        doc = Document.new(URI.open @url)
        doc.elements.each("rss/channel/") do |e| puts "Title: " + e.elements["title"].text end
        link = doc.elements.each("rss/channel/") do |e| puts "Link: " + e.elements["link"].text end
        doc.elements.each("rss/channel/item/") do |e|
            puts "---------------------------------"
            puts "Title: " + e.elements["title"].text
            puts "---------------------------------"
            puts "Description: " + e.elements["description"].text
            puts "---------------------------------"
            
        end
    end
end

#Prompting for url
def url
    puts "Type the url you want to read news from..."
    get_url = gets.chomp
    if get_url == ""
        get_url = "https://kotaku.com/rss"
    else
        puts "URL gotten"
    end
    reader = RSSReader.new(get_url)
    reader.parse_rss_feed
    #Adding URLs to array to be printed out
    puts "----------------------"
    $urls << get_url
    puts "Urls that have been used so far: #{$urls}"
    puts "----------------------"
end

#Prompting for more URLs using choices
def get_choice
    puts "Would you like to try another url? y/n"
    $choice = gets.chomp.downcase
case $choice
when "y"
    url
when "n"
    puts "Exit404"
end
end

#Running
url
#Prompting for URLs until user stops process
until $choice == "n"
    get_choice
end