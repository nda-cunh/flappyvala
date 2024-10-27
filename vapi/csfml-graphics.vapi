/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2024 SFML VAPI Authors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Authors:
 *  Hydral (Nathan) <nathan.dacunha.nd@gmail.com>
 */

[CCode (cheader_filename = "SFML/Graphics.h,SFML/System.h")]
namespace sf {

	[CCode (cname = "sfColor", default_value ="{0,0,0,255}", cheader_filename = "SFML/Graphics.h")]
	[SimpleType]
	public struct Color
	{
		[CCode (cname = "sfColor_fromRGBA")]
		public Color (uint8 red = 255, uint8 green = 255, uint8 blue = 255, uint8 alpha = 255);
		[CCode (cname = "sfColor_fromRGB")]
		public Color.from_RGB (uint8 red, uint8 green, uint8 blue);
		[CCode (cname = "sfColor_fromRGBA")]
		public Color.from_RGBA (uint8 red, uint8 green, uint8 blue, uint8 alpha);
		[CCode (cname = "sfColor_fromInteger")]
		public Color.fromInteger (uint32 color);

		[CCode (cname = "sfColor_toInteger")]
		public uint32 toInteger();

		[CCode (cname = "sfColor_add")]
		public Color add (Color right);

		[CCode (cname = "sfColor_subtract")]
		public Color subtract (Color right);
		
		[CCode (cname = "sfColor_modulate")]
		public Color modulate (Color right);



		/** White predefined color*/
		[CCode (cname = "sfBlack")]
		public const Color Black;
		/** White predefined color*/
		[CCode (cname = "sfWhite")]
		public const Color White;
		/** Red predefined color*/
		[CCode (cname = "sfRed")]
		public const Color Red;
		/** Green predefined color*/
		[CCode (cname = "sfGreen")]
		public const Color Green;
		/** Blue predefined color*/
		[CCode (cname = "sfBlue")]
		public const Color Blue;
		/** Yellow predefined color*/
		[CCode (cname = "sfYellow")]
		public const Color Yellow;
		/** Magenta predefined color*/
		[CCode (cname = "sfMagenta")]
		public const Color Magenta;
		/** Cyan predefined color*/
		[CCode (cname = "sfCyan")]
		public const Color Cyan;
		/** Transparent (black) predefined color.*/
		[CCode (cname = "sfTransparent")]
		public const Color Transparent;

		public uint8 red {get {return r;} set {r = value;}}
		public uint8 blue {get {return b;} set{b = value;}}
		public uint8 green {get {return b;} set{g = value;}}
		public uint8 alpha {get {return b;} set{a = value;}}
		uint8 r;
		uint8 g;
		uint8 b;
		uint8 a;
	}


	[CCode (cname = "sfFloatRect")]
	[SimpleType]
	public struct FloatRect
	{
		public float left;
		public float top;
		public float width;
		public float height;

		[CCode (cname = "sfFloatRect_contains")]
		static bool static_contains (FloatRect *rect, float x, float y);
		[CCode (cname = "sfFloatRect_intersects")]
		static bool static_intersects (FloatRect *rect1, FloatRect *rect2, FloatRect? intersection = null);

		[CCode (cname = "vala_sfFloatRect_contains")]
		public bool contains(FloatRect rect) {
			return FloatRect.static_intersects(&this, &rect, null);
		}

		public inline bool contains_position (float x, float y) {
			return FloatRect.static_contains(&this, x, y);
		}

		public inline bool intersects (FloatRect rect, FloatRect? intersection = null) {
			return FloatRect.static_intersects(&this, &rect, intersection);
		}
	}

	[CCode (cname = "sfIntRect")]
	[SimpleType]
	public struct IntRect
	{
		public int left;
		public int top;
		public int width;
		public int height;
		[CCode (cname = "sfIntRect_contains")]
		static bool static_contains(IntRect *rect, int x, int y);
		[CCode (cname = "sfIntRect_intersects")]
		static bool static_intersects(IntRect* rect1, IntRect* rect2, IntRect? intersection = null);

		[CCode (cname = "vala_sfIntRect_contains")]
		public bool contains(IntRect rect) {
			return IntRect.static_intersects(&this, &rect, null);
		}

		public inline bool contains_position (int x, int y) {
			return IntRect.static_contains(&this, x, y);
		}

		public inline bool intersects (IntRect rect, IntRect? intersection = null) {
			return IntRect.static_intersects(&this, &rect, intersection);
		}
	}

	[CCode (cname = "sfPrimitiveType", cprefix = "sf")]
	public enum PrimitiveType
	{
		/** List of individual point*/
		Points,
		/** List of individual line*/
		Lines,
		/** List of connected lines, a point uses the previous point to form a lin*/
		LineStrip,
		/** List of individual triangle*/
		Triangles,
		/** List of connected triangles, a point uses the two previous points to form a triangl*/
		TriangleStrip,
		/** List of connected triangles, a point uses the common center and the previous point to form a triangl*/
		TriangleFan,
		/** List of individual quad*/
		Quads
	}

	[CCode (cname = "sfTextureCoordinateType", cprefix = "sfTexture")]
	public enum TextureCoordinateType
	{
		/** sfTexture coordinates in range [0 .. 1]*/
		Normalized,
		/** sfTexture coordinates in range [0 .. size]*/
		Pixels
	}

	[Compact]
	[Immutable]
	[CCode (cname="sfTexture", copy_function="sfTexture_copy", free_function = "sfTexture_destroy", cprefix="sfTexture_")]
	public class Texture{
		[CCode (cname = "sfTexture_copy")]
		Texture copy();
		[CCode (cname = "sfTexture_create")]
		public Texture(uint width, uint height);
		[CCode (cname = "sfTexture_createFromFile")]
		public Texture.fromFile(string filename, IntRect? area = null);
		[CCode (cname = "sfTexture_createSrgbFromFile")]
		public Texture.fromSrgvFromFile(string filename, IntRect? area = null);
		[CCode (cname = "sfTexture_createFromMemory")]
		public Texture.fromMemory(owned void* data, size_t sizeInBytes, IntRect? area = null);
		[CCode (cname = "sfTexture_createSrgbFromMemory")]
		public Texture.fromSrgbFromMemory(void* data, size_t sizeInBytes, IntRect? area = null);
		[CCode (cname = "sfTexture_createFromStream")]
		public Texture.fromStream(uint32? stream = null, IntRect? area = null);
		[CCode (cname = "sfTexture_createSrgbFromStream")]
		public Texture.fromSrgbFromStream(InputStream stream, IntRect area);
		[CCode (cname = "sfTexture_createFromImage")]
		public Texture.fromImage(Image image, IntRect? area = null);
		[CCode (cname = "sfTexture_createSrgbFromImage")]
		public Texture.fromSrgbFromImage(Image image, IntRect? area = null);

		public Vector2u size {
			[CCode (cname = "sfTexture_getSize")]
			get;
		}
		
		public uint width {
			get {
				return this.size.x;
			}
		}

		public uint height {
			get {
				return this.size.y;
			}
		}

