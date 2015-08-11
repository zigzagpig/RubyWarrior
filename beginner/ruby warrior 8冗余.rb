class Player
  @health
  @direction
  def play_turn(warrior)
    # 每个回合角色的策略
    if @direction.nil?  #初始化方向
      @direction = false
    elsif warrior.feel.wall?   #查看前方是不是墙
      @direction = false
    elsif warrior.feel(:backward).wall?   #查看后方是不是墙
      @direction = true
    end
    
    detail = warrior.look   #查看周围情况
    first = detail[0] if detail[0]
    if !detail[0].empty?
      first = detail[0]
    elsif !detail[1].empty?
      first = detail[1]
    else
      first = detail[2]
    end
    
    if first.empty? || first.wall?
       warrior.walk!
    elsif first.enemy? #查看前方是否有敌人
      warrior.shoot!  #有敌人就攻击
    elsif warrior.feel.wall?   #查看前方是不是墙
      #warrior.pivot!
    #elsif warrior.feel(:backward).enemy? #看后面有没有敌人
    #  warrior.attack!(:backward)
    elsif first.captive? #查看前方有没有友军
      if warrior.feel.captive?
        warrior.rescue! #有就救
      else
        warrior.walk!
      end
    elsif warrior.feel(:backward).captive? #查看后方有没有友军
      warrior.rescue!(:backward)
    elsif @health.to_i <= warrior.health  #没有收到伤害
    	if warrior.health == 20
    	  if @direction == false
    		  warrior.walk!(:backward)  #满血才向前走
    		else
    		  warrior.walk!
    		end
    	else
    		warrior.rest!  #休息回血
    	end
    else #受到伤害
    	if warrior.feel.empty?  #前方为空 向前走找敌人
    		if @direction == true && warrior.health < 10
    		  warrior.walk!(:backward)
    		else
    		  warrior.walk!
    		end  
    	end
		end
		@health = warrior.health
  end
end