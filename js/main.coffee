# Disable submit 'reserve' link for outdated workshop
$(->
	reserveDisabled = $('.main-reserve > .disabled')
	$('a',reserveDisabled).on 'click', ->
		return false
)
