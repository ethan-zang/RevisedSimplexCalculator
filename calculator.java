import com.mathworks.engine.MatlabEngine;

//To compile: javac -classpath /Applications/MATLAB_R2017a.app/extern/engines/java/jar/engine.jar calculator.java
//To run: java -Djava.library.path=/Applications/MATLAB_R2017a.app/bin/maci64 -classpath .:/Applications/MATLAB_R2017a.app/extern/engines/java/jar/engine.jar calculator

public class calculator {
	public static void main(String[] args) throws Exception {
		//Temporarily defining the parameters of the problem to link to MATLAB
		double[][] a = {{2, -1, 3}, {1, 3, 5}, {2, 0, 1}};
		double[][] b = {{6}, {10}, {7}};
		double[][] c = {{2}, {1}, {3}};

		MatlabEngine eng = MatlabEngine.startMatlab();

		//Calling MATLAB main.m function using above parameters
		Object[] results = eng.feval(3,"main",a,b,c);

		double optVal = (double)results[0];
		//double[][] basis = results[1];
		//double[][] basicVars = results[2];

		System.out.println(optVal);

		eng.close();
	}
}