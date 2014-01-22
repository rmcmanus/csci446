class Player
  def initialize
    @health = 20
    @player_under_attack = false
    @reached_back_wall = false
    @directions = {"forward" => :forward, "backward" => :backward}
    @movement_direction = @directions.fetch("forward")
  end

  def play_turn(warrior)
    @warrior = warrior
    back_wall

    if (@health > @warrior.health)
      @player_under_attack = true
    else
      @player_under_attack = false
    end

    if @warrior.feel.wall?
      @warrior.pivot!
      return
    end

    if (@player_under_attack && !enemy_check? && @warrior.health < 10)
      change_direction
      @warrior.walk! @movement_direction
      change_direction
      return
    # Checks to make sure there is no enemy ahead, and then heals and returns
    # Returns because if the player rests, that's all he can do until the next turn
    elsif (!@player_under_attack) && (@warrior.health < 20) && !enemy_check? && !(@warrior.feel(@movement_direction).stairs?)
      @warrior.rest!
      @health = @warrior.health
      return
    else
      if !@reached_back_wall
        check_backwards
      else
        look_forwards
      end
    end
    
    @health = @warrior.health
  end

  def check_backwards()
    if !(@warrior.feel(@movement_direction).wall?) && !(@reached_back_wall)
      if !@warrior.feel(@movement_direction).empty?
        if !@warrior.feel(@movement_direction).captive?
          @warrior.attack! @movement_direction
        else
          @warrior.rescue! @movement_direction
        end
      else
        @warrior.walk! @movement_direction
      end
    else
      @reached_back_wall = true
      change_direction
      
      look_forwards
      @health = @warrior.health
    end
  end

  def check_forwards()
    if !@warrior.feel.empty?
      if !@warrior.feel.captive?
        @warrior.attack!
      else
        @warrior.rescue!
      end
    else
      @warrior.walk!
    end
  end

  def look_forwards()
    if enemy_check?
      @warrior.shoot! @movement_direction
    else
      check_forwards
    end
  end

  def enemy_check?
    @warrior.look(@movement_direction).each do |space|
      if space.enemy?
        return true
      elsif space.captive?
        return false
      end
    end
    return false
  end

  def back_wall
    if @reached_back_wall
      @movement_direction = @directions.fetch("forward")
    else
      @movement_direction = @directions.fetch("backward")
    end
  end

  def change_direction
    if @movement_direction == @directions.fetch("forward")
      @movement_direction = @directions.fetch("backward")
    else
      @movement_direction = @directions.fetch("forward")
    end
  end


end
