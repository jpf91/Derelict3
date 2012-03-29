/*

Boost Software License - Version 1.0 - August 17th, 2003

Permission is hereby granted, free of charge, to any person or organization
obtaining a copy of the software and accompanying documentation covered by
this license (the "Software") to use, reproduce, display, distribute,
execute, and transmit the Software, and to prepare derivative works of the
Software, and to permit third-parties to whom the Software is furnished to
do so, all subject to the following:

The copyright notices in the Software and this entire statement, including
the above license grant, this restriction and the following disclaimer,
must be included in all copies of the Software, in whole or in part, and
all derivative works of the Software, unless such copies or derivative
works are solely in the form of machine-executable object code generated by
a source language processor.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

*/
module derelict.opengles.egl;

import derelict.util.system;

static if(true) //Derelict_Use_EGL
{
    private
    {
        import std.string;
    
        import derelict.util.loader;
        import derelict.util.xtypes;
        import derelict.opengl3.types;
        import derelict.util.system;
    }
    
    //egplatform.h
    version(Windows)
    {
        import derelict.util.wintypes;
    
        alias HDC     EGLNativeDisplayType;
        alias HBITMAP EGLNativePixmapType;
        alias HWND    EGLNativeWindowType;
    }
    else version(Symbian)
    {
        alias int   EGLNativeDisplayType;
        alias void* EGLNativeWindowType;
        alias void* EGLNativePixmapType;
    }
    else version(Android)
    {
        //import android.native_window;

        struct egl_native_pixmap_t;

        //alias ANativeWindow*           EGLNativeWindowType;
        //alias egl_native_pixmap_t*     EGLNativePixmapType;
        alias void*           EGLNativeWindowType;
        alias void*           EGLNativePixmapType;
        alias void*           EGLNativeDisplayType;
    }
    else version(linux)
    {
        /+
        import X11.Xlib;
        import X11.Xutil;
        
        alias Display* EGLNativeDisplayType;
        alias Pixmap   EGLNativePixmapType;
        alias Window   EGLNativeWindowType;
        +/
    
        alias void* EGLNativeDisplayType;
        alias uint  EGLNativePixmapType;
        alias uint  EGLNativeWindowType;
    }
    else
    {
        static assert(false, "Platform not recognized");
    }
    
    /* EGL 1.2 types, renamed for consistency in EGL 1.3 */
    alias EGLNativeDisplayType NativeDisplayType;
    alias EGLNativePixmapType  NativePixmapType;
    alias EGLNativeWindowType  NativeWindowType;
    
    alias int EGLint;
    
    //egl.h version 1.4
    
    alias uint EGLBoolean;
    alias uint EGLenum;
    alias void* EGLConfig;
    alias void* EGLContext;
    alias void* EGLDisplay;
    alias void* EGLSurface;
    alias void* EGLClientBuffer;
    
    enum EGL_VERSION_1_0 = 1;
    enum EGL_VERSION_1_1 = 1;
    enum EGL_VERSION_1_2 = 1;
    enum EGL_VERSION_1_3 = 1;
    enum EGL_VERSION_1_4 = 1;
    
    enum EGL_FALSE = 0;
    enum EGL_TRUE = 1;
    
    enum EGL_DEFAULT_DISPLAY = cast(EGLNativeDisplayType)0;
    enum EGL_NO_CONTEXT      = cast(EGLContext)0;
    enum EGL_NO_DISPLAY      = cast(EGLDisplay)0;
    enum EGL_NO_SURFACE      = cast(EGLSurface)0;
    
    enum EGL_DONT_CARE       = cast(EGLint)-1;
    
    enum EGL_SUCCESS             = 0x3000;
    enum EGL_NOT_INITIALIZED     = 0x3001;
    enum EGL_BAD_ACCESS          = 0x3002;
    enum EGL_BAD_ALLOC           = 0x3003;
    enum EGL_BAD_ATTRIBUTE       = 0x3004;
    enum EGL_BAD_CONFIG          = 0x3005;
    enum EGL_BAD_CONTEXT         = 0x3006;
    enum EGL_BAD_CURRENT_SURFACE = 0x3007;
    enum EGL_BAD_DISPLAY         = 0x3008;
    enum EGL_BAD_MATCH           = 0x3009;
    enum EGL_BAD_NATIVE_PIXMAP   = 0x300A;
    enum EGL_BAD_NATIVE_WINDOW   = 0x300B;
    enum EGL_BAD_PARAMETER       = 0x300C;
    enum EGL_BAD_SURFACE         = 0x300D;
    enum EGL_CONTEXT_LOST        = 0x300E;
    
    enum EGL_BUFFER_SIZE = 0x3020;
    enum EGL_ALPHA_SIZE = 0x3021;
    enum EGL_BLUE_SIZE = 0x3022;
    enum EGL_GREEN_SIZE = 0x3023;
    enum EGL_RED_SIZE = 0x3024;
    enum EGL_DEPTH_SIZE = 0x3025;
    enum EGL_STENCIL_SIZE = 0x3026;
    enum EGL_CONFIG_CAVEAT = 0x3027;
    enum EGL_CONFIG_ID = 0x3028;
    enum EGL_LEVEL = 0x3029;
    enum EGL_MAX_PBUFFER_HEIGHT = 0x302A;
    enum EGL_MAX_PBUFFER_PIXELS = 0x302B;
    enum EGL_MAX_PBUFFER_WIDTH = 0x302C;
    enum EGL_NATIVE_RENDERABLE = 0x302D;
    enum EGL_NATIVE_VISUAL_ID = 0x302E;
    enum EGL_NATIVE_VISUAL_TYPE = 0x302F;
    enum EGL_SAMPLES = 0x3031;
    enum EGL_SAMPLE_BUFFERS = 0x3032;
    enum EGL_SURFACE_TYPE = 0x3033;
    enum EGL_TRANSPARENT_TYPE = 0x3034;
    enum EGL_TRANSPARENT_BLUE_VALUE = 0x3035;
    enum EGL_TRANSPARENT_GREEN_VALUE = 0x3036;
    enum EGL_TRANSPARENT_RED_VALUE = 0x3037;
    enum EGL_NONE = 0x3038; /* Attrib list terminator */
    enum EGL_BIND_TO_TEXTURE_RGB = 0x3039;
    enum EGL_BIND_TO_TEXTURE_RGBA = 0x303A;
    enum EGL_MIN_SWAP_INTERVAL = 0x303B;
    enum EGL_MAX_SWAP_INTERVAL = 0x303C;
    enum EGL_LUMINANCE_SIZE = 0x303D;
    enum EGL_ALPHA_MASK_SIZE = 0x303E;
    enum EGL_COLOR_BUFFER_TYPE = 0x303F;
    enum EGL_RENDERABLE_TYPE = 0x3040;
    enum EGL_MATCH_NATIVE_PIXMAP = 0x3041; /* Pseudo-attribute (not queryable) */
    enum EGL_CONFORMANT = 0x3042;
    
    enum EGL_SLOW_CONFIG = 0x3050;
    enum EGL_NON_CONFORMANT_CONFIG = 0x3051;
    enum EGL_TRANSPARENT_RGB = 0x3052;
    enum EGL_RGB_BUFFER = 0x308E;
    enum EGL_LUMINANCE_BUFFER = 0x308F;
    
    enum EGL_NO_TEXTURE = 0x305C;
    enum EGL_TEXTURE_RGB = 0x305D;
    enum EGL_TEXTURE_RGBA = 0x305E;
    enum EGL_TEXTURE_2D = 0x305F;
    
    enum EGL_PBUFFER_BIT = 0x0001;
    enum EGL_PIXMAP_BIT = 0x0002;
    enum EGL_WINDOW_BIT = 0x0004;
    enum EGL_VG_COLORSPACE_LINEAR_BIT = 0x0020;
    enum EGL_VG_ALPHA_FORMAT_PRE_BIT = 0x0040;
    enum EGL_MULTISAMPLE_RESOLVE_BOX_BIT = 0x0200;
    enum EGL_SWAP_BEHAVIOR_PRESERVED_BIT = 0x0400;
    
    enum EGL_OPENGL_ES_BIT = 0x0001;
    enum EGL_OPENVG_BIT = 0x0002;
    enum EGL_OPENGL_ES2_BIT = 0x0004;
    enum EGL_OPENGL_BIT = 0x0008;
    
    enum EGL_VENDOR = 0x3053;
    enum EGL_VERSION = 0x3054;
    enum EGL_EXTENSIONS = 0x3055;
    enum EGL_CLIENT_APIS = 0x308D;
    
    enum EGL_HEIGHT = 0x3056;
    enum EGL_WIDTH = 0x3057;
    enum EGL_LARGEST_PBUFFER = 0x3058;
    enum EGL_TEXTURE_FORMAT = 0x3080;
    enum EGL_TEXTURE_TARGET = 0x3081;
    enum EGL_MIPMAP_TEXTURE = 0x3082;
    enum EGL_MIPMAP_LEVEL = 0x3083;
    enum EGL_RENDER_BUFFER = 0x3086;
    enum EGL_VG_COLORSPACE = 0x3087;
    enum EGL_VG_ALPHA_FORMAT = 0x3088;
    enum EGL_HORIZONTAL_RESOLUTION = 0x3090;
    enum EGL_VERTICAL_RESOLUTION = 0x3091;
    enum EGL_PIXEL_ASPECT_RATIO = 0x3092;
    enum EGL_SWAP_BEHAVIOR = 0x3093;
    enum EGL_MULTISAMPLE_RESOLVE = 0x3099;
    
    enum EGL_BACK_BUFFER = 0x3084;
    enum EGL_SINGLE_BUFFER = 0x3085;
    
    enum EGL_VG_COLORSPACE_sRGB = 0x3089;
    enum EGL_VG_COLORSPACE_LINEAR = 0x308A;
    
    enum EGL_VG_ALPHA_FORMAT_NONPRE = 0x308B;
    enum EGL_VG_ALPHA_FORMAT_PRE = 0x308C;
    
    enum EGL_DISPLAY_SCALING = 10000;
    
    enum EGL_UNKNOWN = cast(EGLint)-1;
    
    enum EGL_BUFFER_PRESERVED = 0x3094;
    enum EGL_BUFFER_DESTROYED = 0x3095;
    
    enum EGL_OPENVG_IMAGE = 0x3096;
    
    enum EGL_CONTEXT_CLIENT_TYPE = 0x3097;
    
    enum EGL_CONTEXT_CLIENT_VERSION = 0x3098;
    
    enum EGL_MULTISAMPLE_RESOLVE_DEFAULT = 0x309A;
    enum EGL_MULTISAMPLE_RESOLVE_BOX = 0x309B;
    
    enum EGL_OPENGL_ES_API = 0x30A0;
    enum EGL_OPENVG_API = 0x30A1;
    enum EGL_OPENGL_API = 0x30A2;
    
    enum EGL_DRAW = 0x3059;
    enum EGL_READ = 0x305A;
    
    enum EGL_CORE_NATIVE_ENGINE = 0x305B;
    
    enum EGL_COLORSPACE = EGL_VG_COLORSPACE;
    enum EGL_ALPHA_FORMAT = EGL_VG_ALPHA_FORMAT;
    enum EGL_COLORSPACE_sRGB = EGL_VG_COLORSPACE_sRGB;
    enum EGL_COLORSPACE_LINEAR = EGL_VG_COLORSPACE_LINEAR;
    enum EGL_ALPHA_FORMAT_NONPRE = EGL_VG_ALPHA_FORMAT_NONPRE;
    enum EGL_ALPHA_FORMAT_PRE = EGL_VG_ALPHA_FORMAT_PRE;
    
    extern(C)
    {
        alias nothrow EGLint function() da_eglGetError;
    
        alias nothrow EGLDisplay function(EGLNativeDisplayType) da_eglGetDisplay;
        alias nothrow EGLBoolean function(EGLDisplay, EGLint*, EGLint*) da_eglInitialize;
        alias nothrow EGLBoolean function(EGLDisplay) da_eglTerminate;
    
        alias nothrow const(char)* function(EGLDisplay, EGLint) da_eglQueryString;
    
        alias nothrow EGLBoolean function(EGLDisplay, EGLConfig*,
              EGLint, EGLint*) da_eglGetConfigs;
        alias nothrow EGLBoolean function(EGLDisplay, const(EGLint)*,
                EGLConfig*, EGLint,EGLint*) da_eglChooseConfig;
        alias nothrow EGLBoolean function(EGLDisplay, EGLConfig, EGLint, EGLint*) da_eglGetConfigAttrib;
    
        alias nothrow EGLSurface function(EGLDisplay, EGLConfig, EGLNativeWindowType,
                   const(EGLint)*) da_eglCreateWindowSurface;
        alias nothrow EGLSurface function(EGLDisplay, EGLConfig,
                    const(EGLint)*) da_eglCreatePbufferSurface;
        alias nothrow EGLSurface function(EGLDisplay, EGLConfig, EGLNativePixmapType,
                   const(EGLint)*) da_eglCreatePixmapSurface;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface) da_eglDestroySurface;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLint, EGLint*) da_eglQuerySurface;
    
        alias nothrow EGLBoolean function(EGLenum) da_eglBindAPI;
        alias nothrow EGLenum function() da_eglQueryAPI;
    
        alias nothrow EGLBoolean function() da_eglWaitClient;
    
        alias nothrow EGLBoolean function() da_eglReleaseThread;
    
        alias nothrow EGLSurface function(
           EGLDisplay, EGLenum, EGLClientBuffer,
           EGLConfig, const(EGLint)*) da_eglCreatePbufferFromClientBuffer;
    
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLint, EGLint) da_eglSurfaceAttrib;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLint) da_eglBindTexImage;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLint) da_eglReleaseTexImage;
    
    
        alias nothrow EGLBoolean function(EGLDisplay, EGLint) da_eglSwapInterval;
    
    
        alias nothrow EGLContext function(EGLDisplay, EGLConfig, EGLContext,
                 const(EGLint)*) da_eglCreateContext;
        alias nothrow EGLBoolean function(EGLDisplay, EGLContext) da_eglDestroyContext;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLSurface, EGLContext) da_eglMakeCurrent;
    
        alias nothrow EGLContext function() da_eglGetCurrentContext;
        alias nothrow EGLSurface function(EGLint) da_eglGetCurrentSurface;
        alias nothrow EGLDisplay function() da_eglGetCurrentDisplay;
        alias nothrow EGLBoolean function(EGLDisplay, EGLContext,
                EGLint, EGLint*) da_eglQueryContext;
    
        alias nothrow EGLBoolean function() da_eglWaitGL;
        alias nothrow EGLBoolean function(EGLint) da_eglWaitNative;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface) da_eglSwapBuffers;
        alias nothrow EGLBoolean function(EGLDisplay, EGLSurface, EGLNativePixmapType) da_eglCopyBuffers;
    
        /* This is a generic function pointer type, whose name indicates it must
        * be cast to the proper type *and calling convention* before use.
        */
        alias void function() __eglMustCastToProperFunctionPointerType;
    
        /* Now, define eglGetProcAddress using the generic function ptr. type */
        alias __eglMustCastToProperFunctionPointerType function(const(char)*)
               da_eglGetProcAddress;
    }
    
    __gshared
    {
        da_eglGetError eglGetError;
    
        da_eglGetDisplay eglGetDisplay;
        da_eglInitialize eglInitialize;
        da_eglTerminate eglTerminate;
        
        da_eglQueryString eglQueryString;
        da_eglGetConfigs eglGetConfigs;
        da_eglChooseConfig eglChooseConfig;
        da_eglGetConfigAttrib eglGetConfigAttrib;
        da_eglCreateWindowSurface eglCreateWindowSurface;
        da_eglCreatePbufferSurface eglCreatePbufferSurface;
        da_eglCreatePixmapSurface eglCreatePixmapSurface;
        da_eglDestroySurface eglDestroySurface;
        da_eglQuerySurface eglQuerySurface;
        da_eglBindAPI eglBindAPI;
        da_eglQueryAPI eglQueryAPI;
        da_eglWaitClient eglWaitClient;
        da_eglReleaseThread eglReleaseThread;
        da_eglCreatePbufferFromClientBuffer eglCreatePbufferFromClientBuffer;
        da_eglSurfaceAttrib eglSurfaceAttrib;
        da_eglBindTexImage eglBindTexImage;
        da_eglReleaseTexImage eglReleaseTexImage;
        da_eglSwapInterval eglSwapInterval;
        da_eglCreateContext eglCreateContext;
        da_eglDestroyContext eglDestroyContext;
        da_eglMakeCurrent eglMakeCurrent;
        
        da_eglGetCurrentContext eglGetCurrentContext;
        da_eglGetCurrentSurface eglGetCurrentSurface;
        da_eglGetCurrentDisplay eglGetCurrentDisplay;
        da_eglQueryContext eglQueryContext;
        
        da_eglWaitGL eglWaitGL;
        da_eglWaitNative eglWaitNative;
        da_eglSwapBuffers eglSwapBuffers;
        da_eglCopyBuffers eglCopyBuffers;
    
        da_eglGetProcAddress eglGetProcAddress;
    }
    
    package
    {
        void loadPlatformGL(void delegate(void**, string, bool doThrow = true) bindFunc)
        {
            DerelictEGL.load(); //EGL could also be used to create OpenGL contexts
        }
    
        void* loadGLFunc(string symName)
        {
            return eglGetProcAddress(symName.toStringz());
        }
    
        bool hasValidContext()
        {
            if(eglGetCurrentContext && eglGetCurrentContext())
                return true;
            return false;
        }
    }
}

