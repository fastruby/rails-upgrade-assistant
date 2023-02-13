require_relative "./patcher"

class Rails71 < Patcher
  def self.patched_version
    "Rails 7.1"
  end

  def monkey_patch_form_select
    ActionView::Helpers::FormBuilder.class_eval do
      alias_method :original_select, :select

      def select(method, choices = nil, options = {}, html_options = {}, &block)
        if choices && options[:required] && !options[:include_blank]
          choices_has_blank =
            if choices.is_a?(String)
              choices.match?(/value="\s*"/)
            elsif choices.is_a?(Array)
              choices.any? { |c| c.blank? }
            end

          unless choices_has_blank
            Rails71.warn("f.select now adds an empty option when `required: true` is provided, and current options do not include an empty one")
          end
        end
        original_select(method, choices, options, html_options, &block)
      end
    end
  end
end