#include <f3d/engine.h>
#include <f3d/window.h>

int main()
{
  f3d::engine eng = f3d::engine::createExternal(nullptr);
  f3d::window& win = eng.getWindow();
}
