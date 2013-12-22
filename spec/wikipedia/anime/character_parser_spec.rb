# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::CharacterParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/k_on.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    before do
      @page = Wikipedia.find('けいおん!')
      @parser = Wikipedia::Anime::CharacterParser.new(@page).execute
    end
    it { expect(@parser.characters.first.name).to eq('平沢唯') }
    it { expect(@parser.characters.first.kana).to eq('ひらさわ ゆい') }
    it { expect(@parser.characters.first.seiyu).to eq('豊崎愛生') }

    context '声の項目に複数のページタグが有る場合' do
      before do
        content = "; {{Anchor|巴|輪島 巴}}（わじま ともえ）\n: 声 - [[能登麻美子]]<ref group=\"注\">舞台である石川県の出身者ということもあり、第7話の[[クレジットタイトル#スタッフロール|スタッフロール]]には[[金沢弁]][[監修]]に「能登家の人々」の名が見て取れる。</ref>"
        @page.stub(:content).and_return(content)
        @parser = Wikipedia::Anime::CharacterParser.new(@page).execute
      end
      it { expect(@parser.characters.first.name).to eq('輪島巴') }
      it { expect(@parser.characters.first.kana).to eq('わじま ともえ') }
      it { expect(@parser.characters.first.seiyu).to eq('能登麻美子') }
    end

    context 'spanタグで囲まれている場合' do
      before do
        content = "; <span id=\"平賀才人\">平賀才人</span>（ひらが さいと）\n: 声 - [[日野聡]]"
        @page.stub(:content).and_return(content)
        @parser = Wikipedia::Anime::CharacterParser.new(@page).execute
      end
      it { expect(@parser.characters.first.name).to eq('平賀才人') }
      it { expect(@parser.characters.first.kana).to eq('ひらが さいと') }
      it { expect(@parser.characters.first.seiyu).to eq('日野聡') }
    end

    context 'ふりがなが日本語ではない場合' do
      before do
        content = "; ココ・ヘクマティアル（Koko Hekmatyar）\n: 声 - [[井上麻里奈]] / [[伊藤静]]"
        @page.stub(:content).and_return(content)
        @parser = Wikipedia::Anime::CharacterParser.new(@page).execute
      end
      it { expect(@parser.characters.first.name).to eq('ココ・ヘクマティアル') }
      it { expect(@parser.characters.first.kana).to eq('ここ・へくまてぃある') }
      it { expect(@parser.characters.first.seiyu).to eq('井上麻里奈 / 伊藤静') }
    end
  end
end