		public Vector2u getSize();
		public Image copyToImage();
		public void updateFromPixels(uint8 []pixels, uint width, uint height, uint x, uint y);
		public void updateFromTexture(Texture source, uint x, uint y);
		public void updateFromImage(Image image, uint x, uint y);
		public void updateFromWindow(Window window, uint x, uint y);
		public void updateFromRenderWindow(RenderWindow renderWindow, uint x, uint y);
		public void setSmooth(bool smooth);
		public bool isSmooth();
		public bool isSrgb();
		public bool isRepeated();
		public void setRepeated(bool repeated);
		public bool generateMipmap();
		public void swap(Texture right);
		public uint getNativeHandle();
		public void bind(TextureCoordinateType type);
		[CCode (cname = "sfTexture_getMaximumSize")]
		public static uint getMaximumSize();
	}

	[Compact]
	[CCode (cname = "sfTransformable", copy_function="sfTransformable_copy", free_function = "sfTransformable_destroy", cprefix= "Transformable_", cheader_filename = "SFML/Graphics.h")]
	public class Transformable {
		[CCode (cname = "sfTransformable_create")]
		public Transformable();

		public Transformable copy();

		// Attribut
		public Vector2f position {
			[CCode (cname = "sfTransformable_getPosition")]
			get;
			[CCode (cname = "sfTransformable_setPosition")]
			set;
		}
		public Vector2f origin {
			[CCode (cname = "sfTransformable_getOrigin")]
			get;
			[CCode (cname = "sfTransformable_setOrigin")]
			set;
		}
		public float rotation {
			[CCode (cname = "sfTransformable_getRotation")]
			get;
			[CCode (cname = "sfTransformable_setRotation")]
			set;
		}
		public Vector2f scale {
			[CCode (cname = "sfTransformable_getScale")]
			get;
			[CCode (cname = "sfTransformable_setScale")]
			set;
		}

		public void destroy();
		public void setPosition(Vector2f position);
		public void setRotation(float angle);
		public void setScale(Vector2f scale);
		public void setOrigin(Vector2f origin);
		public Vector2f getPosition();
		public float getRotation();
		public Vector2f getScale();
		public Vector2f getOrigin();
		public void move(Vector2f offset);
		public void rotate(float angle);
		public void scaling(Vector2f factors);
		public Transform getTransform();
		public Transform getInverseTransform();
	}

	[Compact]
	[CCode (cname = "sfCircleShape", copy_function="sfCircleShape_copy", free_function = "sfCircleShape_destroy", cheader_filename = "SFML/Graphics.h")]
	public class CircleShape : Shape {
		[CCode (cname = "sfCircleShape_create")]
		public CircleShape();
		[CCode (cname = "sfCircleShape_copy")]
		public CircleShape copy(CircleShape shape);

		public Vector2f position {
			[CCode (cname = "sfCircleShape_getPosition")]
			get;
			[CCode (cname = "sfCircleShape_setPosition")]
			set;
		}
		public Vector2f origin {
			[CCode (cname = "sfCircleShape_getOrigin")]
			get;
			[CCode (cname = "sfCircleShape_setOrigin")]
			set;
		}
		public float rotation {
			[CCode (cname = "sfCircleShape_getRotation")]
			get;
			[CCode (cname = "sfCircleShape_setRotation")]
			set;
		}
		public Vector2f scale {
			[CCode (cname = "sfCircleShape_getScale")]
			get;
			[CCode (cname = "sfCircleShape_setScale")]
			set;
		}
		public IntRect textureRect {
			[CCode (cname = "sfCircleShape_getTextureRect")]
			get;
			[CCode (cname = "sfCircleShape_setTextureRect")]
			set;
		}

		public Color fillColor {
			[CCode (cname = "sfCircleShape_getFillColor")]
			get;
			[CCode (cname = "sfCircleShape_setFillColor")]
			set;
		}
		public Color outlineColor {
			[CCode (cname = "sfCircleShape_getOutlineColor")]
			get;
			[CCode (cname = "sfCircleShape_setOutlineColor")]
			set;
		}
		public float outlineThickness {
			[CCode (cname = "sfCircleShape_getOutlineThickness")]
			get;
			[CCode (cname = "sfCircleShape_setOutlineThickness")]
			set;
		}
		public float radius {
			[CCode (cname = "sfCircleShape_getRadius")]
			get;
			[CCode (cname = "sfCircleShape_setRadius")]
			set;
		}
		public FloatRect localBounds {
			[CCode (cname = "sfCircleShape_getLocalBounds")]
			get;
			[CCode (cname = "sfCircleShape_setLocalBounds")]
			set;
		}

		[CCode (cname = "sfRenderWindow_drawCircleShape", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);
		[CCode (cname = "sfCircleShape_setPosition")]
		public void setPosition(Vector2f position);
		[CCode (cname = "sfCircleShape_setRotation")]
		public void setRotation(float angle);
		[CCode (cname = "sfCircleShape_setScale")]
		public void setScale(Vector2f scale);
		[CCode (cname = "sfCircleShape_setOrigin")]
		public void setOrigin(Vector2f origin);
		[CCode (cname = "sfCircleShape_getPosition")]
		public Vector2f getPosition();
		[CCode (cname = "sfCircleShape_getRotation")]
		public float getRotation();
		[CCode (cname = "sfCircleShape_getScale")]
		public Vector2f getScale();
		[CCode (cname = "sfCircleShape_getOrigin")]
		public Vector2f getOrigin();
		[CCode (cname = "sfCircleShape_move")]
		public void move(Vector2f offset);
		[CCode (cname = "sfCircleShape_rotate")]
		public void rotate(float angle);
		[CCode (cname = "sfCircleShape_scale")]
		public void scaling(Vector2f factors);
		[CCode (cname = "sfCircleShape_getTransform")]
		public Transform sfCircleShape_getTransform();
		[CCode (cname = "sfCircleShape_getInverseTransform")]
		public Transform sfCircleShape_getInverseTransform();
		[CCode (cname = "sfCircleShape_getTexture")]
		public void setTexture(Texture texture, bool resetRect);
		[CCode (cname = "sfCircleShape_setTextureRect")]
		public void setTextureRect(IntRect rect);
		[CCode (cname = "sfCircleShape_setFillColor")]
		public void setFillColor(Color color);
		[CCode (cname = "sfCircleShape_setOutlineColor")]
		public void setOutlineColor(Color color);
		[CCode (cname = "sfCircleShape_setOutlineThickness")]
		public void setOutlineThickness(float thickness);
		[CCode (cname = "sfCircleShape_getTexture")]
		public unowned Texture getTexture();
		[CCode (cname = "sfCircleShape_getTextureRect")]
		public IntRect getTextureRect();
		[CCode (cname = "sfCircleShape_getFillColor")]
		public Color getFillColor();
		[CCode (cname = "sfCircleShape_getOutlineColor")]
		public Color getOutlineColor();
		[CCode (cname = "sfCircleShape_getOutlineThickness")]
		public float getOutlineThickness();
		[CCode (cname = "sfCircleShape_getPointCount")]
		public size_t getPointCount();
		[CCode (cname = "sfCircleShape_getPoint")]
		public Vector2f getPoint(size_t index);
		[CCode (cname = "sfCircleShape_setRadius")]
		public void setRadius(float radius);
		[CCode (cname = "sfCircleShape_getRadius")]
		public float getRadius();
		[CCode (cname = "sfCircleShape_setPointCount")]
		public void setPointCount(size_t count);
		[CCode (cname = "sfCircleShape_getLocalBounds")]
		public FloatRect getLocalBounds();
		[CCode (cname = "sfCircleShape_getGlobalBounds")]
		public FloatRect getGlobalBounds();
	}

