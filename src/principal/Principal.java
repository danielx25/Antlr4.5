package principal;

import gramatica.Sim2DLexer;
import gramatica.Sim2DParser;

import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;

public class Principal
{
	public static void main(String[] args) throws IOException
	{
		System.out.println("Analisis lexico y aaaaaaaaaaaasintactico");
		
		//ANTLRInputStream archivoEntrada = new ANTLRInputStream("objeto casa{} funcion orbita(velocidad){} regla casa {}");
		ANTLRInputStream archivoEntrada =new ANTLRFileStream("/home/carlos/Documentos/Colegio/2015/Teoría de autómata y lenguajes formales/Proyecto/Sim 2D/test/perro_y_gato.sm2d");
		Sim2DLexer lexico = new Sim2DLexer(archivoEntrada);
		CommonTokenStream simbolos = new CommonTokenStream(lexico);
		Sim2DParser analisisSintactico = new Sim2DParser(simbolos);

		ParseTree arbol = analisisSintactico.archivo();//Inicia el analisis
		System.out.println("Arbol: "+arbol.toStringTree(analisisSintactico));
		System.out.println("Analisis Finalizado");
	}
}
