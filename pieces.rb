class Piece
  attr_accessor :color, :rep, :pos
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @first_move = true

    @board[pos[0]][pos[1]] = self
  end

  def make_move

  end

  def inspect
  end

  def valid_move?(pos) #pos= [x,y]
    x,y = pos
    if [x,y].any?{|i| !i.between?(0,7)}
      return false
    end

    if @board[x][y].nil?
      return true
    elsif @board[x][y].color == self.color
      return false
    else
      return true
    end
  end


end

class SlidingPiece < Piece



  def moves
    poss_moves = move_dir

    my_pos = @pos
    good_moves = []
    poss_moves.each do |dir|
      (1..7).to_a.each do |space|
        test_pos = [my_pos[0]+(space*dir[0]),my_pos[1]+(space*dir[1])]
        if valid_move?(test_pos)
          good_moves << test_pos

        end
        p test_pos
        if !(test_pos.all?{|i|i.between?(0,7)}) || !(@board[test_pos[0]][test_pos[1]].nil?)
          break
        end
      end
    end
    return good_moves
  end



end

class SteppingPiece < Piece
  def moves
    poss_moves = move_dir

    moves = []
    poss_moves.each do |d|
      p_move = [@pos[0]+d[0],@pos[1]+d[1]]
      if valid_move?(p_move)
        moves.push(p_move)
      end
    end
    moves
  end


end


class Rook < SlidingPiece

  attr_accessor :move_dir, :rep

  def move_dir
    [
    [1,0],
    [0,1],
    [-1,0],
    [0,-1]
    ]
  end

  def initialize(pos, color, board)
    super(pos, color, board)
    @rep = 'r' if color != 'black'
    @rep = 'R' if color == 'black'
  end
end

class Bishop < SlidingPiece
  attr_accessor :move_dir, :rep

  def move_dir
    [
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
    ]
  end

  def initialize(pos, color, board)
    super(pos, color, board)
    @rep = 'b' if color != 'black'
    @rep = 'B' if color == 'black'
  end
end

class Queen < SlidingPiece
  attr_accessor :move_dir, :rep

  def move_dir
    [
    [1,0],
    [0,1],
    [-1,0],
    [0,-1],
    [1,1],
    [1,-1],
    [-1,1],
    [-1,-1]
    ]
  end

  def initialize(pos, color, board)
    super(pos, color, board)
    @rep = 'q' if color != 'black'
    @rep = 'Q' if color == 'black'
  end
end

class Knight < SteppingPiece
  attr_accessor :rep, :DELTA

  def move_dir
    [
      [2,1],
      [-2,1],
      [2,-1],
      [-2,-1],
      [1,2],
      [-1,-2],
      [1,-2],
      [-1,2],
    ]
  end

  def initialize(pos, color, board)
    super(pos, color, board)
    @rep = 'k' if color != 'black'
    @rep = 'K' if color == 'black'
  end
end

class King < SteppingPiece
  attr_accessor :rep

  def move_dir
    [
      [1,1],
      [0,1],
      [1,0],
      [0,0],
      [1,-1],
      [-1,1],
      [-1,0],
      [0,-1],
    ]
  end

  def initialize(pos, color, board)
    super(pos, color, board)
    @rep = '$' if color != 'black'
    @rep = '&' if color == 'black'
  end
end

class Pawn < Piece

  attr_accessor :rep

  def moves
    poss_moves = move_dir
    good_deltas = []
    #poss_moves.take(2).each do |i|

    if @board[poss_moves[0][0]+@pos[0]][poss_moves[0][1]+@pos[1]].nil?
       good_deltas << [poss_moves[0][0]+@pos[0],poss_moves[0][1]+@pos[1]]
       if @first_move && @board[poss_moves[1][0]+@pos[0]][poss_moves[1][1]+@pos[1]].nil?
         good_deltas << [poss_moves[1][0]+@pos[0],poss_moves[1][1]+@pos[1]]
       end
    end
    poss_moves.drop(2).each do |i|
      if !@board[@pos[0]+i[0]][@pos[1]+i[1]].nil? && @board[@pos[0]+i[0]][@pos[1]+i[1]].color != self.color
        good_deltas << [@pos[0]+i[0],@pos[1]+i[1]]
      end
    end
    good_deltas
  end

  def move_dir
    blackness = [
      [1,0],
      [2,0],
      [1,1],
      [1,-1]
    ]
    whiteness = [
      [-1,0],
      [-2,0],
      [-1,1],
      [-1,-1]

    ]
    return blackness if self.color == 'white'
    return whiteness if self.color != 'white'
  end


  def initialize(pos, color, board)
    super(pos, color, board)

    @rep = 'p' if color != 'black'
    @rep = 'P' if color == 'black'
  end
end
