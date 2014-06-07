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
        @cuke = Window.new(lines - 4, cucumber_width, 2, cucumber_outline)
        init_colors
        clear
        curs_set(0)


        at_exit do
          sleep 5
          close_screen
        end
      end

      attr_reader :cuke

      def before_feature(*)
        @line = 0
        @background_line = 0
        clear
        cuke.clear
      end

      def feature_name(keyword, name, *)
        @feature_name = "#{keyword}: #{name}"
        cuke.refresh
        add_cuke_line
        set_color(COLOR_WHITE)

        set_bold
        write(@feature_name)
        clear_bold
      end

      def before_background(*)
        add_cuke_line
        write('Background:')
      end

      def after_background(*)
        @background_line = @line
      end

      def scenario_name(keyword, name, *)
        add_cuke_line
        add_cuke_line
        set_color(COLOR_BLUE)
        clear_bold
        write(keyword + ': ')

        set_bold
        write(name)

        cuke.refresh
        sleep 3
      end

      def step_name(keyword, step_match, _status, *_rest)
        step_name = step_match.format_args(->(param) { "*#{param}*" })
        message = "#{step_name}"

        add_cuke_line
        set_color(COLOR_GREEN)
        set_bold
        write(keyword)
        clear_bold
        write(message)
        cuke.refresh

        sleep 0.5
      end

      def before_outline_table(outline_table)
        @table = outline_table
      end

      def before_multiline_arg(multiline_arg)
        @table = multiline_arg
      end

      def before_table_row(table_row)
        @col_index = 0
        add_cuke_line
        write('  | ')
      end

      def after_table_cell(cell)
        return unless @table
        @col_index += 1
      end

      def table_cell_value(value, status)
        return unless @table
        width = @table.col_width(@col_index)

        write(value.to_s)
        #setpos(@line - 1, cucumber_outline + width)
        write((' ' * (width - value.length)) + ' | ')
      end

      def after_outline_table(outline_table)
        @table = nil
      end

      private

      def init_colors
        start_color
        init_pair(COLOR_GREEN, COLOR_GREEN, COLOR_BLACK)
        init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_BLACK)
        init_pair(COLOR_WHITE, COLOR_WHITE, COLOR_BLACK)
        crmode
      end

      def set_bold
        cuke.attron(A_BOLD)
      end

      def clear_bold
        cuke.attroff(A_BOLD)
      end

      def set_color(color)
        cuke.attron(color_pair(color))
      end

      def add_cuke_line
        cuke.setpos(@line, 0)
        write(' ' * cucumber_width)

        cuke.setpos(@line, 0)
        @line += 1
      end

      def write(string)
        @cuke.addstr(string)
      end

      def cucumber_width
        cols / 3
      end

      def cucumber_outline
        cols - cucumber_width
      end
    end
  end
end