	[Compact]
	[CCode (cname = "sfConvexShape", copy_function="sfConvexShape_copy", free_function = "sfConvexShape_destroy", cprefix = "sfConvexShape_")]
	public class ConvexShape : Shape {
		[CCode (cname = "sfConvexShape_create")]
		public ConvexShape();

		public ConvexShape copy();

		// Attribut
		public Vector2f size{
			[CCode (cname = "sfSConvexShape_getSize")]
			get;
			[CCode (cname = "sfSConvexShape_setSize")]
			set;
		}
		public Vector2f position{
			[CCode (cname = "sfSConvexShape_getPosition")]
			get;
			[CCode (cname = "sfSConvexShape_setPosition")]
			set;
		}
		public float rotation{
			[CCode (cname = "sfSConvexShape_getRotation")]
			get;
			[CCode (cname = "sfSConvexShape_setRotation")]
			set;
		}
		public Vector2f scale{
			[CCode (cname = "sfSConvexShape_getScale")]
			get;
			[CCode (cname = "sfSConvexShape_setScale")]
			set;
		}
		public Vector2f origin{
			[CCode (cname = "sfSConvexShape_getOrigin")]
			get;
			[CCode (cname = "sfSConvexShape_setOrigin")]
			set;
		}
		public IntRect textureRect{
			[CCode (cname = "sfSConvexShape_getTextureRect")]
			get;
			[CCode (cname = "sfSConvexShape_setTextureRect")]
			set;
		}
		public Color color{
			[CCode (cname = "sfSConvexShape_getColor")]
			get;
			[CCode (cname = "sfSConvexShape_setColor")]
			set;
		}
		public FloatRect localBounds{
			[CCode (cname = "sfSConvexShape_getLocalBounds")]
			get;
			[CCode (cname = "sfSConvexShape_setLocalBounds")]
			set;
		}
		public FloatRect globalBounds{
			[CCode (cname = "sfSConvexShape_getGlobalBounds")]
			get;
			[CCode (cname = "sfSConvexShape_setGlobalBounds")]
			set;
		}

		[CCode (cname = "sfRenderWindow_drawConvexShape", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);

		public void setPosition(Vector2f position);
		public void setRotation(float angle);
		public void setScale(Vector2f scale);
		public void setOrigin(Vector2f origin);
		public Vector2f getPosition();
		public float getRotation();
		public Vector2f getScale();
		public Vector2f getOrigin();
		public void move(Vector2f offset);
		public void rotate(float angle);
		public void scaling(Vector2f factors);
		public Transform getTransform();
		public Transform getInverseTransform();
		public void setTexture(Texture texture, bool resetRect);
		public void setTextureRect(IntRect rect);
		public void setFillColor(Color color);
		public void setOutlineColor(Color color);
		public void setOutlineThickness(float thickness);
		public unowned Texture getTexture();
		public IntRect getTextureRect();
		public Color getFillColor();
		public Color getOutlineColor();
		public float getOutlineThickness();
		public size_t getPointCount();
		public Vector2f getPoint(size_t index);
		public void setPointCount(size_t count);
		public void setPoint(size_t index, Vector2f point);
		public FloatRect getLocalBounds();
		public FloatRect getGlobalBounds();
	}


	[Compact]
	[CCode (cname = "sfView", copy_function="sfView_copy", free_function = "sfView_destroy", cprefix = "sfView_")]
	public class View {
		[CCode (cname = "sfView_create")]
		public View();
		[CCode (cname = "sfView_createFromRect")]
		public View.fromRect(FloatRect rectangle);
		public View copy();

		public void setCenter(Vector2f center);
		public void setSize(Vector2f size);
		public void setRotation(float angle);
		public void setViewport(FloatRect viewport);
		public void reset(FloatRect rectangle);
		public Vector2f getCenter();
		public Vector2f getSize();
		public float getRotation();
		public FloatRect getViewport();
		public void move(Vector2f offset);
		public void rotate(float angle);
		public void zoom(float factor);
	}

	[Compact]
	[CCode (cname = "sfRenderTexture", free_function = "sfRenderTexture_destroy", cprefix = "sfRenderTexture_")]
	public class RenderTexture {
		[CCode (cname = "sfRenderTexture_create")]
		public RenderTexture(uint width, uint height, bool depthBuffer = true);
		[CCode (cname = "sfRenderTexture_createWithSettings")]
		public RenderTexture.withSettings(uint width, uint height, ContextSettings settings);

		public Vector2u getSize();
		public bool setActive(bool active);
		public void display();
		public void clear(Color color = Color.Black);
		public void setView(View view);
		public unowned View getView();
		public unowned View getDefaultView();
		public IntRect getViewport(View view);
		public Vector2f mapPixelToCoords(Vector2i point, View view);
		public Vector2i mapCoordsToPixel(Vector2f point, View view);
		[CCode (cname = "sfRenderTexture_drawShape")]
		public void draw(Shape object, RenderStates? states = null);
		public void drawVertexBufferRange(VertexBuffer object, size_t firstVertex, size_t vertexCount, RenderStates? states = null);
		public void drawPrimitives(Vertex vertices, size_t vertexCount,PrimitiveType type, RenderStates? states = null);
		public void pushGLStates();
		public void popGLStates();
		public void resetGLStates();
		public unowned Texture getTexture();
		public uint getMaximumAntialiasingLevel();
		public void setSmooth(bool smooth);
		public bool isSmooth();
		public void setRepeated(bool repeated);
		public bool isRepeated();
		public bool generateMipmap();
	}


	/* *****************************     RECTANGLESHAPE     ************************************************/
	[Compact]
	[CCode (free_function = "sfRectangleShape_destroy", copy_function="sfRectangleShape_copy", cheader_filename = "SFML/Graphics.h")]
	public class RectangleShape : Shape {
		[CCode (destroy_function = "sfRectangleShape_destroy", cname = "sfRectangleShape_create")]
		public RectangleShape();
		[CCode (cname = "sfRectangleShape_copy")]
		public RectangleShape* copy();

		// Attribut
		public Vector2f size{
			[CCode (cname = "sfRectangleShape_getSize")]
			get;
			[CCode (cname = "sfRectangleShape_setSize")]
			set;
		}
		public Vector2f position{
			[CCode (cname = "sfRectangleShape_getPosition")]
			get;
			[CCode (cname = "sfRectangleShape_setPosition")]
			set;
		}
		public float rotation{
			[CCode (cname = "sfRectangleShape_getRotation")]
			get;
			[CCode (cname = "sfRectangleShape_setRotation")]
			set;
		}
		public Vector2f scale{
			[CCode (cname = "sfRectangleShape_getScale")]
			get;
			[CCode (cname = "sfRectangleShape_setScale")]
			set;
		}
		public Vector2f origin{
			[CCode (cname = "sfRectangleShape_getOrigin")]
			get;
			[CCode (cname = "sfRectangleShape_setOrigin")]
			set;
		}
		public IntRect textureRect{
			[CCode (cname = "sfRectangleShape_getTextureRect")]
			get;
			[CCode (cname = "sfRectangleShape_setTextureRect")]
			set;
		}
		public Color color{
			[CCode (cname = "sfRectangleShape_getFillColor")]
			get;
			[CCode (cname = "sfRectangleShape_setFillColor")]
			set;
		}
		public FloatRect localBounds{
			[CCode (cname = "sfRectangleShape_getLocalBounds")]
			get;
			[CCode (cname = "sfRectangleShape_setLocalBounds")]
			set;
		}
		public FloatRect globalBounds{
			[CCode (cname = "sfRectangleShape_getGlobalBounds")]
			get;
			[CCode (cname = "sfRectangleShape_setGlobalBounds")]
			set;
		}

