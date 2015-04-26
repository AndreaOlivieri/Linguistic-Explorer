(function(){
	// Init the module here
  this.Terraling = this.Terraling || {};

  this.Terraling.Visualization = this.Terraling.Visualization || {};

  var mapping = this.Terraling.Visualization.Map = {};

  var maps = {};
  
  function createMap(id, conf, cb){
    // here we store all the promises
    T.promises.map = {};

    // get the data as first step while doing other stuff
    T.promises.map.data = getData(conf.name || '', id, conf.type);
    
    // create a Leaflet map in the specific id
    var map = new L.Map(id, {minZoom: 1});

    // read the configuration file for more stuff

    // push the data
    $.when(T.promises.map.data).then(function(){
      
      // add the layer with the map
      var googleMaps = new L.Google();
      map.addLayer(googleMaps);

      map.fitWorld().zoomIn();

      // add the marker
      createMarkers(id, conf.markerStyler, map);

      createLegend(id, map);

      if($.isFunction(cb)){
        cb();
      }

    });
  }

  function createLegend(id, map){
    var div;

    function update(){
      $(div).html('<h4>Note:</h4><p>'+maps[id].markersHidden.length+' languages are not currently shown</p>');
    }

    if(maps[id].markersHidden.length){
      var legend = L.control();

      legend.onAdd = function(map){
        div = L.DomUtil.create('div', 'map-legend');
        update();
        return div;
      };

      legend.update = update;
      legend.addTo(map);
    }
  }

  function createMarkers(id, styler, map){
    maps[id].markersHidden = [];

    $.each(maps[id].values, function (i, entry){
      if(entry.value){
        createMarker(entry, styler, map, id);
      }
    });
  }

  function createMarker(entry, styler, map, id){
    // start with a default style
    var style = {
      markerColor: 'white',
      icon: 'info',
      iconColor: 'red',
      spin: false
    };
    // overwrite style if a styler is passed
    if(styler){
      style = styler(entry);
    }
    // style can be null if we run out of colours
    if(style){
      // append the prefix: 
      // later because the style can have been overrided by the styler
      style.prefix = 'fa';
      // Creates a red marker with the info icon
      var marker = L.AwesomeMarkers.icon(style);
      // In the value property are stored the coords of the marker
      marker = L.marker(entry.value, {icon: marker}).addTo(map);
      if(style.text){
        marker.bindPopup(style.text);
      }
    } else {
      // show in some place that there are missing markers
      maps[id].markersHidden.push(entry.id);
    }
  }

  function getData(ids, mapId, type){
    
    var request = getURL(ids, type);

    return $[request.method](request.url, request.payload)
      .done(parseData(mapId))
      .fail(showError(mapId))
      .always();
  }

  function parseData(id){
    
    return function (json){
      
      if(json.exists){
        maps[id] = {};
        // overwrite the value field with an appropriate array
        maps[id].values = [{id: json.id, value: json.value.split(',')}];
      }

      if(json.type === 'coords'){
        maps[id] = {};

        maps[id].values = $.map(json.values, function (val, id){
          return {id: id, value: val };
        });
      }
    };

  }

  function showError(){

  }

  function getURL(ids, type){
    var url;
    var method = 'get';
    var payload = {};

    // Regular search results
    if($.isArray(ids)){
      url = '/groups/'+T.currentGroup+'/maps';
      payload.ling_ids = ids;
      method = 'post';
    } else if(type === 'ling'){
      // show page on a language
      url = '/groups/'+T.currentGroup+'/lings_properties/exists';
      payload.ling_name = ids;
      payload.prop_name = 'latlong';
    } else if(type === 'property'){
      // show page on a property
      url = '/groups/'+T.currentGroup+'/maps';
      payload.prop_ids = ids;
      method = 'post';
    }

    payload.authenticity_token = $('meta[name=csrf-token]').attr('content');

    return {url: url, payload: payload, method: method};
  }

  mapping.init = createMap;

})();