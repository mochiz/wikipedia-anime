# -*- coding: utf-8 -*-

module Wikipedia
  module Anime
    # スタッフクラス
    #
    # 1つのスタッフをあらわします。
    #
    # Examples
    #
    #   staff = Wikipedia::Anime::Staff.new(name: '虚淵玄', position: '脚本')
    #   # => #<Staff ...>
    #
    class Staff
      attr_accessor :name, :position

      # クラス定数

      # 役職名リスト
      POSITIONS = %w(監督 .*ディレクター .*構成 .*脚本 .*演出 .*デザイン 音楽)

      # Public: Staff を初期化します。
      #
      # args - 属性のハッシュ
      #        :nama      - String, 名前
      #        :position  - String, 役職
      #
      def initialize(args = {})
        @name  = args[:name]
        @position  = args[:position]
      end

      # Public: 属性値の配列を返します。
      #
      # Array を返します。
      def values
        [@position, @name]
      end
    end
  end
end
