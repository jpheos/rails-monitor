module Rails
  module Monitor
    class RequestsBuffer
      class << self
        def init
          @collection = []
        end

        def find(id)
          @collection.find { |r| r.id == id }
        end

        def push(request)
          @collection << request
        end

        def all
          @collection
        end

        def clear!
          @collection = []
        end
      end
    end
  end
end
