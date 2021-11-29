using Bg;
namespace Bg{

	public struct Color{
		uchar r;
		uchar g;
		uchar b;
		uchar a;
	}

	public Color rgba(int r = 255,int g = 255, int b = 255, int a = 255){
		Color c = {};
		c.r = (uchar)r;
		c.g = (uchar)g;
		c.b = (uchar)b;
		c.a = (uchar)a;
		return c;
	}

	public struct Rect{		
	    int x;
		int y;
		int w;
		int h;
	}
}
