# Druzy::LittleFrame

Some little frame

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'druzy-little_frame'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install druzy-little_frame

Or for ubuntu run:

    $ sudo add-apt-repository ppa:druzy-druzy/rubymita
    $ sudo apt-get update
    $ sudo apt-get install ruby-druzy-little-frame

## Usage

###FileChooser
    
    $require 'druzy/little_frame'
    $chooser = Druzy::LittleFrame::FileChooser.new(args)
    $chooser.display_views

    $if chooser.result == :open
    $  puts chooser.model.files
    $end

args is a dictionary, use :filter_mime_type or :filters_mime_type
chooser.result can be return :cancel

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/druzy/druzy-little_frame.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

