#include "title.h"

void create_main_window_800x600(GtkWidget* window) {
  window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
  gtk_window_set_default_size(GTK_WINDOW(window), 800, 600);

  GtkWidget *overlay = gtk_overlay_new();
  gtk_container_add(GTK_CONTAINER(window), overlay);

  GtkWidget *fixed = gtk_fixed_new();
  gtk_overlay_add_overlay(GTK_OVERLAY(overlay), fixed);

  GtkWidget *title = gtk_image_new_from_file("resources/BITMAP/BITMAP_449.png");
  gtk_fixed_put(GTK_FIXED(fixed), title, 0, 0);

  GtkWidget *btn1 = gtk_button_new_with_label("Start");
  gtk_fixed_put(GTK_FIXED(fixed), btn1, 150, 300);
}