		public Color outlineColor{
			[CCode (cname = "sfRectangleShape_getOutlineColor")]
			get;
			[CCode (cname = "sfRectangleShape_setOutlineColor")]
			set;
		}

		public float outlineThickness{
			[CCode (cname = "sfRectangleShape_getOutlineThickness")]
			get;
			[CCode (cname = "sfRectangleShape_setOutlineThickness")]
			set;
		}

		public unowned Texture texture{
			[CCode (cname = "sfRectangleShape_getTexture")]
			get;
			[CCode (cname = "sfRectangleShape_setTexture")]
			set;
		}



		[CCode (cname = "sfRenderWindow_drawRectangleShape", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);

		[CCode (cname = "sfRectangleShape_setPosition")]
		public void setPosition(Vector2f position);
		[CCode (cname = "sfRectangleShape_setRotation")]
		public void setRotation(float angle);
		[CCode (cname = "sfRectangleShape_setScale")]
		public void setScale(Vector2f scale);
		[CCode (cname = "sfRectangleShape_setOrigin")]
		public void setOrigin(Vector2f origin);
		[CCode (cname = "sfRectangleShape_getPosition")]
		public Vector2f getPosition();
		[CCode (cname = "sfRectangleShape_getRotation")]
		public float getRotation();
		[CCode (cname = "sfRectangleShape_getScale")]
		public Vector2f getScale();
		[CCode (cname = "sfRectangleShape_getOrigin")]
		public Vector2f getOrigin();
		[CCode (cname = "sfRectangleShape_move")]
		public void move(Vector2f offset);
		[CCode (cname = "sfRectangleShape_rotate")]
		public void rotate(float angle);
		[CCode (cname = "sfRectangleShape_scale")]
		public void scaling(Vector2f factors);
		[CCode (cname = "sfRectangleShape_getTransform")]
		public Transform getTransform();
		[CCode (cname = "sfRectangleShape_getInverseTransform")]
		public Transform getInverseTransform();
		[CCode (cname = "sfRectangleShape_setTexture")]
		public void setTexture(Texture texture, bool resetRect);
		[CCode (cname = "sfRectangleShape_setTextureRect")]
		public void setTextureRect(IntRect rect);
		[CCode (cname = "sfRectangleShape_setFillColor")]
		public void setFillColor(Color color);
		[CCode (cname = "sfRectangleShape_setOutlineColor")]
		public void setOutlineColor(Color color);
		[CCode (cname = "sfRectangleShape_setOutlineThickness")]
		public void setOutlineThickness(float thickness);
		[CCode (cname = "sfRectangleShape_getTexture")]
		public unowned Texture getTexture();
		[CCode (cname = "sfRectangleShape_getTextureRect")]
		public IntRect getTextureRect();
		[CCode (cname = "sfRectangleShape_getFillColor")]
		public Color getFillColor();
		[CCode (cname = "sfRectangleShape_getOutlineColor")]
		public Color getOutlineColor();
		[CCode (cname = "sfRectangleShape_getOutlineThickness")]
		public float getOutlineThickness();
		[CCode (cname = "sfRectangleShape_getPointCount")]
		public size_t getPointCount();
		[CCode (cname = "sfRectangleShape_getPoint")]
		public Vector2f setPoint(size_t index);
		[CCode (cname = "sfRectangleShape_setSize")]
		public void setSize(Vector2f size);
		[CCode (cname = "sfRectangleShape_getSize")]
		public Vector2f getSize();
		[CCode (cname = "sfRectangleShape_getLocalBounds")]
		public FloatRect getLocalBounds();
		[CCode (cname = "sfRectangleShape_getGlobalBounds")]
		public FloatRect getGlobalBounds();
	}


	[Flags]
	[CCode (cname = "sfTextStyle", cprefix = "sfText")]
	public enum TextStyle{
		/** Regular characters, no style */
		Regular,
		/** Bold character*/
		Bold,
		/** Italic character*/
		Italic,
		/** Underlined character*/
		Underlined,
		/** Strike through character*/
		StrikeThrough,
	}


	[CCode (cname = "sfFontInfo")]
	[SimpleType]
	public struct FontInfo
	{
		unowned string family;
	}

	[CCode (cname = "sfGlyph")]
	public struct Glyph
	{
		/** Offset to move horizontically to the next character*/
		float		advance;
		/** Bounding rectangle of the glyph, in coordinates relative to the baseline*/
		FloatRect	bounds;
		/** Texture coordinates of the glyph inside the font's image*/
		IntRect		textureRect;
	}

	[Compact]
	[CCode (cname = "sfFont", copy_function="sfFont_copy", free_function = "sfFont_destroy", cprefix = "sfFont_")]
	public class Font {

		[CCode (cname = "sfFont_createFromFile")]
		public Font(string filename);
		[CCode (cname = "sfFont_createFromFile")]
		public Font.fromFile(string filename);
		[CCode (cname = "sfFont_createFromMemory")]
		public Font.fromMemory(void *data, size_t sizeInBytes);
		[CCode (cname = "sfFont_createFromStream")]
		public Font.fromStream(sf.InputStream stream);
		public Font copy();
		public Glyph getGlyph(uint32 codePoint, uint characterSize, bool bold, float outlineThickness);
		public float getKerning(uint32 first, uint32 second, uint characterSize);
		public float getLineSpacing(uint characterSize);
		public float getUnderlinePosition(uint characterSize);
		public float getUnderlineThickness(uint characterSize);
		public Texture getTexture(uint characterSize);
		public FontInfo getInfo();
	}

	[Compact]
	[Immutable]
	[CCode (cname = "sfText", copy_function="sfText_copy", free_function = "sfText_destroy", cprefix = "sfText_")]
	public class Text : Shape {

		[CCode (cname="sfText_create")]
		public Text();

		public Text copy();

