import com.mathworks.engine.MatlabEngine;

public class calculator {
	public static void main(String[] args) throws Exception {
		int[][] a = {{2, -1, 3}, {1, 3, 5}, {2, 0, 1}};
		int[][] b = {{6}, {10}, {7}};
		int[][] c = {{2}, {1}, {3}};

		MatlabEngine eng = MatlabEngine.startMatlab();

		Object[] results = eng.feval(3,"main");

		double optVal = (double)results[0];

		System.out.println(optVal);
		eng.close();
	}
}