require 'colored'
require 'aliyun/oss'
require 'listen'
require 'find'
require 'pathname'

module Aosss

  class Sync

    attr_reader :bucket, :key, :secret, :remote, :remote_path, :local_path

    def initialize( options )
      @key        = options[:key] || ENV['OSS_ACCESS_ID']
      @secret     = options[:secret] || ENV['OSS_ACCESS_SECRET']
      @remote     = options[:remote]
      @dryrun     = options[:dryrun]
      @local_path = File.expand_path(options[:local_path])
      parse_remote
      init_connection
    end

    def pull
      step_info "pulling #{"(dryrun)" if @dryrun}"

      print indent << "#{bucket}:#{remote_path}"
      print " => "
      print "local:#{local_path}\n"
    end

    def push
      step_info "pushing #{"(dryrun)" if @dryrun}"

      print "\n" << indent << "#{bucket}:#{remote_path}".bold
      print " => "
      print "local:#{local_path}\n\n".bold

      Find.find( local_path ) do |path|
        if File.basename(path).start_with? ?.
          Find.prune 
        elsif !File.directory?(path)
          file = short_path(path)

          print indent << "=> ".black
          print file

          if exist_on_oss?( file )
            print " ~skip\n".yellow
          else
            push_to_oss( file ) unless @dryrun
            print " ✔\n".green
          end
        end
      end

    end

    private

      def parse_remote
        @bucket, @remote_path = @remote.split(":")
        @remote_path ||= "/"
      end

      def init_connection
        step_info "init connection"
        Aliyun::OSS::Base.establish_connection!(
          :access_key_id     => key, 
          :secret_access_key => secret
        )
      end

      def step_info( msg )
        puts "----> #{msg}"
      end

      def indent
        " " * 6
      end

      def short_path( path )
        Pathname.new( path ).relative_path_from( Pathname.new( local_path ) ).to_path
      end

      def push_to_oss( file )
        Aliyun::OSS::OSSObject.store(
          File.join( remote_path, file ),
          open(file),
          bucket
        )
      end

      def open( file )
        File.open( File.expand_path(file, local_path) )
      end

      def exist_on_oss?( file )
        oss_bucket
        Aliyun::OSS::OSSObject.exists? file, bucket
      end

      def oss_bucket
        @oss_bucket ||= Aliyun::OSS::Bucket.find bucket
      end

    public

      def watch
        Listen.to!( local_path, relative_paths: true ) do |modified, added, removed| 
          modified.each   {|file| push_to_oss(file) }
          added.each      {|file| push_to_oss(file) }
          removed.each    {|file| del_in_oss(file) }
        end
      end

  end

end
