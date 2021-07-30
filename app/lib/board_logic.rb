class BoardLogic

  def initialize(board)
    @board = board
    @game = board.game
    @blank_cells = []
    @counter_cells = []

    set_counters if @game.initialized?
    @game.update!(status: 'playing') if @game.can_resume?
  end

  def activate_cell(cell)
    return true if cell.marked_as?
    return explode_mines if cell.mine?
    return can_win?(cell) unless cell.cell?

    activate_adjacent(cell)
  end

  def mark_cell(cell, mark)
    return true if cell.marked_as == mark

    if mark == 'red_flag'
      @board.update!(remaining_mines: @board.remaining_mines - 1)
    elsif cell.red_flag?
      @board.update!(remaining_mines: @board.remaining_mines + 1)
    end

    cell.update(marked_as: mark)
  end

  private

  def explode_mines
    @board.cells.mines.update_all(active: true)
    @game.over!
    total_played = @board.player.played_games + 1
    total_lost = @board.player.games_lost + 1
    @board.player.update!(played_games: total_played, games_lost: total_lost)
    true
  end

  def activate_adjacent(cell)
    return if cell.counter?

    adjacent_cells_ = adjacent_cells(cell)
    counters = adjacent_cells_.counters
    blanks = adjacent_cells_.bare
    adjacent_counters_and_blanks(counters, blanks)
    cells_to_activate = (@blank_cells + @counter_cells).uniq
    cells_to_activate.each { |c| c.update!(active: true) }
    true
  end

  def set_counters
    @board.cells.map do |cell|
      next if cell.mine?

      mines = adjacent_cells(cell).mines.count
      cell.update!(kind: 'counter', around_mines: mines) unless mines.zero?
    end
  end

  def adjacent_cells(cell)
    row_values = (cell.row - 1..cell.row + 1).to_a
    col_values = (cell.column - 1..cell.column + 1).to_a
    @board.cells.where.not(id: cell.id).where(row: row_values, column: col_values)
  end

  def adjacent_counters_and_blanks(counters, blanks)
    filter_adjacent(blanks)
    @counter_cells = (@counter_cells + counters).uniq
    @blank_cells = (@blank_cells + blanks).uniq
  end

  def filter_adjacent(cells)
    @blank_cells = (@blank_cells + cells).uniq
    cells.each do |c|
      blank_cells = adjacent_cells(c).inactive.bare.where.not(id: @blank_cells.pluck(:id))
      filter_adjacent(blank_cells) unless blank_cells.empty?
      counter_cells = adjacent_cells(c).inactive.counters.where.not(id: @counter_cells.pluck(:id))
      @counter_cells = (@counter_cells + counter_cells).uniq
    end
  end

  def can_win?(cell)
    cells = @board.cells
    remaining_counters = cells.counters.inactive.count
    valid_red_flag_marks = cells.with_red_flag.active
    remaining_mines = @board.mines - valid_red_flag_marks.count
    if remaining_counters == 1 || (remaining_mines.zero? && remaining_counters == 2)
      you_win
    else
      cell.update(active: true)
    end
  end

  def you_win
    @board.cells.counters.update_all(active: true)
    @game.you_win!
    total_played = @board.player.played_games + 1
    total_lost = @board.player.games_won + 1
    @board.player.update!(played_games: total_played, games_lost: total_lost)
    true
  end
end
