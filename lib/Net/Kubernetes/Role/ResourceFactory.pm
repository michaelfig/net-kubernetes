package Net::Kubernetes::Role::ResourceFactory;
# ABSTRACT: Role to allow easy construction of Net::Kubernetes::Resouce::* objects

use Moose::Role;
use MooseX::Aliases;
require Net::Kubernetes::Resource::Endpoint;
require Net::Kubernetes::Resource::Event;
require Net::Kubernetes::Resource::Node;
require Net::Kubernetes::Resource::Pod;
require Net::Kubernetes::Resource::ReplicationController;
require Net::Kubernetes::Resource::Secret;
require Net::Kubernetes::Resource::Service;
require Net::Kubernetes::Resource::ServiceAccount;
require Net::Kubernetes::Resource::default;

sub create_resource_object {
	my($self, $object, $kind) = @_;
	$kind ||= $object->{kind};
	$object->{kind} ||= $kind;
	my(%create_args) = %$object;
	$create_args{api_version} = $object->{apiVersion};
	$create_args{username} = $self->username if($self->username);
	$create_args{password} = $self->password if($self->password);
	$create_args{token} = $self->token if($self->token);
	$create_args{url} = $self->url;
	$create_args{base_path} = $object->{metadata}{selfLink};
	$create_args{ssl_cert_file} = $self->ssl_cert_file if($self->ssl_cert_file);
	$create_args{ssl_key_file} = $self->ssl_key_file if($self->ssl_key_file);
	$create_args{ssl_ca_file} = $self->ssl_ca_file if($self->ssl_ca_file);
	my $class = "Net::Kubernetes::Resource::".$kind;
	my $inc = $class;
	$inc =~ s!::!/!g;
	$class = "Net::Kubernetes::Resource::default" if (!$INC{"$inc.pm"});
	return $class->new(%create_args);
}


return 42;
