using Gtk;

class TestApp : Gtk.Window
{
  private Gtk.Button button;
  public TestApp ()
  {
    type = Gtk.WindowType.TOPLEVEL;

    button = new Gtk.Button.with_label ("Say hi");
    add(button);
    
    destroy += Gtk.main_quit;
    button.clicked += on_button_clicked;
    
  }

  [Callback]
  public void on_button_clicked (Gtk.Button button)
  {
    //set_size_request (800, 600);
    stdout.printf ("Hello World!\n");
  }
  
  public static void main (string[] args)
  {
    Gtk.init (ref args);
    var app = new TestApp();
    app.show_all ();
    Gtk.main ();
  }  
}
