package principal;

public class Mensajes
{
	private static boolean mostrarMensaje = false;
	
	public static void encender()
	{
		mostrarMensaje = true;
	}
	
	public static void apagar()
	{
		mostrarMensaje = false;
	}
	
	public void imprimir(String texto)
	{
		if(mostrarMensaje)
		{
			System.out.println(texto);
		}
	}
}
