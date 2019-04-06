require "chapter2/array_deque"

require_relative "stat"

module OpenDataStructures::Chapter2
  class ArrayDequeStat < Stat
    def initialize
      super(ArrayDeque){|array_deque|
        array_deque.instance_variable_get(:@array).length - array_deque.length
      }
    end

    def dump(unit:, count:)
      dump_first(unit, count)
      dump_last(unit, count)
    end

    def dump_first(unit, count)
      start "first" do |instance,csv|
        count.times do |c|
          csv << rows(instance, c, unit){|i|
            instance.push(i)
          }
        end
        count.times do |c|
          csv << rows(instance, count - c, unit){|i|
            instance.shift
          }
        end
      end
    end

    def dump_last(unit, count)
      start "last" do |instance,csv|
        count.times do |c|
          csv << rows(instance, c, unit){|i|
            instance.unshift(i)
          }
        end
        count.times do |c|
          csv << rows(instance, count - c, unit){|i|
            instance.pop
          }
        end
      end
    end
  end

  ArrayDequeStat.new.dump unit: 100, count: 100
end