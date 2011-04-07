using Gtk;

public static void on_button_clicked (Gtk.Button button)
{
  stdout.printf("Hi there!\n");
}

public static int main (string[] args)
{
  Gtk.init (ref args);
  
  var window = new Gtk.Window(Gtk.WindowType.TOPLEVEL);
  var button = new Gtk.Button.with_label ("Hello World!");
  
  window.add (button);
  window.show_all ();
  
  window.destroy += Gtk.main_quit;
  button.clicked += on_button_clicked;
  
  Gtk.main ();
  
  return 0;
}
