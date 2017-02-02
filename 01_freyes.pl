#!perl
use warnings; #Debuggear
use strict;
my @unoadiez=(1..10);
my @pares=();
foreach(@unoadiez)
	{
	if($_%2==0)
		{
			print "Par: ", $_;
			push @pares, $_;
		}
	}
	print "\n";
	
#Numerico 
# == != < > <= >=
#Cadenas
# eq ne lt gt le ge
