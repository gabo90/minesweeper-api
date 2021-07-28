class GameLogic
  attr_accessor :board, :cells

  def initialize(board)
    @board = board
  end

  def initialize_board
    @cells = []
    @board.rows.times.each do |row|
      @board.columns.times.each do |col|
        @cells.append({ row: row, column: col, type: 'cell' })
      end
    end
    p "cells are #{@cells}"
    place_mines
    @board.cells.insert_all(@cells)
  end

  def place_mines
    mines_to_place = @board.mines
    p "mines is #{mines_to_place}"

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

  def response
    {
      game: @board.game,
      board_id: @board.id
    }
  end
end
