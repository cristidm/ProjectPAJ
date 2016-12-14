import java.util.*;

public class Aplicatie {
    /* Aplicatie pentru cinematograf
     * 
     * Un cinematograf difuzeaza filme.
     * Un film este caracterizat de un titlu si o durata exprimata in minute.
     * Filmele se impart in 2 categorii: drama si animatie.
     * Drama are specificata varsta minima a telespectatorilor.
     * Cinematograful poate sa dubleze filmele sale. Orice film care este dublat
     * trebuie sa furnizeze o metoda de realizare a dublarii, prin specificarea
     * limbii in care se dubleaza.
     * 
     * Animatiile sunt dublate in limba romana.
     * 
     * Aplicatia va realiza urmatoarele operatii:
     * adaugare film
     * afisare filme
     * afisare filme dublate
     * cautare film
     * iesire din aplicatie
     * afisarea nr de filme cu ajutorul unui thread
     * 
     * Din consola vom putea da urmatoarele comenzi:
     * 
     * adaugare tip titlu durata varsta (adauga un film cu tipul mentionat in lista
     *                                  cinematografului)
       afisare (afiseaza toate filmele cu toate detaliile lor)
       afisareDublate (afiseaza doar filmele dublate)
       cautare titlu (cauta si afiseaza un film dupa titlul specificat)
       exit (iesire din aplicatie)
       */
    
    public static Scanner s = new Scanner(System.in);
    public static Cinematograf cinema = new Cinematograf();
    
    
    public static void main(String [] args) {
        String line = "";
        
        while(true) {
            line = s.nextLine();
            String[] v = line.split(" ");
            
            if("adauga".equals(v[0])) {
                Film f = null;
                String tip = v[1];
                String titlu = v[2];
                int durata = Integer.parseInt(v[3]);
                
                if("drama".equals(tip)) {
                    int varsta = Integer.parseInt(v[4]);
                    f = new Drama(titlu, durata, varsta);
                } else if("animatie".equals(tip)) {
                    f = new Animatie(titlu, durata);
                }
                cinema.adaugaFilm(f);
            }
            
            if("afisare".equals(v[0])) {
                cinema.afisare();
            }
            
            if("exit".equals(v[0])) {
                System.out.println("La revedere!");
                System.exit(0);
            }
            
            if("afisareDublate".equals(v[0])) {
                cinema.afisareDublate();
            }
            
            if("cautare".equals(v[0])) {
                Film f = cinema.cautare(v[1]);
                if(f == null) {
                    System.out.println("Film inexistent");
                }else {
                    System.out.println(f);
                }
            }
            
            new Thread(() -> {
                System.out.println(cinema.filme.size());
                try{
                    Thread.sleep(2000);
                }catch(Exception e){
                
                }
            }).start();
        }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }
      
      
      
      
      
      
      
      
      
      
      
      
}