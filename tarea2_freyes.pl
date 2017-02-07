#!perl
use warnings;
use strict;
use 5.014;
=head1 TAREA 2
=head2 Coincidencias
=item
Programa que cuenta el numero total de:
	- Dominios
	- IPs
	- Correos
	- URLs
Del un archivo que se llama datos.txt
=cut
my $archivoentrada = $ARGV[0];
my @dominios;
my @ips;
my @correos;
my @urls;

my $totaldominios;
my $totalips;
my $totalcorreos;
my $totalurls;

=item
Recibimos por parametro el archivo que contiene los datos.
Generamos un archivo en el que guarde el resultado de la busqueda de nuestra 
expresion regular.
=cut

if (not defined $archivoentrada){ die "Necesita especificar el nombre de archivo"};
open(FCG,"<",$archivoentrada) or die "Error al abrir el archivo \n";
open(F1,">","dominios.txt") or die "No se puede crear\n";
open(F2,">","ips.txt") or die "No se puede crear\n";
open(F3,">","correos.txt") or die "No se puede crear\n";
open(F4,">","url.txt") or die "No se puede crear\n";

while(<FCG>)
{
	chomp;
	if(/^([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}$/)
	{
		push(@dominios,$1);
		print F1 $1,"\n"
	}
	if(/\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/)
	{
		push(@ips,$_);
		print F2 $_,"\n"
	}
	if(/^[_a-z0-9-]+(.[_a-z0-9-]+)*@[a-z0-9-]+(.[a-z0-9-]+)*(.[a-z]{2,4})$/ )
	{
		push(@correos,$1);
		print F3 $_,"\n"
	}
	if(/(https?:\/\/[^\s]*\/)/)
	{
		push(@urls,$1);
		print F4 $1,"\n"
	}
}

=item
Al final imprimimos el total de los resultados que coinciden con nuestra busqueda
=cut

$totaldominios=@dominios;
$totalips=@ips;
$totalcorreos=@correos;
$totalurls=@urls;
print "\nTotal de Dominios: ",$totaldominios;
print "\nTotal de IPs: ", $totalips;
print "\nTotal de Correos: ", $totalcorreos;
print "\nTotal de URLs: ", $totalurls;
print "\n";
close(FCG); 
close(FO);
