class HumanPlayer

  def initialize(color)
    @color = color
  end


  def turn
    puts "Player one, make your move! e.g. 'c3,c2', more in sequence when jumping"
    input = gets.chomp

    parse_input(input) #sequence array

  end

  def parse_input(input)
    hash = PARSE_HASH
    in_arr = input.split(',')

    in_arr.map! do |spot|
      spot = spot.reverse.split('').map do |char|
        char = hash[char]
      end
    end


    [in_arr] #array of all moves including starting move
  end

  PARSE_HASH = {
    'a' => 0,
    'b' => 1,
    'c' => 2,
    'd' => 3,
    'e' => 4,
    'f' => 5,
    'g' => 6,
    'h' => 7,
    '1' => 7,
    '2' => 6,
    '3' => 5,
    '4' => 4,
    '5' => 3,
    '6' => 2,
    '7' => 1,
    '8' => 0
  }

end
