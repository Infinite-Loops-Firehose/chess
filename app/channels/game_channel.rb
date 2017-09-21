class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel_#{params[:game_id]}"
    # stream_from "some_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def move_piece(data)
    piece = Piece.find(data['pieceId'])
    game = piece.game
    game_id = game.id
    ActionCable.server.broadcast "game_channel_#{game_id}", piece: Piece.find(data['pieceId'])
  end
end
