# frozen_string_literal: true

RSpec.describe Kagaribi::Collection do
  let(:collection) { Kagaribi::Collection.new("test") }

  describe "#set" do
    subject { collection.set(doc_key, data) }

    let(:doc_key) { "user1" }
    let(:data) { { name: "user1" } }

    context "document isn't exists" do
      it "should be saved" do
        subject

        firestore = Google::Cloud::Firestore.new

        actual = firestore.doc("test/#{doc_key}").get.data
        expect(actual).to eq data
      end
    end

    context "document is exists" do
      let(:old_data) { { name: "user1", description: "desc1" } }

      before do
        firestore = Google::Cloud::Firestore.new

        firestore.doc("test/#{doc_key}").set(old_data)
      end

      it "should be saved" do
        subject

        firestore = Google::Cloud::Firestore.new

        actual = firestore.doc("test/#{doc_key}").get.data
        expect(actual).to eq data
      end
    end
  end

  describe "#update" do
    subject { collection.update(doc_key, data) }

    let(:doc_key) { "user1" }
    let(:old_data) { { name: "user1", description: "desc1" } }
    let(:data) { { name: "user2", nickname: "nickname" } }

    before do
      firestore = Google::Cloud::Firestore.new

      firestore.doc("test/#{doc_key}").set(old_data)
    end

    it "should be updated" do
      subject

      firestore = Google::Cloud::Firestore.new

      actual = firestore.doc("test/#{doc_key}").get.data
      expect(actual).to eq(name: "user2", nickname: "nickname", description: "desc1")
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

  describe "#exists?" do
    subject { collection.exists?(doc_key) }

    let(:doc_key) { "user1" }

    context "doc is exists" do
      let(:data) { { name: "user1" } }

      before do
        firestore = Google::Cloud::Firestore.new

        firestore.doc("test/#{doc_key}").set(data)
      end

      it { should eq true }
    end

    context "doc isn't exists" do
      it { should eq false }
    end
  end
end
