/*global $*/
$(function() {
  let index = 1;
  $('.onegai')
    .on('cocoon:after-insert', function(e, insertedItem) {
      $(insertedItem).find('.class-a').attr('data-a', index);
      $(insertedItem).find('.class-b').attr('data-b', index);
      $(insertedItem).find('.class-c').attr('data-c', index);
      index = index+1

      $('.class-a').on('change',function(e){
        const dataA = $(this).attr('data-a')

        const dataB = $("option:selected", this).data("b");
        const dataC = $("option:selected", this).data("c");

        $(`[data-b="${dataA}"]`).text(dataB)
        $(`[data-c="${dataA}"]`).text(dataC)
      })
    })
})
