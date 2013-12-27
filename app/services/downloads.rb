require 'open-uri'

class Downloads
  def call(url_string)
    url_string = url_string.to_s

    extension = url_string.split('.').last

    Tempfile.new(['', ".#{extension}"]).tap do |file|
      file.binmode # note that our tempfile must be in binary mode
      file.write open(url_string).read
      file.rewind
    end
  end
end
