using Bg;
namespace Bg{

	public class Sprite : Drawable{
		public Sprite(Texture texture){
			m_whats_is = SPRITE;
			m_texture = texture;
			m_size.x = 1;
			m_size.y = 1;
			if(m_texture.get_image() == null){
			    m_rect = {-1,-1, -1,-1};
			}
			else
                m_rect = {0,0, m_texture.get_W(), m_texture.get_H()};
		}
		public void set_texture(Texture texture){
			m_texture = texture;
			m_rect = {0,0, m_texture.get_W(), m_texture.get_H()};
		}
	}
}
