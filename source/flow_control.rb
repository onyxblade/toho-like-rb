module FlowControl
  def wait second
    frames = (second * 60).to_i
    frames.times{ @yielder.yield nil }
  end

  def wait_for &block
    @yielder.yield nil until instance_eval(&block)
  end

  def within second
    frames = (second * 60).to_i
    frames.times{ @yielder.yield yield }
  end
end