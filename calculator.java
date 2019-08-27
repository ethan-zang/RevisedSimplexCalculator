import com.mathworks.engine.MatlabEngine;

//To compile: javac -classpath /Applications/MATLAB_R2017a.app/extern/engines/java/jar/engine.jar calculator.java
//To run: java -Djava.library.path=/Applications/MATLAB_R2017a.app/bin/maci64 -classpath .:/Applications/MATLAB_R2017a.app/extern/engines/java/jar/engine.jar calculator

public class calculator {
	public static void main(String[] args) throws Exception {
		int[][] a = {{2, -1, 3}, {1, 3, 5}, {2, 0, 1}};
		int[][] b = {{6}, {10}, {7}};
		int[][] c = {{2}, {1}, {3}};

		MatlabEngine eng = MatlabEngine.startMatlab();

		Object[] results = eng.feval(3,"main",a,b,c);

		double optVal = (double)results[0];
		double[][] basis = results[1];
		double[][] basicVars = results[2];

		System.out.println(optVal);
		
		for (int i = 0; i < basis.length; i++)	{
			for (int j = 0; j < basis[0].length; j++)	{
				System.out.println(basis[i][j]);
			}
		}
		
		for (int i = 0; i < basicVars.length; i++)	{
			for (int j = 0; j < basicVars[0].length; j++)	{
				System.out.println(basicVars[i][j]);
			}
		}

		eng.close();
	}
}