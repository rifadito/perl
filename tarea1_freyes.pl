#!perl
=head1 Descripcion POD de mi programa
Este programa es el famoso reto de FizzBuzz el cual consiste en:
Dado una n = [1,30] se debe imprimir linea a linea, intercambiando los 
multiplos de 3 por la palabra Fizz, y los de 5 por Buzz; cuando sea
multiplo de ambos, debe imprimirse FIzzBuzz.

=head2 PRAGMA
	Por lo que lei, entiendo que es una instruccion ya establecida que
	controlan a un compilador.
	En el caso de Perl son como las reglas que ya trae preestabecidas
	su compilador, para reducir codigo e informarnos de nuestros errores.
	
=cut
use strict;
use warnings;
my @arreglo=(1..50);
foreach (@arreglo)
{
	if (($_%3==0)&&($_%5==0)){
        print $_,"FizzBuzz\n";
	}
	if ($_%3==0){
	print $_,"Fizz\n";
	}
	if ($_%5==0){
        print $_,"Buzz\n";
	}
	else{
	print $_,"\n";
	}
}
