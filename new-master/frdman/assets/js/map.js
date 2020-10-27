function initMap() {
    var map;
    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        mapTypeId: 'roadmap',
        center: {
            lat: 21.554526,
            lng: 39.177674
        },
        zoom: 9
    };

    // Display a map on the web page
    map = new google.maps.Map(document.getElementById("map"), mapOptions);
    map.setTilt(50);

    // Multiple markers location, latitude, and longitude
    var markers = [
        ['Jadda', 21.554526, 39.177674]
    ];

    // Info window content
    var infoWindowContent = [
        ['<div class="info_content">' +
            '<h3>جدة - المملكة العربية السعودية</h3>' +
            '</div>'
        ]
    ];

    // Add multiple markers to map
    var infoWindow = new google.maps.InfoWindow(),
        marker, i;

    // Place each marker on the map  
    for (i = 0; i < markers.length; i++) {
        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
        bounds.extend(position);
        marker = new google.maps.Marker({
            position: position,
            map: map,
            icon: 'images/marker.png',
            title: markers[i][0]
        });

        // Add info window to marker    
        google.maps.event.addListener(marker, 'click', (function (marker, i) {
            return function () {
                infoWindow.setContent(infoWindowContent[i][0]);
                infoWindow.open(map, marker);
            }
        })(marker, i));

    }

}