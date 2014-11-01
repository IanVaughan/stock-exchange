class TopPointDetection
  attr_reader :high_points, :collections
  attr_reader :window_width, :give_up_after, :collection_count

  def initialize(points)
    @points = points
  end

  def run(window_width, give_up_after, collection_count)
    @window_width = window_width
    @give_up_after = give_up_after
    @collection_count = collection_count

    @high_points = []
    @collections = []
    points.each { |p| analise(p) }
  end

  private
  attr_accessor :points, :window_width, :high_point, :collection

  def analise(p)
    @high_point ||= p
    @collection ||= []

    # Find next higher point
    if p.px_high > @high_point.px_high
      @high_point = p
      @new_high = true
    end

    # Save found higher point
    if @new_high && (p.position - @high_point.position) >= window_width
      @high_points << @high_point
      @collection << high_point
      @new_high = false

      if collection.count % collection_count == 0
        @collections << collection
        @collection = []
        @high_point = nil
      end
    end

    # Give up finding higher point after a while
    if @high_point && (p.position - @high_point.position) >= @give_up_after
      @high_point = nil
      @collections << collection
      @collection = []
    end
  end
end
