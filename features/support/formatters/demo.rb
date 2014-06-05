require 'curses'

module Cucumber
  module Formatter
    # Creates a layout on screen to show the cucumber steps
    # and the active state of the game
    #
    # The active state of the game is rendered using the
    # DemoRenderer
    class Demo
      include Curses

      class << self
        attr_accessor :active
      end

      def initialize(*)
        self.class.active = true
        init_screen
        init_colors
        clear
        curs_set(0)

        @line = 3

        at_exit do
          sleep 5
          close_screen
        end
      end

      def before_feature(*)
        @line = 2
        clear
      end

      def feature_name(keyword, name, *)
        @feature_name = "#{keyword}: #{name}"
        refresh
        add_line
        addstr(@feature_name)
      end

      def before_background(*)
        add_line
        addstr('Background:')
      end

      def scenario_name(keyword, name, *)
        add_line
        add_line
        attron(color_pair(COLOR_BLUE))
        attroff(A_BOLD)
        addstr(keyword + ': ')

        attron(color_pair(COLOR_BLUE) | A_BOLD)
        addstr(name)
        refresh
        sleep 2
      end

      def step_name(keyword, step_match, _status, *_rest)
        step_name = step_match.format_args(->(param) { "*#{param}*" })
        message = "#{step_name}"

        add_line
        attron(color_pair(COLOR_GREEN) | A_BOLD)
        addstr(keyword)
        attroff(A_BOLD)
        addstr(message)
        refresh

        sleep 0.5
      end

      # def before_outline_table(outline_table)
      #   @table = outline_table
      # end

      # def before_table_row(table_row)
      #   addstr(table_row.inspect)
      #   refresh
      #   sleep 5
      # end

      # def after_outline_table(outline_table)
      #   @table = nil
      # end

      private

      def init_colors
        start_color
        init_pair(COLOR_GREEN, COLOR_GREEN, COLOR_BLACK)
        init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_BLACK)
        init_pair(COLOR_WHITE, COLOR_WHITE, COLOR_BLACK)
        crmode
      end

      def add_line
        width = cols / 3
        setpos(@line, cols - width)
        addstr(' ' * width)

        setpos(@line, cols - width)
        @line += 1
      end
    end
  end
end
