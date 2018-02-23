RSpec.describe SoftDelete do
  it "has a version number" do
    expect(SoftDelete::VERSION).not_to be nil
  end

  let!(:alderaan) { TestModel.create(name: "Alderaan") }
  let!(:tatooine) { TestModel.create(name: "Tatooine") }
  let!(:dagobah) { TestModel.create(name: "Dagobah") }

  before { alderaan.destroy }

  describe "scopes" do

    describe ".not_deleted" do
      it "returns records that have not been deleted" do
        expect(TestModel.not_deleted).to match_array([tatooine, dagobah])
      end
    end

    describe ".deleted" do
      it "returns deleted records" do
        expect(TestModel.deleted).to match_array([alderaan])
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
      expect { TestModel.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
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
    
    it 'runs callbacks' do
       expect(tatooine).to receive(:after_save_do_this)
       tatooine.destroy
    end
    
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
      expect { TestModel.find(id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#restore" do
    it "sets the deleted_at field to nil" do
      alderaan.restore
      expect(alderaan.deleted_at).to be_nil
    end
  end
end
