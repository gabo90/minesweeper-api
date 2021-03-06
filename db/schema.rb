# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_29_011049) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boards", force: :cascade do |t|
    t.integer "mines", default: 0
    t.integer "rows", default: 8
    t.integer "columns", default: 8
    t.integer "remaining_mines", default: 0
    t.bigint "game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["game_id"], name: "index_boards_on_game_id"
  end

  create_table "cells", force: :cascade do |t|
    t.boolean "active", default: false
    t.integer "around_mines", default: 0
    t.integer "row", null: false
    t.integer "column", null: false
    t.string "marked_as"
    t.bigint "board_id", null: false
    t.datetime "created_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", precision: 6, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.string "kind", default: "cell"
    t.index ["board_id"], name: "index_cells_on_board_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "result"
    t.bigint "player_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_games_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.string "alias", null: false
    t.integer "played_games", default: 0
    t.integer "games_won", default: 0
    t.integer "games_lost", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "boards", "games"
  add_foreign_key "cells", "boards"
  add_foreign_key "games", "players"
end
