require 'sinatra'
require 'commonmarker'
require 'front_matter_parser'

loader = FrontMatterParser::Loader::Yaml.new(whitelist_classes: [Time])

posts = Dir.glob('exported_files/**/*.md').map do |path|
  begin
    parsed = FrontMatterParser::Parser.parse_file(path, loader: loader)
    [
      parsed['number'],
      parsed.front_matter.merge(
        'path' => path,
        'content' => parsed.content
      )
    ]
  rescue
    puts "[warning] parse failure: #{path}"
  end
end.compact.sort.to_h

get '/' do
  @posts = posts
  erb :index
end

get '/posts/:id' do
  @post = posts[params[:id].to_i]
  return "Not Found" unless @post

  doc = CommonMarker.render_doc(
    @post['content'],
    %i[DEFAULT FOOTNOTES STRIKETHROUGH_DOUBLE_TILDE VALIDATE_UTF8],
    %i[table strikethrough autolink]
  )
  @content_html = doc.to_html(%i[DEFAULT HARDBREAKS UNSAFE SOURCEPOS TABLE_PREFER_STYLE_ATTRIBUTES])

  erb :post
end
