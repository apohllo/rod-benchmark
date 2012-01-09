require 'fileutils'
require 'net/http'
require 'bzip2'
require 'archive/tar/minitar'

DATA_DIR = File.join(File.dirname(__FILE__),"data")
SRC_DATA_DIR = File.join(DATA_DIR,"src")

def download_file(host,url_path,file_name)
  file_path = File.join(SRC_DATA_DIR,file_name)
  unless File.exist?(file_path)
    puts "Downloading #{host}#{url_path}"
    Net::HTTP.start(host) do |http|
      response = http.get(url_path)
      File.open(file_path,"wb") do |output|
        output.write(response.body)
      end
    end
  end
end

desc "Load the data"
task :load => :download do
  unless File.exist?(File.join(DATA_DIR,"rod","database.yml"))
    sh "./utils/load_rod_data.rb"
  end
  unless File.exist?(File.join(DATA_DIR,"sqlite","rod.sqlite3"))
    sh "./utils/load_ar_data.rb"
  end
end

desc "Check the loaded data"
task :check => :load do
  sh "./utils/check_rod_data.rb"
  sh "./utils/check_ar_data.rb"
end

desc "Benchmark the implementations"
task :default => :load do
  sh "./utils/scan_rod_data.rb"
  #sh "./utils/scan_ar_data.rb"
end

desc "Download the source data"
task :download do
  FileUtils.mkdir_p(SRC_DATA_DIR)
  download_file("www.gutenberg.org","/files/28014/28014-0.txt","text_1.txt")
  download_file("www.gutenberg.org","/files/31536/31536-0.txt","text_2.txt")
  sgjp_file = File.join(SRC_DATA_DIR,"sgjp.txt")
  unless File.exist?(sgjp_file)
    download_file("sgjp.pl","/morfeusz/download/morfeusz-SGJP-src-20110416.tar.bz2","sgjp.tar.bz2")
    bzip_file = File.open(File.join(SRC_DATA_DIR,"sgjp.tar.bz2"))
    tar_file_path = File.join(SRC_DATA_DIR,"sgjp.tar")
    unless File.exist?(tar_file_path)
      puts "Unziping sgjp.tar.bz2"
      reader = Bzip2::Reader.new(bzip_file)
      output = File.open(tar_file_path,"wb")
      while(!reader.eof?) do
        chunk = reader.read(2**(10) * 4)
        output.write(chunk)
      end
    end
    sgjp_original_file = File.join(SRC_DATA_DIR,"sgjp","formySGJP.tab")
    tar_path = File.join(SRC_DATA_DIR,"sgjp")
    unless File.exist?(sgjp_original_file)
      puts "Unpacking sgjp.tar"
      FileUtils.mkdir_p(tar_path)
      Archive::Tar::Minitar.unpack(File.open(tar_file_path,"rb"),tar_path)
    end
    FileUtils.mv(sgjp_original_file,sgjp_file)
    puts "Cleaning"
    FileUtils.rm_rf(tar_file_path)
    FileUtils.rm_rf(tar_path)
  end
end
