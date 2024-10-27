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

[CCode (cheader_filename = "SFML/Window.h")]
namespace sf {

	[CCode (free_function = "sfWindow_destroy", cheader_filename = "SFML/Window.h", cprefix = "sfWindow_")]
	[Compact]
	public class Window: WindowBase {
		[CCode (cname = "sfWindow_create")]
		public Window(VideoMode mode, string title, WindowStyle style = WindowStyle.DefaultStyle, ContextSettings? settings = null);
		[CCode (cname = "sfWindow_createUnicode")]
		public Window.withUnicode(VideoMode mode, uint32 []title, WindowStyle style, ContextSettings? settings = null);
		[CCode (cname = "isfWindow_createFromHandle")]
		public Window.fromHandle(WindowHandle handle, ContextSettings? settings = null);

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
		public void setUnicodeTitle(uint32 []title);
		public void setIcon(uint width, uint height, uint8[] pixels);
		public void setVisible(bool visible);
		public void setVerticalSyncEnabled(bool enabled);
		public void setMouseCursorVisible(bool visible);
		public void setMouseCursorGrabbed(bool grabbed);
		public void setMouseCursor(Cursor cursor);
		public void setKeyRepeatEnabled(bool enabled);
		public void setFramerateLimit(uint limit);
		public void setJoystickThreshold(float threshold);
		public bool setActive(bool active);
		public void requestFocus();
		public bool hasFocus();
		public void display();
		[CCode (cname="sfMouse_getPosition")]
		public Vector2i getMousePosition();
		[CCode (cname="sfMouse_setPosition", instance_pos=0.1)]
		public void setMousePosition(Vector2i position);
		public WindowHandle* getSystemHandle();
	}

	[CCode (cname = "sfWindowHandle")]
	[SimpleType]
	public struct WindowHandle { }

	namespace Vulkan {
		[CCode (cname = "VkAllocationCallbacks")]
		public struct VkAllocationCallbacks {

		}
		[CCode (cname = "VkSurfaceKHR")]
		public struct VkSurfaceKHR : uint64 {

		}
		[CCode (cname = "VkInstance")]
		public struct VkInstance {

		}
		[CCode (cname="sfVulkanFunctionPointer")]
		public delegate void FunctionPointer();
		[CCode (cname="sfVulkan_isAvailable")]
		public bool isAvailable(bool requireGraphics);
		[CCode (cname="sfVulkan_getFunction")]
		public FunctionPointer getFunction(string name);
		[CCode (cname="sfVulkan_getRequiredInstanceExtensions")]
		public string getGraphicsRequiredInstanceExtensions(out size_t count);
	}

	[CCode (cprefix="sfClipboard_", cheader_filename = "SFML/Window/Clipboard.h")]
	namespace ClipBoard {
		public unowned string getString();
		public uint32 []getUnicodeString();
		public void setString(string text);
		public void setUnicodeString(uint32 []text);
	}

	[Compact]
	[CCode (free_function = "sfContext_destroy", cprefix="sfContext_", cheader_filename = "SFML/Window/Context.h")]
	public class Context {
		[CCode (cname = "sfContext_create")]
		public Context();

		public delegate void GlFunctionPointer();

		public static bool isExtensionAvailable(string name);
		public static unowned GlFunctionPointer getFunction(string name);
		public static uint64 getActiveContextId();
		public bool setActive(bool active);
		public unowned ContextSettings getSettings();
	}

	[CCode (cname = "sfContextSettings")]
	public struct ContextSettings
	{
		/** Bits of the depth buffer*/
		uint depthBits;
		/** Bits of the stencil buffer*/
		uint stencilBits;
		/** Level of antialiasing*/
		uint antialiasingLevel;
		/** Major number of the context version to create*/
		uint majorVersion;
		/** Minor number of the context version to create*/
		uint minorVersion;
		/** The attribute flags to create the context with*/
		uint32 attributeFlags;
		/** Whether the context framebuffer is sRGB capable*/
		bool sRgbCapable;
	}

