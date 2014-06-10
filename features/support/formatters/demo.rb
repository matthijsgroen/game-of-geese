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
        init_window

        at_exit do
          sleep 5
          close_screen
        end
      end

      attr_reader :cuke

      def before_feature(*)
        clear
        cuke.clear
      end

      def feature_name(keyword, name, *)
        @feature_name = "#{keyword}: #{name}"
        cuke.refresh
        cuke.add_line(@feature_name, attrs: color_pair(COLOR_WHITE) | A_BOLD)
      end

      def before_background(*)
        cuke.add_line 'Background:'
      end

      def scenario_name(keyword, name, *)
        cuke.add_line
        cuke.add_line(keyword + ': ', attrs: color_pair(COLOR_BLUE))
        cuke.write(name, attrs: color_pair(COLOR_BLUE) | A_BOLD)

        cuke.refresh
        sleep 3
      end

      def step_name(keyword, step_match, _status, *_rest)
        step_name = step_match.format_args(->(param) { "*#{param}*" })
        message = "#{step_name}"

        cuke.add_line(keyword, attrs: color_pair(COLOR_GREEN) | A_BOLD)
        cuke.write(message, attrs: color_pair(COLOR_GREEN))
        cuke.refresh

        sleep 0.5
      end

      def before_outline_table(outline_table)
        self.table = outline_table
      end

      def before_multiline_arg(multiline_arg)
        self.table = multiline_arg
      end

      def before_table_row(_table_row)
        @col_index = 0
        cuke.add_line
        cuke.write('  | ')
      end

      def after_table_cell(_cell)
        return unless table
        @col_index += 1
      end

      def table_cell_value(value, _status)
        return unless table
        width = table.col_width(@col_index)

        cuke.write(value.to_s)
        # setpos(@line - 1, cucumber_outline + width)
        cuke.write((' ' * (width - value.length)) + ' | ')
      end

      def after_outline_table(_outline_table)
        self.table = nil
      end

      private

      attr_accessor :table

      def init_window
        @cuke = CucumberWindow.new(
          lines - 4, cucumber_width,
          2, cucumber_outline
        )
        clear
        curs_set(0)
      end

      def init_colors
        start_color
        init_pair(COLOR_GREEN, COLOR_GREEN, COLOR_BLACK)
        init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_BLACK)
        init_pair(COLOR_WHITE, COLOR_WHITE, COLOR_BLACK)
        crmode
      end

      def cucumber_width
        cols / 3
      end

      def cucumber_outline
        cols - cucumber_width
      end
    end

    # The Window displaying cuke information
    class CucumberWindow < Curses::Window
      def initialize(height, width, top, left)
        super(height, width, top, left)
        @line = 0
      end

      def clear
        super
        @line = 0
      end

      def add_line(text = nil, options = {})
        setpos(@line, 0)
        write(' ' * maxx)

        setpos(@line, 0)
        @line += 1

        write(text, options) if text
      end

      def write(string, options = {})
        with_text_options options do
          addstr(string)
        end
      end

      private

      def with_text_options(options = {})
        attron(options[:attrs]) if options.key? :attrs
        yield
        attroff(options[:attrs]) if options.key? :attrs
      end
    end
  end
end
