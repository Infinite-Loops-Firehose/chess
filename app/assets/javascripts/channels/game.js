$(".games.show").ready(function(){

  var gameId = $("div#gameId").data("gameId");
  App.game = App.cable.subscriptions.create( { channel: "GameChannel", game_id: gameId }, {  
    connected: function(data){
      // Called when the subscription is ready for use on the server
      console.log(data);
    },

    disconnected: function(){
      // Called when the subscription has been terminated by the server
    },

    received: function(data){
      console.table(data.piece)
      // var pieceHTML = $(),
      //     destSqX = ,
      //     destSqY = ,
      //     isEnPassantCapture = ,
      // $(pieceHTML).attr('data-x-pos', destSqX);
      // $(pieceHTML).attr('data-y-pos', destSqY);
      // if (isEnPassantCapture){
      //   $("td#" + destSqX + startY).empty();
      // }
      // $(e.target).empty();
      // e.target.append( pieceHTML );
      // $(pieceHTML).css({"top":"initial", "left":"initial"});
      // Called when there's incoming data on the websocket for this channel
    },

    broadcastPieceMovement: function(pieceId, gameId){
      this.perform('broadcast_piece_movement', {
        pieceId: pieceId, 
        gameId: gameId
      })
    },
  })

})



