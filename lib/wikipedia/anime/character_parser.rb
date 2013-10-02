# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    class CharacterParser
      CASTING_LINE_SCAN_REGEXP = /;(.*?)\n.*声[-:](.*)/
      CHARACTERS_PAGE_TITLE_REGEXP = /{{.*登場人物}}/
      SEIYU_REGEXP = /\[\[(.*?)\]\]/

      # Public: 新しいインスタンスを生成します。
      #
      # title - Wikipediaページタイトル
      def initialize(title)
        @page = Wikipedia.find(title)
        @content = @page.content.gsub(' ', '').gsub('：', ':').gsub('[[声優|声]]', '声')
        @castings = @content.scan(CASTING_LINE_SCAN_REGEXP)
      end

      # Public: キャラクター名と人物名のハッシュ配列を返します。
      # 声優のWikiページのあるキャラクターのみ対象とします
      #
      # Array を返します。
      def execute
        params = []
        @castings.each do |character, seiyu|
          next unless seiyu.match(/\[\[/)
          params << parsed_casting(character, seiyu)
        end
        params
      end

      private

      # Public: 登場人物ページヘのリダイレクトが必要か否かを返します
      #
      # Boolean を返します。
      def should_redirect
        parsed_castings.empty? && characters_page_title.length > 0
      end

      # Public: 登場人物ページのタイトルを返します
      #
      # String を返します。
      def characters_page_title
        return '' unless @content.match(CHARACTERS_PAGE_TITLE_REGEXP)
        @content.match(CHARACTERS_PAGE_TITLE_REGEXP)[0].gsub(/{.*\|/, '').gsub('}}', '')
      end

      private

      # Internal: キャラクター名と人物名のハッシュ配列を返します。
      #
      # character - String "平沢唯（ひらさわゆい）"
      # seiyu - String "[[豊崎愛生]]"
      #
      # Hash を返します。
      def parsed_casting(character, seiyu)
        character = retrieve_unnecessary_tag(character)
        names = character.gsub(/）.*/, '').split('（')
        name = parsed_name(names[0])
        kana = parsed_kana(name, names[1])
        seiyu = parsed_seiyu(seiyu)
        { name: name, kana: kana, seiyu: seiyu }
      end

      # Internal: 人物名を返します。
      #
      # name - String
      #
      # String を返します
      def parsed_seiyu(name)
        name.gsub(/{{.*\|/, '').gsub('}}', '') \
          .gsub(/\|.*?\]\]/, '') \
          .gsub('[[', '') \
          .gsub(']]', '')
      end

      # Internal: キャラクター文字列から不要なタグを除去します
      #
      # character - String
      #
      # String を返します。
      def retrieve_unnecessary_tag(character)
        character.gsub(/<!--.*-->/, '') \
          .gsub(/<ref.*?<\/ref>/, '') \
          .gsub(/\[\[.*?\|/, '') \
          .gsub(']]', '')
      end

      # Internal: 名前を返します。
      #
      # name - String
      #
      # String を返します。
      def parsed_name(name)
        name.gsub(/{{.*\|/, '').gsub('}}', '') \
          .gsub(/\[\[.*?\|/, '') \
          .gsub(']]', '') \
          .gsub('[[', '')
      end

      # Internal: ふりがなを返します。
      #
      # name - String
      # kana - String
      #
      # String を返します
      def parsed_kana(name, kana = nil)
        return name.tr('ァ-ン', 'ぁ-ん') unless kana
        kana.gsub(/{{.*\|/, '').gsub('}}', '') \
          .gsub(/\[\[.*?\|/, '') \
          .gsub(']]', '') \
          .gsub('[[', '') \
          .tr('ァ-ン', 'ぁ-ん')
      end
    end
  end
end
