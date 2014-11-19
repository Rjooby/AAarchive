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
    @rep = (color == :black ? '&' : '$')
  end
end
