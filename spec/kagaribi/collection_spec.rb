# frozen_string_literal: true

RSpec.describe Kagaribi::Collection do
  let(:collection) { Kagaribi::Collection.new("test") }

  describe "#set" do
    subject { collection.set(doc_key, data) }

    let(:doc_key) { "user1" }
    let(:data) { { name: "user1" } }

    it "should be saved" do
      subject

      firestore = Google::Cloud::Firestore.new

      actual = firestore.doc("test/#{doc_key}").get.data
      expect(actual).to eq data
    end
  end

  describe "#get" do
    subject { collection.get(doc_key) }

    let(:doc_key) { "user1" }

    context "doc is exists" do
      let(:data) { { name: "user1" } }

      before do
        firestore = Google::Cloud::Firestore.new

        firestore.doc("test/#{doc_key}").set(data)
      end

      it { should eq data }
    end

    context "doc isn't exists" do
      it { should eq({}) }
    end
  end
end
