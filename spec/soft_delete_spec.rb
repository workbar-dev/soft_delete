class MockModel < ActiveRecord::Base
  include SoftDelete
end

RSpec.describe SoftDelete do
  it "has a version number" do
    expect(SoftDelete::VERSION).not_to be nil
  end

  let!(:alderaan) { MockModel.create! }
  let!(:tatooine) { MockModel.create! }
  let!(:dagobah) { MockModel.create! }

  describe "scopes" do
    before { alderaan.destroy }

    describe ".not_deleted" do
      it "returns records that have not been deleted" do
        expect(MockModel.not_deleted).to match_array([tatooine, dagobah])
      end
    end

    describe ".deleted" do
      it "returns deleted records" do
        # The array [alderaan] returns a MockModel object, whereas this returns
        # alderaan as an object of its subclass
        expect(MockModel.deleted).to match_array([alderaan_alias])
      end
    end
  end

  describe "#delete" do
    it "sets the deleted_at field" do
      expect(dagobah.deleted_at).to be_nil
      dagobah.delete
      expect(dagobah.deleted_at).to be_a(Time)
    end
  end

  describe "#delete!" do
    it "deletes the record" do
      id = dagobah.id
      dagobah.delete!
      expect { MockModel.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#deleted?" do
    it "returns true for deleted records" do
      expect(alderaan.deleted?).to eq(true)
    end

    it "returns false for existing records" do
      expect(tatooine.deleted?).to eq(false)
      expect(dagobah.deleted?).to eq(false)
    end
  end

  describe "#destroy" do
    it "sets the deleted_at field" do
      expect(tatooine.deleted_at).to be_nil
      tatooine.destroy
      expect(tatooine.deleted_at).to be_a(Time)
    end
  end

  describe "#destroy!" do
    it "deletes the record" do
      id = tatooine.id
      tatooine.destroy!
      expect { MockModel.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#restore" do
    it "sets the deleted_at field to nil" do
      alderaan.restore
      expect(alderaan.deleted_at).to be_nil
    end
  end
end
