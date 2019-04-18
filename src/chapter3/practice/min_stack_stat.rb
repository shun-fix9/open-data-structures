require "chapter3/practice/min_stack"

require_relative "../stat"

module OpenDataStructures::Chapter3
  module Practice
    class MinStackStat < Stat
      def initialize
        super(MinStack)

        @random = Random.new(1000)
      end

      def dump(unit:, count:)
        dump_first(unit, count)
      end

      def dump_first(unit, count)
        start "first" do |instance,csv|
          count.times do |c|
            csv << rows_after(
              instance, c, unit,
              ->(i){ instance.push @random.rand },
              ->(i){ [ instance.length, instance.min ] }
            )
          end
          count.times do |c|
            csv << rows_before(
              instance, count - c - 1, unit,
              ->(i){ instance.pop },
              ->(i){ [ instance.length, instance.min ] }
            )
          end
        end
      end

      private

        def init_instance
          @klass.new
        end
    end

    MinStackStat.new.dump unit: 100, count: 100
  end
end