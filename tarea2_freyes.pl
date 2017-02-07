#!perl
use warnings;
use strict;
use 5.014;
=head1 TAREA 2
=head2 Coincidencias
=item
 Busca coincidencias de el archivo datos.txt y las arroja en el
 archivo url.txt, lo genera :D
=cut

my @tmp;

my @dominios;
my @ips;
my @correos;
my @urls;

my $total;

my $totaldominios;
my $totalips;
my $totalcorreos;
my $totalurls;

=item
 Abrimos los archivos para lectura y escritura,
 FCG abre como lectura el archivo datos.txt
 FO abre un archivo como escritura llamado "url.txt"
  si no existe lo generara.
=cut

open(FCG,"<","datos.txt") or die "No se puede abrir el archivo\n";
open(FO,">","salida.txt") or die "No se puede crear\n";
open(F1,">","dominios.txt") or die "No se puede crear\n";
open(F2,">","ips.txt") or die "No se puede crear\n";
open(F3,">","correos.txt") or die "No se puede crear\n";
open(F4,">","url.txt") or die "No se puede crear\n";

while(<FCG>)
{
	chomp;
	if(/(https?:\/\/[^\s]*\/)/)
	{
		push(@tmp,$1);
		#print $1,"\n";
    		print FO $1,"\n"
  	}
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
	if(/^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \?=.-]*)*\/?$/  )
	{
		push(@urls,$1);
		print F4 $_,"\n"
	}
}
$total=@tmp;
$totaldominios=@dominios;
$totalips=@ips;
$totalcorreos=@correos;
$totalurls=@urls;
print "\nTotal de URLs: ",$total;
print "\nTotal de Dominios: ",$totaldominios;
print "\nTotal de IPs: ", $totalips;
print "\nTotal de Correos: ", $totalcorreos;
print "\nTotal de URLs: ", $totalurls;
print "\n";
close(FCG); 
close(FO);
