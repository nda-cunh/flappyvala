using Bg;
namespace Bg{
    public class Animate{
        public Animate(uint32 tick) {
            every_t = (uint32)tick;
        }
        public bool animate(){
            if(SDL.Timer.get_ticks() >= diff + every_t){
                diff = SDL.Timer.get_ticks();
                return true;
            }
            return false;
        }
        private uint32 every_t;
        private uint32 diff;
    }
}
