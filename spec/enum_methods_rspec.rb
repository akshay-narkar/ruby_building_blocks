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

  describe '#my_any? Goes through each element of the structure. Returns true based on condition provided if
  any content satisfy the conditons' do
    context 'when block is given' do
      it 'when array is passed' do
        expect(array.my_any? { |x| x > 2 }).to be_truthy
      end
      it 'when hash is passed' do
        expect(hash1.my_any? { |_x, y| y > 20 }).to be_truthy
      end
      it 'array is passed with block requirement as Numeric ' do
        expect(array.my_any? { |x| x.is_a?(Numeric) }).to be_truthy
      end
      it 'array is passed with block requirement as Numeric ' do
        expect(array.my_any? { |x| x.is_a?(String) }).to be_falsy
      end
      it 'array1 is passed with block requirement as Numeric ' do
        expect(array1.my_any? { |x| x.is_a?(Numeric) }).to be_truthy
      end
    end

    context ' when block is not given' do
      it 'when block is not given and argument is given' do
        expect(array.my_any?(Integer)).to be_truthy
      end

      it 'when block is not given and argument is not given' do
        expect(array.my_any?).to be_truthy
      end

      it 'when block is not given and argument is not given & array with false is passed' do
        expect(array1.my_any?).to be_truthy
      end
    end
  end

  describe '#my_none? Goes through each element of the structure. Returns true or false based on condition provided if
  all contents satisfy the conditons' do
    context 'when block is given' do
      it 'when array is passed' do
        expect(array.my_none? { |x| x > 2 }).to be_falsy
      end
      it 'when hash is passed' do
        expect(hash1.my_none? { |_x, y| y > 20 }).to be_falsy
      end
      it 'array is passed with block requirement as Numeric ' do
        expect(array.my_none? { |x| x.is_a?(Numeric) }).to be_falsy
      end
      it 'array1 is passed with block requirement as Numeric ' do
        expect(array2.my_none? { |x| x.is_a?(Numeric) }).to be_truthy
      end
    end

    context ' when block is not given' do
      it 'when block is not given and argument is given' do
        expect(array.my_none?(Integer)).to be_falsy
      end

      it 'when block is not given and argument is not given' do
        expect(array.my_none?).to be_falsy
      end

      it 'when block is not given and argument is not given & array with all false is passed' do
        expect(array2.my_none?).to be_truthy
      end
    end
  end

  describe '#my_count Goes through each element of the structure. Returns the count based on contents
    that satisfy the conditons' do
    context 'when block is given' do
      it 'when array is passed & argument is given' do
        expect(array.my_count(2) { |x| x > 2 }).to eq(1)
      end
      it 'when hash is passed & argument is not given' do
        expect(hash1.my_count { |_x, y| y > 20 }).to eq(2)
      end
      it 'array is passed with block requirement as Numeric & argument is not given' do
        expect(array.my_count { |x| x.is_a?(Numeric) }).to eq(array.count { |x| x.is_a?(Numeric) })
      end
    end

    context ' when block is not given' do
      it 'when argument is given' do
        expect(array.my_count(Integer)).to eq(array.count(Integer))
      end

      it 'when argument is not given' do
        expect(array2.my_count).to eq(2)
      end
    end
  end

  describe '#my_map Goes through each element of the structure. Returns a new array
    based on block calculations' do
    context 'when proc is not given' do
      it 'when array is passed & block is given' do
        expect(array.my_map { |value| [value + 20] })
          .to eq(array.map { |value| [value + 20] })
      end
      it 'when hash is passed & block is given' do
        expect(hash1.my_map { |key, value| [key.upcase, value + 20] })
          .to eq(hash1.map { |key, value| [key.upcase, value + 20] })
      end
      it 'block is not given' do
        expect(array.my_map).to be_kind_of(Enumerator)
      end
    end

    context 'when proc is given' do
      my_proc = proc { |x| x**3 }
      it 'No block only proc' do
        expect(array.my_map(my_proc)).to eq(array.map(&my_proc))
      end
      it 'Proc and block given' do
        expect(array.my_map(my_proc) { |x| x**2 }).to eq(array.map(&my_proc))
      end
    end
  end

  describe '#my_inject Goes through each element of the structure. Returns a new array
    based on block calculations' do
    it 'when block is not given & argument is nil' do
      expect { array.my_inject }.to raise_error(LocalJumpError)
    end
    it 'when just the symbol is passed ' do
      expect { array.my_inject(:+) }.to eq(array.inject(:+))
    end
    it 'when symbol is passed with argument' do
      expect(array.my_inject(1, :+)).to eq(array.inject(1, :+))
    end
    context 'when block is passed with argument'
    it do
      expect(array.my_inject(1) { |product, n| product + n })
        .to eq(array.inject(1) { |product, n| product + n })
    end
    it do
      expect(animals.my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end)
        .to eq(animals.inject do |memo, word|
                 memo.length > word.length ? memo : word
               end)
    end
  end
end
