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
    @board = board.board
    @rep = (color == :black ? 'K' : 'k')

  end
end
