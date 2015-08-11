class Player
  def play_turn(warrior)
    # 每个回合角色的策略
    if warrior.feel.empty?  #前方为空
      if warrior.health == 20
        warrior.walk!  #满血才向前走
      else
        warrior.rest!  #休息回血
      end
    elsif warrior.feel.enemy?  #前方有敌人
      warrior.attack!  #攻击
    end
  end
end
  