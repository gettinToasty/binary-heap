require_relative "heap"

class Array
  def heap_sort!
    heap_len = 0
    prc = proc { |a, b| b <=> a }
    while heap_len < self.length
      BinaryMinHeap.heapify_up(self, heap_len, heap_len + 1, &prc)
      heap_len += 1
    end
    heap_len -= 1
    while heap_len > 0
      self[0], self[heap_len] = self[heap_len], self[0]
      heap_len -= 1
      BinaryMinHeap.heapify_down(self, 0, heap_len + 1, &prc)
    end
    self
  end
end
