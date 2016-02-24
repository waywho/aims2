# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( casein/dropzone.css casein/dropzone.js jquery-ui.css jquery-ui.js font-awesome.css 
	froala_editor.min.css froala_style.min.css froala_editor.min.js plugins/code_view.min.js plugins/code_view.min.css, plugins/link.min.js 
	 plugins/image.min.css plugins/image.min.js plugins/image_manager.min.js plugins/image_manager.min.css plugins/colors.min.css plugins/colors.min.js
	plugins/paragraph_format.min.js plugins/paragraph_style.min.js plugins/fullscreen.min.css plugins/fullscreen.min.js plugins/font_size.min.js plugins/align.min.js 
	plugins/char_counter.min.css plugins/char_counter.min.js plugins/quote.min.js plugins/file.min.js plugins/file.min.css)