class Pawn < Piece

  attr_accessor :rep

  def moves
    poss_moves = move_dir
    good_moves = []
    #poss_moves.take(2).each do |i|
    w,x,y,z = poss_moves
    if @board[w[0]+@pos[0]][w[1]+@pos[1]].nil?
       good_moves << [w[0]+@pos[0],w[1]+@pos[1]]
       #p @board[x[0]+@pos[0]][x[1]+@pos[1]]
       if @first_move && @board[x[0]+@pos[0]][x[1]+@pos[1]].nil?
         good_moves << [x[0]+@pos[0],x[1]+@pos[1]]
       end
    end
    poss_moves.drop(2).each do |i|
      if !@board[@pos[0]+i[0]][@pos[1]+i[1]].nil? && @board[@pos[0]+i[0]][@pos[1]+i[1]].color != self.color
        good_moves << [@pos[0]+i[0],@pos[1]+i[1]]
      end
    end
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
    @rep = (color == :black ? 'P' : 'p')
  end
end
