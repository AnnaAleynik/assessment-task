require "rails_helper"

describe SearchRelation do
  let(:search_relation) { described_class.new(data) }

  let(:data) { results }
  let(:results) do
    {
      page: 3,
      results: [
        { payload: "payload" },
        { payload: "payload" },
        { payload: "payload" }
      ],
      total_pages: 10,
      total_results: 1000
    }
  end

  describe "#current_page" do
    subject { search_relation.current_page }

    let(:expected_data) { 3 }

    it { is_expected.to eq(expected_data) }
  end

  describe "#total_pages" do
    subject { search_relation.total_pages }

    let(:expected_data) { 10 }

    it { is_expected.to eq(expected_data) }
  end

  describe "#all" do
    subject { search_relation.all }

    let(:expected_data) do
      [
        { payload: "payload" },
        { payload: "payload" },
        { payload: "payload" }
      ]
    end

    it { is_expected.to eq(expected_data) }
  end

  describe "#limit_value" do
    subject { search_relation.limit_value }

    let(:expected_data) { 20 }

    it { is_expected.to eq(expected_data) }
  end
end
