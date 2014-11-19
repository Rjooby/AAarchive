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
    @board = board.board
    @rep = (color == :black ? 'B' : 'b')
  end
end
