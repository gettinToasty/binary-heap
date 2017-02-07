class BinaryMinHeap
  def initialize(&prc)
    @store = []
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    min = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0)
    min
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    @store = BinaryMinHeap.heapify_up(@store, @store.length - 1)
  end

  protected
  attr_accessor :prc, :store

  public
  def self.child_indices(len, parent_index)
    children = []
    children << (parent_index * 2 + 1) if parent_index * 2 + 1 < len
    children << (parent_index * 2 + 2) if parent_index * 2 + 2 < len
    children
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = proc { |a, b| a <=> b } unless prc
    children = BinaryMinHeap.child_indices(len, parent_idx)
    until children.empty?
      if children[1] && prc.call(array[children[0]], array[children[1]]) == 1
        min_child = children[1]
      else
        min_child = children[0]
      end
      if prc.call(array[parent_idx], array[min_child]) == 1
        array[parent_idx], array[min_child] = array[min_child], array[parent_idx]
      end
      parent_idx = min_child
      children = BinaryMinHeap.child_indices(len, parent_idx)
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc = proc { |a, b| a <=> b } unless prc
    parent = BinaryMinHeap.parent_index(child_idx)
    if prc.call(array[child_idx], array[parent]) == -1
      array[child_idx], array[parent] = array[parent], array[child_idx]
    end
    BinaryMinHeap.heapify_up(array, parent, len, &prc)
  end
end
