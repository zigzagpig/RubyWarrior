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
    elsif first.captive? #查看前方有没有友军
      if warrior.feel.captive?
        warrior.rescue! #有就救
      else
        warrior.walk!
      end
		end
		@health = warrior.health
  end
end