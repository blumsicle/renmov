require 'optparse'
require 'fileutils'
require 'renmov/basic_renamer'

module Renmov
  class CLI
    attr_reader :args
    attr_accessor :options
    attr_accessor :filenames
    attr_accessor :renamer

    def initialize(args = ARGV, renamer = BasicRenamer)
      @args      = args
      @filenames = []
      @options   = { verbose: false, noop: false }
      @renamer   = renamer
    end

    def parse_options
      optparse = OptionParser.new do |opts|
        opts.on('-v', '--verbose', 'Output more information') do
          options[:verbose] = true
        end

        opts.on('-n', '--noop', 'Output actions without invoking them') do
          options[:noop]    = true
          options[:verbose] = true
        end
      end

      self.filenames = optparse.parse! args
    end

    def run
      filenames.each do |filename|
        dirname   = "#{File.dirname(filename)}/"
        dirname.gsub!(/\A\.\/\z/, '')
        
        basename  = File.basename(filename)
        renamer_i = renamer.new(basename)
        newname   = "#{dirname}#{renamer_i.rename}"
        FileUtils.mv(filename,
                     newname,
                     verbose: options[:verbose],
                     noop: options[:noop])
      end
    end
  end
end