		public Vector2f position{
			[CCode (cname = "sfText_getPosition")]
			get;
			[CCode (cname = "sfText_setPosition")]
			set;
		}
		public float rotation{
			[CCode (cname = "sfText_getRotation")]
			get;
			[CCode (cname = "sfText_setRotation")]
			set;
		}
		public Vector2f scale{
			[CCode (cname = "sfText_getScale")]
			get;
			[CCode (cname = "sfText_setScale")]
			set;
		}
		public Vector2f origin{
			[CCode (cname = "sfText_getOrigin")]
			get;
			[CCode (cname = "sfText_setOrigin")]
			set;
		}
		public unowned string @string{
			[CCode (cname = "sfText_getString")]
			get;
			[CCode (cname = "sfText_setString")]
			set;
		}
		public unowned Font font{
			[CCode (cname = "sfText_getFont")]
			get;
			[CCode (cname = "sfText_setFont")]
			set;
		}
		public uint size {
			[CCode (cname = "sfText_getCharacterSize")]
			get;
			[CCode (cname = "sfText_setCharacterSize")]
			set;
		}
		public float linespacing{
			[CCode (cname = "sfText_getLineSpacing")]
			get;
			[CCode (cname = "sfText_setLineSpacing")]
			set;
		}
		public float letterspacing{
			[CCode (cname = "sfText_getLetterSpacing")]
			get;
			[CCode (cname = "sfText_setLetterSpacing")]
			set;
		}
		public TextStyle style{
			[CCode (cname = "sfText_getStyle")]
			get;
			[CCode (cname = "sfText_setStyle")]
			set;
		}
		public Color color{
			[CCode (cname = "sfText_getColor")]
			get;
			[CCode (cname = "sfText_setColor")]
			set;
		}
		public Color fillcolor{
			[CCode (cname = "sfText_getFillColor")]
			get;
			[CCode (cname = "sfText_setFillColor")]
			set;
		}
		public Color outlinecolor{
			[CCode (cname = "sfText_getoutlineColor")]
			get;
			[CCode (cname = "sfText_setoutlineColor")]
			set;
		}
		public float outlinethickness{
			[CCode (cname = "sfText_getoutlinethickness")]
			get;
			[CCode (cname = "sfText_setoutlinethickness")]
			set;
		}

		[CCode (cname = "sfRenderWindow_drawText", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);

		public void setPosition(Vector2f position);
		public void setRotation(float angle);
		public void setScale(Vector2f scale);
		public void setOrigin(Vector2f origin);
		public Vector2f getPosition();
		public float getRotation();
		public Vector2f getScale();
		public Vector2f getOrigin();
		public void move(Vector2f offset);
		public void rotate(float angle);
		public void scaling(Vector2f factors);
		public Transform getTransform();
		public Transform getInverseTransform();
		public void setString(string str);
		public void setUnicodeString(uint32 []str);
		public void setFont(Font font);
		public void setCharacterSize(uint size);
		public void setLineSpacing(float spacingFactor);
		public void setLetterSpacing(float spacingFactor);
		public void setStyle(TextStyle style);
		[Version (deprecated = true, replacement = "setFillColor")]
		public void setColor(Color color);
		public void setFillColor(Color color);
		public void setOutlineColor(Color color);
		public void setOutlineThickness(float thickness);
		public unowned string getString();
		public uint32 []getUnicodeString();
		public unowned Font getFont();
		public uint getCharacterSize();
		public float getLetterSpacing();
		public float getLineSpacing();
		public TextStyle getStyle();
		[Version (deprecated = true, replacement = "getFillColor")]
		public Color getColor();
		public Color getFillColor();
		public Color getOutlineColor();
		public float getOutlineThickness();
		public Vector2f findCharacterPos(size_t index);
		public FloatRect getLocalBounds();
		public FloatRect getGlobalBounds();
	}

	[Compact]
	[Immutable]
	[CCode (copy_function = "sfImage_copy", cname = "sfImage", free_function = "sfImage_destroy", cprefix="sfImage_")]
	public class Image{
		[CCode (cname = "sfImage_create")]
		public Image(uint width, uint height);
		[CCode (cname = "sfImage_createFromColor")]
		public Image.fromColor(uint width, uint height, Color color);
		[CCode (cname = "sfImage_createFromPixels")]
		public Image.fromPixels(uint width, uint height, uint8* pixels);
		[CCode (cname = "sfImage_createFromFile")]
		public Image.fromFile(string filename);
		[CCode (cname = "sfImage_createFromMemory")]
		public Image.fromMemory(void* data, size_t size);
		[CCode (cname = "sfImage_createFromStream")]
		public Image.FromStream(InputStream stream);
		[CCode (cname = "sfImage_copy")]
		public Image copy();

		public bool saveToFile(string filename);
		public Vector2u getSize();
		public void createMaskFromColor(Color color, uint8 alpha);
		public void copyImage(Image source, uint destX, uint destY, IntRect sourceRect, bool applyAlpha);
		public void setPixel(uint x, uint y, Color color);
		public Color getPixel(uint x, uint y);
		public uint8 []getPixelsPtr();
		public void flipHorizontally();
		public void flipVertically();
	}


	[Compact]
	[CCode (cname = "sfShape", free_function = "sfShape_destroy", copy_function="sfShape_copy", cprefix="sfShape_", cheader_filename = "SFML/Graphics.h")]
	public class Shape : Transformable {
		[CCode (cname = "sfShapeGetPointCountCallback")]
		public delegate size_t GetPointCountDelegate (void* data);
		[CCode (cname = "sfShapeGetPointCallback")]
		public delegate Vector2f GetPointDelegate(size_t len, void* data);
		[CCode (cname = "sfShape_create")]

		// Attribut
		public Vector2f size{
			[CCode (cname = "sfShape_getSize")]
			get;
			[CCode (cname = "sfShape_setSize")]
			set;
		}
		public Vector2f position{
			[CCode (cname = "sfShape_getPosition")]
			get;
			[CCode (cname = "sfShape_setPosition")]
			set;
		}
		public float rotation{
			[CCode (cname = "sfShape_getRotation")]
			get;
			[CCode (cname = "sfShape_setRotation")]
			set;
		}
		public Vector2f scale{
			[CCode (cname = "sfShape_getScale")]
			get;
			[CCode (cname = "sfShape_setScale")]
			set;
		}
		public Vector2f origin{
			[CCode (cname = "sfShape_getOrigin")]
			get;
			[CCode (cname = "sfShape_setOrigin")]
			set;
		}
		public IntRect textureRect{
			[CCode (cname = "sfShape_getTextureRect")]
			get;
			[CCode (cname = "sfShape_setTextureRect")]
			set;
		}
		public Color color{
			[CCode (cname = "sfShape_getColor")]
			get;
			[CCode (cname = "sfShape_setColor")]
			set;
		}
		public FloatRect localBounds{
			[CCode (cname = "sfShape_getLocalBounds")]
			get;
			[CCode (cname = "sfShape_setLocalBounds")]
			set;
		}
		public FloatRect globalBounds{
			[CCode (cname = "sfShape_getGlobalBounds")]
			get;
			[CCode (cname = "sfShape_setGlobalBounds")]
			set;
		}

