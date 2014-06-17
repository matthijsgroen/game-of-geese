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

  def next_after_with_skipping(player)
    loop do
      player = next_after_without_skipping(player)
      return player if player.allowed_to_play?
    end
  end
  alias_method :next_after_without_skipping, :next_after
  alias_method :next_after, :next_after_with_skipping
end
