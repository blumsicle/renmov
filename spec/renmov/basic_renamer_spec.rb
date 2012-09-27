require 'spec_helper'

module Renmov
  describe BasicRenamer do
    let(:renamer) { BasicRenamer.new(filename) }
    describe '#rename' do
      let(:filename) { 'TV.Show.S01E02.HDTV.test.mp4' }

      it 'returns new filename' do
        renamer.rename.should == 'tv.show.s01e02.mp4'
      end
    end

    describe '#get_title' do
      context 'title is a regular title' do
        let(:filename) { 'TV.Show.S01E02.HDTV.test.mp4' }

        it 'returns only the title' do
          renamer.get_title.should == 'tv.show'
        end
      end

      context 'title begins with "the"' do
        let(:filename) { 'The.TV.Show.S01E02.HDTV.test.mp4' }
        
        it 'returns title without "the"' do
          renamer.get_title.should == 'tv.show'
        end
      end

      context 'title contains the year at the end' do
        let(:filename) { 'TV.Show.2012.S01E02.HDTV.test.mp4' }

        it 'returns title without the year' do
          renamer.get_title.should == 'tv.show'
        end
      end
    end

    describe '#get_season' do
      context 'season is in regular format' do
        let(:filename) { 'TV.Show.S01E02.HDTV.test.mp4' }

        it 'returns only the season number' do
          renamer.get_season.should == '01'
        end
      end
    end

    describe '#get_episode' do
      context 'episode is in regular format' do
        let(:filename) { 'TV.Show.S01E02.HDTV.test.mp4' }

        it 'returns only the episode number' do
          renamer.get_episode.should == '02'
        end
      end
    end

    describe '#get_format' do
      context 'format is "mp4"' do
        let(:filename) { 'TV.Show.S01E02.HDTV.test.mp4' }

        it 'returns only "mp4"' do
          renamer.get_format.should == 'mp4'
        end
      end

      context 'format is "avi"' do
        let(:filename) { 'TV.Show.S01E02.HDTV.test.avi' }

        it 'returns only "avi"' do
          renamer.get_format.should == 'avi'
        end
      end
    end
  end
end
