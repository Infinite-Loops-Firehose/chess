App.game = App.cable.subscriptions.create( { channel: "GameChannel", game_id: 38 }, {  
  connected: function(){
    // Called when the subscription is ready for use on the server
    
  },

  disconnected: function(){
    // Called when the subscription has been terminated by the server
  },

  received: function(data){
    console.log(data['piece']);
    // Called when there's incoming data on the websocket for this channel
  },

  movePiece: function(pieceId){
    this.perform('move_piece', {
      pieceId: pieceId 
    })
  },

})

