class Player
  def play_turn(warrior)
    # 每个回合角色的策略
    if warrior.feel.empty?  # 前方为空
      warrior.walk!  #向前走
    elsif warrior.feel.enemy?  #前方有敌人
      warrior.attack!  #攻击
    end
  end
end