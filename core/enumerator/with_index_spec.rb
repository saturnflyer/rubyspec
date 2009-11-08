require File.dirname(__FILE__) + '/../../spec_helper'

ruby_version_is "1.8.7" do
  require File.dirname(__FILE__) + '/../../shared/enumerator/with_index'

  describe "Enumerator#with_index" do
    it_behaves_like(:enum_with_index, :with_index)

    ruby_version_is "1.9" do
      it "accepts an optional argument when given a block" do
        lambda do
          @enum.with_index(1) { |f| f}
        end.should_not raise_error(ArgumentError)
      end

      it "accepts an optional argument when not given a block" do
        lambda do
          @enum.with_index(1)
        end.should_not raise_error(ArgumentError)
      end

      it "numbers indices from the given index when given an offset but no block" do
        @enum.with_index(1).to_a.should == [[1,1],[2,2],[3,3],[4,4]]
      end

      it "numbers indices from the given index when given an offset and block" do
        acc = []
        @enum.with_index(1) {|e,i| acc << [e,i] }
        acc.should == [[1,1],[2,2],[3,3],[4,4]]
      end

      it "raises a TypeError when the argument cannot be converted to numeric" do
        lambda do
          @enum.with_index('1') {|i| i}
        end.should raise_error(TypeError)
      end

      it "converts non-numeric arguments to Integer via #to_int" do
        (o = mock('1')).should_receive(:to_int).and_return(1)
        @enum.with_index(o).to_a.should == [[1,1],[2,2],[3,3],[4,4]]
      end

      it "coerces the given numeric argument to an Integer" do
        @enum.with_index(1.678).to_a.should == [[1,1],[2,2],[3,3],[4,4]]
      end
    end
  end
end
