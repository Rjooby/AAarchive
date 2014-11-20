require_relative 'piece.rb'
require 'colorize'
require 'unicode'
# encoding: utf-8

class Board
  attr_reader :board
  def initialize(new_board=false, jump_case=false)
    @board = Array.new(8){Array.new(8)}
    fill_board unless new_board || jump_case
    jump_board if jump_case == true
  end

  def fill_board
    [0,1,2,5,6,7].each do |row|
      color = (row.between?(0,2) ? :red : :black)
      if row % 2 == 0
        [1,3,5,7].each do |column|
          self[[row,column]] = Piece.new(color, [row,column], self, :Pawn)
        end
      else
        [0,2,4,6].each do |column|
          self[[row,column]] = Piece.new(color, [row,column], self, :Pawn)
        end
      end
    end
  end

  def piece_count
    red_pieces = 0
    black_pieces = 0
    @board.each do |row|
      row.each do |space|
        next if space.nil?
        if space.color == :red
          red_pieces += 1
        else
          black_pieces += 1
        end
      end
    end
    return {:red => red_pieces, :black => black_pieces }
  end

  #test board
  def jump_board
    self[[0,1]] = Piece.new(:red, [0,1], self, :King)
    self[[1,2]] = Piece.new(:black, [1,2], self, :Pawn)
    self[[3,2]] = Piece.new(:black, [3,2], self, :Pawn)
  end

  def inspect
  end

  def render
    puts "   A  B  C  D  E  F  G  H   ".colorize(:background => :light_black)
    flip = -1
    count = 8
    @board.each do |row|

      print "#{count} ".colorize(:background => :light_black)

      flip *= -1
        row.each do |space|
          flip *= -1
        color = (flip == 1 ? :white : :black)
        if space.nil?
          print "   ".colorize(:background => color)
        else
          print " #{space.rep} ".colorize(:background => color)
        end
      end
      print " #{count}".colorize(:background => :light_black)
      count -= 1
      puts
    end
    puts "   A  B  C  D  E  F  G  H   ".colorize(:background => :light_black)
    return
  end



  def [](pos)
    x,y = pos
    @board[x][y]
  end

  def []=(pos,piece)
    x,y = pos
    @board[x][y] = piece
  end

end
