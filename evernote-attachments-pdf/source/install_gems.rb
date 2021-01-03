#!/usr/bin/env ruby

# Ensures that 'ox' is either installed as global gem or as a standalone bundled version
begin
  begin
    require_relative 'bundle/bundler/setup'
  rescue LoadError
    require 'bundler'
    Bundler.setup
  end
rescue Bundler::GemNotFound
  puts "Installing necessary gems..."
  system("/usr/bin/env bundle install --standalone")
end