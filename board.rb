

class Board

  attr_accessor :board, :white_king, :black_king

  def initialize
    @board = [
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil],
      [nil,nil,nil,nil,nil,nil,nil,nil]
    ]

    @white_king = nil
    @black_king = nil
    init_pieces
  end

  def init_pieces

    Rook.new([7,0],:black,@board)
    Rook.new([7,7],:black,@board)
    Bishop.new([7,2],:black,@board)
    Bishop.new([7,5],:black,@board)
    Knight.new([7,1],:black,@board)
    Knight.new([7,6],:black,@board)
    @black_king = King.new([2,4],:black,@board)
    Queen.new([7,3],:black,@board)
    Pawn.new([6,0],:black,@board)
    Pawn.new([6,1],:black,@board)
    Pawn.new([6,2],:black,@board)
    Pawn.new([6,3],:black,@board)
    Pawn.new([6,4],:black,@board)
    Pawn.new([6,5],:black,@board)
    Pawn.new([6,6],:black,@board)
    Pawn.new([6,7],:black,@board)

    Rook.new([0,0],:white,@board)
    Rook.new([0,7],:white,@board)
    Bishop.new([0,2],:white,@board)
    Bishop.new([0,5],:white,@board)
    Knight.new([0,1],:white,@board)
    Knight.new([0,6],:white,@board)
    @white_king = King.new([0,4],:white,@board)
    Queen.new([0,3],:white,@board)
    Pawn.new([1,0],:white,@board)
    Pawn.new([1,1],:white,@board)
    Pawn.new([1,2],:white,@board)
    Pawn.new([1,3],:white,@board)
    Pawn.new([1,4],:white,@board)
    Pawn.new([1,5],:white,@board)
    Pawn.new([1,6],:white,@board)
    Pawn.new([1,7],:white,@board)

  end

  def play

  end


  def inspect
  end

  def reassign_board_pos(piece)
    x,y = piece.pos
    @board[x][y] = nil
    @board[x][y] = piece
  end

  def move(start_pos,end_pos)
    x,y = start_pos
    i,j = end_pos
    piece = @board[x][y]
    if piece.moves.include?(end_pos)
      if !self.will_check?(start_pos, end_pos)
        @board[x][y] = nil
        @board[i][j] = piece
        piece.pos = [i,j]
        reassign_board_pos(piece)
      else
        raise 'This move puts you in check, silly'
      end

    else
    raise 'Cannot move that piece to that position'
    end
    self.render
  end

  def move!(start_pos,end_pos,dupped)
    #dupped = self.deep_dup
    x,y = start_pos
    i,j = end_pos
    piece = dupped.board[x][y]
    dupped.board[x][y] = nil
    dupped.board[i][j] = piece
    piece.pos = [i,j]
    #reassign_board_pos(piece)
  end

  def will_check?(start_pos,end_pos)
    x,y = start_pos
    i,j = end_pos
    dupped = self.deep_dup
    dupped.move!(start_pos,end_pos,dupped)
    dupped.render
    puts dupped.in_check?(:black)
    color = dupped.board[i][j].color unless dupped.board[i][j].nil?

    dupped.in_check?(color)
  end

  def in_check?(color)

    opp_pieces = (color == :black ? white_pieces : black_pieces)
    our_king_pos = (color == :black ? @black_king.pos : @white_king.pos)

    opp_pieces.each do |opp_piece|
      p opp_piece if opp_piece.moves.include?(our_king_pos)
      return true if opp_piece.moves.include?(our_king_pos)
    end

    false

  end


  def deep_dup
    collect = Board.new
    @board.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        collect.board[i][j] = piece.dup unless piece.nil?
      end
    end
    collect
  end

  def pieces
    @board.flatten.compact
  end

  def black_pieces
    pieces.select { |piece| piece.color == :black }
  end

  def white_pieces
    pieces.select { |piece| piece.color == :white }
  end



  def render
    flip = 1
    row_accum = 8
    @board.each do |row|
      flip *= -1
      print "#{row_accum} "
      row_accum -= 1
      row.each do |piece|
        if flip == 1
          flip *= -1
          if piece.nil?
            print "[ ]"
          else
            print "[#{piece.rep}]"
          end
        else
          flip *= -1
          if piece.nil?
            print "{ }"
          else
            print "{#{piece.rep}}"
          end
        end
      end
      puts
    end
    puts "   a  b  c  d  e  f  g  h"
    nil
  end


end
