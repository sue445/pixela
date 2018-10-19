RSpec.shared_examples :success do
  its(:message)   { should eq "Success." }
  its(:isSuccess) { should eq true }
end
