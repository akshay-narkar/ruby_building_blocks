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

  describe '#my_select Goes through each element of the array and returns a new array based on selection' do
    it 'when block is given' do
      expect(array.my_select { |x| x > 2 }).to eq(array.select { |x| x > 2 })
    end
 
    it 'when block is not given' do
      expect(array.my_select).to be_kind_of(Enumerator)
    end
  end
 
  describe '#my_all? Goes through each element of the structure. Returns true or false based on condition provided if
  all contents satisfy the conditons' do
    context 'when block is given' do
      it 'when array is passed' do
        expect(array.my_all? { |x| x > 2 }).to be_falsy
      end
      it 'when hash is passed' do
        expect(hash1.my_all? { |_x, y| y > 20 }).to be_falsy
      end
      it 'array is passed with block requirement as Numeric ' do
        expect(array.my_all? { |x| x.is_a?(Numeric) }).to be_truthy
      end
      it 'array1 is passed with block requirement as Numeric ' do
        expect(array1.my_all? { |x| x.is_a?(Numeric) }).to be_falsy
      end
    end
 
    context ' when block is not given' do
      it 'when block is not given and argument is given' do
        expect(array.my_all?(Integer)).to be_truthy
      end
 
      it 'when block is not given and argument is not given' do
        expect(array.my_all?).to be_truthy
      end
 
      it 'when block is not given and argument is not given & array with false is passed' do
        expect(array1.my_all?).to be_falsy
      end
    end
  end