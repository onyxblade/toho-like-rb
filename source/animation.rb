class Animation
  def initialize
    enum_block = yield
    @enum = Enumerator.new &enum_block
  end

  def next
    @enum.next
  end

  def rewind
    @enum.rewind
  end
end