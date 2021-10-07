obj = double
obj.test #=> error here
allow(obj).to receive(:test)
obj.test #=> nil

obj = double
allow(obj).to receive(:test)
obj.test #=> nil
allow(obj).to receive(:test).and_return('value')
obj.test #=> "value"
allow(obj).to receive(:test) { 1 }
obj.test #=> 1

obj = double
allow(obj).to receive(:test).with(1).and_return('test1')
obj.test #=> error here
obj.test(1) #=> 1

o = double
allow(o).to receive(:test).and_return(1, 2)
o.test #=> 1
o.test #=> 2
o.test #=> 2

allow(object).to receive(:test_method).and_return('test values')
expect(object).to receive(:test_method).with('test result')

class A
  def method1
    method2
  end

  def method2
    method3
    method3
  end

  def method3; end
end

describe A do
  context 'method1' do
    subject { a.method1 }

    let(:a) { A.new }
    let(:expected) { 'expected' }

    before do
      expect(a).to receive(:method2).and_return(expected)
    end

    it { is_expected.to eq expected }
  end
end

allow(Foo).to receive(:bar).with(baz).and_return(foobar_result)
expect(Foo).to receive(:bar).with(baz).and_return(foobar_result)
