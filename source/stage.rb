class Stage
  include FlowControl

  def initialize
    @drama = Enumerator.new do |yielder|
      @yielder = yielder
      instance_eval { drama }
      loop { yielder.yield }
    end
    @cursor = [0, 0]
  end

  def update
    @drama.next
  end

end