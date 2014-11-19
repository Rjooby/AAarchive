

class Board

  attr_accessor :board

  def initialize(empty = false,check_mate = false)
    @board = Array.new(8){Array.new(8)}
    init_pieces unless empty || check_mate
    init_check_mate_pieces if check_mate
  end

  def init_check_mate_pieces
      Queen.new([0,2],:black,self)
      Rook.new([1,2],:black,self)
      King.new([0,0],:white,self)
      King.new([7,7],:black,self)
  end

  def init_pieces

    Rook.new([7,0],:white,self)
    Rook.new([7,7],:white,self)
    Bishop.new([7,2],:white,self)
    Bishop.new([7,5],:white,self)
    Knight.new([7,1],:white,self)
    Knight.new([7,6],:white,self)
    King.new([7,4],:white,self)
    Queen.new([7,3],:white,self)
    Pawn.new([6,0],:white,self)
    Pawn.new([6,1],:white,self)
    Pawn.new([6,2],:white,self)
    Pawn.new([6,3],:white,self)
    Pawn.new([6,4],:white,self)
    Pawn.new([6,5],:white,self)
    Pawn.new([6,6],:white,self)
    Pawn.new([6,7],:white,self)

    Rook.new([0,0],:black,self)
    Rook.new([0,7],:black,self)
    Bishop.new([0,2],:black,self)
    Bishop.new([0,5],:black,self)
    Knight.new([0,1],:black,self)
    Knight.new([0,6],:black,self)
    King.new([0,4],:black,self)
    Queen.new([0,3],:black,self)
    Pawn.new([1,0],:black,self)
    Pawn.new([1,1],:black,self)
    Pawn.new([1,2],:black,self)
    Pawn.new([1,3],:black,self)
    Pawn.new([1,4],:black,self)
    Pawn.new([1,5],:black,self)
    Pawn.new([1,6],:black,self)
    Pawn.new([1,7],:black,self)

  end

  def play

  end

  def black_king
    black_pieces.each do |piece|
      if piece.class == King
        return piece
      end
    end
  end

  def white_king
    white_pieces.each do |piece|
      if piece.class == King
        return piece
      end
    end
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
    raise 'There is no piece here' if board[x][y].nil?
    i,j = end_pos
    piece = @board[x][y]
    if piece.moves.include?(end_pos)
      if !(move!(start_pos, end_pos))
        @board[x][y] = nil
        @board[i][j] = piece
        piece.pos = [i,j]
        #reassign_board_pos(piece)
      else
        raise 'This move puts you in check, silly'
      end

    else
    raise 'Cannot move that piece to that position'
    end
    self.render
  end

  def move!(start_pos,end_pos)
    dupped = self.deep_dup
    x,y = start_pos
    i,j = end_pos
    color = @board[x][y].color
    piece = dupped.board[x][y]
    dupped.board[i][j] = piece
    dupped.board[x][y] = nil
    piece.pos = [i,j]
    #dupped.render
    dupped.in_check?(color)

  end

  def in_check?(color)

    opp_pieces = (color == :black ? white_pieces : black_pieces)
    our_king_pos = (color == :black ? self.black_king.pos : self.white_king.pos)

    opp_pieces.each do |opp_piece|
      return true if opp_piece.moves.include?(our_king_pos)
    end

    false

  end


  def checkmate?
    white_mated = false
    black_mated = false
    white_pieces.each do |piece|
      if piece.moves.all? { |move| move!(piece.pos,move)}
        white_mated = true
      else
        white_mated = false
        break
      end
    end
    black_pieces.each do |piece|
      if piece.moves.all? { |move| move!(piece.pos,move)}
        black_mated = true
      else
        black_mated = false
        break
      end
    end
    return black_mated || white_mated
  end

  def deep_dup
    collect = Board.new(true)
    @board.each_with_index do |row,i|
      row.each_with_index do |piece,j|
        collect.board[i][j] = piece.class.new([i,j],piece.color,collect) unless piece.nil?
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
