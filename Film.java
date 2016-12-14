public class Film {
    public String titlu;
    public int durata;
    
    public Film(String titlu, int durata) {
        this.titlu = titlu;
        this.durata = durata;
    }
    
    public String toString() {
        return titlu + " / " + durata;
    }
}