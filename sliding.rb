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

        if !(test_pos.all?{|i|i.between?(0,7)}) || !(@board[test_pos[0]][test_pos[1]].nil?)
          break
        end
      end
    end
    return good_moves
  end



end
