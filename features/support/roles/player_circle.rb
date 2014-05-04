# This role represents a circle of players,
# positioned clock-wise
module PlayerCircle
  def start
    # the youngest player may start
    sort { |a, b| a.age <=> b.age }.first
  end

  def next_after(player)
    player == last ? first : at(index(player) + 1)
  end
end
