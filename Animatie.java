public class Animatie extends Film implements Dublat {
    public Animatie(String titlu, int durata) {
        super(titlu, durata);
    }
    
    public String dubleaza() {
        return "limba romana";
    }
    
    public String toString() {
        return super.toString() + " / " + dubleaza();
    }
}