require_relative '../lib/squad_creator'

describe SquadCreator do
  let(:path) { "path_to_file" }
  let(:team_manager) { double("TeamManager") }
  let(:athlete_expected) do
    [
      { name: 'Rafael', position: 'full-back' }
    ]
  end
  let(:file) { double('File') }
  let(:content_hash) do
    {
      'athletes' => [],
      'squads' => []
    }
  end
  let(:expected_squad) do
    {
      id: 10,
      squad: 'Squad 10',
      athletes: athlete_expected
    }
  end

  subject { described_class.new(path) }

  before :each do
    allow(TeamManager).to receive(:new).and_return team_manager
    allow(team_manager).to receive(:create_new_team).and_return athlete_expected
  end

  describe '#create' do
    context 'when JSON file is not given' do
      let(:path) { 'wrong_path' }
      it 'raises exception' do
        expect { subject.create(10) }.to raise_error(RuntimeError)
      end
    end

    context 'when JSON file is provided' do
      before :each do
        allow(File).to receive(:read).with('path_to_file').and_return file
        allow(JSON).to receive(:parse).with(file).and_return content_hash
      end

      it 'does not raise exception' do
        expect { subject.create(10) }.not_to raise_error
      end

      it 'creates a rugby union squad' do
        expect(team_manager).to receive(:create_new_team)
        subject.create(10)
      end

      it 'returns Hash with correct attributes' do
        expect(subject.create(10)).to eq(expected_squad)
      end
    end
  end

  describe '#create_and_output_as_string' do
    context 'when JSON file is not given' do
      let(:path) { 'wrong_path' }
      it 'raises exception' do
        expect { subject.create_and_output_as_string(10) }.to raise_error(RuntimeError)
      end
    end

    context 'when JSON file is provided' do
      before :each do
        allow(File).to receive(:read).with('path_to_file').and_return file
        allow(JSON).to receive(:parse).with(file).and_return content_hash
        allow(subject).to receive(:puts)
      end

      it 'does not raise exception' do
        expect { subject.create_and_output_as_string(10) }.not_to raise_error
      end

      it 'creates a rugby union squad' do
        expect(team_manager).to receive(:create_new_team)
        subject.create(10)
      end

      it 'prints squad formation' do
        expect(subject).to receive(:puts).with("Squad ID: 10 \nSquad Name: Squad 10 \nAthletes: \n - Rafael - full-back")
        subject.create_and_output_as_string(10)
      end
    end
  end
end
