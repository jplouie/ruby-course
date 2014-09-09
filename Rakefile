task :console do
  require './lib/songify.rb'
  require 'irb'
  ARGV.clear
  IRB.start
end

task :reset_db do
  `dropdb songs-db`
  `createdb songs-db`
end