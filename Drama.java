public class Drama extends Film {
    public int varsta;
    
    public Drama(String titlu, int durata, int varsta){
        super(titlu, durata);
        this.varsta = varsta;
    }
    
    public String toString() {
        return super.toString() + " / " + varsta;
    }
}