import java.util.Scanner;
import java.util.ArrayList;
import java.io.File;
import java.io.FileNotFoundException;

public class testCache{

    public static void main(String[] args) throws FileNotFoundException{


            Cache cache = new Cache(16,1,8);

            File f = new File("addrList.txt");
            Scanner s = new Scanner(f);
            ArrayList<String> addrList = new ArrayList<String>();
            String hexAddress;

            while(s.hasNextLine()){

                hexAddress=s.nextLine();
            //    System.out.println("Address= " + hexAddress);
                addrList.add(hexAddress);
            }
            s.close();
            System.out.println("Address List Created");
            cache.takeInput(addrList);

    }
}
