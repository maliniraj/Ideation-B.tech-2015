package utility;

public abstract class Misc {
	 public static String Encrypt(String s) {
	        String s1="";
	        for(int i=0;i<s.length();i++)
	        {
	            s1+=(char)((float)s.charAt(i)+i%4);
	        }
	        return s1;
	    }

	    public static String Decrypt(String s) {
	        String s1="";
	        for(int i=0;i<s.length();i++)
	        {
	            s1+=(char)((float)s.charAt(i)-i%4);
	        }
	        return s1;
	    }
}
