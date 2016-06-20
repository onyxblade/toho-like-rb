class EnemyFactory
  def initialize enum
    @enum = enum
  end

  def update
    @enum.next
  end
end