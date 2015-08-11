class Player
  @detonate
  def play_turn(warrior)
    # 每个回合角色的行动策略
    # 烂泥代码，想睡觉了，前10个回合特殊处理，之后听怪得位置一一解决
    if @detonate.nil?
      @detonate = 1
    end

    if @detonate == 1
      warrior.bind!(:right)
      @detonate = 2
    elsif @detonate == 2
      warrior.detonate!(:left)
      @detonate = 3
    elsif @detonate == 3
      warrior.attack!(:left)
      @detonate = 4
    elsif @detonate == 4
      warrior.walk!(:left)
      @detonate = 5
    elsif @detonate == 5
      warrior.attack!(:forward)
      @detonate = 6
    elsif @detonate == 6
      warrior.attack!(:forward)
      @detonate = 7
    elsif @detonate == 7
      warrior.walk!
      @detonate = 8
    elsif @detonate == 8
      warrior.bind!(:right)
      @detonate = 9
    elsif @detonate == 9
      warrior.rescue!(:forward)
      @detonate = 10
    else


    if warrior.listen.first.nil?  #防止无声音时变量为空空的错误
      direction = nil
    else
      direction = warrior.direction_of(warrior.listen.first) #听到声音后处理第一个发出声音的地方
    end

    # if warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就致盲
    #   warrior.bind!(:forward)
    # elsif warrior.feel(:left).enemy?
    #   warrior.bind!(:left)
    # elsif warrior.feel(:right).enemy?
    #   warrior.bind!(:right)
    # elsif warrior.feel(:backward).enemy?
    #   warrior.bind!(:backward)
      
    if warrior.feel(:forward).enemy?  #查看四周有没有敌人，有就攻击 #这几行代码不会被执行
      warrior.attack!(:forward)
    elsif warrior.feel(:left).enemy?
      warrior.attack!(:left)
    elsif warrior.feel(:right).enemy?
      warrior.attack!(:right)
    elsif warrior.feel(:backward).enemy?
      warrior.attack!(:backward)
    
    elsif warrior.health < 20  #生命值小于20就回血
      warrior.rest!
    
    elsif warrior.feel(:forward).captive?  #查看四周有没有友军俘虏，有就救援
      warrior.rescue!(:forward)
    elsif warrior.feel(:left).captive?
      warrior.rescue!(:left)
    elsif warrior.feel(:right).captive?
      warrior.rescue!(:right)
    elsif warrior.feel(:backward).captive?
      warrior.rescue!(:backward)
    
    else
      if warrior.health < 20  #生命值小于20就回血
        warrior.rest!
      else
        if direction.nil?
          warrior.walk!(warrior.direction_of_stairs) #解决所有怪和俘虏就走向楼梯过关
        else
          warrior.walk!(direction)  #有声音就朝声音的地方走
        end
      end
    end


    end

  end
end