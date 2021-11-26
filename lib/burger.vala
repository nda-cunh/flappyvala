//valac --pkg sdl2 --pkg SDL2_gfx main.vala grille.vala burger.vala


const int POS_CENTER = (int)SDL.Video.Window.POS_CENTERED;
public class Window{
	public Window(string title = "hello", int size_x = 500, int size_y = 500) {
		print("creation de la fenetre\n");
		m_title = title;
		m_size_x = size_x;
		m_size_y = size_y;
		m_is_open = true;
		SDL.init(SDL.InitFlag.EVERYTHING);
		SDL.Video.GL.set_attribute(SDL.Video.GL.Attributes.MULTISAMPLEBUFFERS, 8);
		m_win = new SDL.Video.Window(m_title, POS_CENTER, POS_CENTER, m_size_x, m_size_y, SDL.Video.WindowFlags.SHOWN);
		m_render = SDL.Video.Renderer.create (m_win, -1, SDL.Video.RendererFlags.SOFTWARE);
	}
	public bool is_open(){
		return m_is_open;            
	}
	public void drawPoint (uint32 x, uint32 y){
		m_render.draw_point((int)x, (int)y);
	}
	
	public void draw(Drawable drawer){	
		if(drawer.get_whatsIs() == CIRCLE)
		{
		    int16 x = (int16)drawer.get_position().x;
		    int16 y = (int16)drawer.get_position().y;
		    int16 r = (int16)drawer.get_radius();
		    Color c = drawer.get_outline_color();
		    Color c2 = {drawer.get_red(), drawer.get_green(), drawer.get_blue(), drawer.get_alpha()};
		    
		    SDLGraphics.Circle.fill_rgba(m_render,x, y, r, c2.r, c2.g, c2.b, c2.a);
		    for(int16 i = 0; i!= drawer.get_outline_radius(); i++)
		    {
		        SDLGraphics.Circle.outline_rgba(m_render, x, y, r + i, c.r, c.g, c.b, c.a);
		    }

		
		}
		else if(drawer.get_whatsIs() == SPRITE){
			drawer.set_render(m_render);
			Texture text_tmp = drawer.get_surface();
			m_render.copyex(drawer.get_texture(), {0,0,text_tmp.get_W(), text_tmp.get_H()}, {(int)drawer.get_position().x,(int)drawer.get_position().y, text_tmp.get_W() * drawer.get_scale().x ,text_tmp.get_H() * drawer.get_scale().y}, drawer.get_angle(), {text_tmp.get_W()/2,text_tmp.get_H()/2}, SDL.Video.RendererFlip.NONE);                     
		    
		}

	}

	protected void fps_loop(){
    
    uint32 time_dif,slp;

	slp = 1000/m_fps_limit;
	slp +=1;
	time_end = SDL.Timer.get_ticks();
	time_dif = time_end - time_begin;

	if(time_dif <= 0) time_dif = 0;
	if(time_dif < slp)
	    SDL.Timer.delay(slp - time_dif);
	time_begin = SDL.Timer.get_ticks();
}
	public void set_framelimit(uint fps){
		m_fps_limit = (uint32)fps;
	}

	public void clear(){		m_render.clear ();
		m_render.set_draw_color (255, 255, 255, 250);
		m_render.fill_rect ( {0, 0, 1024, 768} ) ;
	}
	public uint32 get_fps_average(){
		return (uint32)5;
	}

	public void close(){
		m_win.destroy();
		m_is_open = false;
	}
	public void present(){
	    fps_loop();
		m_render.present();
		m_win.update_surface();
	}
	public SDL.Video.Renderer *get_render(){
		return m_render;
	}
	private uint32 m_fps_limit = 60;
	private uint32 time_end;
    private uint32 time_begin;
	private bool m_is_open;
	private string m_title;
	private int m_size_x;
	private int m_size_y;
	private SDL.Video.Window m_win;
	private SDL.Video.Renderer m_render;
}

public struct Vector2i{
	int x;
	int y;
}
public struct Vector2f{
	double x;
	double y;
}





public class Texture{
	public Texture(string bpm = "n"){
	    if(bpm.data[0] == 'n'){
	        return;
	    }
		m_surface = new SDL.Video.Surface.from_bmp(bpm);
		if(m_surface == null)
		    print("Texture non ajouté\n");
	}
	public bool set_texture(string bpm){
	    m_surface = new SDL.Video.Surface.from_bmp(bpm);
	    return (m_surface == null);
	}
	public void set_color(uint8 red, uint8 green, uint8 blue){
		m_surface.set_colormod(red ,green, blue);
	}
	public void get_color(uint8 red, uint8 green, uint8 blue){
		m_surface.get_colormod(out red, out green, out blue);
	}
	public void set_opacity(uint8 alpha){
		m_surface.set_alphamod(alpha);
	}
	public int get_W(){
		return m_surface.w;
	}
	public int get_H(){
		return m_surface.h;
	}
	public SDL.Video.Surface *get_image(){
		return m_surface;
	}
	public void set_image(ref SDL.Video.Surface surface){
		m_surface = (owned)surface;
	}
	private SDL.Video.Surface m_surface;
}



public class Sprite : Drawable{
	public Sprite(Texture texture){
		m_whats_is = SPRITE;
		m_texture = texture;
		m_size.x = 1;
		m_size.y = 1;
	}
	public void set_texture(Texture texture){
        m_texture = texture;
    }
    public void set_rect(int x, int y, int w, int h){
        m_texture.get_image()->set_cliprect({x,y,w,h});
    }
}






