$(document).ready(function(){

google.maps.event.addDomListener(window, 'load', initialize);

  function initialize() {

    var latlng = new google.maps.LatLng(52.3731, 4.8922);
    var chicago = new google.maps.LatLng(42, -87);

    var mapOptions = {
      center: latlng,
      scrollWheel: true,
      zoom: 13
    };
    
    var marker = new google.maps.Marker({
      position: latlng,
      url: '/',
      animation: google.maps.Animation.DROP
    });

    var marker = new google.maps.Marker({
      position: chicago,
      url: '/',
      animation: google.maps.Animation.DROP
    });
    
    var map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    marker.setMap(map);

  };
});