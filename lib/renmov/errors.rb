module Renmov
  class NoFilenameError < StandardError
    def to_s
      'no filename(s) provided'
    end
  end
end
