module Api
  module V1
    class CellsController < ApplicationController
      before_action :set_cell, only: %i[show activate mark]
      before_action :set_board_logic, only: %i[activate mark]

      # GET /cells/1
      def show
        render json: @cell
      end

      # PATCH/PUT /cells/1/activate
      def activate
        if @board_logic.activate_cell(@cell.reload)
          render status: :ok
        else
          render json: @cell.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /cells/1/mark
      def mark
        if @board_logic.mark_cell(@cell.reload, cell_params[:marked_as])
          render status: :ok
        else
          render json: @cell.errors, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_cell
        @cell = Cell.find(params[:id])
      end

      def set_board_logic
        @board_logic = BoardLogic.new(@cell.board)
      end

      # Only allow a list of trusted parameters through.
      def cell_params
        params.require(:cell).permit(:marked_as)
      end
    end
  end
end
