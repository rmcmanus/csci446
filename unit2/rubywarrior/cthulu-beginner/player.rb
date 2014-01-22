##
# Instance variables:
# => @health
# => @movement_direction
#
# Class variables:
# => @@player_under_attack
# => @@reached_back_wall
#
# Constants:
# => @MAX_HEALTH
#
# Array:
# => In the enemy_check? function below, I stored the current Spaces in front of the player as a local array
# => These are stored in the array variable spaces_array, which is then analyzed for Space information
#
# Hash:
# => The @directions variable holds a hash that contains valid symbolic directions for the player
#
# Functions:
# => Included an initialize function to define instance and class variables, and added the following functions:
# ===> check_backwards - checks condition of space behind player
# ===> check_forwards - checks condition of space in front of player
# ===> look_forwards - looks further ahead to check condition (directional)
# ===> enemy_check? - check on Player#look to see if enemies or captives exist
# ===> back_wall - changes direction if a wall has been found
# ===> change_direction - change the current direction

class Player
  def initialize
    # Starting health of the player
    @health = 20
    # Max health of player
    @MAX_HEALTH = 20
    # Boolean value that determines if the player is currently under attack by an enemy
    @@player_under_attack = false
    # Has the player reached the back wall? This changes regardless of where the player starts
    @@reached_back_wall = false
    # Hash that contains directions as needed for movement
    @directions = {"forward" => :forward, "backward" => :backward}
    # Direction variable
    @movement_direction = @directions.fetch("forward")
  end

  def play_turn(warrior)
    @warrior = warrior
    # Changes direction of movement with hash by checking if the back wall has 
    # been reached using @reached_back_wall
    back_wall

    # Checks to see if the player's health has changed since the last round.
    # If it has, then the player is under attack, changing @player_under_attack.
    if (@health > @warrior.health)
      @player_under_attack = true
    else
      @player_under_attack = false
    end

    # Pivots warrior if a wall is in the direction of movement
    if @warrior.feel.wall?
      @warrior.pivot!
      return
    end

    # If the player is under attack by a ranged enemy, change the current direction,
    # move the player away, and change the direction back.

    # Conditional if the player is under attack, there are no enemies close,
    # and the warrior's health is low.
    if (@player_under_attack && !enemy_check? && @warrior.health < 10)
      change_direction
      @warrior.walk! @movement_direction
      change_direction
      return
    # Checks to make sure there is no enemy ahead, and then heals and returns
    # Returns because if the player rests, that's all he can do until the next turn
    elsif (!@player_under_attack) && (@warrior.health < @MAX_HEALTH) && !enemy_check? && !(@warrior.feel(@movement_direction).stairs?)
      @warrior.rest!
      @health = @warrior.health
      return
    # Else, we begin initiating player movement
    else
      if !@reached_back_wall
        check_backwards
      else
        look_forwards
      end
    end
    
    @health = @warrior.health
  end

  ##
  # Checks movement backwards; movement is very similar to forward movement, but deals with
  # enemies and captives behind the player, especially if starting in the middle of a room.
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

  ##
  # Checks movement forwards; movement is dictated by whether an enemy appears in front
  # of the player or the space has a captive; if neither of these conditions pass, the player
  # is moved forward one space, and the turn is ended.
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

  ##
  # Checks if an enemy exists by calling enemy_check?, and acts appropriately.
  # If an enemy, the warrior fires; otherwise, forward motion is initiated.
  def look_forwards()
    if enemy_check?
      @warrior.shoot! @movement_direction
    else
      check_forwards
    end
  end

  ##
  # Checks for an enemy in the 3 Spaces in front of the warrior by calling
  # Player#look; this information is stored in an array, and then iterated over,
  # checking to see if either enemies or captives exist.
  #
  # If an enemy is found first, return true (enemy present)
  # Else if a captive is found first, return false (no enemy present)
  # Otherwise, the function just returns false (empty Spaces)
  def enemy_check?
    spaces_array = @warrior.look(@movement_direction)
    spaces_array.each do |space|
      if space.enemy?
        return true
      elsif space.captive?
        return false
      end
    end
    return false
  end

  ##
  # Changes the current direction based on whether the player has encountered the
  # back wall yet.
  def back_wall
    if @reached_back_wall
      @movement_direction = @directions.fetch("forward")
    else
      @movement_direction = @directions.fetch("backward")
    end
  end

  ##
  # Funtion to quickly the direction oppostive of the currently selected direction
  def change_direction
    if @movement_direction == @directions.fetch("forward")
      @movement_direction = @directions.fetch("backward")
    else
      @movement_direction = @directions.fetch("forward")
    end
  end

end