require_relative '../lib/team_manager'

describe TeamManager do
  let(:athletes) { double("AthleteList") }
  let(:athletes_manager) { double("AthletesManager") }
  let(:props) { [{ 'name' => '', 'position' => 'prop' }, { 'name' => '', 'position' => 'prop' }] }
  let(:hookers) { [{ 'name' => '', 'position' => 'hooker' }, { 'name' => '', 'position' => 'hooker' }] }
  let(:locks) { [{ 'name' => '', 'position' => 'lock' }, { 'name' => '', 'position' => 'lock' }] }
  let(:flankers) { [{ 'name' => '', 'position' => 'flanker' }, { 'name' => '', 'position' => 'flanker' }] }
  let(:number_eights) { [{ 'name' => '', 'position' => 'number-eight' }, { 'name' => '', 'position' => 'number-eight' }] }
  let(:scrum_halves) { [{ 'name' => '', 'position' => 'scrum-half' }, { 'name' => '', 'position' => 'scrum-half' }] }
  let(:out_halves) { [{ 'name' => '', 'position' => 'out-half' }, { 'name' => '', 'position' => 'out-half' }] }
  let(:centres) { [{ 'name' => '', 'position' => 'centre' }, { 'name' => '', 'position' => 'centre' }] }
  let(:wingers) { [{ 'name' => '', 'position' => 'winger' }, { 'name' => '', 'position' => 'winger' }] }
  let(:full_backs) { [{ 'name' => '', 'position' => 'full-back' }, { 'name' => '', 'position' => 'full-back' }] }

  subject { described_class.new(athletes) }

  before :each do
    allow(AthletesManager).to receive(:new).with(athletes).and_return athletes_manager
    allow(athletes_manager).to receive(:players_by_position).with('prop'        ).and_return props
    allow(athletes_manager).to receive(:players_by_position).with('hooker'      ).and_return hookers
    allow(athletes_manager).to receive(:players_by_position).with('lock'        ).and_return locks
    allow(athletes_manager).to receive(:players_by_position).with('flanker'     ).and_return flankers
    allow(athletes_manager).to receive(:players_by_position).with('number-eight').and_return number_eights
    allow(athletes_manager).to receive(:players_by_position).with('scrum-half'  ).and_return scrum_halves
    allow(athletes_manager).to receive(:players_by_position).with('out-half'    ).and_return out_halves
    allow(athletes_manager).to receive(:players_by_position).with('centre'      ).and_return centres
    allow(athletes_manager).to receive(:players_by_position).with('winger'      ).and_return wingers
    allow(athletes_manager).to receive(:players_by_position).with('full-back'   ).and_return full_backs
  end

  describe '#create_new_team' do
    context 'when athletes list is nil' do
      let(:athletes) { nil }

      it 'raises an error' do
        expect{ subject.create_new_team }.to raise_error(RuntimeError)
      end
    end

    context 'when team is a valid ruby union team' do
      it 'returns an Array of 15 items' do
        expect(subject.create_new_team.length).to eq(15)
      end

      [
        { position: 'prop', expected: 2 },
        { position: 'hooker', expected: 1 },
        { position: 'lock', expected: 2 },
        { position: 'flanker', expected: 2 },
        { position: 'number-eight', expected: 1 },
        { position: 'scrum-half', expected: 1 },
        { position: 'out-half', expected: 1 },
        { position: 'centre', expected: 2 },
        { position: 'winger', expected: 2 },
        { position: 'full-back', expected: 1 },
      ].each do |test_data|
        it "has #{test_data[:expected]} #{test_data[:position]} players in the team" do
          team = subject.create_new_team
          expect(team.count{ |t| t[:position] == 'prop' }).to eq(2)
        end
      end
    end

    context 'when team is not a valid ruby union team' do
      let(:full_backs) { [] }

      it 'raises an error' do
        expect{ subject.create_new_team }.to raise_error(RuntimeError)
      end
    end
  end
end
