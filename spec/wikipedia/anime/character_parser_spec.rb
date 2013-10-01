require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::CharacterParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/k_on.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    subject { Wikipedia::Anime::CharacterParser.new('けいおん!') }
    it { expect(subject.execute.first).to eq({name: '平沢唯', kana: 'ひらさわゆい', seiyu: '豊崎愛生'}) }
  end
end