	[CCode (cname = "sfCursorType", cprefix = "sfCursor")]
	public enum CursorType {
		/** Arrow cursor (default)*/
		Arrow,
		/** Busy arrow cursor*/
		ArrowWait,
		/** Busy cursor*/
		Wait,
		/** I-beam, cursor when hovering over a field allowing text entry*/
		Text,
		/** Pointing hand cursor*/
		Hand,
		/** Horizontal double arrow cursor*/
		SizeHorizontal,
		/** Vertical double arrow cursor*/
		SizeVertical,
		/** Double arrow cursor going from top-left to bottom-right*/
		SizeTopLeftBottomRight,
		/** Double arrow cursor going from bottom-left to top-right*/
		SizeBottomLeftTopRight,
		/** Combination of SizeHorizontal and SizeVertical*/
		SizeAll,
		/** Crosshair cursor*/
		Cross,
		/** Help cursor*/
		Help,
		/** Action not allowed cursor*/
		NotAllowed
	}

	[Compact]
	[CCode (free_function = "sfCursor_destroy", cheader_filename = "SFML/Window.h")]
	public class Cursor {
		[CCode (cname = "sfCursor_createFromPixels")]
		public Cursor.fromPixels(uint8 []pixels, Vector2u size, Vector2u hotspot);
		[CCode (cname = "sfCursor_createFromSystem")]
		public Cursor.fromSystem(CursorType type);
	}



	///////////////////////////////////////////////////////////////
	//							EVENT							//
	/////////////////////////////////////////////////////////////


	[CCode (cname = "sfEventType", cprefix = "sfEvt")]
	public enum EventType {
		/** The window requested to be closed (no data)*/
		Closed,
		/** The window was resized (data in event.size)*/
		Resized,
		/** The window lost the focus (no data)*/
		LostFocus,
		/** The window gained the focus (no data)*/
		GainedFocus,
		/** A character was entered (data in event.text)*/
		TextEntered,
		/** A key was pressed (data in event.key)*/
		KeyPressed,
		/** A key was released (data in event.key)*/
		KeyReleased,
		/** The mouse wheel was scrolled (data in event.mouseWheel) (deprecated)*/
		MouseWheelMoved,
		/** The mouse wheel was scrolled (data in event.mouseWheelScroll)*/
		MouseWheelScrolled,
		/** A mouse button was pressed (data in event.mouseButton)*/
		MouseButtonPressed,
		/** A mouse button was released (data in event.mouseButton)*/
		MouseButtonReleased,
		/** The mouse cursor moved (data in event.mouseMove)*/
		MouseMoved,
		/** The mouse cursor entered the area of the window (no data)*/
		MouseEntered,
		/** The mouse cursor left the area of the window (no data)*/
		MouseLeft,
		/** A joystick button was pressed (data in event.joystickButton)*/
		JoystickButtonPressed,
		/** A joystick button was released (data in event.joystickButton)*/
		JoystickButtonReleased,
		/** The joystick moved along an axis (data in event.joystickMove)*/
		JoystickMoved,
		/** A joystick was connected (data in event.joystickConnect)*/
		JoystickConnected,
		/** A joystick was disconnected (data in event.joystickConnect)*/
		JoystickDisconnected,
		/** A touch event began (data in event.touch)*/
		TouchBegan,
		/** A touch moved (data in event.touch)*/
		TouchMoved,
		/** A touch event ended (data in event.touch)*/
		TouchEnded,
		/** A sensor value changed (data in event.sensor)*/
		SensorChanged,
	}

	[CCode (cname = "sfKeyEvent")]
	[SimpleType]
	public struct	KeyEvent{
		EventType	type;
		KeyCode		code;
		bool		alt;
		bool		control;
		bool		shift;
		bool		system;
	}

	[CCode (cname = "sfTextEvent")]
	[SimpleType]
	public struct TextEvent{
		EventType	type;
		uint32		unicode;
	}

	[CCode (cname = "sfMouseMoveEvent")]
	[SimpleType]
	public struct MouseMoveEvent{
		sf.EventType	type;
		int				x;
		int				y;
	}

	[CCode (cname = "sfMouseButtonEvent")]
	[SimpleType]
	public struct MouseButtonEvent
	{
		EventType	type;
		MouseButton	button;
		int			x;
		int			y;
	}

	[CCode (cname = "sfMouseWheelEvent")]
	[SimpleType]
	public struct MouseWheelEvent
	{
		EventType	type;
		int			delta;
		int			x;
		int			y;
	}

	[CCode (cname = "sfMouseWheelScrollEvent")]
	[SimpleType]
	public struct MouseWheelScrollEvent
	{
		EventType 	type;
		MouseWheel	wheel;
		float		delta;
		int			x;
		int			y;
	}

