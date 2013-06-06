# Login form identifier
# From London with love

require 'anemone'
require 'trollop'
require_relative 'lib/formfinder'
$VERBOSE=false



def main

  opts = Trollop::options do

    version "Login form identifer v0.31337"
    banner <<-EOS Example usage:
      #{File.basename($0)} -u http://www.hack.com/ -c forms.csv
EOS
    opt :url, "URL to crawl", :type => :string, :required => true
    # opt :csv,		"CSV file for output", :required => false, :type => :string
    opt :verbose,	"Verbose"

  end



  $VERBOSE=opts[:verbose]
  LOGIN_WORDS="login auth".split(" ")
  ff=FormFinder.new
  Anemone.crawl(opts[:url]) do |anemone|
    anemone.on_every_page do |page|
      puts "Crawling #{page.url}" if $VERBOSE
      (ff.findAllForms page.doc).each {|f| 
        puts "Form with action '#{f['action']}' found at #{page.url}"}
    end
  end
end

if __FILE__ == $0
  main()
end

