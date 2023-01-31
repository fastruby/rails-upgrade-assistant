require_relative "./patcher"

class Rails71 < Patcher
  def patched_version
    "Rails 7.0"
  end
end