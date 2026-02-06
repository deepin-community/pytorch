Implement pytorch Debhelper sequence for automatically filling the
dependency fields for the reverse dependencies, so that any variant of
pytorch could satisfy the dependency of python3-torch.
In particular, we insert "python3-torch | python3-torch-api-2.0" to the
python3:Depends field for the reverse dependencies. And we make all
pytorch variants, including but not limited to the cpu and cuda variants,
Provides: python3-torch-api-2.0 virtual package.
So that a reverse dependency built on top of python3-torch could work
with python3-torch-cuda without the maintainers to manually filling in
the alternatives in their Depends: field.

+ New debhelper sequence file debian/dh_pytorch

+ New debhelper sequence file debian/pytorch.pm