		[CCode (cname = "sfRenderWindow_drawShape", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);

		public Shape(GetPointCountDelegate getPointCount, GetPointDelegate getPoint, void* userData);
		public void setPosition(Vector2f position);
		public void setRotation(float angle);
		public void setScale(Vector2f scale);
		public void setOrigin(Vector2f origin);
		public Vector2f getPosition();
		public float getRotation();
		public Vector2f getScale();
		public Vector2f getOrigin();
		public void move(Vector2f offset);
		public void rotate(float angle);
		public void scaling(Vector2f factors);
		public unowned Transform getTransform();
		public unowned Transform getInverseTransform();
		public void setTexture(Texture texture, bool resetRect);
		public void setTextureRect(IntRect rect);
		public void setFillColor(Color color);
		public void setOutlineColor(Color color);
		public void setOutlineThickness(float thickness);
		public unowned Texture getTexture();
		public IntRect getTextureRect();
		public Color getFillColor();
		public Color getOutlineColor();
		public float getOutlineThickness();
		public size_t getPointCount();
		public Vector2f getPoint(size_t index);
		public FloatRect getLocalBounds();
		public FloatRect getGlobalBounds();
		public void update();
	}

/* *****************************     SPRITE     ************************************************/
	[Compact]
	[CCode (cname = "sfSprite", copy_function="sfSprite_copy", free_function = "sfSprite_destroy", cheader_filename = "SFML/Graphics.h")]
	public class Sprite : Shape {
		[CCode (cname = "sfSprite_create")]
		public Sprite();
		/**
		* Create a copy of the current Sprite object.
		*
		* @return A copy of the current Sprite object.
		*/
		[CCode (cname = "sfSprite_copy")]
		public Sprite copy();

		public Vector2f position{
			[CCode (cname = "sfSprite_getPosition")]
			get;
			[CCode (cname = "sfSprite_setPosition")]
			set;
		}

		public float x {
			get {
				return position.x;
			}
			set {
				position = {value, position.y};
			}
		}

		public float y {
			get {
				return position.y;
			}
			set {
				position = {position.x, value};
			}
		}

		public float rotation{
			[CCode (cname = "sfSprite_getRotation")]
			get;
			[CCode (cname = "sfSprite_setRotation")]
			set;
		}

		public Vector2f scale{
			[CCode (cname = "sfSprite_getScale")]
			get;
			[CCode (cname = "sfSprite_setScale")]
			set;
		}
		public Vector2f origin{
			[CCode (cname = "sfSprite_getOrigin")]
			get;
			[CCode (cname = "sfSprite_setOrigin")]
			set;
		}
		public IntRect textureRect{
			[CCode (cname = "sfSprite_getTextureRect")]
				get;
			[CCode (cname = "sfSprite_setTextureRect")]
				set;
		}
		public Color color{
			[CCode (cname = "sfSprite_getColor")]
			get;
			[CCode (cname = "sfSprite_setColor")]
			set;
		}
		public FloatRect localBounds{
			[CCode (cname = "sfSprite_getLocalBounds")]
			get;
			[CCode (cname = "sfSprite_setLocalBounds")]
			set;
		}
		public FloatRect globalBounds{
			[CCode (cname = "sfSprite_getGlobalBounds")]
			get;
			[CCode (cname = "sfSprite_setGlobalBounds")]
			set;
		}
		public unowned Texture texture{
			[CCode (cname = "sfSprite_getTexture")]
			get;
			set{
				setTexture(value);
			}
		}
		public float angle{
			[CCode (cname = "sfSprite_setRotation")]
			set;
			[CCode (cname = "sfSprite_getRotation")]
			get;
		}
		/**
		* Set the texture of the sprite.
		*
		* @param texture The texture to set.
		* @param resetRect Whether to reset the texture rectangle to the size of the new texture.
		*/
		[CCode (cname = "sfSprite_setTexture")]
		public void setTexture(Texture texture, bool resetRect = false);

		/**
		* Draw the sprite to the render window.
		*
		* @param window The render window to draw to.
		* @param state The render states to use for drawing.
		*/
		[CCode (cname = "sfRenderWindow_drawSprite", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);

		[CCode (cname = "sfSprite_setPosition")]
		public void setPosition(Vector2f position);

		[CCode (cname = "sfSprite_setRotation")]
		public void setRotation(float angle);

		[CCode (cname = "sfSprite_setScale")]
		public void setScale(Vector2f scale);

		[CCode (cname = "sfSprite_setOrigin")]
		public void setOrigin(Vector2f origin);

		[CCode (cname = "sfSprite_getPosition")]
		public Vector2f getPosition();

		[CCode (cname = "sfSprite_getRotation")]
		public float getRotation();

		[CCode (cname = "sfSprite_getScale")]
		public Vector2f getScale();

		[CCode (cname = "sfSprite_getOrigin")]
		public Vector2f getOrigin();

		[CCode (cname = "sfSprite_move")]
		public void move(Vector2f offset);

		[CCode (cname = "sfSprite_rotate")]
		public void rotate(float angle);

		[CCode (cname = "sfSprite_scale")]
		public void scaling(Vector2f factors);

		[CCode (cname = "sfSprite_getTransform")]
		public Transform getTransform();

		[CCode (cname = "sfSprite_getInverseTransform")]
		public Transform getInverseTransform();

		/**
		* Set the texture rectangle of the sprite.
		*
		* @param rectangle The new texture rectangle of the sprite.
		*/
		[CCode (cname = "sfSprite_setTextureRect")]
		public void setTextureRect(IntRect rectangle);

		[CCode (cname = "sfSprite_setColor")]
		public void setColor(Color color);

		/**
		* Get the texture of the sprite.
		*
		* @return The texture of the sprite.
		*/
		[CCode (cname = "sfSprite_getTexture")]
		public unowned Texture getTexture();

		/**
		* Get the texture rectangle of the sprite.
		*
		* @return The texture rectangle of the sprite.
		*/
		[CCode (cname = "sfSprite_getTextureRect")]
		public IntRect getTextureRect();

		[CCode (cname = "sfSprite_getColor")]
		public Color getColor();

		/**
		* Get the local bounds of the sprite.
		*
		* @return The local bounds of the sprite.
		*/
		[CCode (cname = "sfSprite_getLocalBounds")]
		public unowned FloatRect getLocalBounds();

		/**
		* Get the global bounds of the sprite.
		*
		* @return The global bounds of the sprite.
		*/
		[CCode (cname = "sfSprite_getGlobalBounds")]
		public unowned FloatRect getGlobalBounds();
	}

	[CCode (cname = "sfGlslVec2")]
	public struct GlslVec2{
		float x;
		float y;
	}

	[CCode (cname = "sfGlslIvec2")]
	public struct GlslIvec2{
		int x;
		int y;
	}

	[CCode (cname = "sfGlslBvec2")]
	[SimpleType]
	public struct GlslBvec2
	{
		bool x;
		bool y;
	}

	[CCode (cname = "sfGlslVec3")]
	[SimpleType]
	public struct GlslVec3 {
		float x;
		float y;
		float z;
	}

	[CCode (cname = "sfGlslIvec3")]
	[SimpleType]
	public struct GlslIvec3
	{
		int x;
		int y;
		int z;
	}

	[CCode (cname = "sfGlslBvec3")]
	[SimpleType]
	public struct GlslBvec3
	{
		bool x;
		bool y;
		bool z;
	}

	[CCode (cname = "sfGlslVec4")]
	[SimpleType]
	public struct GlslVec4
	{
		float x;
		float y;
		float z;
		float w;
	}

	[CCode (cname = "sfGlslIvec4")]
	[SimpleType]
	public struct GlslIvec4
	{
		int x;
		int y;
		int z;
		int w;
	}

	[CCode (cname = "sfGlslBvec4")]
	[SimpleType]
	public struct GlslBvec4
	{
		bool x;
		bool y;
		bool z;
		bool w;
	}

