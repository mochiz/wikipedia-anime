# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::Title do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/k_on.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '.find' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.class).to eq(Wikipedia::Anime::Title) }
    it { expect(@title.page.class).to eq(Wikipedia::Page) }
  end

  describe '#characters' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.characters.count).to eq(9) }
    it { expect(@title.characters.first.class).to eq(Wikipedia::Anime::Character) }
    it { expect(@title.characters.first.name).to eq('平沢唯') }
    it { expect(@title.characters.first.kana).to eq('ひらさわ ゆい') }
    it { expect(@title.characters.first.seiyu).to eq('豊崎愛生') }
  end

  describe '#character_names' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.character_names.count).to eq(9) }
    it { expect(@title.character_names.first).to eq('平沢唯') }
  end

  describe '#seiyu_names' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.seiyu_names.count).to eq(9) }
    it { expect(@title.seiyu_names.first).to eq('豊崎愛生') }
  end
end
