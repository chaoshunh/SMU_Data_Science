public class Pizza
{
	// fields
	private String[] toppings;
	private float diameter;
	private float price;

	// required to name file exact same name as the class	
	public Pizza()
	{
		System.out.println("Sup bros? Wanna lift?");
	}
	
	// static designates fields and methods that are unique copies
	// every single object the class has exact same value
	
    public Pizza(String[] toppings, float diameter, float price)
	{
		System.out.println("in overloaded cstr");
	}
	
	// methods

	
	
	// getters and setters
	
	public void setPrice(float price)
	{
		if(price > 0 && price < 50)
		{
		this.price = price;
		}
	}
	
	
	public float getPrice()
	{
		return price;
	}
	
	// dont need to worry about where things are declared
	// C has a very distinct order
	public static void main(String[] args)
	{
		Pizza p = new Pizza(); // heap memory
		// p doesnt live beyond main, but control passes to Pizza() constructor
		// do not really need p in this case, because control passes to Pizza()
	}

}

// pizza.java and pizza.class can be read through java development environment
// through JVM, class is bytecode that gets translated by JVM to machine code