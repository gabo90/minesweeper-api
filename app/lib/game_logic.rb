class GameLogic

  def initialize(game)
    @board = game.board
    @cells = nil
  end

  def initialize_board
    @cells = []
    @board.rows.times.each do |row|
      @board.columns.times.each do |col|
        @cells.append({ row: row, column: col, kind: 'cell' })
      end
    end
    place_mines
    @board.cells.insert_all(@cells)
  end

  def place_mines
    mines_to_place = @board.mines

    until mines_to_place.zero?
      @cells.reject { |cell| cell[:kind] == 'mine' }.map! do |cell|
        break if mines_to_place.zero?

        if [true, false].sample
          mines_to_place -= 1
          cell[:kind] = 'mine'
        end
      end
    end
  end
end
