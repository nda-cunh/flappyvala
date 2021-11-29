using Bg;
class Tuyau{
    public Tuyau () {
        m_texture_tuyau = new Texture();
        m_texture_tuyauC = new Texture();
        
        m_sprite_tuyau1 = new Sprite(m_texture_tuyau);
        m_sprite_tuyau2 = new Sprite(m_texture_tuyau);
        m_sprite_chapeau1 = new Sprite(m_texture_tuyauC);
        m_sprite_chapeau2 = new Sprite(m_texture_tuyauC);
        
        
        
        if(m_texture_tuyauC.set_texture(IMAGE_DIR + "tuyauC.bmp")){
            m_texture_tuyauC.set_texture("data/tuyauC.bmp");
        }
        if(m_texture_tuyau.set_texture(IMAGE_DIR + "tuyau.bmp")){
            m_texture_tuyau.set_texture("data/tuyau.bmp");
        }
        this.tuyau_init();
    }
    protected void tuyau_init(){
        var rand = new Rand();
        int y = rand.int_range(220, 480);
        int diff = 145;//rand.int_range(140, 180);
        
        m_sprite_tuyau1.set_position({500,      y});
        m_sprite_tuyau2.set_position({500,      y - (500+diff)});
        
        m_sprite_chapeau1.set_position({500-4,  y - 18});
        m_sprite_chapeau2.set_position({500-4,  y- diff-1});
    }
    public void init(){
        this.tuyau_init();
        is_activate = false;
    }
    public void draw(ref Window win){
        win.draw(m_sprite_tuyau1);
        win.draw(m_sprite_tuyau2);
        win.draw(m_sprite_chapeau1);
        win.draw(m_sprite_chapeau2);
    }
    public void animate(){
        if(is_activate == false)
            return;
        if(m_sprite_tuyau1.get_position().x <= -80)
        {
            is_activate = false;
            this.tuyau_init();
        }
        m_sprite_tuyau1.move({-m_vitesse,0});
        m_sprite_tuyau2.move({-m_vitesse,0});
        m_sprite_chapeau1.move({-m_vitesse,0});
        m_sprite_chapeau2.move({-m_vitesse,0});
    }
    public void activate(){
        is_activate = true;
    }
    public bool is_collision(Sprite perso){
        if(perso.get_position().y >= 510)
        {
            return true;
        }
        if(perso.collision_rect(m_sprite_tuyau1))
            return true;
        if(perso.collision_rect(m_sprite_tuyau2))
            return true;
        if(perso.collision_rect(m_sprite_chapeau1))
            return true;
        if(perso.collision_rect(m_sprite_chapeau2))
            return true;
        return false;
    }
    private Texture m_texture_tuyau;
    private Texture m_texture_tuyauC;
    
    private Sprite m_sprite_tuyau1;
    private Sprite m_sprite_tuyau2;
    private Sprite m_sprite_chapeau1;
    private Sprite m_sprite_chapeau2;
    private bool is_activate = false;
    private double m_vitesse = 2;
}
