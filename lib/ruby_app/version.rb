module RubyApp
  VERSION = "0.6.62"
  ROOT    = File.expand_path(File.dirname(__FILE__))

  def self.root
    @@_root ||= '/'
  end

  def self.root=(value)
    @@_root = value
  end

end
