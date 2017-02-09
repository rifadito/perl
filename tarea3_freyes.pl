#!/usr/bin/perl
use strict;
use warnings;
use HTML::Template;

=pod

=head1 PRACTICA 3

=head2 Reyes Alberdo Fernado 

Programa que recibe como paramtro el archivo passwd, obtine sus datos
y los muestra en una plantilla html.

=cut

my $archivoentrada=$ARGV;
if (not defined $archivoentrada)
	{	
		die "ERROR Se necesita ingresa un archivo como parametro";
	}
open FH,'>',"pruebatarea.html" or die "Error";
        print FH &showForm();
close FH;

sub showForm{
	my $output; 
	my $template = HTML::Template->new(filename => './template.tmpl');
	my $info=&infoPasswd($_[0]);
	my @loop_data=();
	while(@{$info->[0]}){
		my %row_data;           
		$row_data{user}=shift @{$info->[0]};
		$row_data{pass}=shift @{$info->[1]};
		$row_data{uid}=shift @{$info->[2]};
		$row_data{gid}=shift @{$info->[3]};
		$row_data{desc}=shift @{$info->[4]};
		$row_data{home}=shift @{$info->[5]};
		$row_data{shell}=shift @{$info->[6]};
		push(@loop_data,\%row_data);
	  }           
	$template->param(hash2 => \@loop_data);
	$output.=$template->output();
	return $output;
}

sub infoPasswd{
	#my %hash;
	my @user=();
	my @pass=();
	my @uid=();
	my @gid=();
	my @desc=();
	my @home=();
	my @shell=();
	#open(FCG,"<",$archivoentrada) or die "Error al abrir el archivo \n";
	my $filename = $_[0];
	open FILE, "<",$filename;
	my @file=(<FILE>);
	for(@file){
		#my %hash;
		if(/(.*):(.*):(.*):(.*):(.*):(.*):(.*)/){
			push(@user,$1);
			push(@pass,$2);
			push(@uid,$3);
			push(@gid,$4);
			push(@desc,$5);
			push(@home,$6);
			#push(@shell,@temp[-1]);
			push(@shell,$7);
		}
	}
	my @info=(\@user,\@pass,\@uid,\@gid,\@desc,\@home,\@shell);
	return \@info;
}
close FILE;
