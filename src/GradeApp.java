
public class GradeApp {

	public static void main(String[] args) {
		// read in 3 command line arguments
		// the program expects 3 command line arguments
		if(args.length < 3) {
			System.err.println("\n **USAGE\n\tyou need to pass in 3 grades to run this program\n");
			System.err.println("\tIf you are using Make the command is:\n\t make grade x=# y=# z=#\n");
			System.exit(1);
		}
		
		// Note the data types of these values!
		String grade1 = args[0];
		String grade2 = args[1];
		String grade3 = args[2];
		
		System.out.printf("Current Grade: \n",convertFromStringToDouble(grade1),
				convertFromStringToDouble(grade2),
				convertFromStringToDouble(grade3));
	}
	
	/**
	 * convert a string to a double
	 * @param s the string to convert
	 * @return the double that represents the string
	 * 
	 * @throws error if the string can not be parsed into a double
	 */
	public static double convertFromStringToDouble(String s) {
		return Double.parseDouble(s);
	}

}
