<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script
    src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&key=AIzaSyD_nkcEFMlfk6QehiK-jFKem1We2v2YoO0"></script>
<script>
	var map; //<-- This is now available to both event listeners and the initialize() function
	var latitude = 10;
	var longitude = 106;
	var marker;
	var current_point = null;

	function geoFindMe() {
		function success(position) {
			latitude = position.coords.latitude;
			longitude = position.coords.longitude;
			console.log(latitude);
			console.log(longitude);

			var currLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);

	         // plot the currLocation on Google Maps, or handle accordingly:
             if (current_point != null) {
            	 current_point.setMap(null);
                 }
	         current_point = new google.maps.Marker({ title: 'Current Location',
	                                  map: map, 
	                                  position: currLocation });

	         map.setCenter(currLocation);
		}

		function error() {
			console.log("Unable to retrieve your location");
		}

		if (navigator.geolocation) {
		    navigator.geolocation.getCurrentPosition(success, error);
		}
	}

	function initialize() {
		var myLatlng = new google.maps.LatLng(10, 106);
		geoFindMe();
		var mapOptions = {
			center : myLatlng,
			zoom : 20,
			mapTypeId : google.maps.MapTypeId.ROADMAP
		};
		map = new google.maps.Map(document.getElementById("map-canvas"),
				mapOptions);
	}

	google.maps.event.addDomListener(window, 'load', initialize);
	google.maps.event.addDomListener(window, "resize", function() {
		var center = map.getCenter();
		google.maps.event.trigger(map, "resize");
		map.setCenter(center);
	});
</script>
<style>
body, html {
  height: 98%;
  width: 98%;
}

div#map-canvas {
  width: 100%; height: 80%;margin-left: 2%;
}
</style>
</head>
<body>
 <div id="header">
    <P>  The time on the server is ${serverTime}. </P>
    <input type="button" value="current" onclick="geoFindMe();">
 </div>
 <div id="map-canvas"></div>
</body>
</html>