	[CCode (cname = "sfGlslMat3")]
	[SimpleType]
	public struct GlslMat3
	{
		float array[3 * 3];
	}

	[CCode (cname = "sfGlslMat4")]
	[SimpleType]
	public struct GlslMat4
	{
		float array[4 * 4];
	}

	[Compact]
	[CCode (cname = "sfShader", free_function = "sfShader_destroy", cprefix="sfShader_")]
	public class Shader {
		[CCode (cname = "sfShader_createFromFile")]
		public Shader.FromFile(string vertexShaderFilename, string geometryShaderFilename, string fragmentShaderFilename);
		[CCode (cname = "sfShader_createFromMemory")]
		public Shader.FromMemory(string vertexShader, string geometryShader, string fragmentShader);
		[CCode (cname = "sfShader_createFromStream")]
		public Shader.FromStream(InputStream vertexShaderStream, InputStream geometryShaderStream, InputStream fragmentShaderStream);

		public static bool isAvailable();
		public static bool isGeometryAvailable();
		public void setFloatUniform(string name, float x);
		public void setVec2Uniform(string name, GlslVec2 vector);
		public void setVec3Uniform(string name, GlslVec3 vector);
		public void setVec4Uniform(string name, GlslVec4 vector);
		public void setColorUniform(string name, Color color);
		public void setIntUniform(string name, int x);
		public void setIvec2Uniform(string name, GlslIvec2 vector);
		public void setIvec3Uniform(string name, GlslIvec3 vector);
		public void setIvec4Uniform(string name, GlslIvec4 vector);
		public void setIntColorUniform(string name, Color color);
		public void setBoolUniform(string name, bool x);
		public void setBvec2Uniform(string name, GlslBvec2 vector);
		public void setBvec3Uniform(string name, GlslBvec3 vector);
		public void setBvec4Uniform(string name, GlslBvec4 vector);
		public void setMat3Uniform(string name, GlslMat3 matrix);
		public void setMat4Uniform(string name, GlslMat4 matrix);
		public void setTextureUniform(string name, Texture texture);
		public void setCurrentTextureUniform(string name);
		public void setFloatUniformArray(string name, float scalarArray, size_t length);
		public void setVec2UniformArray(string name, GlslVec2 vectorArray, size_t length);
		public void setVec3UniformArray(string name, GlslVec3 vectorArray, size_t length);
		public void setVec4UniformArray(string name, GlslVec4 vectorArray, size_t length);
		public void setMat3UniformArray(string name, GlslMat3 matrixArray, size_t length);
		public void setMat4UniformArray(string name, GlslMat4 matrixArray, size_t length);
		public void setFloatParameter(string name, float x);
		public void setFloat2Parameter(string name, float x, float y);
		public void setFloat3Parameter(string name, float x, float y, float z);
		public void setFloat4Parameter(string name, float x, float y, float z, float w);
		public void setVector2Parameter(string name, Vector2f vector);
		public void setVector3Parameter(string name, Vector3f vector);
		public void setColorParameter(string name, Color color);
		public void setTransformParameter(string name, Transform transform);
		public void setTextureParameter(string name, Texture texture);
		public void setCurrentTextureParameter(string name);
		public uint getNativeHandle();
		public void bind();
	}

	[SimpleType]
	[CCode(cname = "sfTransform", cprefix="sfTransform_")]
	public struct Transform {
		public float matrix[9];
		public Transform* Identity;
		public static Transform fromMatrix(float a00, float a01, float a02,
				float a10, float a11, float a12,
				float a20, float a21, float a22);
		public void getMatrix(float matrix);
		public Transform getInverse(Transform transform);
		public Vector2f transformPoint(Vector2f point);
		public FloatRect transformRect(FloatRect rectangle);
		public void combine(Transform other);
		public void translate(float x, float y);
		public void rotate(float angle);
		public void rotateWithCenter(float angle, float centerX, float centerY);
		public void scale(float scaleX, float scaleY);
		public void scaleWithCenter(float scaleX, float scaleY, float centerX, float centerY);
		public bool equal(Transform left, Transform right);
	}

	[CCode (cname = "sfVertex")]
	[SimpleType]
	public struct Vertex
	{
		/** Position of the vertex*/
		Vector2f position;
		/** Color of the vertex*/
		Color    color;
		/** Coordinates of the texture's pixel to map to the vertex*/
		Vector2f texCoords;
	}

	[Compact]
	[CCode (free_function = "sfVertexArray_destroy", copy_function = "sfVertexArray_copy", cprefix="sfVertexArray_", cheader_filename = "SFML/Graphics.h")]
	public class VertexArray : Shape {
		[CCode (cname = "sfVertexArray_create")]
		public VertexArray();

		public VertexArray copy();
		public size_t getVertexCount();
		public Vertex* getVertex(size_t index);
		[CCode(cname="sfVertexArray_getVertex")]
		public Vertex* get(size_t index);
		public void clear();
		public void resize(size_t vertexCount);
		public void append(Vertex vertex);
		public void setPrimitiveType(PrimitiveType type);
		public PrimitiveType getPrimitiveType();
		public FloatRect getBounds();
	}
	[CCode (cname = "sfVertexBufferUsage", cprefix= "sfVertexBuffer")]
	public enum VertexBufferUsage
	{
		/** Constantly changing data */
		Stream,
		/** Occasionally changing data */
		Dynamic,
		/** Rarely changing data */
		Static
	}

	[Compact]
	[CCode (free_function = "sfVertexBuffer_destroy", copy_function="sfVertexBuffer_copy", cprefix="sfVertexBuffer_", cheader_filename = "SFML/Graphics.h")]
	public class VertexBuffer {
		public VertexBuffer(uint vertexCount, PrimitiveType type, VertexBufferUsage usage);
		public VertexBuffer copy();
		public uint getVertexCount();
		[CCode (cname = "sfRenderWindow_drawVertexBuffer", instance_pos = 1.2)]
		public void draw(RenderWindow window, RenderStates? state = null);
		public bool update(Vertex vertices, uint vertexCount, uint offset);
		public bool updateFromVertexBuffer(VertexBuffer other);
		public void swap(VertexBuffer source);
		public uint getNativeHandle();
		public void setPrimitiveType(PrimitiveType type);
		public PrimitiveType getPrimitiveType();
		public void setUsage(VertexBufferUsage usage);
		public VertexBufferUsage getUsage();
		public void bind();
		public bool isAvailable();
}

	[CCode (cname = "sfRenderStates")]
	public struct RenderStates{
		/** Blending mode*/
		BlendMode		blendMode;
		Transform		transform;
		Texture			texture;
		Shader			shader;
		[CCode (cname = "sfRenderStates_default")]
		public static RenderStates @default();
	}

