module Behavior
  include ::FlowControl

  def initialize *arg, &block
    super(*arg, &block)
    if block_given?
      initialize_behavior &block
    else
      initialize_behavior {}
    end
  end

  def initialize_behavior &block
    @behavior = Enumerator.new do |yielder|
      @yielder = yielder
      instance_eval(&block)
      loop do
        yielder.yield nil
      end
    end
    @behavior.next
  end

  def update
    @behavior.next
    super
  end

  def set hash = {}
    hash.each{|key, value| instance_variable_set("@#{key}", value)}
  end

end