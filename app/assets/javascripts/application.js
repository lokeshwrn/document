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
//= //require jquery
//= //require jquery_ujs
//= //require turbolinks
//= require_tree .
//= require tinymce

$(document).ready(function(){
    $('.sub-menu-toggle').click(function(e){
        e.preventDefault();
        $(this).next('.second-level-menu').toggle();
        $("#wrapper").removeClass("toggled");
        $("#menu-toggle").addClass("opened");
    });

    $("#menu-toggle").click(function(e) {
        e.preventDefault();
        $("#wrapper").toggleClass("toggled");
        $("#menu-toggle").toggleClass("opened");
        $('.toggled .second-level-menu').hide();
    });
});

function fill_up_values(parent_div, tab_header, single_div, values){
    var x=parent_div, a=tab_header, k=single_div, v=values;
    $(x+a+k).attr('href', v.url);
    $(x+a+k).find('h3').text(v.title);
    $(x+a+k).find('h6').text(v.desc);
    $(x+a+k).find('span').text(v.count);
}

function reset_values(parent_div){
    $(parent_div + ".index a").each(function(){
        $(this).attr('href', "javascript:void(0)");
        $(this).find('h3').text("");
        $(this).find('h6').text("");
        $(this).find('span').text("*");
    });
}

function get_ajax_call(parent) {
    $.ajax({
        type: "GET",
        url: "/get_"+parent,
        dataType: "json",
        success: function (data) {
            $.each(data, function (a, b) {
                $.each(this, function (k, v) {
                    fill_up_values('#'+parent+' ', a, k, v);
                });
            });
            $('#'+parent+' .tab-content').removeClass('loader');
            $('#'+parent+' img').hide();
        }
    });
}

$(document).ready(function(){

    $('#toppers img').show();
    $('#favourites img').show();

    $('.tab-content .tab-pane:first-child').addClass('active');
    $('#search').find('.tab-content').removeClass('loader');



    // tab structure toggle
    $('.tab-header li').on("click", function(){
        var parent=$(this).parents('.my-tab').attr('id');
        var x=$(this);
        $('#'+parent+' .tab-header li').each(function(){
            $(this).removeClass("active");
        });
        x.addClass("active");
        var y=x.find('a').attr('data-url');
        $('#'+parent+' .tab-content .tab-pane').each(function(){
            $(this).removeClass("active");
        });
        $('#'+parent+' #'+y).addClass("active");
    });

    // search data ajax
    $(".search-form button").on("click", function(){
        reset_values("#search ");
        $('#search .tab-content').addClass('loader');
        $('#search img').show();
        var value=$('.search-form input').val();
        $.ajax({
            type: "POST",
            url: "/get_search",
            dataType: "json",
            data: {"search_data":value},
            success: function (data) {
                console.log(data);
                $.each(data, function(a,b) {
                    $.each(this, function(k, v) {
                        fill_up_values("#search ", a, k, v);
                    });
                });
                $('#search .tab-content').removeClass('loader');
                $('#search img').hide();
            }
        });
    });
});

