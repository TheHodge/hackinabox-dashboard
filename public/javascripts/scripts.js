/*	
	Silky Admin Template
	
	v1.0 16th November 2009
	Jeff Adams	
*/
$(document).ready(function() {


	// Closing Divs - used on Notification Boxes
	$(".canhide").append("<div class='close-notification png_bg'></div>").css("position", "relative");
	$(".close-notification").click(function() {
		$(this).hide();
		$(this).parent().fadeOut(700);
	});
	
	// Load WYSIWYG Editor - add class 'wysiwyg' to any textarea to add functionality.
	$('.wysiwyg').wysiwyg();
	
	// Load Facebox - simple add "rel="facebook" to any link to activate Modal Dialog
	$('a[rel*=facebox]').facebox();
	
	// Load Table Sorter - change this if you only want to sort a particular table.
	 $("table") 
    .tablesorter({widgets: ['zebra']}) 
  	
	// Ticks all checkboxes	
		$('.tick-all').click(
			function(){
				$(this).parent().parent().parent().parent().find("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
			}
		);

	
	
// Closing jQuery
});