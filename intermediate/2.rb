
class Player
  def play_turn(warrior)
    # 每个回合角色的行动策略
    
    if warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就攻击
      warrior.attack!(:forward)
    elsif warrior.feel(:left).enemy?
      warrior.attack!(:left)
    elsif warrior.feel(:right).enemy?
      warrior.attack!(:right)
    elsif warrior.feel(:backward).enemy?
      warrior.attack!(:backward)
    
    else
      if warrior.health < 20  #生命值小于20就回血
        warrior.rest!
      else
        warrior.walk!(warrior.direction_of_stairs)  #没敌人且满血就向楼梯走
      end
    end
  end
end