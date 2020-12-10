print 'hello'
require_relative '../enum_methods'
describe Enumerable do
  let(:array) { [1, 2, 3, 4, 5] }
  let(:array1) { [1, 2, 3, 4, false] }
  let(:array2) { [false, nil] }
  let(:animals) { %w[cat sheep bear] }

  let(:hash1) do
    { 'twenty' => 20, 'thirty' => 30, 'fourty' => 40 }
  end

  describe '#myeach Goes through each element of the array and returns' do
    it 'when block is given' do
      expect(array.my_each { |x| }).to eq(array)
    end

    it 'when block is not given' do
      expect(array.each).to be_kind_of(Enumerator)
    end
  end

  describe '#my_each_with_index Goes through each element of the array and returns value and index' do
    it 'when block is given' do
      expect(array.my_each_with_index { |x, _y| x > 2 }).to eq([1, 2, 3, 4, 5])
    end

    it 'when block is not given' do
      expect(array.my_each_with_index).to be_kind_of(Enumerator)
    end
  end