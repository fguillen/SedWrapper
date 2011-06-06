require_relative '../lib/sed'

TMP_PATH          = Dir.mktmpdir
TMP_FILE_PATH     = "#{TMP_PATH}/file.txt"
EXAMPLE_FILE_PATH = "#{File.dirname(__FILE__)}/file.txt"

puts "EXAMPLE 1--------------------------------"
FileUtils.copy(EXAMPLE_FILE_PATH, TMP_FILE_PATH)

Sed::Runner.new(TMP_FILE_PATH) do |s|
  s.replace('a', '-')
  s.replace('o', 'XXXX')
end

puts File.read(TMP_FILE_PATH)
puts

puts "EXAMPLE 2--------------------------------"
FileUtils.copy(EXAMPLE_FILE_PATH, TMP_FILE_PATH)

Sed::Runner.new(TMP_FILE_PATH, :extended_regex => true) do |s|
  s.replace('[aeiou]', 'X')
end

puts File.read(TMP_FILE_PATH)
puts

puts "END"
FileUtils.rmtree TMP_PATH