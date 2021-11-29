using Bg;
namespace Bg{

	public class Texture{
		public Texture(string file = "n"){
			if(file.data[0] == 'n'){
				return;
			}
			this.set_texture(file);

		}
		public bool set_texture(string file){
			m_surface = new SDL.Video.Surface.from_bmp(file);
			if(m_surface == null){
				m_surface = SDLImage.load(file);
				return false;
			}
			if(m_surface == null)
				print("Erreur texture format\n");
			return false;
		}
		public void set_color(Color c){
			m_surface.set_colormod(c.r ,c.g, c.b);
		}
		public Color get_color(){
			Color color = {};
			m_surface.get_colormod(out color.r, out color.g, out color.b);
			return color;
		}
		public void set_opacity(int alpha){
			m_surface.set_alphamod((uint8)alpha);
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
}
