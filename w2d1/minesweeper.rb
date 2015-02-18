require 'yaml'

class Game


  def play(*tile)
    puts "Let's play Minesweeper!"

    unless tile[0]
      puts "How many bombs?"
      bomb_num = gets.chomp.to_i
    end

    tile = tile[0] || Player.new(bomb_num)

    board = Board.new
    board.render(tile)
    winner = false
    loser = false

    until winner || loser

      puts "Do you want to choose or flag? (F or C)"
      choice = gets.chomp
      puts "Where? e.g. \"3,4\" for row 3, column 4"
      pos = gets.chomp
      pos = pos.split(',')

      pos_x = pos[0].to_i
      pos_y = pos[1].to_i
      if choice.downcase == "f"
        tile.flag_tile(pos_x,pos_y)
      end
      if choice.downcase == 'c'
        tile.choose_tile(pos_x,pos_y)
        if tile.bombs?([pos_x,pos_y])
          loser = true
          break
        end
      end
        board.render(tile)
      if (81-tile.revealed_tiles.count) == tile.bomb_tiles.count
        winner = true
        break
      end





      puts "Save and quit? (Y/N)"
      leave_game = gets.chomp
      if leave_game.downcase == 'y'
        save_state = tile.to_yaml
        File.open("mine_save.yml", "w") do |f|
          f.puts save_state
        end
        break
      end

    end
    puts "You Win!" if winner
    puts "You Lose!" if loser
    puts "Game End"
  end


end


class Player
  attr_reader :bomb_hash, :bomb_tiles, :flagged_tiles, :revealed_tiles
  MOVES = [
    [1,1],
    [1, -1],
    [-1,1],
    [-1,-1],
    [0, 1],
    [1, 0],
    [-1, 0],
    [0, -1]
  ]

  def initialize(bomb_num)
    @bomb_hash = Hash.new(0)
    @chosen_tiles = []
    @bomb_tiles = populate_bombs(bomb_num)
    @flagged_tiles = []
    @revealed_tiles = []
  end

  def populate_bombs(bomb_num)
    bombs = Array.new
    until bombs.length == bomb_num

      x = (0..8).to_a.sample
      y = (0..8).to_a.sample
      bombs << [x,y] unless bombs.include?([x,y])
      p [x,y]
    end
    bombs
  end

  def choose_tile(choice_x, choice_y)
    choice = [choice_x, choice_y]

    @chosen_tiles << choice unless @chosen_tiles.include?(choice)
    check_adjacent(choice)

  end

  def bombs?(choice)
    @bomb_tiles.include?(choice)
  end

  def check_adjacent(choice)
    bomb_count = 0

    MOVES.each do |move|
      new_move = [choice[0]+move[0], choice[1]+move[1]]
      if exist?(new_move)
        bomb_count+=1 if bombs?(new_move)
      end
    end

    @bomb_hash[choice] = bomb_count unless bomb_count == 0

    @revealed_tiles << choice unless @revealed_tiles.include?(choice)

    if bomb_count == 0
      MOVES.each do |move|
        new_move = [choice[0] + move[0], choice[1]+move[1]]
        next if @revealed_tiles.include?(new_move)
        check_adjacent(new_move) if exist?(new_move)
      end
    end
  end

  def exist?(choice)
    choice.all? {|pos| pos.between?(0,8)}
  end

  def flag_tile(choice_x, choice_y)
    choice = [choice_x, choice_y]
    @flagged_tiles << choice unless @revealed_tiles.include?(choice) ||
      @flagged_tiles.include?(choice)

    p @revealed_tiles
  end

  def check_win
    return true if @flagged_tiles.sort == @bomb_tiles.sort
    return true if 81 - @bomb_tiles.count == @revealed_tiles.count
    false
  end


end



class Board

  def initialize
    @board = Array.new(9){Array.new(9, " * ")}
  end

  def render(tile)
    tile.revealed_tiles.each do |i|
      pos = [i[0],i[1]]
      if tile.bomb_hash.has_key?(pos)
        @board[i[0]][i[1]] = " #{tile.bomb_hash[pos]} "
      else
        @board[i[0]][i[1]] = " _ "
      end
    end
    tile.flagged_tiles.each do |k|
      pos = [k[0],k[1]]
      @board[k[0]][k[1]] = " F "
    end
    @board.each{|row|p row}
    true
  end



end


if __FILE__ == $PROGRAM_NAME
  unless ARGV.empty?
    tile = YAML.load_file(ARGV.shift)
    game = Game.new
    game.play(tile)
  else
    game = Game.new
    game.play
  end
end
