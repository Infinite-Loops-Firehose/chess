$(".games.show").ready(function(){
  // Getting gameId from games#show
  var gameId = $("div#gameId").data("gameId");
  App.game = App.cable.subscriptions.create( { channel: "GameChannel", game_id: gameId }, {  
    connected: function(){
      // Called when the subscription is ready for use on the server
    },

    disconnected: function(){
      // Called when the subscription has been terminated by the server
    },

    received: function(data){
      console.log("Received callback has been triggered!");
      var pieceId = data.pieceId,
          pieceHTML =  $('img#piece[data-id="' + pieceId + '"]'),
          startY = data.startY,
          destSqX = data.destSqX,
          destSqY = data.destSqY,
          isEnPassantCapture = data.isEnPassantCapture
      if (isEnPassantCapture){
        $("td#" + destSqX + startY).empty();
      }
      pieceHTML.attr("data-x", destSqX);
      pieceHTML.attr("data-y", destSqY); 
      destSqHTML = $("td#" + destSqX + destSqY);
      destSqHTML.empty();
      destSqHTML.append(pieceHTML);
      pieceHTML.css({"top":"initial", "left":"initial"});

      if(data.gameState != null && data.gameState != 0){
        location.reload();
      }
      // Called when there's incoming data on the websocket for this channel
    },

    broadcastPieceMovement: function(pieceId, gameId, startX, startY, destSqX, destSqY, isEnPassantCapture){
      this.perform('broadcast_piece_movement', {
        pieceId: pieceId, 
        gameId: gameId,
        startX: startX,
        startY: startY,
        destSqX: destSqX,
        destSqY: destSqY,
        isEnPassantCapture: isEnPassantCapture
      })
    },

    broadcastGameOver: function(gameId, gameState){
      this.perform('broadcast_game_over', {
        gameId: gameId, 
        gameState: gameState
      })
    } 

  })
})



