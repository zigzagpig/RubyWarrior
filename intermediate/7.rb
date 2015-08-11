
class Player
  def play_turn(warrior)
    # 每个回合角色的行动策略
    sounds = warrior.listen
    if sounds.first.nil?  #防止无声音时变量为空的错误
      direction = nil
    else
      direction = warrior.direction_of(warrior.listen.first) #听到声音后处理第一个发出声音的地方
    end

    if sounds.count >= 5 #烂代码,不能用循环，对块不熟悉，获取俘虏的方位
      captive = sounds[4] if sounds[4].ticking?
    end
    if sounds.count >= 4 #烂代码,不能用循环，对块不熟悉，获取俘虏的方位
      captive = sounds[3] if sounds[3].ticking?
    end
    if sounds.count >= 3
      captive = sounds[2] if sounds[2].ticking?
    end
    if sounds.count >= 2
      captive = sounds[1] if sounds[1].ticking?
    end
    if sounds.count >= 1
      captive = sounds[0] if sounds[0].ticking?
    end

    if warrior.listen.first.nil? #场上已经没有怪了
      warrior.walk!(warrior.direction_of_stairs) #解决所有怪和俘虏就走向楼梯过关
    elsif warrior.feel(:forward).enemy?  #查看前面有没有敌人，有就攻击
      warrior.attack!(:forward)
    
    elsif warrior.feel(:forward).ticking?  #查看四周有没有友军俘虏，有就救援
      warrior.rescue!(:forward)
    elsif warrior.feel(:left).ticking?
      warrior.rescue!(:left)
    elsif warrior.feel(:right).ticking?
      warrior.rescue!(:right)
    elsif warrior.feel(:backward).ticking?
      warrior.rescue!(:backward)

    elsif !(captive.nil?) #存在未被拯救的俘虏
      if !warrior.feel(:right).wall?
        warrior.walk!(:right)
      else
        warrior.walk!(warrior.direction_of(captive))
      end
    elsif warrior.feel(:forward).captive?  #查看四周有没有友军俘虏，有就救援
      warrior.rescue!(:forward)
    elsif warrior.feel(:left).captive?
      warrior.rescue!(:left)
    elsif warrior.feel(:right).captive?
      warrior.rescue!(:right)
    elsif warrior.feel(:backward).captive?
      warrior.rescue!(:backward)

    #elsif warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就致盲
    #  warrior.bind!(:forward)
    #elsif warrior.feel(:left).enemy?
    #  warrior.bind!(:left)
    #elsif warrior.feel(:right).enemy?
    #  warrior.bind!(:right)
    #elsif warrior.feel(:backward).enemy?
    #  warrior.bind!(:backward)

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

    elsif warrior.feel(:left).empty? && !warrior.feel(:left).wall?  #左边是空的就往左边走
      warrior.walk!(:left)
    elsif warrior.feel(:forward).empty? #前面是空的就往前面走
      warrior.walk!(direction)
    end
    
  end
end
  