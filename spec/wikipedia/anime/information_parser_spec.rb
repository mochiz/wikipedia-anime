# -*- coding: utf-8 -*-

require File.expand_path(File.dirname(__FILE__) + '../../../spec_helper')

describe Wikipedia::Anime::InformationParser do
  before do
    json = File.read(File.expand_path(File.dirname(__FILE__) + '../../../fixtures/k_on.json'))
    allow(Wikipedia).to receive(:find) { Wikipedia::Page.new(json) }
  end

  describe '#execute' do
    before do
      @page = Wikipedia.find('けいおん!')
      @parser = Wikipedia::Anime::InformationParser.new(@page).execute
      @informations = {
        "アニメーション制作" => "京都アニメーション",
        "放送局" => "JapanNewsNetwork|TBS系列各局（他、#放送局|放送局参照）",
        "放送開始" => "第1期：2009年4月2日",
        "製作" => "桜高軽音部、TBSテレビ|TBS",
        "話数" => "第1期：全14話（本編24話+番外編3話）"
      }
    end

    it { expect(@parser.informations).to eq(@informations) }
  end
end