	[CCode(cname="sfBlendFactor", cprefix="sfBlendFactor")]
	public enum BlendFactor
	{
		/** (0, 0, 0, 0)*/
		Zero,
		/** (1, 1, 1, 1)*/
		One,
		/** (src.r, src.g, src.b, src.a)*/
		SrcColor,
		/** (1, 1, 1, 1) - (src.r, src.g, src.b, src.a)*/
		OneMinusSrcColor,
		/** (dst.r, dst.g, dst.b, dst.a)*/
		DstColor,
		/** (1, 1, 1, 1) - (dst.r, dst.g, dst.b, dst.a)*/
		OneMinusDstColor,
		/** (src.a, src.a, src.a, src.a)*/
		SrcAlpha,
		/** (1, 1, 1, 1) - (src.a, src.a, src.a, src.a)*/
		OneMinusSrcAlpha,
		/** (dst.a, dst.a, dst.a, dst.a)*/
		DstAlpha,
		/** (1, 1, 1, 1) - (dst.a, dst.a, dst.a, dst.a)*/
		OneMinusDstAlpha
	}

	[CCode(cname="sfBlendEquation", cprefix="sfBlendEquation")]
	public enum BlendEquation
	{
		/** Pixel = Src * SrcFactor + Dst * DstFactor*/
		Add,
		/** Pixel = Src * SrcFactor - Dst * DstFactor*/
		Subtract,
		/** Pixel = Dst * DstFactor - Src * SrcFactor*/
		ReverseSubtract
	}

	[CCode(cname="sfBlendMode")]
	public struct BlendMode
	{
		/** Source blending factor for the color channels*/
		public BlendFactor colorSrcFactor;
		/** Destination blending factor for the color channels*/
		public BlendFactor colorDstFactor;
		/** Blending equation for the color channels*/
		public BlendEquation colorEquation;
		/** Source blending factor for the alpha channel*/
		public BlendFactor alphaSrcFactor;
		/** Destination blending factor for the alpha channel*/
		public BlendFactor alphaDstFactor;
		/** Blending equation for the alpha channel*/
		public BlendEquation alphaEquation;


		[CCode (cname = "sfBlendAlpha")]
		public const BlendMode Alpha;    ///< Blend source and dest according to dest alpha
		[CCode (cname = "sfBlendAdd")]
		public const BlendMode Add;      ///< Add source to dest
		[CCode (cname = "sfBlendMultiply")]
		public const BlendMode Multiply; ///< Multiply source and dest
		[CCode (cname = "sfBlendMin")]
		public const BlendMode Min;      ///< Take minimum between source and dest
		[CCode (cname = "sfBlendMax")]
		public const BlendMode Max;      ///< Take maximum between source and dest
		[CCode (cname = "sfBlendNone")]
		public const BlendMode None;     ///< Overwrite dest with source
	}

	[Compact]
	[CCode (free_function = "sfRenderWindow_destroy", cheader_filename = "SFML/Window.h,SFML/Graphics.h", cprefix = "sfRenderWindow_")]
	public class RenderWindow {
		[CCode (cname = "sfRenderWindow_create")]
		public RenderWindow(VideoMode mode, string title, WindowStyle style = WindowStyle.DefaultStyle, ContextSettings? settings = null);
		[CCode (cname = "sfRenderWindow_createUnicode")]
		public RenderWindow.createUnicode(VideoMode mode, uint32 []title, WindowStyle style, ContextSettings? settings = null);
		[CCode (cname = "sfRenderWindow_createFromHandle")]
		public RenderWindow.createFromHandle(WindowHandle handle, ContextSettings? settings = null);

		public bool visible {
			[CCode (cname = "sfRenderWindow_getVisible")]
			get;
			[CCode (cname = "sfRenderWindow_setVisible")]
			set;
		}

		public Vector2i position{
			[CCode (cname = "sfRenderWindow_getPosition")]
			get;
			[CCode (cname = "sfRenderWindow_setPosition")]
			set;
		}

		public Vector2u size{
			[CCode (cname = "sfRenderWindow_getSize")]
			get;
			[CCode (cname = "sfRenderWindow_setSize")]
			set;
		}

		public uint width {
			get {
				return size.x;
			}
			set {
				size.x = value;
			}
		}

		public uint height {
			get {
				return size.y;
			}
			set {
				size.y = value;
			}
		}

		public unowned string title{
			[CCode (cname = "sfRenderWindow_getTitle")]
			get;
			[CCode (cname = "sfRenderWindow_setTitle")]
			set;
		}

		public uint framerateLimit{
			[CCode (cname = "sfRenderWindow_getFramerateLimit")]
			get;
			[CCode (cname = "sfRenderWindow_setFramerateLimit")]
			set;
		}

		public float joystickThreshold{
			[CCode (cname = "sfRenderWindow_getJoystickThreshold")]
			get;
			[CCode (cname = "sfRenderWindow_setJoystickThreshold")]
			set;
		}

		public bool active{
			[CCode (cname = "sfRenderWindow_getActive")]
			get;
			[CCode (cname = "sfRenderWindow_setActive")]
			set;
		}

		public bool focus{
			[CCode (cname = "sfRenderWindow_hasFocus")]
			get;
		}

		public uint fps{
			[CCode (cname = "sfRenderWindow_setFramerateLimit")]
			set;
			[CCode (cname = "sfRenderWindow_getFramerateLimit")]
			get;
		}

		public void close();
		public bool isOpen();
		public unowned ContextSettings getSettings();
		public bool pollEvent(out Event event);
		public bool waitEvent(out Event event);
		public Vector2i getPosition();
		public void setPosition(Vector2i position);
		public Vector2u getSize();
		public void setSize(Vector2u size);
		public void setTitle(string title);
		public unowned string getTitle();
		public void setUnicodeTitle(uint32 []title);
		public void setIcon(uint width, uint height, uint8 []pixels);
		public void setVisible(bool visible);
		public void setVerticalSyncEnabled(bool enabled);
		public void setMouseCursorVisible(bool show);
		public void setMouseCursorGrabbed(bool grabbed);
		public void setMouseCursor(Cursor cursor);
		public void setKeyRepeatEnabled(bool enabled);
		public void setFramerateLimit(uint limit);
		public void setJoystickThreshold(float threshold);
		public bool setActive(bool active);
		public void requestFocus();
		public bool hasFocus();
		public void display();
		public unowned WindowHandle getSystemHandle();
		public void clear(Color color = Color.Black);
		public void setView(View view);
		public unowned View getView();
		public unowned View getDefaultView();
		public IntRect getViewport(View view);
		public Vector2f mapPixelToCoords(Vector2i point, View view);
		public Vector2i mapCoordsToPixel(Vector2f point, View view);
		[CCode (cname = "sfRenderWindow_drawShape")]
		public void draw (Shape drawable, sf.RenderStates? state = null);
		public void drawVertexBuffer(VertexBuffer object, RenderStates? states = null);
		public void drawVertexBufferRange(VertexBuffer object, size_t firstVertex, size_t vertexCount, RenderStates? states = null);
		public void drawPrimitives(Vertex vertices, size_t vertexCount, PrimitiveType type, RenderStates? states = null);
		public void pushGLStates();
		public void popGLStates();
		public void resetGLStates();
		[Version (deprecated = true, replacement = "")]
		public Image capture();
	}

	[CCode (cname = "sfContextAttribute", cprefix = "sfContext")]
	public enum ContextAttribute
	{
		Default,
		Core,
		Debug
	}

}

public inline sf.IntRect IntRect(int left, int top, int width, int height){
	return {left, top, width, height};
}

public inline sf.FloatRect FloatRect(float left, float top, float width, float height){
	return {left, top, width, height};
}

