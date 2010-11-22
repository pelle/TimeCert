#!/usr/bin/env ruby
require 'rubygems'
require 'bundler'
Bundler.setup

#require 'rubygems'
require 'mysql2'
require 'redis'

env = ENV["RAILS_ENV"]||"development"

$redis = Redis.new(:db => (env=="development" ? 11 : 1))

c = Mysql2::Client.new(:host => "localhost", :username => "root", :database=>"timecert_#{(env=="development" ? "development" : "production")}")
puts "importing"
c.query("select * from stamps").each do |r| 
  $redis.set("sha1:#{r["digest"]}",r["created_at"].to_i)
end
puts "done"
