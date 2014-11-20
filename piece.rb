# encoding: utf-8


class Piece

  attr_reader :color, :rank, :pos, :board
  def initialize(color, pos, board, rank = Pawn)
    @color = color
    @rank = rank
    @pos = pos
    @board = board
  end

  def [](pos)
    x,y = pos
    @board[x][y]
  end

  def []=(pos,piece)
    x,y = pos
    @board[x][y] = piece
  end

  def rep
    @color == :black ? "\u25C9".encode('utf-8') : "\u25cc".encode('utf-8')
  end

  def perform_moves(move_sequence)
    perform_moves! if valid_move_seq?(move_sequence)
  end

  def perform_moves!(move_sequence)
    #move_sequence should be an array of coordinate steps
    if move_sequence.size == 1
      if !self.perform_slide(move_sequence[0])
        return false if !self.perform_jump(move_sequence[0])
      end
    else
      start = self.pos
      move_sequence.each do |move|
        return false if !(@board[start].perform_jump(move))
        start = move
      end
    end
    true
  end

  def valid_move_seq?(move_sequence)

    dupped = Board.new(true)
    @board.board.each_with_index do |row, x|
      row.each_with_index do |space,y|
        next if space.nil?
        dupped[[x,y]] = Piece.new(space.color, space.pos, dupped, space.rank)
      end
    end

    dupped[self.pos].perform_moves!(move_sequence)

  end


  def perform_slide(end_pos)
    #use diff of two positions to see valid rather than moves method
    if slide_moves.include?(end_pos)
      @board[@pos] = nil
      @board[end_pos] = self
      @pos = end_pos
    else
      return false
    end
    return true
  end

  def perform_jump(end_pos)
    if jump_moves.include?(end_pos)
      jumped_pos = [(@pos[0]+end_pos[0])/2, (@pos[1]+end_pos[1])/2]
      @board[@pos] = nil
      @board[end_pos] = self
      @pos = end_pos
      @board[jumped_pos] = nil
    else
      return false
    end
    true
  end

  def slide_moves
    legal_moves = []
    og_x,og_y = @pos
    slide_x = (self.color == :black ? -1 : 1)

    [1,-1].each do |delta|
      new_move = [og_x+slide_x, og_y+delta]

      legal_moves << new_move unless @board[new_move] != nil
      if self.rank == :King
        new_move = [og_x-slide_x, og_y+delta]
        legal_moves << new_move unless @board[new_move] != nil
      end
    end
    legal_moves.select{|pos| pos.all?{|i| i.between?(0,7)}}
      end

  def jump_moves
    legal_moves = []
    og_x, og_y = @pos
    jump_x = (self.color == :black ? -2 : 2)

    [2,-2].each do |delta|
      new_move = [og_x+jump_x, og_y+delta]
      jumped_space = [og_x + jump_x/2, og_y + (delta/2)]

      next if @board[jumped_space].nil? || @board[jumped_space].color == self.color
      legal_moves << new_move if @board[new_move].nil?

      if self.rank == :King
        new_move = [og_x-jump_x, og_y+delta]
        jumped_space = [(og_x - jump_x)/2, (og_y + delta)/2]

        next if @board[jumped_space].nil? || @board[jumped_space].color == self.color
        legal_moves << new_move if @board[new_move].nil?
      end
    end

    legal_moves.select{|pos| pos.all?{|i| i.between?(0,7)}}
  end

  def inspect
  end

end
