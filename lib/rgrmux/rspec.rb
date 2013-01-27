require 'rspec/core/formatters/progress_formatter'

module Rgrmux

  # Credits: @thedelchop - https://gist.github.com/4195788
  class RSpec < ::RSpec::Core::Formatters::ProgressFormatter

    def initialize(output)
      @tmux_message = ""
      @write_to_tmux = true
      super
    end

    def dump_summary(duration, example_count, failure_count, pending_count)
      summary = pluralize(example_count, "example")
      summary << ", " << pluralize(failure_count, "failure")
      summary << ", #{pending_count} pending" if pending_count > 0

      system "tmux set quiet on"

      if pending_count > 0
        system "tmux set status-right-bg yellow"
      elsif failure_count > 0
        system "tmux set status-right-bg red"
      else
        system "tmux set status-right-bg green"
      end

      @tmux_message = summary + @tmux_message

      super
    end

    def dump_failure_info(example)
      if @write_to_tmux
        exception = example.execution_result[:exception]

        @tmux_message << "  Failure/Error: #{read_failed_line(exception, example).strip} "

        exception.message.each_line do |line|
          @tmux_message << "#{line.gsub("\n","").strip} "
        end

        @write_to_tmux = false
      end

      super
    end

    def close
      system "tmux set status-right-length #{@tmux_message.length + 5}"

      system "tmux set status-right '#{@tmux_message.gsub('`','').gsub("'",'')}'"
      super
    end
  end
end
