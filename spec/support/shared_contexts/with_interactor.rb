shared_context "with interactor" do
  let(:interactor) { described_class.new(initial_context) }
  let(:context) { interactor.context }
end
