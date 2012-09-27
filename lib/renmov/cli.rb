require 'optparse'
require 'fileutils'
require 'renmov/basic_renamer'
require 'renmov/errors'

module Renmov
  class CLI
    attr_reader   :executable_name, :args, :options, :optparse
    attr_accessor :filenames, :renamer

    def initialize(args = ARGV, renamer = BasicRenamer)
      @executable_name = File.basename($PROGRAM_NAME, '.rb')
      @args      = args
      @options   = { verbose: false, noop: false }
      @optparse  = OptionParser.new
      @filenames = []
      @renamer   = renamer
    end

    def run
      exit_status = 0

      begin
        parse_options
        raise NoFilenameError if filenames.empty?

        filenames.each do |filename|
          dirname   = "#{File.dirname(filename)}/"
          dirname.gsub!(/\A\.\/\z/, '')
          
          basename  = File.basename(filename)
          renamer_i = renamer.new(basename)
          newname   = "#{dirname}#{renamer_i.rename}"

          rename_file(filename, newname)
        end
      rescue OptionParser::InvalidOption => e
        output_error_message(e)
        exit_status = 1
      rescue NoFilenameError => e
        output_error_message(e)
        exit_status = 1
      end

      exit_status
    end

    def parse_options
      optparse.banner =
        ['Rename video files to a consistent format.', '',
         "Usage: #{executable_name} [options] filename..."].join("\n")

      optparse.on('-v', '--verbose',
                  'Output more information') do
        options[:verbose] = true
      end

      optparse.on('-n', '--noop',
                  'Output actions without invoking them') do
        options[:noop]    = true
        options[:verbose] = true
      end

      optparse.on_tail('-h', '--help',
                       'Show this message') do
        puts optparse
        exit
      end

      optparse.on_tail('--version',
                       'Show version') do
        puts Renmov::VERSION
        exit
      end

      self.filenames = optparse.parse! args
    end

    def output_error_message(msg)
      $stderr.puts "#{executable_name}: #{msg}"
      $stderr.puts optparse
    end

    def rename_file(old, new)
      unless old == new
        FileUtils.mv(old,
                     new,
                     verbose: options[:verbose],
                     noop:    options[:noop])
      end
    end
  end
end
