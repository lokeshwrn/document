// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= //require turbolinks
//= require_tree .
//= require tinymce


function fill_up_values(parent_div, tab_header, single_div, values){
    var x=parent_div, a=tab_header, k=single_div, v=values;
    console.log(a);
    $(x+a+k).attr('href', v.url);
    $(x+a+k).find('h3').text(v.title);
    $(x+a+k).find('h6').text(v.desc);
    $(x+a+k).find('span').text(v.count);
}

$(document).on("ready", function(){
    $('.tab-content .tab-pane:first-child').addClass('active');
});