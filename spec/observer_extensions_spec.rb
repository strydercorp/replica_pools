require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require File.expand_path(File.dirname(__FILE__) + '/config/test_model')

describe SlavePools do

  before(:each) do
    ActiveRecord::Base.configurations = SLAVE_POOLS_SPEC_CONFIG
    ActiveRecord::Base.establish_connection :test
    ActiveRecord::Migration.verbose = false
    ActiveRecord::Migration.create_table(:test_models, :force => true) {}
    ActiveRecord::Migration.create_table(:test_subs, :force => true) {|t| t.integer :test_model_id}
    SlavePoolsModule::ConnectionProxy.setup!
    @observer = TestModelObserver.instance
  end
  
  context "asfd" do
    before(:each) do
      @test_model = TestModel.create
    end
    
    it "observers use observers correctly" do
      TestSub.first.test_model_id.should == @test_model.id
    end
    
    it  "should not throw a stack too deep error" do
      @test_model.should be_valid
    end
  end
end
