imgix = require('imgix')
conf = require('./configuration')

# # # # # # # # # # # # # # #
# # # RESPONSIVE IMAGES # # #
# # # # # # # # # # # # # # #

# Replace responsive images with local paths (development mode helper)
overwrite_images_with_local_paths = ->
	$('.imgix-fluid').each (i, el) ->
		path = $(el).data('src')
		path = path.replace("http://#{conf.asset_host}/", '/assets/projects/')
		$(el).attr('data-src', path)
		bkg_img = "url(#{path})"
		if el.tagName == 'IMG'
			el.src = path
		else
			$(el).css(backgroundImage: "#{bkg_img}", backgroundSize: "cover")

module.exports =
	init: ->
		# Responsive image logic
		$(document).ready ->
			# If we're in production
			if document.location.href.indexOf('localhost') == -1
				# deploy imgix image replacement
				imgix.onready () ->
					imgix.fluid
						updateOnResizeDown: true,
						pixelStep: 5,
						autoInsertCSSBestPractices: true,
						lazyLoad: true,
						lazyLoadOffsetVertical: 2000,
						lazyLoadColor: false
						onLoad: ->
							$(document).trigger('imgix:load')
			# If we're developing
			else
				console.log 'hello'
				overwrite_images_with_local_paths()
