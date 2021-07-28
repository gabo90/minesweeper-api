class BoardLogic
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def activate_cell(cell)
    return explode_mines if cell.mine?

    adjacent_cells_ = adjacent_cells(cell.row, cell.column)
    p "adjacent cells #{adjacent_cells_}"
    cell.update(active: true)
  end

  private

  def explode_mines
    @board.cells.mines.update_all(active: true)
    @board.game.over!
    total_played = @board.player.played_games + 1
    total_lost = @board.player.games_lost + 1
    @board.player.update!(played_games: total_played, games_lost: total_lost)
    true
  end

  def adjacent_cells(row, col)
    [
      { row: row - 1, col: col - 1 },
      { row: row - 1, col: col },
      { row: row - 1, col: col + 1 },
      { row: row, col: col - 1 },
      { row: row, col: col + 1 },
      { row: row + 1, col: col - 1 },
      { row: row + 1, col: col },
      { row: row + 1, col: col + 1 }
    ]
    # fetch cells from db
  end
end
