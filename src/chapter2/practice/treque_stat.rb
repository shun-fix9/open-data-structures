require "chapter2/practice/treque"

require_relative "../stat"

module OpenDataStructures::Chapter2
  module Practice
    class TrequeStat < Stat
      def initialize
        super(Treque)
      end

      def dump(unit:, count:)
        dump_first(unit, count)
        dump_last(unit, count)
        dump_middle(unit, count)
      end

      def dump_first(unit, count)
        start "first" do |instance,csv|
          count.times do |c|
            csv << rows(instance, c, unit){|i|
              instance.unshift(i)
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
              instance.push(i)
            }
          end
          count.times do |c|
            csv << rows(instance, count - c, unit){|i|
              instance.pop
            }
          end
        end
      end

      def dump_middle(unit, count)
        start "middle" do |instance,csv|
          count.times do |c|
            csv << rows(instance, c, unit){|i|
              instance.add(instance.length/2,i)
            }
          end
          count.times do |c|
            csv << rows(instance, count - c, unit){|i|
              instance.remove(instance.length/2)
            }
          end
        end
      end
    end

    TrequeStat.new.dump unit: 100, count: 100
  end
end
