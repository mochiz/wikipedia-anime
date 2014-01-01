# -*- coding: utf-8 -*-

# Wikipediaページ クラス
#
# 日本語ページを取り扱いやすくするためにメソッドを追加します。
#
class Wikipedia::Page
  # Public: コンテンツテキストを返します。
  # ※日本語ページ用のコンテンツを取得するようcontentメソッドを上書きします
  #
  # String を返します。
  def content
    page['revisions'].first['*'] if page['revisions']
  end

  # Public: 人名の曖昧さ回避ページか否かを返します。
  #
  # Boolean を返します。
  def disambiguation_pages?
    categories.include?('Category:人名の曖昧さ回避') if categories
  end

  # Public: 人物ページの性別が男性か否かを返します。
  #
  # Boolean を返します。
  def male?
    return false unless categories
    categories.any? { |x| ['Category:日本の男性声優', 'Category:日本の俳優'].include?(x) }
  end

  # Public: 人物ページの性別が女性か否かを返します。
  #
  # Boolean を返します。
  def female?
    return false unless categories
    categories.any? { |x| ['Category:日本の女性声優', 'Category:日本の女優'].include?(x) }
  end

  # Public: 人物ページの性別を返します。
  #
  # String または nil を返します。
  def gender
    return '男性' if male?
    return '女性' if female?
    nil
  end
end
