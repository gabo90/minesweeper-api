module Api
  module V1
    class PlayersController < ApplicationController

      # GET /players
      def index
        @players = Player.all

        render json: @players
      end

      # POST /players
      def create
        @player = Player.new(player_params)

        if @player.save
          render json: @player, status: :created
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      private

      # Only allow a list of trusted parameters through.
      def player_params
        params.require(:player).permit(:name, :last_name, :alias, :total)
      end
    end
  end
end
