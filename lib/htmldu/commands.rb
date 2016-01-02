require "tempfile"

module Htmldu
  class Commands
    def self.start(args, script_dir)
      command = self.new(args[0], script_dir)
      command.exec
    end

    def initialize(dir, script_dir)
      @dir = dir
      @script_dir = script_dir
      @dirtree = Htmldu::Dirtree.new(@dir)
    end

    def exec()
      @dirtree.generate_tree

      json_file = Tempfile.create("htmldu")
      json_file.write "dirtree="
      json_file.write @dirtree.to_json
      json_file.close
      json_path = json_file.path + ".js"
      json_url = "file://#{json_path}"
      File.rename(json_file.path, json_path)

      script_url = "file://#{@script_dir}/lib/htmldu/js/show.js"

      html_file = Tempfile.create("htmldu")
      html_file.write <<"EOS"
<html>
  <head>
    <title> DU: #{@dir} </title>
    <script src="#{json_url}"></script>
  </head>
  <body>
  </body>
  <script src="#{script_url}"></script>
</html>
EOS
      html_file.close
      html_path = html_file.path + ".html"
      File.rename(html_file.path, html_path)
      p html_path
    end
  end
end
