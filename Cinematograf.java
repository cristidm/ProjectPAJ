import java.util.*;

public class Cinematograf {
    public ArrayList<Film> filme = new ArrayList<>();
    
    
    public void adaugaFilm(Film f) {
        filme.add(f);
    }
    
    public void afisare() {
        for(Film f : filme) {
            System.out.println(f);
        }
    }
    
    public void afisareDublate() {
        for(Film f : filme) {
            if(f instanceof Dublat) {
                System.out.println(f);
            }
        }
    }
    
    public Film cautare(String titlu) {
        Film filmCautat = null;
        for(Film f : filme) {
            if(f.titlu.equals(titlu)) {
                filmCautat = f;
            }
        }
        return filmCautat;
    }
    
    
    
}