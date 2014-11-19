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
