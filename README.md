# tumblrExporter
| ⚠️ This repository will be archived in the future, this config will no longer be maintained. Thanks for all the stars, help and brainstorms! |

Code for Japan Webサイトの Tumblr から個別のデータを抜き出すスクリプトです。

通常のTumblrのRSSでは、[[MORE]]以降が表示されない、長いタイトルが削られるといったことがあったため、スクレイピングして取得するスクリプトを組みました。

## install

```
gem install mechanize
```

## run

```
ruby scrape.rb
```

## result

./out/ ディレクトリの下に、記事ID.xml という名前で、各記事の xml ファイルができます。

## make rss.xml

```
./makerss.sh
```

./out/ ディレクトリ配下のファイルを元に、 rss.xml というファイルが生成されます。

## 注意点

現行（2016年5月6日現在）の Code for Japan のThemeにしか対応していません。



