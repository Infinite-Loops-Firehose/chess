
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
      destSqIdNum = parseInt(e.target.id);
      destSqX = Math.trunc(destSqIdNum / 10);
      destSqY = destSqIdNum % 10;
      function isEnPassantCapture(){
        if ( $(e.target).children().length == 0 && Math.abs(destSqX - startX) == 1 && Math.abs(destSqY - startY) == 1 && pieceMovedType == "Pawn" ){
          return true;
        }
        return false;
      }
      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: { piece: { x_position: destSqX, y_position: destSqY } },
        success: function(){
          $(pieceHTML).attr('data-x-pos', destSqX);
          $(pieceHTML).attr('data-y-pos', destSqY);
          if (isEnPassantCapture()){
            $("td#" + destSqX + startY).empty();
          }
          $(e.target).empty();
          e.target.append( pieceHTML );
          $(pieceHTML).css({"top":"initial", "left":"initial"});
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
