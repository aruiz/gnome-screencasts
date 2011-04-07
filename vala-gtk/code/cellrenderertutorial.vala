using Gtk;
using Gdk;

class MyCellRenderer : Gtk.CellRenderer
{
  /* icon property set by the tree column */
  public Gdk.Pixbuf icon { get; set; }

  /* dumb constructor */
  public MyCellRenderer () {}
  
  /* get_size method, always request a 50x50 area */
  public override void get_size (Gtk.Widget widget,
                                 Gdk.Rectangle? cell_area,
                                 out int x_offset,
                                 out int y_offset,
                                 out int width,
                                 out int height)
  {
    /* The bindings miss the nullable property, so we need to check if the
     * values are null.
     */
    if (&x_offset != null) x_offset = 0;
    if (&y_offset != null) y_offset = 0;
    if (&width != null) width = 50;
    if (&height != null) height = 50;
    return;
  }
  
  /* render method */
  public override void render (Gdk.Window    window,
                               Gtk.Widget    widget,
                               Gdk.Rectangle background_area,
                               Gdk.Rectangle cell_area,
                               Gdk.Rectangle expose_area,
                               Gtk.CellRendererState flags)
  {

    var ctx = Gdk.cairo_create (window);
    if (&expose_area != null)
    {
      Gdk.cairo_rectangle (ctx, expose_area);
      ctx.clip();
    }
    
    Gdk.cairo_rectangle (ctx, background_area);
    if (icon != null)
    {
      Gdk.cairo_set_source_pixbuf (ctx, icon, 0, 0); /* draws a pixbuf on a cairo context */
      ctx.fill();
    }
  
    return;
  }

}

/* CLASS WITH TEST CODE */
class TestCellRenderer
{
  public static Gdk.Pixbuf open_image ()
  {
    Gdk.Pixbuf pixbuf = null;
    try {
      pixbuf = new Gdk.Pixbuf.from_file ("/usr/share/pixmaps/firefox-3.0.png");
    } catch (Error e) {
      error ("%s", e.message);
    }
    return pixbuf;
  }
  
  public static int main (string[] args)
  {    
    Gtk.init (ref args);

    var tv = new Gtk.TreeView();
    var tm = new Gtk.ListStore(2, typeof(Gdk.Pixbuf), typeof(string));    
    tv.set_model(tm);
    
    var renderer = new MyCellRenderer ();
    var col = new Gtk.TreeViewColumn ();
    col.pack_start (renderer, true);
    col.set_title ("1st column");
    col.add_attribute (renderer, "icon", 0);

    Gtk.TreeIter ti;
    tm.append (out ti);
    tv.append_column (col);
    
    var pixbuf = open_image ();
    tm.set (ti, 0, pixbuf, 1, "asd", -1); 
    col.add_attribute (renderer, "icon", 0);

    var win = new Gtk.Window(Gtk.WindowType.TOPLEVEL);
    win.add(tv);    
    win.show_all();    
    Gtk.main();
    
    return 0;
  }
}
