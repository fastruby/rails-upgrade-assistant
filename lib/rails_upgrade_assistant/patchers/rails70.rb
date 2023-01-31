require_relative "./patcher"

class Rails70 < Patcher
  def patched_version
    "Rails 7.0"
  end

  def check_sprockets_rails_gem
    gemfile_content = File.read(ENV["BUNDLE_GEMFILE"])
    if !gemfile_content.match?("sprockets-rails")
      warn("The `sprocket-rails` gem must be added to the gemfile.")
    end
  end

  def check_zeitwerk
    if app.config.autoloader != :zeitwerk
      warn("#{app.config.autoloader} autoloader must be replaced with zeitwerk.")
    end
  end

  def monkey_patch_button_to
    ActionView::Helpers::UrlHelper.class_eval do
      alias_method :original_button_to, :button_to

      def button_to(name = nil, options = nil, html_options = nil, &block)
        if options.is_a?(Array) && options.any? { |x| x.is_a?(ActiveRecord::Base) }
          record = options.find { |x| x.is_a?(ActiveRecord::Base) && x.persisted? }
          if record
            warn("button_to used with a persisted object in the options, HTTP method will change from POST to PATCH")
          end
        end
        original_button_to(name, options, html_options) do
          yield
        end
      end
    end
  end
end