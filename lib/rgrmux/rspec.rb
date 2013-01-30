require 'rspec/core/formatters/base_formatter'

module Rgrmux
  # Credits:
  #   @thedelchop - https://gist.github.com/4195788
  #   https://github.com/guard/guard/blob/master/lib/guard/notifiers/tmux.rb
  #
  class RSpec < ::RSpec::Core::Formatters::BaseFormatter

    def initialize(output)
      @tmux_color = ""
      @tmux_message = ""
      if ENV['TMUX']
        @write_to_tmux = true
        system "tmux set quiet on"
      end
      super
    end

    def dump_summary(duration, example_count, failure_count, pending_count)
      return super unless @write_to_tmux

      summary = pluralize(example_count, "example")
      summary << ", " << pluralize(failure_count, "failure")
      summary << ", #{pending_count} pending" if pending_count > 0

      if pending_count > 0
        @tmux_color = "yellow"
      elsif failure_count > 0
        @tmux_color = "red"
      else
        @tmux_color = "green"
      end

      @tmux_message = summary + @tmux_message
    end

    def close
      if @write_to_tmux
        system "tmux set status-left-bg #{@tmux_color}"
        system "tmux set message-bg #{@tmux_color}"
        system "tmux set display-time 3000"
        system "tmux display-message '#{@tmux_message.gsub('`','').gsub("'",'')}'"
        system "tmux set quiet off"
      end
      super
    end
  end
end
