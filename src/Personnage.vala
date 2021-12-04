using Bg;
class Personnage : Object {
    public Personnage () {
        this.init_object();
        
        if(m_t[0].set_texture(IMAGE_DIR + "flappy1.bmp")){
            m_t[0].set_texture("data/flappy1.bmp");
        }
        if(m_t[1].set_texture(IMAGE_DIR + "flappy2.bmp")){
            m_t[1].set_texture("data/flappy2.bmp");
        }
        if(m_t[2].set_texture(IMAGE_DIR + "flappy3.bmp")){
            m_t[2].set_texture("data/flappy3.bmp");
        }
        this.init();
        
    }
    private void init_object(){
        m_t[0] = new Texture();
        m_t[1] = new Texture();
        m_t[2] = new Texture();
        a_gravity = new Bg.Animate(30);
        a_sprite = new Animate(250);
        m_sprite = new Sprite(m_t[0]);
    }
    public void init(){
        m_sprite.set_position({150,250});
        is_dead = false;
        is_playing = false;
        m_sprite.set_angle(0);
    }
    public void draw(ref Window win){
        this.animate();
        win.draw(m_sprite);
        
    }
    public void saute(){
        if(is_dead)
            return;
        if(is_playing == false)
            is_playing = true; 
        m_vitesse = -9;
    }
    protected void animate(){
        if(!is_playing == false)
            gravity();
        if(is_dead == true)
            return;
        if(a_sprite.animate())
        {
            n_texture++;
            if(n_texture == 3)
                n_texture = 0;
            m_sprite.set_texture(m_t[n_texture]);
        }
    }
    protected void gravity(){
        if(m_sprite.get_position().y >= 510)
                return;

        if(a_gravity.animate())
        {
            m_sprite.move({0,m_vitesse});
            if(m_vitesse != 12)
                m_vitesse = m_vitesse + 1;
            m_sprite.set_angle(m_vitesse*7 -20);
        }
        
    }
    public Sprite get_sprite(){
        return m_sprite;
    }
    public void kill(){
        is_dead = true;
    }
    private int m_vitesse = 0;
    private Animate a_gravity;
    private Animate a_sprite;
    private int n_texture;
    private Texture m_t[3];
    private Sprite m_sprite;
    private bool is_playing = false;
    private bool is_dead;
}
