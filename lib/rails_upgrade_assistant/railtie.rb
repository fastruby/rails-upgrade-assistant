require_relative "./patchers/rails70"
require_relative "./patchers/rails71"

module RailsUpgradeAssistant
  class Railtie < ::Rails::Railtie
    initializer "rails_upgrade_assistant.breaking_changes" do |app|
      apply_from "#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}", app
    end

    def apply_from(version, app)
      case version
      when "2.3"
        apply_from("3.0", app)
      when "3.0"
        apply_from("3.1", app)
      when "3.1"
        apply_from("3.2", app)
      when "3.2"
        apply_from("4.0", app)
      when "4.0"
        apply_from("4.1", app)
      when "4.1"
        apply_from("4.2", app)
      when "4.2"
        apply_from("5.0", app)
      when "5.0"
        apply_from("5.1", app)
      when "5.1"
        apply_from("5.2", app)
      when "5.2"
        apply_from("6.0", app)
      when "6.0"
        apply_from("6.1", app)
      when "6.1"
        Rails70.patch(app)
        apply_from("7.0", app)
      when "7.0"
        Rails71.patch(app)
        apply_from("7.2", app)
      end
    end
  end
end