	[CCode (cname = "sfJoystickMoveEvent")]
	[SimpleType]
	public struct JoystickMoveEvent
	{
		EventType		type;
		uint			joystickId;
		JoystickAxis	axis;
		float			position;
	}

	[CCode (cname = "sfJoystickButtonEvent")]
	[SimpleType]
	public struct JoystickButtonEvent
	{
		EventType	type;
		uint		joystickId;
		uint		button;
	}

	[CCode (cname = "sfJoystickConnectEvent")]
	[SimpleType]
	public struct JoystickConnectEvent
	{
		EventType		type;
		uint			joystickId;
	}

	[CCode (cname = "sfSizeEvent")]
	[SimpleType]
	public struct SizeEvent
	{
		EventType type;
		uint width;
		uint height;
	}

	[CCode (cname = "sfTouchEvent")]
	[SimpleType]
	public struct TouchEvent
	{
		EventType	type;
		uint		finger;
		int			x;
		int			y;
	}

	[CCode (cname = "sfSensorEvent")]
	[SimpleType]
	public struct SensorEvent
	{
		EventType	type;
		SensorType	sensorType;
		float		 x;
		float		 y;
		float		 z;
	}

	[CCode (cname = "sfEvent", cprefix="sf", default_value ="{-42}")]
	[SimpleType]
	public struct Event{
		/** Type of the event*/
		EventType             type;
		/** Size event parameters*/
		SizeEvent             size;
		/** Key event parameters*/
		KeyEvent              key;
		/** Text event parameters*/
		TextEvent             text;
		/** Mouse move event parameters*/
		MouseMoveEvent        mouseMove;
		/** Mouse button event parameters*/
		MouseButtonEvent      mouseButton;
		/** Mouse wheel event parameters (deprecated)*/
		MouseWheelEvent       mouseWheel;
		/** Mouse wheel event parameters*/
		MouseWheelScrollEvent mouseWheelScroll;
		/** Joystick move event parameters*/
		JoystickMoveEvent     joystickMove;
		/** Joystick button event parameters*/
		JoystickButtonEvent   joystickButton;
		/** Joystick (dis)connect event parameters*/
		JoystickConnectEvent  joystickConnect;
		/** Touch events parameters*/
		TouchEvent            touch;
		/** Sensor event parameters*/
		SensorEvent           sensor;
	}
	[CCode (cname = "sfJoystickCount")]
	public const int JoystickCount;
	[CCode (cname = "sfJoystickButtonCount")]
	public const int JoystickButtonCount;
	[CCode (cname = "sfJoystickAxisCount")]
	public const int JoystickAxisCount;
	[CCode (cname = "sfJoystickAxis", cprefix = "sfJoystick")]
	public enum JoystickAxis
	{
		/** The X axis*/
		X,
		/** The Y axis*/
		Y,
		/** The Z axis*/
		Z,
		/** The R axis*/
		R,
		/** The U axis*/
		U,
		/** The V axis*/
		V,
		/** The X axis of the point-of-view hat*/
		PovX,
		/** The Y axis of the point-of-view hat*/
		PovY
	}
	[CCode (cprefix = "sfKeyboard_")]
	namespace Keyboard {
		public bool isKeyPressed(KeyCode key);
		public void setVirtualKeyboardVisible(bool visible);
	}

	[CCode (cprefix = "sfJoystick_")]
	namespace Joystick {
		public bool isConnected(uint joystick);
		public uint getButtonCount(uint joystick);
		public bool hasAxis(uint joystick, JoystickAxis axis);
		public bool isButtonPressed(uint joystick, uint button);
		public float getAxisPosition(uint joystick, JoystickAxis axis);
		public JoystickIdentification getIdentification(uint joystick);
		public void update();
	}

	[CCode (cname = "sfJoystickIdentification")]
	public struct JoystickIdentification
	{
		string	name;
		uint	vendorId;
		uint	productId;
	}

