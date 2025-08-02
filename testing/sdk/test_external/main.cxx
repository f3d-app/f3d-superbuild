#include <f3d/engine.h>
#include <f3d/window.h>

#include <EGL/egl.h>

int main()
{
  EGLDisplay eglDpy = eglGetDisplay(EGL_DEFAULT_DISPLAY);

  // initialize
  EGLint major, minor;
  eglInitialize(eglDpy, &major, &minor);

  // configure
  EGLint numConfigs;
  EGLConfig eglCfg;

  constexpr EGLint configAttribs[] = { EGL_SURFACE_TYPE, EGL_PBUFFER_BIT, EGL_BLUE_SIZE, 8,
    EGL_GREEN_SIZE, 8, EGL_RED_SIZE, 8, EGL_DEPTH_SIZE, 8, EGL_RENDERABLE_TYPE, EGL_OPENGL_BIT,
    EGL_NONE };
  eglChooseConfig(eglDpy, configAttribs, &eglCfg, 1, &numConfigs);

  // create a surface
  constexpr int size[] = { 300, 300 };
  constexpr EGLint pbufferAttribs[] = { EGL_WIDTH, size[0], EGL_HEIGHT, size[1], EGL_NONE };
  EGLSurface eglSurf = eglCreatePbufferSurface(eglDpy, eglCfg, pbufferAttribs);

  // bind the API
  eglBindAPI(EGL_OPENGL_API);

  // create a context
  EGLContext eglCtx = eglCreateContext(eglDpy, eglCfg, EGL_NO_CONTEXT, nullptr);
  eglMakeCurrent(eglDpy, eglSurf, eglSurf, eglCtx);

  f3d::engine eng = f3d::engine::createExternalEGL();
  f3d::window& win = eng.getWindow();

  // terminate EGL when finished
  eglTerminate(eglDpy);
  return 0;
}
