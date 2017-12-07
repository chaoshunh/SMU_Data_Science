public class Controller 
{
	Pizza p;


	public Controller()
	{

	}

	public Controller(Pizza p)
	{
		this.p = p;
		System.out.println("woot");

	}

	public static void main(String args[])
	{
		Controller c = new Controller(new Pizza());
		System.out.println(args[0]);
	}
}