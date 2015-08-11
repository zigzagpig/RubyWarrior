class Player
  @health
  def play_turn(warrior)
    # 每个回合角色的策略
    if warrior.feel.enemy? #攻击敌人是第一优先
      warrior.attack!  #有敌人就攻击
    elsif warrior.feel.captive?
      warrior.rescue!
    elsif @health.to_i <= warrior.health  #没有收到伤害
    	if warrior.health == 20
    		warrior.walk!  #满血才向前走
    	else
    		warrior.rest!  #休息回血
    	end
    else #受到伤害
    	if warrior.feel.empty?  #前方为空
    		warrior.walk!  #向前走找敌人
    	end
		end
		@health = warrior.health
  end
end