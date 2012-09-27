module Renmov
  class BasicRenamer
    attr_reader :filename
    def initialize(filename)
      @filename = filename.downcase
    end

    def rename
      title   = get_title
      season  = get_season
      episode = get_episode
      format  = get_format

      "#{title}.s#{season}e#{episode}.#{format}"
    end

    def get_title
      title = filename.dup
      title.gsub!(/\Athe\./, '')
      title.gsub!(/(\.20\d\d)?\.s\d\de\d\d.*/, '')

      title
    end

    def get_season
      season = filename.dup
      season.gsub!(/.*\.s(\d\d).*/, '\1')

      season
    end

    def get_episode
      episode = filename.dup
      episode.gsub!(/.*\.s\d\de(\d\d).*/, '\1')

      episode 
    end

    def get_format
      format = filename.dup
      format.gsub!(/.*\.(...)\z/, '\1')

      format
    end
  end
end