public enum IS_DRAWABLE{
	RECTANGLE, SPRITE, CIRCLE
}

public class Drawable{
	public Drawable(){

	}
	public IS_DRAWABLE get_whatsIs(){
		return m_whats_is;
	}
	public Vector2i get_scale(){
		return m_size;
	}
	public Vector2f get_position(){
		return m_pos;
	}
	public void scale(Vector2i size){
		m_size.x += size.x;
		m_size.y += size.y;
	}
	public void set_scale(Vector2i size){
		m_size.x = size.x;
		m_size.y = size.y;
	}
	public void set_position(Vector2f pos){
		m_pos.x = pos.x;
		m_pos.y = pos.y;
	}
	public void move(Vector2f position){
		m_pos.x = m_pos.x + position.x;
		m_pos.y = m_pos.y + position.y;
	}
	public SDL.Video.Texture *get_texture(){
		return m_texture_sdl;
	}
	public Texture *get_surface(){
		return m_texture;
	}
	public void set_render(SDL.Video.Renderer render){
		m_texture_sdl = SDL.Video.Texture.create_from_surface (render, m_texture.get_image());
	}
	public uchar get_red(){
	    return m_RED;
	}
	public uchar get_green(){
	    return m_GREEN;
	}
	public uchar get_blue(){
	    return m_BLUE;
	}
	public uchar get_alpha(){
	    return m_ALPHA;
	}
    public int get_radius(){
	    return m_radius;
	}
	public bool collision_point(Vector2i point){
	    if(m_whats_is == CIRCLE){
	        double d2 = (point.x - m_pos.x)*(point.x - m_pos.x) + (point.y - m_pos.y)*(point.y - m_pos.y);
	        if (d2 > m_radius*m_radius)
                return false;
            else
            return true;
	    }
        if(m_whats_is == SPRITE || m_whats_is == RECTANGLE){
            Texture text_tmp = this.get_surface();
            int width = 0;
            int height = 0;
            if(m_whats_is == SPRITE)
            {
                width = text_tmp.get_W();
                height = text_tmp.get_H();
            }
            if (point.x >= m_pos.x && point.x < m_pos.x + width && point.y >= m_pos.y && point.y < m_pos.y + height)
                return true;
            else
                return false;
	    }
	    return false;
	}
	public bool collision_circle(Circle cercle){
        double d2;
        if(m_whats_is == CIRCLE)
        {
            d2 = (int)(m_pos.x -cercle.get_position().x)*(m_pos.x-cercle.get_position().x) + (m_pos.y-cercle.get_position().y)*(m_pos.y-cercle.get_position().y);
            if (d2 > (m_radius + cercle.get_radius())*(m_radius + cercle.get_radius()))
                return false;
            else
                return true;
	    }
	    else{
	        print("Nexiste pas encore pour ce dessin");
	        return false;
	    }
	}
	public bool collision_sprite(Sprite sprite)
    {
        var box1 = m_pos;
        var box2 = sprite.get_position();
        var box1w = m_texture.get_W();
        var box2w = sprite.m_texture.get_W();
        var box1h = m_texture.get_H();
        var box2h = sprite.m_texture.get_H();
        
        if((box2.x >= box1.x + box1w) || (box2.x + box2w <= box1.x) || (box2.y >= box1.y + box1h) || (box2.y + box2h <= box1.y))
                return false; 
        else
            return true; 
}
	public int get_outline_radius(){
	    return m_outline_radius;
	}
    public Color get_outline_color(){
	    return m_outline_color;
	}
	public void set_angle(int angle){
	    m_angle = angle;
	}
	public int get_angle(){
	    return m_angle;
	}
	public void rotate(int degree){
	    m_angle = m_angle + degree;
	}
	
	protected int m_angle = 0;
	protected Color m_outline_color;
	protected int m_radius;
	protected uchar m_RED;
	protected uchar m_GREEN;
	protected uchar m_BLUE;
	protected uchar m_ALPHA;
	protected IS_DRAWABLE m_whats_is;
	protected Vector2i m_size;
	protected Vector2f m_pos;
	protected SDL.Video.Texture m_texture_sdl;
	protected Texture m_texture;
	protected int m_outline_radius = 0;
}


public class Circle : Drawable{
	public Circle(int radius = 5, Vector2f  position = {0,0}){
		m_radius = radius;
		m_pos = position;
		m_whats_is = CIRCLE;
		m_ALPHA = 255;
		m_RED = 255;
		m_BLUE = 255;
		m_GREEN = 255;
		m_radius = 45;
	}
	public void set_color(Color color){
	    m_ALPHA = (uchar)color.a;
		m_RED = (uchar)color.r;
		m_GREEN = (uchar)color.g;
		m_BLUE = (uchar)color.b;
	}
	public void set_radius(int radius){
	    m_radius = radius;
	}
	public void set_outline_radius(int radius){
	    m_outline_radius = radius;
	}
	public void set_outline_color(Color color){
	    m_outline_color = color;
	}
}

public struct Color{
    uchar r;
    uchar g;
    uchar b;
    uchar a;
}
public Color rgba(int r = 255,int g = 255, int b = 255, int a = 255){
    var c = new Color();
    c.r = (uchar)r;
    c.g = (uchar)g;
    c.b = (uchar)b;
    c.a = (uchar)a;
    return c;
}
