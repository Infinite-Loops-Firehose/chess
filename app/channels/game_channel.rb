class GameChannel < ApplicationCable::Channel
  def subscribed
    puts "The id of the game subscribed to is: #{params[:game_id]}"
    stream_from "game_channel_#{params[:game_id]}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def broadcast_piece_movement(data)
    piece = Piece.find(data['pieceId'])
    game = piece.game
    game_id = game.id
    ActionCable.server.broadcast "game_channel_#{game_id}", piece: Piece.find(data['pieceId'])
  end
end
