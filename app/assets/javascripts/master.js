
$(function(){

  var pieceMoved = $('span#piece');
  // pieceMoved.on('mouseDown', function(){
  //   $('table#chessboard').css('z-index', '1');
  //   pieceMoved.css('z-index', '100');
  // });

  var pieceId;

  pieceMoved.mousedown(function(e){
    pieceId = $(e.target).data('id');
  })

  pieceMoved.draggable();

  $('td').droppable(
    { accept: pieceMoved },
    {drop: function(e){
      destSqIdNum = parseInt(e.target.id);
      destSqX = Math.trunc(destSqIdNum / 10);
      destSqY = destSqIdNum % 10;
      console.log('destSqY', destSqY);
      console.log('destSqX', destSqX);
      $.ajax({
        url: '/pieces/' + pieceId,
        method: "PUT",
        data: { piece: { x_position: destSqX, y_position: destSqY } },
      }) 
    }}
  )

});
