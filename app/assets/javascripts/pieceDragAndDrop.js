// added drop piece code back to this file
$(".games.show").ready(function(){

  var pieces = $('img#piece');
  var pieceHTML;
  var pieceId;
  var pieceMovedType;
  var startX;
  var startY;

  pieces.mousedown(function(e){
    pieceHTML = $(e.target);
    pieceId = $(e.target).attr('data-id');
    pieceMovedType = $(e.target).attr('data-type');
    startX = $(e.target).attr('data-x');
    startY = $(e.target).attr('data-y');
  })

  pieces.draggable({
    containment: '#chessboard tbody',
    cursor: 'move',
  });

  $('td').droppable(
    { accept: pieces },
    {drop: function(e){
      var destSqIdNum = parseInt(e.target.id);
      var destSqX = Math.trunc(destSqIdNum / 10);
      var destSqY = destSqIdNum % 10;
      var isEnPassantCapture = $(e.target).children().length == 0 && Math.abs(destSqX - startX) == 1 && Math.abs(destSqY - startY) == 1 && pieceMovedType == "Pawn";
      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: {
          piece: { id: pieceId, x_position: destSqX, y_position: destSqY } 
        },
        success: function(data){
          var gameId = $("#gameId").data("gameId");
          App.game.broadcastPieceMovement(pieceId, gameId, startX, startY, destSqX, destSqY, isEnPassantCapture);
        },
          // Called when there's incoming data on the websocket for this channel
          // data represents the updated game, including all its pieces. (todo: make sure that game includes all pieces)
          // loop through all pieces in the DOM, and update position/remove based on game.pieces.
          // check game.status and end the game and display game over message as appropriate

        error: function(jqXHR){
          alert(jqXHR.responseJSON.error);
          $(pieceHTML).css({"top":"initial", "left":"initial"});
          $(pieceHTML).addClass('ui-draggable ui-draggable-handle')
        },
      })
    }}
  )

});

// stops all drag and drop piece movement once game is marked as over.
$('span#gameover').ready(function(){
  var gameState = $("#gameState").data("gameState"),
      gameId = $("#gameId").data("gameId");
  App.game.broadcastGameOver(gameId, gameState);
  $('img#piece').draggable("destroy");
})
