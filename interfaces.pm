#!/usr/bin/perl
use strict;
package interfaces;
use Net::Ifconfig::Wrapper;
#use Data::Validate::IP;
use HTML::Template;
use parent 'CGI::Application';
use CGI::Application::Plugin::Forward;
sub setup{
	my $self=shift;
	$self->run_modes(
			'view' => 'showForm',
			'controler' => 'changeIP',
			'menu' => 'menu',
			'suma' => 'suma',
			'resta' => 'resta',
			'multi' => 'multi',
			'divi' => 'divi',
		);
		$self->start_mode('menu');
		$self->mode_param('selector');
}
sub showForm{
		my $output;
		my $template = HTML::Template->new(filename => './menu.tmpl');
		my $info=&inet_info;
		my @loop_data=();
		while(@{$info->[0]}){
				my %row_data;
				$row_data{iface}=shift @{$info->[0]};
				$row_data{inet}=shift @{$info->[1]};
				$row_data{netmask}=shift @{$info->[2]};
				push(@loop_data,\%row_data);
	
		}
		$template->param(interfaces => \@loop_data);
		$output.=$template->output();
		#print $output;
		return $output;
}
sub suma{
	my $self=shift;
	my $q=$self->query();
	my $a=$q->param('numero1');
	my $b=$q->param('numero2');
	return $a+$b;
}
sub resta{
	my $self=shift;
	my $q=$self->query();
	my $a=$q->param('numero1');
	my $b=$q->param('numero2');
	return $a-$b;
}
sub multi{
	my $self=shift;
	my $q=$self->query();
	my $a=$q->param('numero1');
	my $b=$q->param('numero2');
	return $a*$b;
}
sub divi{
	my $self=shift;
	my $q=$self->query();
	my $a=$q->param('numero1');
	my $b=$q->param('numero2');
	if ($b==0){
		printf "Indefinido";
	}
	else{
		return $a/$b;
	}
		
}
sub menu{
	my $output;
	my $template = HTML::Template->new(filename=>'./menu.tmpl');
	$output.=$template->output();
	return $output;
}

sub inet_info{
	my $list=&listIface();
	my @ip_address;
	my @netmask;
	my @interface_name = keys %$list;
	foreach my $iface(keys %$list){
		my @tmp=keys %{$list->{$iface}->{inet}},"\n"||" ";
		push(@ip_address,shift @tmp);
		@tmp=values %{$list->{$iface}->{inet}},"\n"||" ";
		push(@netmask,shift @tmp);
	}
	#while(@interface_name){
	#        print "\n",shift @interface_name;
	#        print "\n",shift @ip_address;
	#        print "\n",shift @netmask;
	#}
	my @info=(\@interface_name,\@ip_address,\@netmask);
	return \@info;
}
sub listIface{
	my $interfaces=Net::Ifconfig::Wrapper::Ifconfig('list','','','');
	return $interfaces;
}
