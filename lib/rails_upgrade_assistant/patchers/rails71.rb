require_relative "./patcher"

class Rails71 < Patcher
  def self.patched_version
    "Rails 7.1"
  end

  def monkey_patch_form_select
    ActionView::Helpers::FormBuilder.class_eval do
      alias_method :original_select, :select

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        if choices && options[:required] && !options[:include_blank] && !options[:prompt]
          choices_has_blank =
            if choices.is_a?(String)
              choices.match?(/value="\s*"/)
            elsif choices.is_a?(Array)
              choices.any? { |c| c.blank? }
            end

          unless choices_has_blank
            Rails71.warn("f.select now adds an empty option tag when `required: true` is provided in the `options` hash, and current option tags do not include an empty one (ref: https://github.com/rails/rails/commit/49c2e51808aaa89f3a0e833b6c42d97732f7d039)")
          end
        end
        original_select(method, choices, options, html_options, &block)
      end
    end
  end
end