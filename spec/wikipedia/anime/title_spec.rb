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

  describe '#staffs' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.staffs.count).to eq(4) }
    it { expect(@title.staffs.first.class).to eq(Wikipedia::Anime::Staff) }
    it { expect(@title.staffs.first.position).to eq('監督') }
    it { expect(@title.staffs.first.name).to eq('山田尚子') }
  end

  describe '#information' do
    before do
      @title = Wikipedia::Anime::Title.find('けいおん!')
      @informations = {
        "アニメーション制作" => "京都アニメーション",
        "放送局" => "JapanNewsNetwork|TBS系列各局（他、#放送局|放送局参照）",
        "放送開始" => "第1期：2009年4月2日",
        "製作" => "桜高軽音部、TBSテレビ|TBS",
        "話数" => "第1期：全14話（本編24話+番外編3話）"
      }
    end
    it { expect(@title.informations).to eq(@informations) }
  end

  describe '#targeted_characters' do
    before do
      @names = %w(平沢 琴吹)
      @title = Wikipedia::Anime::Title.find('けいおん!')
    end
    it { expect(@title.characters(@names).count).to eq(2) }
    it { expect(@title.characters(@names).first.class).to eq(Wikipedia::Anime::Character) }
    it { expect(@title.characters(@names).first.name).to eq('平沢唯') }
    it { expect(@title.characters(@names).last.name).to eq('琴吹紬') }
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
