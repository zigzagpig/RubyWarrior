class Player
  def play_turn(warrior)
    # 每个回合角色的行动策略  这局很简单啊
    if warrior.look[1].enemy? && warrior.look[0].enemy? #能炸2个怪才炸
    	warrior.detonate!
    elsif warrior.feel(:forward).captive?	#有救则救
    	warrior.rescue!
    else
    	warrior.walk!	#没有怪和俘虏就前进
    end
  end
end