	[CCode (cname = "sfKeyCode", cprefix = "sfKey")]
	public enum KeyCode
	{
		/** Unhandled*/
		Unknown = -1,
		A,
		B,
		C,
		D,
		E,
		F,
		G,
		H,
		I,
		J,
		K,
		L,
		M,
		N,
		O,
		P,
		Q,
		R,
		S,
		T,
		U,
		V,
		W,
		X,
		Y,
		Z,
		/** Number 0*/
		Num0,
		/** Number 1*/
		Num1,
		/** Number 2*/
		Num2,
		/** Number 3*/
		Num3,
		/** Number 4*/
		Num4,
		/** Number 5*/
		Num5,
		/** Number 6*/
		Num6,
		/** Number 7*/
		Num7,
		/** Number 8*/
		Num8,
		/** Number 9*/
		Num9,
		/** Escape [Esc]*/
		Escape,
		/** The left Control*/
		LControl,
		/** The left Shift*/
		LShift,
		/** The left Alt*/
		LAlt,
		/** The left OS specific : window (Windows and Linux), apple (MacOS X), ..*/
		LSystem,
		/** The right Control*/
		RControl,
		/** The right Shift*/
		RShift,
		/** The right Alt*/
		RAlt,
		/** The right OS specific : window (Windows and Linux), apple (MacOS X), ..*/
		RSystem,
		/** The Menu*/
		Menu,
		/** The [*/
		LBracket,
		/** The ]*/
		RBracket,
		/** The ;*/
		Semicolon,
		/** The ,*/
		Comma,
		/** The .*/
		Period,
		/** The '*/
		Quote,
		/** The '/'*/
		Slash,
		/** The '\'*/
		Backslash,
		/** The ~*/
		Tilde,
		/** The =*/
		Equal,
		/** The -  (hyphen)*/
		Hyphen,
		/** The Space*/
		Space,
		/** The Enter/Return*/
		Enter,
		/** The Backspace*/
		Backspace,
		/** The Tabulation*/
		Tab,
		/** The Page up*/
		PageUp,
		/** The Page down*/
		PageDown,
		/** The End*/
		End,
		/** The Home*/
		Home,
		/** The Insert*/
		Insert,
		/** The Delete*/
		Delete,
		/** The +*/
		Add,
		/** The -  (minus, usually from numpad)*/
		Subtract,
		/** The '*'*/
		Multiply,
		/** The '/'*/
		Divide,
		/** Left arro*/
		Left,
		/** Right arro*/
		Right,
		/** Up arro*/
		Up,
		/** Down arro*/
		Down,
		/** The numpad 0*/
		Numpad0,
		/** The numpad 1*/
		Numpad1,
		/** The numpad 2*/
		Numpad2,
		/** The numpad 3*/
		Numpad3,
		/** The numpad 4*/
		Numpad4,
		/** The numpad 5*/
		Numpad5,
		/** The numpad 6*/
		Numpad6,
		/** The numpad 7*/
		Numpad7,
		/** The numpad 8*/
		Numpad8,
		/** The numpad 9*/
		Numpad9,
		F1,
		F2,
		F3,
		F4,
		F5,
		F6,
		F7,
		F8,
		F9,
		F10,
		F11,
		F12,
		F13,
		F14,
		F15,
		Pause,
		Count,
		[Version (deprecated = true, replacement = "Hyphen")]
		/** Deprecated Hyphen '-' */
		Dash,
		[Version (deprecated = true, replacement = "Backspace")]
		/** Deprecated Backspace */
		Back,
		[Version (deprecated = true, replacement = "Backslash")]
		/** Deprecated Backslash '\'*/
		BackSlash,
		[Version (deprecated = true, replacement = "Semicolon")]
		/** Deprecated Semicolon ','*/
		SemiColon,
		[Version (deprecated = true, replacement = "Enter")]
		/** Deprecated Enter */
		Return
	}

	[CCode (cname = "sfMouseButton", cprefix = "sfMouse")]
	public enum MouseButton
	{
		/** The left mouse button*/
		Left,
		/** The right mouse button*/
		Right,
		/** The middle (wheel) mouse button*/
		Middle,
		/** The first extra mouse button*/
		Button1,
		/** The second extra mouse button*/
		Button2,
		/** Keep last -- the total number of mouse buttons*/
		ButtonCount
	}

	[CCode (cname = "sfMouseWheel", cprefix = "sfMouse")]
	public enum MouseWheel
	{
		Vertical,
		Horizontal
	}

