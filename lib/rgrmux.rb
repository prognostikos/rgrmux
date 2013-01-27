# require "rgrmux/version"

module Rgrmux
  autoload :RSpec, "rgrmux/rspec"

  def self.new(*args)
    case args.size
    when 0 then MiniTest::Unit
    when 1 then RSpec
    when 2 then Spec
    when 3 then Cucumber
    else
      raise ArgumentError
    end.new(*args)
  end
end
