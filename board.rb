
require_relative 'pieces.rb'
class Board

  attr_accessor :board

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

  def play

  end


  def inspect
  end

  def reassign_board_pos(piece)
    x,y = piece.pos
    @board[x][y] = nil
    @board[x][y] = piece
  end

  def init_pieces

    Rook.new([7,0],'black',@board)
    Rook.new([7,7],'black',@board)
    Bishop.new([7,2],'black',@board)
    Bishop.new([7,5],'black',@board)
    Knight.new([7,1],'black',@board)
    Knight.new([7,6],'black',@board)
    @black_king = King.new([2,4],'black',@board)
    Queen.new([7,3],'black',@board)
    Pawn.new([6,0],'black',@board)
    Pawn.new([6,1],'black',@board)
    Pawn.new([6,2],'black',@board)
    Pawn.new([6,3],'black',@board)
    Pawn.new([6,4],'black',@board)
    Pawn.new([6,5],'black',@board)
    Pawn.new([6,6],'black',@board)
    Pawn.new([6,7],'black',@board)

    Rook.new([0,0],'white',@board)
    Rook.new([0,7],'white',@board)
    Bishop.new([0,2],'white',@board)
    Bishop.new([0,5],'white',@board)
    Knight.new([0,1],'white',@board)
    Knight.new([0,6],'white',@board)
    @white_king = King.new([0,4],'white',@board)
    Queen.new([0,3],'white',@board)
    Pawn.new([1,0],'white',@board)
    Pawn.new([1,1],'white',@board)
    Pawn.new([1,2],'white',@board)
    Pawn.new([1,3],'white',@board)
    Pawn.new([1,4],'white',@board)
    Pawn.new([1,5],'white',@board)
    Pawn.new([1,6],'white',@board)
    Pawn.new([1,7],'white',@board)

  end

  def in_check?(color)
    @board.each do |row|
      row.each do |cell|
        next if cell.nil? || cell.color == color
        color == 'black' ? king = @black_king : king = @white_king
        print king.pos
        return true if cell.moves.include?(king.pos)
      end
    end
    false
  end


  def render
    flip = 1
    row_accum = 1
    @board.each do |row|
      flip *= -1
      print "#{row_accum} "
      row_accum += 1
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
