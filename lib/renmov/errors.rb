module Renmov
  class NoFilenameError < StandardError
    def initialize(*args)
      super('no filename(s) provided', *args)
    end
  end
end
