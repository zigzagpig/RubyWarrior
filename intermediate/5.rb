
class Player
  def play_turn(warrior)
    # 每个回合角色的行动策略

    if warrior.listen.first.nil? #场上已经没有怪了
      warrior.walk!(warrior.direction_of_stairs) #解决所有怪和俘虏就走向楼梯过关

    elsif warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就致盲
      warrior.bind!(:forward)
    elsif warrior.feel(:left).enemy?
      warrior.bind!(:left)
    elsif warrior.feel(:right).enemy?
      warrior.bind!(:right)
    elsif warrior.feel(:backward).enemy?
      warrior.bind!(:backward)

    elsif warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就攻击 #这几行代码不会被执行
      warrior.attack!(:forward)
    elsif warrior.feel(:left).enemy?
      warrior.attack!(:left)
    elsif warrior.feel(:right).enemy?
      warrior.attack!(:right)
    elsif warrior.feel(:backward).enemy?
      warrior.attack!(:backward)
      
    elsif warrior.health < 20
      warrior.rest!

    elsif warrior.feel(:forward).wall? && warrior.feel(:left).wall? #特殊格子，右上角救右边的友军
      warrior.rescue!(:right)
    elsif warrior.feel(:forward).captive?  #查看四周有没有友军俘虏，有就救援
      warrior.attack!(:forward)
    elsif warrior.feel(:left).captive?
      warrior.attack!(:left)
    elsif warrior.feel(:right).captive?
      warrior.attack!(:right)
    elsif warrior.feel(:backward).captive?
      warrior.attack!(:backward)

    elsif warrior.feel(:left).empty? && !warrior.feel(:left).wall?  #左边是空的就往左边走
      warrior.walk!(:left)
    elsif warrior.feel(:forward).empty? #前面是空的就往前面走
      warrior.walk!(:forward)
    end
    
  end
end
  