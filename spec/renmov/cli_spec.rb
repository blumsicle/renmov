require 'spec_helper'
require 'fileutils'

module Renmov
  describe CLI do
    describe '#run' do
      let(:tmpdir) { File.expand_path('../../../tmp', __FILE__) }

      before(:each) do
        filenames.each { |f| FileUtils.rm(f) if File.exists?(f) }
        newnames.each  { |f| FileUtils.rm(f) if File.exists?(f) }

        FileUtils.touch(filenames) unless filenames.empty? 
        cli = CLI.new(filenames)
        @exit_status = cli.run
      end

      context 'no filename provided' do
        let(:filenames) { [] }
        let(:newnames)  { [] }

        it 'exits with a status of 1' do
          @exit_status.should == 1
        end
      end

      context 'one filename provided' do
        context 'filename different than newname' do
          let(:filenames) { ["#{tmpdir}/TV.Show.S01E02.HDTV.test.mp4"] }
          let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4"] }

          it 'properly renames file' do
            File.should_not exist(filenames[0])
            File.should exist(newnames[0])
          end

          it 'exits with a status of 0' do
            @exit_status.should == 0
          end
        end

        context 'filename same as newname' do
          let(:filenames) { ["#{tmpdir}/tv.show.s01e02.mp4"] }
          let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4"] }

          it 'does not rename file' do
            File.should exist(newnames[0])
          end

          it 'exits with a status of 0' do
            @exit_status.should == 0
          end
        end
      end

      context 'multiple filenames provided' do
        context 'filenames different than newnames' do
          let(:filenames) { ["#{tmpdir}/TV.Show.S01E02.HDTV.test.mp4",
                             "#{tmpdir}/The.TV.Show.S02E03.LOL.avi"] }
          let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4",
                             "#{tmpdir}/tv.show.s02e03.avi"] }

          it 'properly renames all files' do
            filenames.each { |f| File.should_not exist(f) }
            newnames.each  { |n| File.should exist(n) }
          end

          it 'exits with a status of 0' do
            @exit_status.should == 0
          end
        end

        context 'one filename same as and one filename different than newnames' do
          let(:filenames) { ["#{tmpdir}/TV.Show.S01E02.HDTV.test.mp4",
                             "#{tmpdir}/tv.show.s02e03.avi"] }
          let(:newnames)  { ["#{tmpdir}/tv.show.s01e02.mp4",
                             "#{tmpdir}/tv.show.s02e03.avi"] }

          it 'properly renames first file and not second file' do
            File.should_not exist(filenames[0])
            File.should exist(filenames[1])
            newnames.each  { |n| File.should exist(n) }
          end

          it 'exits with a status of 0' do
            @exit_status.should == 0
          end
        end
      end
    end

    describe '#parse_options' do
      before(:each) do
        @cli = CLI.new(options + filenames)
        @default_options = @cli.options
        @cli.parse_options
      end

      context 'no options provided' do
        let(:options) { [] }

        context 'no filenames provided' do
          let(:filenames) { [] }

          it 'keeps default options' do
            @cli.options.should == @default_options
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'keeps default options' do
            @cli.options.should == @default_options
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end

      context 'verbose option provided' do
        let(:options) { ['-v'] }

        context 'no filenames provided' do
          let(:filenames) { [] }

          it 'merges verbose with default options' do
            @cli.options.should == @default_options.merge(verbose: true)
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'merges verbose with default options' do
            @cli.options.should == @default_options.merge(verbose: true)
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end

      context 'noop option provided' do
        let(:options) { ['-n'] }

        context 'no filenames provided' do
          let(:filenames) { [] }

          it 'merges verbose and noop with default options' do
            @cli.options.should == @default_options.merge(verbose: true,
                                                         noop: true)
          end

          it 'sets filenames to []' do
            @cli.filenames.should == filenames
          end
        end

        context 'one filename provided' do
          let(:filenames) { ['TV.Show.S01E02.HDTV.test.mp4'] }

          it 'merges verbose and noop with default options' do
            @cli.options.should == @default_options.merge(verbose: true,
                                                         noop: true)
          end

          it 'sets filenames to filename provided' do
            @cli.filenames.should == filenames
          end
        end
      end
    end
  end
end
