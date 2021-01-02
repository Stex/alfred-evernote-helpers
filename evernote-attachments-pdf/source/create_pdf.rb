#!/usr/bin/ruby

begin
  require_relative 'bundle/bundler/setup'
rescue LoadError
  # fall back to regular bundler if the developer hasn't bundled standalone
  require 'bundler'
  Bundler.setup
end

require "fileutils"
require "pathname"
require "base64"
require "securerandom"
require "ox"

OUTPUT_FOLDER = Pathname.new(ENV.fetch("PDF_OUTPUT_FOLDER"))
NOTE_XML_FILE = Pathname.new(File.expand_path(ARGV[0].strip))
PDF_OUTPUT_FILE = OUTPUT_FOLDER.join("#{NOTE_XML_FILE.basename(".enex")}.pdf")
TMP_FOLDER = OUTPUT_FOLDER.join(SecureRandom.hex(10))

def file_extension(mime_type)
  case mime_type
  when /pdf/
    "pdf"
  else
    mime_type.split("/").last
  end
end

FileUtils.mkdir_p(TMP_FOLDER.to_s)

xml = Ox.load(File.read(NOTE_XML_FILE), mode: :hash)

# Extract the various attachments from the exported note.
# It is an XML file with each attachment as base64 encoded string inside.
files = xml[:"en-export"].last[:note][:resource].each_with_index.map do |resource, idx|
  binary_content = Base64.decode64(resource[:data].last)
  TMP_FOLDER.join("resource_#{idx}.#{file_extension(resource[:mime])}").to_s.tap do |path|
    File.write(path, binary_content)
  end
end

system("#{ENV["CONVERT_PATH"]} #{files.join(" ")} '#{PDF_OUTPUT_FILE}'")

# Cleanup
FileUtils.rm_rf(TMP_FOLDER.to_s)
FileUtils.rm(NOTE_XML_FILE.to_s)

puts PDF_OUTPUT_FILE.to_s
