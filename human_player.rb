class HumanPlayer

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "Hey, #{color.to_s} player, make your move!"
    input = gets.chomp
    until input.length == 5
      puts "incorrect input format...try again like this: 'e2 e4' "
      input = gets.chomp
    end

    parse_input(input)

  end

  def parse_input(input)
    hash = PARSE_HASH
    in_arr = input.split('')
    x = input[1]
    y = input[0]
    i = input[-1]
    j = input[-2]

    [
      [hash[x], hash[y]],
      [hash[i], hash[j]]
    ]

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
