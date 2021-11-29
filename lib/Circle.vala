using Bg;
namespace Bg{

	public class Circle : Drawable{
		public Circle(int radius = 5, Vector2f  position = {0,0}){
			m_radius = radius;
			m_pos = position;
			m_whats_is = CIRCLE;
			m_radius = 45;
			m_color = {255,255,255,255};
		}
		public void set_color(Color color){
			m_color = color;
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
}
