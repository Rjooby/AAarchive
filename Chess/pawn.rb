class Pawn < Piece

  attr_accessor :rep

  def moves
    poss_moves = move_dir
    good_moves = []
    #poss_moves.take(2).each do |i|
    w,x,y,z = poss_moves
    piece_row, piece_column = @pos

    non_capture = [w,x]
    capture = [y,z]

    #p [@pos[0],@pos[1]]
    #p [x[0]+@pos[0],@pos[1]]

    if @board[w[0]+@pos[0]][@pos[1]].nil?
       good_moves << [w[0]+@pos[0],@pos[1]]
       #p @board[x[0]+@pos[0]][x[1]+@pos[1]]
       #puts @board[x[0]+@pos[0]][@pos[1]].nil?
       if @first_move && @board[x[0]+@pos[0]][@pos[1]].nil?
         good_moves << [x[0]+@pos[0],@pos[1]]
       end
    end

    capture.each do |i|
      delta_row,delta_column = i
      new_row = piece_row+delta_row
      new_column = piece_column+delta_column
      if !@board[new_row][new_column].nil? && @board[new_row][new_column].color != self.color
        good_moves << [new_row,new_column]
      end
    end
    #p "good_moves = #{good_moves}"
    good_moves
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
    return (self.color == :white ? whiteness : blackness)

  end


  def initialize(pos, color, board)
    super(pos, color, board)
    @board = board.board
    @rep = (color == :black ? 'P' : 'p')
  end
end
