
$(function(){
  var pieceMoved = $('span#piece');
  // pieceMoved.on('mouseDown', function(){
  //   $('table#chessboard').css('z-index', '1');
  //   pieceMoved.css('z-index', '100');
  // });
  pieceMoved.draggable({
  });

  $('td').droppable(
    { accept: pieceMoved },
    {drop: function(e){
      
    }
  )

});
