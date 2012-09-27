require 'spec_helper'
require 'fileutils'

module Renmov
  describe CLI do
    describe '#parse_options' do
      let(:default_options) { { verbose: false, noop: false } }

      before(:each) do
        @cli = CLI.new(options + filenames)
        @cli.parse_options
      end

      context 'with no options provided' do
        let(:options) { [] }

        context 'with no filenames provided' do
          let(:filenames) { [] }

          it 'keeps default options' do
            @cli.options.should == default_options
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'with one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'keeps default options' do
            @cli.options.should == default_options
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end

      context 'with verbose option provided' do
        let(:options) { ['-v'] }

        context 'with no filenames provided' do
          let(:filenames) { [] }

          it 'merges verbose with default options' do
            @cli.options.should == default_options.merge(verbose: true)
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'with one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'merges verbose with default options' do
            @cli.options.should == default_options.merge(verbose: true)
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end

      context 'with noop option provided' do
        let(:options) { ['-n'] }

        context 'with no filenames provided' do
          let(:filenames) { [] }

          it 'merges verbose and noop with default options' do
            @cli.options.should == default_options.merge(verbose: true,
                                                         noop: true)
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'with one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'merges verbose and noop with default options' do
            @cli.options.should == default_options.merge(verbose: true,
                                                         noop: true)
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end
    end

    describe '#run' do
      let(:tmpdir) { File.expand_path('../../../tmp', __FILE__) }

      before(:each) do
        filenames.each do |filename|
          FileUtils.rm(filename) if File.exists?(filename)
        end
        newnames.each do |newname|
          FileUtils.rm(newname) if File.exists?(newname)
        end

        FileUtils.touch(filenames)
        cli = CLI.new(filenames)
        cli.parse_options
        cli.run
      end

      context 'with one filename provided' do
        let(:filenames) { ["#{tmpdir}/TV.Show.S01E02.HDTV.test.mp4"] }
        let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4"] }

        it 'properly renames file' do
          File.exists?(filenames[0]).should_not be_true
          File.exists?(newnames[0]).should be_true
        end
      end

      context 'with multiple filenames provided' do
        let(:filenames) { ["#{tmpdir}/TV.Show.S01E02.HDTV.test.mp4",
                           "#{tmpdir}/The.TV.Show.S02E03.LOL.avi"] }
        let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4",
                           "#{tmpdir}/tv.show.s02e03.avi"] }

        it 'properly renames all files' do
          filenames.each { |f| File.exists?(f).should_not be_true }
          newnames.each  { |n| File.exists?(n).should be_true }
        end
      end
    end
  end
end
