# -*- coding: utf-8 -*-

require 'wikipedia/anime/tag_remover'

module Wikipedia
  module Anime
    # アニメキャラクターパーサー
    #
    # アニメページのwikiテキストからキャラクター情報をパースします。
    # ";平沢唯 \n:声 - 豊崎愛生\n" 形式のテキストを1つのキャラクターとして扱います。
    #
    # Examples
    #
    #   page = Wikipedia.find('けいおん!')
    #   parser = Wikipedia::Anime::CharacterParser.new(page.content).execute
    #   # => [#<Wikipedia::Anime::Character ..>]
    #
    class CharacterParser
      include TagRemover

      # アクセサー
      attr_accessor :characters, :character_texts, :page, :content

      # クラス定数
      CHARACTER_SCAN_REGEXP = /;(.*)\n.*声 ??[-:](.*)/
      NAME_GSUB_REGEXP      = /{{.*\||}}|\[\[.*?\||\[\[|\]\]/

      # Public: 新しいインスタンスを生成します。
      #
      # page - Wikipedia::Page オブジェクト
      def initialize(page)
        @page            = page
        @content         = page.content.gsub('：', ':').gsub('[[声優|声]]', '声')
        @characters      = []
        @character_texts = @content.scan(CHARACTER_SCAN_REGEXP)
      end

      # Public: キャラクターをパースします。
      # Wikiページのコンテンツからキャラクターをパースします。
      #
      # Wikipedia::Anime::CharacterParser オブジェクトを返します。
      def execute
        @character_texts.each do |character, seiyu|
          character = remove_tag(character)
          @characters << parsed_character(character, seiyu)
        end
        self
      end

      private

      # Internal: キャラクターをパースして返します。
      #
      # character - String "平沢唯（ひらさわゆい）"
      # seiyu     - String "[[豊崎愛生]]"
      #
      # Wikipedia::Anime::Character オブジェクトを返します。
      def parsed_character(character, seiyu)
        name = parsed_name(character)
        kana = parsed_kana(name, character)
        seiyu = parsed_seiyu(seiyu)
        Character.new(name: name,
                      kana: kana,
                      seiyu: seiyu)
      end

      # Internal: キャラクター名を返します。
      #
      # name - String
      #
      # String を返します。
      def parsed_name(name)
        remove_tag(name).gsub(/（.*）/, '').gsub(NAME_GSUB_REGEXP, '').gsub(/ /, '')
      end

      # Internal: ふりがなを返します。
      #
      # name - String
      # kana - String
      #
      # String を返します
      def parsed_kana(name, character)
        kana = character.match(/（.*）/)
        return name.tr('ァ-ン', 'ぁ-ん') unless kana
        return name.tr('ァ-ン', 'ぁ-ん') if /[A-Za-z]/ =~ kana[0]
        kana[0].gsub(/（|）/, '').gsub(NAME_GSUB_REGEXP, '').tr('ァ-ン', 'ぁ-ん')
      end

      # Internal: 人物名を返します。
      #
      # name - String
      #
      # String を返します
      def parsed_seiyu(name)
        name = remove_tag(name).gsub(NAME_GSUB_REGEXP, '').strip
        name.gsub!('島崎信長', '島﨑信長')
        name.gsub!('赤崎千夏', '赤﨑千夏')
        name
      end
    end
  end
end
