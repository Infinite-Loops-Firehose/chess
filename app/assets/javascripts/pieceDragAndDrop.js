
$(".games.show").ready(function(){

  var pieces = $('span#piece');
  var pieceHTML;
  var pieceId;

  pieces.mousedown(function(e){
    pieceHTML = e.target;
    pieceId = $(e.target).data('id');
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
      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: { piece: { x_position: destSqX, y_position: destSqY } },
        success: function(){
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
