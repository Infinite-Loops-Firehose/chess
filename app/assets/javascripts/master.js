
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

  pieceMoved.draggable({

  });

  $('td').droppable(
    { accept: pieceMoved },
    {drop: function(e){
      destSqIdNum = parseInt(e.target.id);
      destSqX = Math.trunc(destSqIdNum / 10);
      destSqY = destSqIdNum % 10;
      console.log()
      console.log('x will be:' + destSqX )
      console.log('y will be:' + destSqY )
      $.ajax({
        url: '/pieces/' + pieceId,
        type: 'PUT',
        data: {
          piece: { x_position: destSqX, y_position: destSqY }
        }
      }) 
    }}
  )

});
