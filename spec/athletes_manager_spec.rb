require_relative '../lib/athletes_manager'

describe AthletesManager do
  let(:athletes) do
    [
      { 'position' => 'full-back', 'is_injured' => true },
      { 'position' => 'full-back', 'is_injured' => true },
      { 'position' => 'out-half', 'is_injured' => false },
      { 'position' => 'out-half', 'is_injured' => true },
      { 'position' => 'hooker', 'is_injured' => true },
      { 'position' => 'hooker', 'is_injured' => true },
      { 'position' => 'hooker', 'is_injured' => true },
      { 'position' => 'hooker', 'is_injured' => false },
      { 'position' => 'hooker', 'is_injured' => false },
      { 'position' => 'flanker', 'is_injured' => false },
      { 'position' => 'flanker', 'is_injured' => false },
      { 'position' => 'flanker', 'is_injured' => true }
    ]
  end

  subject { described_class.new(athletes) }

  describe '#players_by_position' do
    context 'when athletes list is not empty' do
      [
        { position: 'full-back', quantity: 0 },
        { position: 'out-half', quantity: 1 },
        { position: 'hooker', quantity: 2 },
        { position: 'flanker', quantity: 2 }
      ].each do |test_params|
        it "returns #{test_params[:quantity]} #{test_params[:position]} players" do
          players = subject.players_by_position(test_params[:position])
          expect(players.length).to eq(test_params[:quantity])
        end

        it "returns only #{test_params[:position]} players" do
          players = subject.players_by_position(test_params[:position])
          players.each do |player|
            expect(player['position']).to eq test_params[:position]
          end
        end

        it 'does not return injured players' do
          players = subject.players_by_position(test_params[:position])
          players.each do |player|
            expect(player['is_injured']).to eq false
          end
        end
      end
    end

    context 'when athletes list is empty' do
      let(:athletes) { [] }
      it 'returns empty array' do
        expect(subject.players_by_position('lock')).to eq([])
      end
    end

    context 'when athletes list nil' do
      let(:athletes) { nil }
      it 'returns empty array' do
        expect(subject.players_by_position('lock')).to eq([])
      end
    end
  end
end
