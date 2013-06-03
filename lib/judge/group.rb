module Judge
  class Group
    include Enumerable

    attr_accessor :items

    def initialize(items=[])
      @items = items
    end

    def self.load(corpus_path)
      
      group = Group.new

      File.open(corpus_path, 'r') do |file|
        file.each_line do |line|
          group << Item.new(line)
        end
      end

      group
    end

    def <<(val)
      @items << val
    end

    def each(&block)
      @items.each(&block)
    end

    def freq(word)
      count = @items.inject(0) do |ret, item|
        ret += 1 if item.include?(word)
        ret
      end

      if count.zero?
        0.0001
      else
        count.to_f / @items.count.to_f
      end
    end

  end
end