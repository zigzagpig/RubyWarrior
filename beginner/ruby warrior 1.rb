class Player
  def play_turn(warrior)
    # 每个回合角色的策略
    warrior.walk!
  end
end