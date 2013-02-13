module RubyApp
  VERSION = "0.6.61"
  ROOT    = File.expand_path(File.dirname(__FILE__))

  def self.base
    @@_base ||= '/'
  end

  def self.base=(value)
    @@_base = value
  end

end
