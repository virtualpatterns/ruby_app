module RubyApp
  VERSION = "0.6.64"
  ROOT    = File.expand_path(File.dirname(__FILE__))

  def self.root
    @@_root ||= '/'
  end

  def self.root=(value)
    @@_root = value
  end

  def self.root_or_nil
    return @@_root.nil_if('/')
  end

end
