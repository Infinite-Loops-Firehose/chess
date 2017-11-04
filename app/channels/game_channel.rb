class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast_piece_movement(data)
    ActionCable.server.broadcast "game_channel_#{data['gameId']}", data
  end

  def broadcast_player_forfeit(data)
    ActionCable.server.broadcast "game_channel_#{data['gameId']}", data
  end

  # def broadcast_game_over(data)
  #   ActionCable.server.broadcast "game_channel_#{data['gameId']}", data
  # end
end
