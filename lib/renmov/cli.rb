require 'optparse'
require 'fileutils'
require 'renmov/basic_renamer'

module Renmov
  class CLI
    attr_reader :args
    attr_accessor :options
    attr_accessor :filenames

    def initialize(args = ARGV, renamer = BasicRenamer)
      @args      = args
      @filenames = []
      @options   = { verbose: false }
      @renamer   = renamer
    end

    def parse_options
      optparse = OptionParser.new do |opts|
        opts.on('-v', '--verbose', 'Output more information') do
          options[:verbose] = true
        end
      end

      self.filenames = optparse.parse! args
    end

    def run
      @filenames.each do |filename|
        dirname  = File.dirname(filename)
        filename = File.basename(filename)
        renamer  = @renamer.new(filename)
        newname  = renamer.rename
        FileUtils.mv("#{dirname}/#{filename}",
                     "#{dirname}/#{newname}",
                     verbose: options[:verbose])
      end
    end
  end
end
