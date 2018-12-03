import java.util.Set;
import java.util.ArrayList;
import java.lang.Math;
import java.lang.StringBuilder;

public class Cache{

    public static final int ADDR_LEN = 16;

    public static int lineSize;
    public static int associativity;
    public static int numberSets;
    public static int cacheSize;
    public static Set[] sets;

    public Cache(int L, int K, int N){
        this.lineSize = L;
        this.associativity = K;
        this.numberSets = N;

        this.sets = new Set[numberSets];
        System.out.println("New cache object created");
    }

    public void takeInput(ArrayList<String> hexAddrList){

            for(int i=0; i<hexAddrList.size();i++){
                parseAddress(hexAddrList.get(i));
                System.out.println("");
            }
    }

    private void parseAddress(String hexAddr){
            int addr = Integer.parseInt(hexAddr,16);
            System.out.print("Address hex = " + hexAddr);

            //Find binary string with leading 0s
            String addrBin = String.format("%16s",Integer.toBinaryString(addr)).replace(' ','0');
        //    System.out.print("  Address Binary= "+ addrBin);

            //Offset = 4 MSB
            String offSetStr = addrBin.substring(ADDR_LEN-4,ADDR_LEN);
    //        System.out.print("  Offset Binary  = " + offSetStr);
            int offSet = Integer.parseInt(offSetStr,2);

            System.out.print("  Offset = " + offSet);

            //From now on it is easier to work with reversed string
            addrBin = new StringBuilder(addrBin).reverse().toString();
        //    System.out.print("  Reversed address =" + addrBin);

            int numDigits = (int) (Math.log(numberSets)/Math.log(2)) ;
            int setNum = selectSet(numDigits, addrBin.substring(4));


            //Finding tag by cutting off first n+4 digits
            String tagBin = addrBin.substring(numDigits+4);
            System.out.print("  Tag= " + tagBin);

        }
    /*
        Takes in a string of the binary rep of the reversed address without the offSet
        and number of digits required to find set nunber.
        i.e **** 0100 0000 1010 ,where **** has been removed
        Set is selected by finding the first log2(n) digits and converting to dec
    */

    private int selectSet(int numDigits,String binaryAddress){

        String setString = binaryAddress.substring(0, numDigits);
        //Reverse
        setString = new StringBuilder(setString).reverse().toString();
    //    System.out.print("  Set Bin = " + setString);
        int setNumber = Integer.parseInt(setString,2);
        System.out.print("  Set = " + setNumber);

        return setNumber;
    }

}
