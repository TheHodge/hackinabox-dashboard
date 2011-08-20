// 	FLOT GRAPHS - FOR ALL HELP AND SUPPORT VISIT: - http://people.iola.dk/olau/flot/examples/
// STYLING CAN BE CHANGED BY AMENDEDING THE OPTIONS AS COMMENTED BELOW - CHECK LINES 46, 61 AND 63 FOR THE DIFFERENT THEMES.

$(function () {
    
// DATA STORED IN AN ARRAY. THE FIRST VALUE IS THE DATE IN MILLISECONDS, THE SECOND THE VALUE. IN THIS EXAMPLE WE ARE USING WEBSITE HITS.
// PLEASE REFER TO THE SUPPORT SITE LISTED ABOVE FOR DETAILS ON HOW TO CHANGE THE GRAPH OPTIONS.

var d 	= [[1257138000000, 100], [1257310800000, 120], [1257656400000, 150], [1257814800000, 170], [1257872400000, 200], [1257955200000, 220], [1258041600000, 250], [1258214400000, 300], [1258395120000, 350], [1258567920000, 375], [1258791120000, 400], [1259050320000, 420], [1259280720000, 440], [1259367120000, 500], [1259680320000, 500], [1259939520000, 600], [1260025920000, 620], [1260371520000, 700], [1260457920000, 720], [1260544320000, 800], [1260818700000, 850], [1260905100000, 900], [1260991500000, 920], [1261077660000, 1100], [1261250460000, 1200], [1261336860000, 1400]];

    // first correct the timestamps - they are recorded as the daily
    // midnights in UTC+0100, but Flot always displays dates in UTC
    // so we have to add one hour to hit the midnights in the plot
    for (var i = 0; i < d.length; ++i)
      d[i][0] += 60 * 60 * 1000;

    // helper for returning the weekends in a period
    function weekendAreas(axes) {
        var markings = [];
        var d = new Date(axes.xaxis.min);
        // go to the first Saturday
        d.setUTCDate(d.getUTCDate() - ((d.getUTCDay() + 1) % 7))
        d.setUTCSeconds(0);
        d.setUTCMinutes(0);
        d.setUTCHours(0);
        var i = d.getTime();
        do {
            // when we don't set yaxis the rectangle automatically
            // extends to infinity upwards and downwards
            markings.push({ xaxis: { from: i, to: i + 2 * 24 * 60 * 60 * 1000 } });
            i += 7 * 24 * 60 * 60 * 1000;
        } while (i < axes.xaxis.max);

        return markings;
    }
	
    // OPTIONS FOR THE FLOT
    var options = {
        xaxis: { mode: "time" },
		selection: { mode: "xy" },
		lines: { show: true, fill: 0.5 },
		points: { show: true },
		yaxis: { min: 0, max: 2000 },
        grid: { hoverable: true, clickable: true, labelMargin: 10, borderWidth: 1, borderColor: "#ccc" },
		
		// BLUE (DEFAULT): #1B63AB, DARK BLUE: #2E4266,  
		// RED: #750000 GREEN: #006600, PINK: #AC205F, PURPLE: #330066
		// GREY: #333333, DARK GREEN: #003300. ORANGE: #CC3300
		colors: ["#750000"], 
		shadowSize: 2
    };
	
	// SET TOOLTIP DEFAULTS.
  	function showTooltip(x, y, contents) {
        $('<div id="tooltip">' + contents + '</div>').css( {
            position: 'absolute',
            display: 'none',
            left: x + -35,
			top: y - 45,
			padding: '4px',
			color: '#FFF',
			
			// BLUE (DEFAULT): #1B63AB, DARK BLUE: #2E4266 
			// RED: #DF0000, GREEN: #003300, PINK: #AC205F, PURPLE: #330066
			// GREY: #333333, DARK GREEN: #003300, ORANGE: #FF4000
            border: '1px solid #DF0000', 
			
			// BLUE (DEFAULT): #2278CE, DARK BLUE: #6C89BD R
			// RED: #750000, GREEN: #006600, PINK: #E44C90, PURPLE: #8409FF
			// GREY: #999999, DARK GREEN: #009900, ORGANGE: #FF4000
            'background-color': '#750000', 
			
            opacity: 0.80
        }).appendTo("body").fadeIn(200);
    }
	
    var plot = $.plot($("#placeholder"), [d], options);
    var previousPoint = null;
    $("#placeholder").bind("plothover", function (event, pos, item) {
        $("#x").text(pos.x.toFixed(2));
        $("#y").text(pos.y.toFixed(2));
            if (item) {
                if (previousPoint != item.datapoint) {
                    previousPoint = item.datapoint;
                    // CALL TOOLTIPS
                    $("#tooltip").remove();
                    var x = item.datapoint[0].toFixed(2),
                        y = item.datapoint[1].toFixed(2);
                    
                    showTooltip(item.pageX, item.pageY,
                               y + " hits");
                }
            }
			
            else {
                $("#tooltip").remove();
                previousPoint = null;            
            }
    });
});