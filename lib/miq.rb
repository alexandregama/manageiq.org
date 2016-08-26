require 'pathname'
require 'bundler'
Bundler.require(:default)

unless ENV["MIQ_ENV"] == "production"
  Bundler.require(:development)
  Dotenv.load
end

require_relative "miq/executor"
require_relative "miq/site"
require_relative "miq/guides"
require_relative "miq/ref_docs"

module Miq
  def self.working_dir
    if ENV["MIQ_BASE_DIR"]
      Pathname.new(ENV["MIQ_BASE_DIR"])
    else
      Pathname.new(Dir.pwd)
    end
  end

  def self.dest_dir
    working_dir.join( (ENV["MIQ_SITE_DEST"] || "dest") )
  end

  def self.site_dir
    working_dir.join( (ENV["MIQ_SITE_SOURCE"] || "site") )
  end

  def self.docs_dir
    if ENV["MIQ_DOCS_DIR"]
      working_dir.join(ENV["MIQ_DOCS_DIR"])
    else
      working_dir.join("site", "docs")
    end
  end
end