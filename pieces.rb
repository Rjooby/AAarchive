

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
    return {color: color, pos: pos, class: self.class.to_s}.inspect
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