/*
 * Derelict Loader Code
 */

private
{
    import std.conv;
    import std.string;

    import derelict.util.loader;
    import derelict.util.exception;
    import derelict.util.system;
    import derelict.opengles.types;
    import derelict.opengles.internal;

    static if(Derelict_OS_Posix)
    {
        enum libNames = "libEGL.so";
    }
    else
        static assert(0, "Need to implement OpenGLES libNames for this operating system.");
}

class DerelictEGLLoader : SharedLibLoader
{
    protected
    {
        override void loadSymbols()
        {
            bindFunc(cast(void**)&eglGetError, "eglGetError");

            bindFunc(cast(void**)&eglGetDisplay, "eglGetDisplay");
            bindFunc(cast(void**)&eglInitialize, "eglInitialize");
            bindFunc(cast(void**)&eglTerminate, "eglTerminate");
    
            bindFunc(cast(void**)&eglQueryString, "eglQueryString");
            bindFunc(cast(void**)&eglGetConfigs, "eglGetConfigs");
            bindFunc(cast(void**)&eglChooseConfig, "eglChooseConfig");
            bindFunc(cast(void**)&eglGetConfigAttrib, "eglGetConfigAttrib");
            bindFunc(cast(void**)&eglCreateWindowSurface, "eglCreateWindowSurface");
            bindFunc(cast(void**)&eglCreatePbufferSurface, "eglCreatePbufferSurface");
            bindFunc(cast(void**)&eglCreatePixmapSurface, "eglCreatePixmapSurface");
            bindFunc(cast(void**)&eglDestroySurface, "eglDestroySurface");
            bindFunc(cast(void**)&eglQuerySurface, "eglQuerySurface");
            bindFunc(cast(void**)&eglBindAPI, "eglBindAPI");
            bindFunc(cast(void**)&eglQueryAPI, "eglQueryAPI");
            bindFunc(cast(void**)&eglWaitClient, "eglWaitClient");
            bindFunc(cast(void**)&eglReleaseThread, "eglReleaseThread");
            bindFunc(cast(void**)&eglCreatePbufferFromClientBuffer, "eglCreatePbufferFromClientBuffer");
            bindFunc(cast(void**)&eglSurfaceAttrib, "eglSurfaceAttrib");
            bindFunc(cast(void**)&eglBindTexImage, "eglBindTexImage");
            bindFunc(cast(void**)&eglReleaseTexImage, "eglReleaseTexImage");
            bindFunc(cast(void**)&eglSwapInterval, "eglSwapInterval");
            bindFunc(cast(void**)&eglCreateContext, "eglCreateContext");
            bindFunc(cast(void**)&eglDestroyContext, "eglDestroyContext");
            bindFunc(cast(void**)&eglMakeCurrent, "eglMakeCurrent");
            
            bindFunc(cast(void**)&eglGetCurrentContext, "eglGetCurrentContext");
            bindFunc(cast(void**)&eglGetCurrentSurface, "eglGetCurrentSurface");
            bindFunc(cast(void**)&eglGetCurrentDisplay, "eglGetCurrentDisplay");
            bindFunc(cast(void**)&eglQueryContext, "eglQueryContext");
    
            bindFunc(cast(void**)&eglWaitGL, "eglWaitGL");
            bindFunc(cast(void**)&eglWaitNative, "eglWaitNative");
            bindFunc(cast(void**)&eglSwapBuffers, "eglSwapBuffers");
            bindFunc(cast(void**)&eglCopyBuffers, "eglCopyBuffers");
    
            bindFunc(cast(void**)&eglGetProcAddress, "eglGetProcAddress");
        }
    }

    private
    {
        this()
        {
            super(libNames);
        }
    }
}

__gshared DerelictEGLLoader DerelictEGL;

shared static this()
{
    DerelictEGL = new DerelictEGLLoader();
}

shared static ~this()
{
    if(SharedLibLoader.isAutoUnloadEnabled())
        DerelictEGL.unload();
}

