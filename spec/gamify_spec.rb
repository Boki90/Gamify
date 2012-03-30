require "gamify"
require "mocha"

class DummyClass
  include Gamify
end

describe DummyClass do

  before(:each) do
    @dummy_class = DummyClass.new
  end

  it "should keep track of the user's points" do
    @dummy_class.set_points(25)
    @dummy_class.total_points.should eq(25)
  end

  it "should allow the number of points to be increased" do
    @dummy_class.set_points(25)
    @dummy_class.add_points(200)
    @dummy_class.total_points.should eq(225)
  end

  it "should track the level associated with the number of experience points" do
    @dummy_class.set_points(25)
    @dummy_class.level.should_not be_nil
  end

  it "should track the experience curve of a popular MMORPG" do
    levels = {}
    levels[1] = 400
    levels[2] = 900
    levels[3] = 1400
    levels[4] = 2100
    levels[5] = 2800
    levels[6] = 3600
    levels[10] = 7600
    levels[11] = 8700
    levels[17] = 16400
    levels.each_pair do |level, max_points|
      @dummy_class.set_points(max_points - 1)
      @dummy_class.add_points(1)
      @dummy_class.level.should eq(level + 1)
    end
  end

  it "should return level 1 for 1 experience point" do
    @dummy_class.set_points(1)
    @dummy_class.level.should eq(1)
  end

  it "should return level 1 for 300 experience points" do
    @dummy_class.set_points(300)
    @dummy_class.level.should eq(1)
  end

  it "should return level 2 for 410 experience points" do
    @dummy_class.set_points(410)
    @dummy_class.level.should eq(2)
  end

  it "should return level 10 for 7599 experience points" do 
    @dummy_class.set_points(7599)
    @dummy_class.level.should eq(10)
  end

  it "should return level 11 for 8699 experience points" do
    @dummy_class.set_points(8699)
    @dummy_class.level.should eq(11)
  end

  it "should return the level of the user after points have been added" do
    @dummy_class.set_points(2099)
    @dummy_class.level.should eq(4)
    @dummy_class.total_points.should eq(2099)
    @dummy_class.add_points(1)
    @dummy_class.total_points.should eq(2100)
    @dummy_class.level.should eq(5)
  end

  it "should report the number of points necessary to reach the next level" do
    @dummy_class.set_points(2099)
    @dummy_class.total_points.should eq(2099)
    @dummy_class.level.should eq(4)
    @dummy_class.points_to_next_level.should eq(1)
  end

  it "should track the percentage completion of the current level" do
    @dummy_class.set_points(650)
    @dummy_class.points_to_next_level.should eq(250)
    @dummy_class.percent_level_complete.should eq(50)
  end

  it "should update the object's activerecord point balance if present" do
    @dummy_class.set_points(650)
    @dummy_class.expects(:update_model_point_balance)
    @dummy_class.expects(:update_attributes)
    @dummy_class.add_points(1)
  end

  it "should use the object's activerecord point balance if present" do 
    @dummy_class.expects(:points).returns(500)
    @dummy_class.total_points.should eq(500)
  end

  it "should default to zero points if the object's point method returns nil" do
    @dummy_class.expects(:points).returns(nil)
    @dummy_class.total_points.should eq(0)
  end

  it "should default to zero percent complete upon instantiation" do
    @dummy_class.level.should eq(1)
  end

end