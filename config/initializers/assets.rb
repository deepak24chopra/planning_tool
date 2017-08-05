# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path


Rails.application.config.assets.precompile += %w( theme-default.css )
Rails.application.config.assets.precompile += %w( jquery.min.js )
Rails.application.config.assets.precompile += %w( jquery-ui.min.js )
Rails.application.config.assets.precompile += %w( bootstrap.min.js )
Rails.application.config.assets.precompile += %w( icheck.min.js )
Rails.application.config.assets.precompile += %w( jquery.mCustomScrollbar.min.js )
Rails.application.config.assets.precompile += %w( scrolltopcontrol.js )
Rails.application.config.assets.precompile += %w( raphael-min.js )
Rails.application.config.assets.precompile += %w( morris.min.js )
Rails.application.config.assets.precompile += %w( d3.v3.js )
Rails.application.config.assets.precompile += %w( rickshaw.min.js )
Rails.application.config.assets.precompile += %w( jquery-jvectormap-1.2.2.min.js )
Rails.application.config.assets.precompile += %w( jquery-jvectormap-world-mill-en.js )
Rails.application.config.assets.precompile += %w( bootstrap-datepicker.js )
Rails.application.config.assets.precompile += %w( owl.carousel.min.js )
Rails.application.config.assets.precompile += %w( moment.min.js )
Rails.application.config.assets.precompile += %w( daterangepicker.js )
Rails.application.config.assets.precompile += %w( bootstrap-file-input.js )
Rails.application.config.assets.precompile += %w( bootstrap-select.js )
Rails.application.config.assets.precompile += %w( jquery.tagsinput.min.js )
Rails.application.config.assets.precompile += %w( jquery.dataTables.min.js )

Rails.application.config.assets.precompile += %w( plugins.js )
Rails.application.config.assets.precompile += %w( actions.js )
Rails.application.config.assets.precompile += %w( demo_dashboard.js )

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
