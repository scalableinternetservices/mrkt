//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
$(document).on('turbolinks:load',function(){
    var $grid = $('.grid').masonry({
        itemSelector: '.grid-item',
        percentPosition: true,
        columnWidth: '.grid-sizer'
    });
    $grid.imagesLoaded().progress( function() {
        $grid.masonry('layout');
    });
    //msnry.layout()
});
