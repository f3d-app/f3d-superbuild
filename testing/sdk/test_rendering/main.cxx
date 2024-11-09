#include <f3d/engine.h>
#include <f3d/window.h>

int main()
{
  f3d::engine eng = f3d::engine::create(true);
  f3d::window& win = eng.getWindow();
  win.render();
}
