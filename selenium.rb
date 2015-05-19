#coding: utf-8

require 'rubygems'
require "open-uri"
require 'bundler'
Bundler.require(:default)

# スクレイピング先のURL
url = 'http://www.shazam.com/charts/top-100/japan'

# charset = nil
# html = open(url) do |f|
#   charset = f.charset
#   f.read
# end
# doc = Nokogiri::HTML.parse(html, nil, charset)
# doc.css(".flexgrid--item--large").each do |node|
#   unless node.css(".auto-playing")
#       node['audio-player'] += "not-playing"
#   end
# end

driver = Selenium::WebDriver.for :firefox
# driver = Selenium::WebDriver.for :chrome
driver.navigate.to url
# wait = Selenium::WebDriver::Wait.new(:timeout => 50)

100.times do |num|
  begin
    driver.find_elements(:class, 'flexgrid--item--large')[num].find_element(:class => "audio-player")
  rescue Selenium::WebDriver::Error::NoSuchElementError
    next
  end
  driver.find_elements(:class, 'flexgrid--item--large')[num].find_element(:class, 'audio-player').find_element(:tag_name, 'a').click
  sleep 30
  # ここは、sleepじゃなくて他のことでやたkった。
  # wait.until {
    # driver.find_elements(:class, 'flexgrid--item--large')[num].find_element(:class => "not-playing").displayed? 
  # }
  next
end



# id = driver.find_element(:id, "signin-email")
# pass = driver.find_element(:id, "signin-password")
# id.send_keys("PallCreaker")
# pass.send_keys("20051029")
# driver.find_element(:class, 'password-signin').find_element(:tag_name, 'button').click
# driver.switch_to.frame("#footer")