	[CCode (cprefix = "sfMouse_")]
	namespace Mouse {
		public bool isButtonPressed(MouseButton button);
		public Vector2i getPosition(Window relativeTo);
		public void setPosition(Vector2i position, Window relativeTo);
		public Vector2i getPositionWindowBase(WindowBase relativeTo);
		public void setPositionWindowBase(Vector2i position, WindowBase relativeTo);
	}

	[CCode (cname = "sfSensorType", cprefix = "sfSensor")]
	public enum SensorType
	{
		/** Measures the raw acceleration (m/s^2)*/
		Accelerometer,
		/** Measures the raw rotation rates (degrees/s)*/
		Gyroscope,
		/** Measures the ambient magnetic field (micro-teslas)*/
		Magnetometer,
		/** Measures the direction and intensity of gravity, independent of device acceleration (m/s^2)*/
		Gravity,
		/** Measures the direction and intensity of device acceleration, independent of the gravity (m/s^2)*/
		UserAcceleration,
		/** Measures the absolute 3D orientation (degrees)*/
		Orientation,
		/** Keep last -- the total number of sensor types*/
		Count
	}

	[CCode (cprefix = "sfSensor_")]
	namespace Sensor {
		public bool isAvailable(SensorType sensor);
		public void setEnabled(SensorType sensor, bool enabled);
		public Vector3f getValue(SensorType sensor);
	}

	[CCode (cprefix = "sfTouch_")]
	namespace Touch {
		public bool isDown(uint finger);
		public Vector2i getPosition(uint finger, Window relativeTo);
		public Vector2i getPositionWindowBase(uint finger, WindowBase relativeTo);

	}

	[CCode (cname = "sfVideoMode", cheader_filename = "SFML/Window.h")]
	[SimpleType]
	public struct VideoMode{
		uint width;
		uint height;
		uint bitsPerPixel;
		[CCode (cname = "sfVideoMode_getDesktopMode")]
		public VideoMode getDesktopMode();
		[CCode (cname = "sfVideoMode_getFullscreenModes")]
		public unowned VideoMode getFullscreenModes(ref size_t count);
		[CCode (cname = "sfVideoMode_isValid")]
		public bool isValid(VideoMode mode);

	}

	[CCode (cname = "sfWindowBase", free_function="sfWindowBase_destroy", cprefix = "sfWindowBase_")]
	[Compact]
	public class WindowBase {
		[CCode (cname = "sfWindowBase_create")]
		public WindowBase(VideoMode mode,  char* title, WindowStyle style);
		[CCode (cname = "sfWindowBase_createUnicode")]
		public WindowBase.createUnicode(VideoMode mode,  uint32[] title, WindowStyle style);
		[CCode (cname = "sfWindowBase_createFromHandle")]
		public WindowBase.createFromHandle(WindowHandle handle);

		[DestroysInstance]
		public void close();

		public bool isOpen();
		public bool pollEvent(out Event event);
		public bool waitEvent(out Event event);
		public Vector2i getPosition();
		public void setPosition(Vector2i position);
		public Vector2u getSize();
		public void setSize(Vector2u size);
		public void setTitle(string title);
		public void setUnicodeTitle(uint8[] title);
		public void setIcon(uint width, uint height,  uint8[] pixels);
		public void setVisible(bool visible);
		public void setMouseCursorVisible(bool visible);
		public void setMouseCursorGrabbed(bool grabbed);
		public void setMouseCursor(Cursor cursor);
		public void setKeyRepeatEnabled(bool enabled);
		public void setJoystickThreshold(float threshold);
		public void requestFocus();
		public bool hasFocus();
		public WindowHandle* getNativeHandle();
		public bool createVulkanSurface(Vulkan.VkInstance instance, Vulkan.VkSurfaceKHR surface, Vulkan.VkAllocationCallbacks allocator);

		[CCode (cname="sfMouse_getPositionWindowBase")]
		public Vector2i getMousePosition();
		[CCode (cname="sfMouse_setPositionWindowBase", instance_pos=0.1)]
		public void setMousePosition(Vector2i position);
	}

	[CCode (cname = "sfWindowStyle", cprefix = "sf", cheader_filename = "SFML/Window.h")]
	public enum WindowStyle
	{
		None,
		Titlebar,
		Resize,
		Close,
		Fullscreen,
		DefaultStyle
	}
}

/** VideoMode constructor */
public inline sf.VideoMode VideoMode(int width, int height) {
	return {width, height};
}

