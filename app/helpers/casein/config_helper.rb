module Casein
  module ConfigHelper
    
    # Name of website or client — used throughout Casein.
    def casein_config_website_name
      'AIMS International Music School'
    end

    # Filename of logo image. Ideally, it should be a transparent PNG around 140x30px
    def casein_config_logo
      'AIMS_red-sm.jpg'
    end

    # The server hostname where Casein will run
    def casein_config_hostname
      if Rails.env.production?
        'http://aims-international.herokuapp.com'
      else
        'http://0.0.0.0:3000'
      end
    end

    # The sender address used for email notifications
    def casein_config_email_from_address
      'donotreply@aims.uk.com'
    end
  
    # The initial page the user is shown after they sign in or click the logo. Probably this should be set to the first tab.
    # Do not point this at casein/index!
    def casein_config_dashboard_url
      # url_for :controller => :casein, :action => :blank
      casein_dashboards_path
    end
  
    # A list of stylesheets to include. Do not remove the core casein/casein, but you can change the load order, if required.
    def casein_config_stylesheet_includes
      %w[casein/casein casein/custom casein/dropzone jquery-ui font-awesome froala_style.min froala_editor.min plugins/code_view.min 
        plugins/image.min plugins/image_manager.min plugins/fullscreen.min plugins/colors.min plugins/char_counter.min plugins/file.min]
    end
  
    # A list of JavaScript files to include. Do not remove the core casein/casein, but you can change the load order, if required.
    def casein_config_javascript_includes
      %w[casein/casein casein/custom casein/dropzone jquery-ui froala_editor.min plugins/image.min plugins/image_manager.min plugins/code_view.min 
        plugins/paragraph_format.min plugins/paragraph_style.min plugins/fullscreen.min plugins/link.min plugins/colors.min plugins/font_size.min plugins/align.min
        plugins/char_counter.min plugins/quote.min plugins/file.min plugins/lists.min]
    end
  end
end