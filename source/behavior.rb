class Behavior
  def initialize &block
    @enum = Enumerator.new do |yielder|
      @yielder = yielder
      instance_eval(&block)
      loop do
        yielder.yield nil
      end
    end
  end

  def next
    @enum.next
  end

  private

    def start_by hash = {}
      @yielder.yield hash
    end
end