require 'druzy/mvc'
require 'gtk3'

module Druzy
  module LittleFrame
    
    class FileChooser < Druzy::MVC::Controller
      def initialize(args)
        if (args[:model]==nil)
          initialize(:model => FileChooserModel.new(args))
        else
          super(args[:model])
          add_view(FileChooserView.new(self))
        end
      end
      
      def notify_action(view,action,args={})
        if action == :destroy
          view.close
          @model.result = :cancel
        elsif action == :open_clicked
          view.close
          @model.files = args[:files]
          @model.result = :open
        end    
      end
      
      def result
        if @model.result == nil
          @model.stopped_thread=Thread.current
          Thread.stop
        end
       
        return @model.result
      end
    
    end
    
    
    class FileChooserModel < Druzy::MVC::Model
      attr_accessor :files, :result, :stopped_thread, :filters_mime_type
      
      def initialize(args)
        if args[:filter_mime_type] != nil
          initialize(:filters_mime_type => [args[:filter_mime_type]])
         
        else
          super()
          @files = nil
          @result = nil
          @stopped_thread = nil
          @filters_mime_type=args[:filters_mime_type]
          
        end
      end
      
      def result=(result)
          @result = result
          if @stopped_thread != nil
            @stopped_thread.wakeup
          end
      end
      
    end

    class FileChooserView < Druzy::MVC::View
      def initialize(controller)
        super(controller)
        Gtk.init
        @window =Gtk::Window.new
        @window.signal_connect('destroy') do
          Thread.new do
            @controller.notify_action(self,:destroy)
          end
        end
        
        @open = Gtk::Button.new(:label => "Ouvrir")
        @open.signal_connect("clicked") do
          Thread.new do
            @controller.notify_action(self,:open_clicked, :files => @chooser.filenames)
          end
        end
        
        @cancel = Gtk::Button.new(:label => "Annuler")  
        @cancel.signal_connect("clicked") do
          Thread.new do
            @controller.notify_action(self,:destroy)
          end
        end
        
        @chooser = Gtk::FileChooserWidget.new(Gtk::FileChooser::Action::OPEN)
        @chooser.select_multiple = true
        for filter in @controller.model.filters_mime_type
          f=Gtk::FileFilter.new
          f.add_mime_type(filter)
          f.name = filter
          @chooser.add_filter(f)
        end
        
        @main_vbox = Gtk::Box.new(:vertical,0)
        
        @button_hbox = Gtk::Box.new(:horizontal,0)
        
        #ajout des composants 
        @window.add(@main_vbox)
        
        @main_vbox.pack_start(@chooser)
        @main_vbox.pack_start(@button_hbox, :expand => false, :padding => 20)
        
        @button_hbox.pack_end(@open, :expand => false, :padding => 20)
        @button_hbox.pack_end(@cancel, :expand => false)
        
        
        Thread.new do
          Gtk.main
        end
      end
      
      def display
        @window.show_all
      end
      
      def close
        Gtk.main_quit
      end      
    end
    
  end
end

if __FILE__ == $0
  chooser = Druzy::LittleFrame::FileChooser.new(:filters_mime_type => ["video/*","image/*"])
  chooser.display_views
  
  if chooser.result == :open
    puts chooser.model.files
  end
  Thread.list.each {|t| t.join if t!=Thread.main}
  
end