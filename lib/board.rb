class Board
    attr_accessor :cells

    def initialize
        @cells = Array.new(9, " ")
    end

    def reset!
        self.cells = Array.new(9, " ")
    end

    def display
        puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
        puts "-----------"
        puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
        puts "-----------"
        puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
    end

    def position(index)
        self.cells[index.to_i - 1]
    end

    def full?
        self.cells.any? {|cell| cell == " "} ? false : true
    end

    def turn_count
        self.cells.count {|box| box != " "}
    end

    def taken?(index)
        self.cells[index.to_i - 1] == " " ? false : true
    end

    def valid_move?(index)
        index.to_i.between?(1,9) && !taken?(index.to_i)
    end

    def update(index, player)
        self.cells[index.to_i - 1] = player.token
    end
end