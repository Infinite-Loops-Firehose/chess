
$(".games.show").ready(function(){

  var pieces = $('span#piece');
  var pieceHTML;
  var pieceId;
  var pieceMovedType;
  var startX;
  var startY;

  pieces.mousedown(function(e){
    pieceHTML = e.target;
    pieceId = $(e.target).attr('data-id');
    pieceMovedType = $(e.target).attr('data-type');
    startX = $(e.target).attr('data-x-pos');
    startY = $(e.target).attr('data-y-pos');
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
      var isEnPassantCapture = $(e.target).children().length == 0 && Math.abs(destSqX - startX) == 1 && Math.abs(destSqY - startY) == 1 && pieceMovedType == "Pawn"
      // $.ajax({
      //   url: '/games/' + gameId,
      //   method: "PUT",
      //   data: {
      //     piece: { id: pieceId, x_position: destSqX, y_position: destSqY } 
      //   },
      //   success: function(data){
      //     // data represents the updated game, including all its pieces. (todo: make sure that game includes all pieces)
      //     // loop through all pieces in the DOM, and update position/remove based on game.pieces.
      //     // check game.status and end the game and display game over message as appropriate
      //   }
      // })

      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: { piece: { x_position: destSqX, y_position: destSqY } },
        success: function(){
          gameId = $("#gameId").data("gameId");
          App.game.broadcastPieceMovement(pieceId, gameId, startX, startY, destSqX, destSqY, isEnPassantCapture);
        },
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
  $('span#piece').draggable("destroy");
})
