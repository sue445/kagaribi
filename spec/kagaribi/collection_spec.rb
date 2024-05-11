# frozen_string_literal: true

RSpec.describe Kagaribi::Collection do
  let(:collection) { Kagaribi::Collection.new("users") }

  describe "#set" do
    subject { collection.set(doc_key, params) }

    let(:doc_key) { "user1" }
    let(:params) { { name: "user1" } }

    it { expect { subject }.not_to raise_error }
  end
end
