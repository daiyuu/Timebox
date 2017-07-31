class ContentsController < ApplicationController
  require 'nokogiri'
  require 'open-uri'
  require 'kconv'


  def index
    @contents = Content.order(counter: :desc)
    @contents = @contents.page(params[:page]).per(50)
  end


  def show
    @content = Content.find(params[:id])
    counter = @content.counter += 1
    @content.update(counter: counter)
    category = @content.category
    @contents = Content.all
    @contents = @contents.where(category: category)
    @contents = @contents.shuffle
  end

  def search
    @contents = Content.search(params[:search])
    @contents = @contents.page(params[:page]).per(50)
    render :index
  end

  def crawl
    @contents = Content.all

    diamond_home
    number_web
    mdpr
    sirabee
    itmedia

    diamond_sub
    baseballking
    soccerking
    natalie
    otona_salone
    lifehacker
    gigazine

    redirect_to profile_path
  end

  def crash
    @contents = Content.where(counter: 0)
    @contents.destroy_all
    redirect_to profile_path
  end

  def crasher
    Content.destroy_all
    redirect_to profile_path
  end

  private

    def baseballking
      doc = Nokogiri::HTML(open('https://baseballking.jp/'))
      7.times do |i|
        doc.xpath("//*[@id='head-line-special']/div[2]/ul/li[#{i+1}]").each do |c|
          url = c.css('a').attr("href")
          doc2 = Nokogiri::HTML(open(url.to_s))
          title = doc2.xpath("//*[@id='main']/article/div[1]/h1").text
          thumbnail = doc2.xpath("//*[@id='main']/article/div[3]/figure/img[2]").attr("src")
          category = 'sports'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def soccerking
      doc = Nokogiri::HTML(open('https://www.soccer-king.jp/'))
      2.times do |i|
        doc.xpath("/html/body/div[5]/div/div[1]/ul/li[#{i+1}]").each do |c|
          url = c.css('a').attr("href")
          title = c.xpath("/html/body/div[5]/div/div[1]/ul/li[#{i+1}]/a/div[3]").text
          thumbnail = c.xpath("/html/body/div[5]/div/div[1]/ul/li[#{i+1}]/a/div[2]/img").attr("src")
          category = 'sports'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      5.times do |i|
        doc.xpath("/html/body/div[5]/div/div[2]/ul/li[#{i+1}]").each do |c|
          url = c.css('a').attr("href")
          title = c.xpath("/html/body/div[5]/div/div[2]/ul/li[#{i+1}]/a/div[3]").text
          thumbnail = c.xpath("/html/body/div[5]/div/div[2]/ul/li[#{i+1}]/a/div[2]/img").attr('src')
          category = 'sports'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def natalie
      doc = Nokogiri::HTML(open('http://natalie.mu/owarai'))
      30.times do |i|
        doc.xpath("//*[@id='NA_main']/div[2]/div[1]/section/div/ul/li[#{i+1}]").each do |element|
          url = 'http://natalie.mu' + element.css('a').attr("href")
          title = element.xpath("//*[@id='NA_main']/div[2]/div[1]/section/div/ul/li[#{i+1}]/a/dl/dt").text
          doc2 = Nokogiri::HTML(open(url.to_s))
          begin
            thumbnail = doc2.xpath("//*[@id='NA_main']/article/div/div[1]/figure/p/img").attr("src")
          rescue => e
            thumbnail = 'IztbfaBz.png'
          end
          category = 'entertainment'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def mdpr
      doc = Nokogiri::HTML(open('https://mdpr.jp/topics/entertainment'))
      20.times do |i|
        doc.xpath("/html/body/div[1]/div[2]/div/main/section[1]/div[1]/ul/li[#{i+1}]").each do |element|
          url = 'https://mdpr.jp' + element.css('a').attr("href")
          title = element.xpath("/html/body/div[1]/div[2]/div/main/section[1]/div[1]/ul/li[#{i+1}]/a/div/p").text
          doc2 = Nokogiri::HTML(open(url.to_s))
          begin
            thumbnail = doc2.xpath("//*[@id='body-top']/div/figure/a/img").attr("src")
          rescue => e
            thumbnail = 'Unknown-1.png'
          end
          category = 'entertainment'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def diamond_home
      doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E6%94%BF%E6%B2%BB%E3%83%BB%E7%B5%8C%E6%B8%88'))
      6.times do |i|
        doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
          url = 'http://diamond.jp/' + element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'society'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def diamond_sub
      doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E7%A4%BE%E4%BC%9A'))
      6.times do |i|
        doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
          url = 'http://diamond.jp/' + element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'society'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E6%94%BF%E6%B2%BB%E3%83%BB%E7%B5%8C%E6%B8%88'))
      6.times do |i|
        doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
          url = 'http://diamond.jp/' + element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'society'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      doc = Nokogiri::HTML(open('http://diamond.jp/subcategory/%E5%9B%BD%E9%9A%9B'))
      6.times do |i|
        doc.xpath("//*[@id='main-column']/div[1]/article[#{i+1}]").each do |element|
          url = 'http://diamond.jp/' + element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'society'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def itmedia
      doc = Nokogiri::HTML(open('http://www.itmedia.co.jp/'))
      2.times do |i|
        doc.xpath("//*[@id='colBoxTopStories']/div[1]/div[#{i+1}]").each do |element|
          url = element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'science'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      4.times do |i|
        doc.xpath("//*[@id='colBoxTopStories']/div[3]/div[#{i+1}]").each do |element|
          url = element.css('a').attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'science'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def gigazine
      doc = Nokogiri::HTML(open('http://gigazine.net/'))
      20.times do |i|
        doc.xpath("//*[@id='section']/div[2]/section[#{i+1}]").each do |element|
          url = element.css('a').attr("href")
          title = element.css('h2').text
          thumbnail = element.css('img').attr("src")
          category = 'science'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def lifehacker
      doc = Nokogiri::HTML(open('https://www.lifehacker.jp/'))
      2.times do |i|
        doc.xpath("/html/body/main/div[1]/div[1]/div[1]/div[2]/a[#{i+1}]").each do |element|
          url = 'https://www.lifehacker.jp/' + element.attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'life'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      6.times do |i|
        doc.xpath("/html/body/main/div[1]/div[1]/div[1]/div[3]/a[#{i+1}]").each do |element|
          url = 'https://www.lifehacker.jp/' + element.attr("href")
          title = element.css('h3').text
          thumbnail = element.css('img').attr("src")
          category = 'life'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def sirabee
      doc = Nokogiri::HTML(open('https://sirabee.com/genre/%E3%82%B3%E3%83%A9%E3%83%A0/'))
      24.times do |i|
        doc.xpath("/html/body/div[2]/div[1]/div[1]/ul/li[#{i+1}]").each do |element|
          url = element.css('a').attr("href")
          title = element.xpath("/html/body/div[2]/div[1]/div[1]/ul/li[#{i+1}]/a/p[2]").text
          thumbnail = element.css('img').attr("src")
          category = 'life'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def otona_salone
      doc = Nokogiri::HTML(open('https://otonasalone.jp/'))
      12.times do |i|
        doc.xpath("//*[@id='tab1']/div[1]/ul/li[#{i+1}]").each do |element|
          url = element.css('a').attr("href")
          title = element.xpath("//*[@id='tab1']/div[1]/ul/li[#{i+1}]/a/div[2]/div[1]/p").text
          thumbnail = element.css('img').attr("src")
          category = 'life'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end

    def number_web
      doc = Nokogiri::HTML(open('http://number.bunshun.jp/'))
      6.times do |i|
        doc.xpath("/html/body/div[4]/div/article/section[1]/section[#{i+1}]").each do |element|
          url = 'http://number.bunshun.jp/' + element.css('a').attr("href")
          title = element.css('h2').text
          thumbnail = element.css('img').attr("src")
          category = 'sports'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
      21.times do |i|
        doc.xpath("/html/body/div[4]/div/article/section[2]/section[#{i+1}]").each do |element|
          url = 'http://number.bunshun.jp/' + element.css('a').attr("href")
          title = element.css('h2').text
          thumbnail = element.css('img').attr("src")
          category = 'sports'
          unless @contents.where(title: title).exists?
            content = Content.new(url: url, title: title, thumbnail: thumbnail, category: category)
            content.save
          end
        end
      end
    end




end
