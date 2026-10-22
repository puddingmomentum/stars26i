#include "keyboard.h"
#include "title.h"
#include <gtk/gtk.h>

void update_star_logic_with_primes(uint32_t);

int main(int argc, char *argv[]) {
  gtk_init(&argc, &argv);

  // Mimic GETTICKCOUNT and the Print Table math
  // Patterns should match original logic

  uint32_t seed = (uint32_t)g_get_monotonic_time() / 1000;
  update_star_logic_with_primes(seed);

  GtkWidget *window;
  create_main_window_800x600(window);

  gtk_widget_show_all(window);
  gtk_main();

  return 0;
}

void update_star_logic_with_primes(uint32_t seed) {}
