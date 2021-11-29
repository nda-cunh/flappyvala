using Bg;
namespace Bg{

	public enum IS_DRAWABLE{
		RECTANGLE, SPRITE, CIRCLE
	}

	public class Drawable{
		public Drawable(){

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
		        int width = m_rect.w;
		        int height = m_rect.h;
			    
		        if (point.x >= m_pos.x && point.x < m_pos.x + width && point.y >= m_pos.y && point.y < m_pos.y + height)
			        return true;
		        else
			        return false;
	        }
	        return false;
        }
        
        public bool collision_rect(Sprite sprite)
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
		public Texture get_surface(){
			return m_texture;
		}
		public void set_render(SDL.Video.Renderer render){
			m_texture_sdl = SDL.Video.Texture.create_from_surface (render, m_texture.get_image());
		}
		public Color get_color(){
			return m_color;
		}
		public int get_radius(){
			return m_radius;
		}
		public int get_outline_radius(){
			return m_outline_radius;
		}
		public Color get_outline_color(){
			return m_outline_color;
		}
		public void rotate(int degree){
			m_angle = m_angle + degree;
		}
		public Rect get_rect(){
			return m_rect;
		}
		public void set_rect(Rect rect){
			m_rect = rect;
		}
        public int get_m_angle(){
            return m_angle;
        }

        public int get_angle(){
            return m_angle;
        }
        public void set_angle(int angle){
            m_angle = angle;
        }

		protected int m_angle = 0;
		protected Color m_outline_color;
		protected int m_radius;
		protected Color m_color;
		protected IS_DRAWABLE m_whats_is;
		protected Vector2i m_size;
		protected Vector2f m_pos;
		protected SDL.Video.Texture m_texture_sdl;
		protected Texture m_texture;
		protected int m_outline_radius = 0;
		protected Rect m_rect;
	}
}
