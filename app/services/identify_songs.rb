class IdentifySongs
  def initialize(code)
    @code = code
  end

  def call
    @songs ||= client.identify(version: 4.12, code: @code).map(&:with_indifferent_access)
  end

  private

    def client
      Nestling.new.song
    end
end