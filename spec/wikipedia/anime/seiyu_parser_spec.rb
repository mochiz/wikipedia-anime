# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::SeiyuParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/aki.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    subject { Wikipedia::Anime::SeiyuParser.new('豊崎愛生') }
    it { expect(subject.execute[:name]).to eq('豊崎愛生') }
    it { expect(subject.execute[:sort_name]).to eq('とよさきあき') }
    it { expect(subject.execute[:gender]).to eq('female') }
    it { expect(subject.execute[:twitter_username]).to eq(nil) }
    it { expect(subject.execute[:wikipedia_url]).to eq(URI.encode("http://ja.wikipedia.org/wiki/豊崎愛生")) }
    it { expect(subject.execute[:search_text]).to eq('あきちゃん') }
  end
end
