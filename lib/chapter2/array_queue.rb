require "chapter2/backing_array"

module OpenDataStructures
  module Chapter2
    class ArrayQueue
      def initialize
        @length = 0
        @index = 0
        @array = BackingArray.new(length: 1)
      end

      attr_reader :length

      def blank
        @array.length - length
      end

      def [](index)
        validate_index index
        get index
      end

      def []=(index,value)
        validate_index index
        set index, value
      end

      def add(index,value)
        validate_add index
        grow if full?

        (length - index).times do |i|
          set (length - i), get(length - i - 1)
        end

        set index, value
        @length += 1

        nil
      end

      def remove(index)
        validate_index index
        target = get index

        index.times do |i|
          set (index - i), get(index - i - 1)
        end

        set 0, nil
        @length -= 1
        @index += 1

        shrink if over?

        target
      end

      def push(value)
        add(length,value)
      end

      def unshift(value)
        add(0,value)
      end

      def pop
        remove(length - 1)
      end

      def shift
        remove(0)
      end

      private

        def get(index)
          @array[fit index]
        end

        def set(index,value)
          @array[fit index] = value
        end

        def fit(index)
          (index + @index) % @array.length
        end

        def full?
          length + 1 > @array.length
        end

        def over?
          length < @array.length / 3
        end

        def grow
          resize(@array.length * 2)
        end

        def shrink
          resize(@array.length / 2)
        end

        def resize(new_length)
          new_length = 1 if new_length <= 0
          new_array = BackingArray.new(length: new_length)
          length.times do |i|
            new_array[i] = get i
          end
          @array = new_array
          @index = 0
        end

        def validate_index(index)
          raise ArgumentError, "index: #{index} / length: #{length}" if index < 0 or index >= length
        end
        def validate_add(index)
          raise ArgumentError, "index: #{index} / length: #{length}" if index < 0 or index >= length + 1
        end
    end
  end
end
