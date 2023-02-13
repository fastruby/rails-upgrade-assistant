class Patcher
  def self.patch(app)
    patcher = new(app)
    patcher.run_checks
    patcher.apply_monkey_patches
  end

  attr_reader :app

  def initialize(app)
    @app = app
  end

  def self.warn(message)
    puts("[Upgrade Assistant] #{patched_version}: #{message} (#{caller[1]})")
  end

  def patched_version
    raise "#{self} does not define a patched version string"
  end

  def run_checks
    checks.each { |check| send(check) }
  end

  def apply_monkey_patches
    monkey_patches.each { |patch| send(patch) }
  end

  def checks
    methods.select{ |m| m.to_s.start_with?("check_")}
  end

  def monkey_patches
    methods.select{ |m| m.to_s.start_with?("monkey_patch_")}
  end
end