class Presenter
  include FlowControl

  def initialize &block
    @alive = true
    @enum = Enumerator.new do |enum|
      @yielder = enum
      instance_eval &block
    end
  end

  def update
    @enum.next
  rescue StopIteration
    @alive = false
  end

  def alive?
    @alive
  end

end