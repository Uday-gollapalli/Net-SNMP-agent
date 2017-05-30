#!/usr/bin/perl

use NetSNMP::agent;
use NetSNMP::ASN;
use Time::Local;
$filelocation='/home/prafull/Desktop/ANM1/counter.conf';
if (open(my $fh, '<', $filelocation)) {
my $i=0;  
while (my $row = <$fh>) {
    chomp $row;
	$info[$i]=$row;
	$i++;
  }
} 
sub handling_routine {
  my ($handler, $registration_info, $request_info, $requests) = @_;
  my $request;
  my $callTime = timelocal(localtime); 	
  for($request = $requests; $request; $request = $request->next()) {
    my $oid = $request->getOID();
	my @element = $oid->to_array();
	my $end = $element[8];
    if ($request_info->getMode() == MODE_GET) {
	if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.1")) {
        $request->setValue(ASN_COUNTER, "$callTime");
      }      
	$num=@info+1;
	if(($end>1) && ($end<=$num)){	
	@arg=split /,/,$info[$end-2];
	
	my $value= int($callTime*$arg[1]);
	if ($oid == new NetSNMP::OID(".1.3.6.1.4.1.4171.40.$end")) {
        $request->setValue(ASN_COUNTER, "$value");
      }
}
      
      
    } 
  }
}

my $agent = new NetSNMP::agent();
$agent->register("Prafull", ".1.3.6.1.4.1.4171.40",
                 \&handling_routine);
