
class Player
  def play_turn(warrior)
    # 每个回合角色的行动策略
    warrior.walk!(warrior.direction_of_stairs) #根据地图提示的方向接近楼梯
  end
end
  