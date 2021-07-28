class GameLogic
  attr_accessor :board, :cells

  def initialize(game)
    @board = game.board
  end

  def initialize_board
    @cells = []
    @board.rows.times.each do |row|
      @board.columns.times.each do |col|
        @cells.append({ row: row, column: col, type: 'cell' })
      end
    end
    place_mines
    @board.cells.insert_all(@cells)
  end

  def place_mines
    mines_to_place = @board.mines

    until mines_to_place.zero?
      @cells.reject { |cell| cell[:type] == 'mine' }.map! do |cell|
        break if mines_to_place.zero?

        if [true, false].sample
          mines_to_place -= 1
          cell[:type] == 'mine'
        end
      end
    end
  end
end