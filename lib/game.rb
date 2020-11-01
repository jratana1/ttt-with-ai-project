class Game
    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0, 4, 8], [2,4,6]]

    attr_accessor :board , :player_1, :player_2, :input

    def initialize(player1 = Players::Human.new("X"), player2 = Players::Human.new("O"), board = Board.new)
        @board = board
        @player_1 = player1
        @player_2 = player2
    end

    def current_player
        self.board.turn_count.odd? ? @player_2 : @player_1
    end

    def won?
        WIN_COMBINATIONS.each do |combo|
                if self.board.cells[combo[0]] == 'X' && self.board.cells[combo[1]] == 'X' && self.board.cells[combo[2]] == 'X'
                return combo
                elsif self.board.cells[combo[0]] == 'O' && self.board.cells[combo[1]] == 'O' && self.board.cells[combo[2]] == 'O'
                return combo
                end
            end
        return false
    end

    def draw?
        if self.board.full? == false
          return false
        elsif self.won? == false
          return true
        end
    end

    def over?
        if self.board.full? == true
          return true
        elsif self.won? == false
          return false
        else
          return true
        end
      end

    def winner
        if self.won? == false
          return nil
        else
          return self.board.cells[self.won?[0]]
        end
    end

    def turn
                puts "Please enter a number 1-9:"
                @input = current_player.move(self.board)
                self.board.valid_move?(@input) ? self.board.update(@input, self.current_player) : self.turn
                self.board.display
    end

    def play
        until self.over? == true
            if self.draw?
              return "Cat\'s Game!"
            end
        self.turn
        end
         
        if self.won?
        puts "Congratulations #{self.winner}!"
        else
        puts "Cat\'s Game!"
        end
    end

    def start
      puts "Welcome to Tic Tac Toe!"
      puts "How many players (0, 1, or 2)?"
      input = gets.strip
      if input == "0"
        game = Game.new(Players::Computer.new("X"), Players::Computer.new("O"), Board.new)
        game.board.display
        game.play
      elsif input == "1"
        puts "Who should go first?  (computer or human)"
        input2 = gets.strip
        if input2 == "computer"
          game = Game.new(Players::Computer.new("X"), Players::Human.new("O"), Board.new)
          game.board.display
          game.play
        else
          game = Game.new(Players::Human.new("X"), Players::Computer.new("O"), Board.new)
          game.play
        end
      else
        game = Game.new(Players::Human.new("X"), Players::Human.new("O"), Board.new)
        game.board.display
        game.play
      end
    end
end