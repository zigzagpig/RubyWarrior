class Player
  @health   #用于存储勇士上回合生命值
  @direction  #用于指示勇士行进方向，之前的关卡会用到。
  def play_turn(warrior)
    # 每个回合角色的策略
    if @direction.nil?  #初始化方向
      @direction = false
    elsif warrior.feel.wall?   #查看前方是不是墙
      @direction = false
    elsif warrior.feel(:backward).wall?   #查看后方是不是墙
      @direction = true
    end
    
    detail = warrior.look(:backward)   #查看周围情况
    if !detail[0].empty?  #查看后方周围情况
      first = detail[0]    #记录第一格非空目标
    elsif !detail[1].empty?
      first = detail[1]
    else
      first = detail[2]
    end
    if first.empty?   #后方为空的话
      detail = warrior.look   #查看前方周围情况
      if !detail[0].empty?    #记录第一格非空目标
        first = detail[0]
      elsif !detail[1].empty?
        first = detail[1]
      else
        first = detail[2]
      end
      back = false
    else
      back = true
    end
    
    if first.empty? || first.wall?
      if warrior.feel.wall?   #查看前方是不是墙
        warrior.pivot!
      else
        warrior.walk!
      end
    elsif first.enemy? #查看前方是否有敌人
      if back == true
        warrior.shoot!(:backward)  #有敌人就射击后面
      else
        warrior.shoot!
      end
    elsif first.captive? #查看前方有没有友军
      if warrior.feel.captive?
        warrior.rescue! #有就救
      else
        warrior.walk!
      end
		end
		@health = warrior.health  #回合结束前纪录勇士当前生命值
  end
end