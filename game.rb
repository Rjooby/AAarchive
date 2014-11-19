class Game


  def initialize
    @board = Board.new
    @board.render
    @white_player = HumanPlayer.new(:white)
    @black_player = HumanPlayer.new(:black)
  end


  def play
    winner = nil
    until @board.checkmate?

      white_move = @white_player.play_turn
      until @board.board[white_move[0][0]][white_move[0][1]].color == @white_player.color
        print "Wrong color idiot"
        puts
        white_move = @white_player.play_turn
      end
      @board.move(white_move[0],white_move[1])
      if @board.checkmate?
        winner = :white
        break
      end
      black_move = @black_player.play_turn
      until @board.board[black_move[0][0]][black_move[0][1]].color == @black_player.color
        print "Wrong color idiot"
        puts
        black_move = @black_player.play_turn
      end
      @board.move(black_move[0],black_move[1])
      if @board.checkmate?
        winner = :black
        break
      end
    end
    puts "#{winner.to_s} wins!!"
  end

end
