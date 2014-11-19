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
    @rep = (color == :black ? 'R' : 'r')
  end
end
