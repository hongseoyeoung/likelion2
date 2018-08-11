// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){ 
    // bxslider 
    var slider = $('.bxslider').bxSlider({ 
           mode: 'horizontal', // 슬라이드 방식 ( horizontal, fade, vertical  중 선택 ) 
           // mode: 'fade', 
           auto: true, // 자동재생 유무 
           controls:false, // 이전, 다음 컨트롤 유무 
           autoHover: true, // 슬라이더 영역에 마우스 올렸을시 슬라이드를 멈출건지 여부 
           pause: 2000, // 한 슬라이드가 멈춰있는 시간 
           speed: 600, // 슬라이드애니메이션의 속도 
           pager: true, // 페이징버튼 사용 여부 
           pagerCustom: '#slider-pager', // 페이징 버튼이 들어있는 부모태그의 선택자 
           // 버튼을 눌러 슬라이드를 이동시킨후 다시 슬라이드가 자동 재생되게 하는 옵션 
           onSlideAfter: function($slideElement, oldIndex, newIndex){ 
                  slider.startAuto(); 
           } 
    }); 
}); 