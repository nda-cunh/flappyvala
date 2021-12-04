using Bg;
namespace Bg{

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
				Color c2 = drawer.get_color();

				SDLGraphics.Circle.fill_rgba(m_render,x, y, r, c2.r, c2.g, c2.b, c2.a);
				for(int16 i = 0; i!= drawer.get_outline_radius(); i++)
				{
					SDLGraphics.Circle.outline_rgba(m_render, x, y, r + i, c.r, c.g, c.b, c.a);
				}


			}
			else if(drawer.get_whatsIs() == SPRITE){
				drawer.set_render(m_render);
				Texture text_tmp = drawer.get_surface();
				Rect rect = drawer.get_rect();
				Vector2i pos = {(int) drawer.get_position().x, (int) drawer.get_position().y};
				if(rect.w == -1){
				    drawer.set_rect({0, 0, text_tmp.get_W(), text_tmp.get_H()});
				    rect = drawer.get_rect();
				}
				m_render.copyex(drawer.get_texture(), {rect.x, rect.y, rect.w, rect.h}, {pos.x, pos.y, rect.w * drawer.get_scale().x ,rect.h * drawer.get_scale().y}, drawer.get_angle(), {text_tmp.get_W()/2,text_tmp.get_H()/2}, SDL.Video.RendererFlip.NONE);

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
			m_fps_limit = (int32)fps;
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
		    if(m_fps_limit != -1)
			    fps_loop();
			m_render.present();
			m_win.update_surface();
		}
		public SDL.Video.Renderer *get_render(){
			return m_render;
		}
		private int32 m_fps_limit = 120;
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
}
