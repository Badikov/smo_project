# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
	$("ul.ate").on "click", (event) ->
		_target = $(@)
		_target.off "click"
		$(".spin")
			.addClass("modal-backdrop")
			.spin()
		$.ajax
			type: "GET"
			url: "/ats/to_mu"
			dataType: "html"
			data: kdatemu: $(@).data("kdatemu")
			success: (data, textStatus, jqXHR) ->
				$(data).appendTo(_target)
				$(".spin")
					.spin(false)
					.removeClass "modal-backdrop"
			error: (jqXHR, textStatus, errorThrown) -> 
				$(".spin").spin(false)
				alert errorThrown