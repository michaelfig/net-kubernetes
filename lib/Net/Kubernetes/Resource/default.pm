package Net::Kubernetes::Resource::default;
# ABSTRACT: Object representatioon of a Kubernetes default resource

use Moose;


extends 'Net::Kubernetes::Resource';

with 'Net::Kubernetes::Resource::Role::State';
with 'Net::Kubernetes::Resource::Role::Spec';

return 42;
