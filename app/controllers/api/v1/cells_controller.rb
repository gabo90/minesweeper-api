module Api
  module V1
    class CellsController < ApplicationController
      before_action :set_cell, only: [:show, :activate]
      before_action :set_board_logic, only: [:activate]

      # GET /cells
      # def index
      #   @cells = Cell.all
      #
      #   render json: @cells
      # end

      # GET /cells/1
      def show
        render json: @cell
      end

      # POST /cells
      # def create
      #   @cell = Cell.new(cell_params)
      #
      #   if @cell.save
      #     render json: @cell, status: :created, location: @cell
      #   else
      #     render json: @cell.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /cells/1
      def activate
        if @board_logic.activate_cell(@cell)
          render status: :ok
        else
          render json: @cell.errors, status: :unprocessable_entity
        end
      end

      # DELETE /cells/1
      # def destroy
      #   @cell.destroy
      # end

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
        params.require(:cell).permit(:active, :marked_as)
      end
    end
  end
end
