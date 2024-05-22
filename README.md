# Rocky Linux 9 RPM Build Environment

This container allows you to use your existing RPM build folders but build within the Rocky Linux 9 environment.

The container has:

* EPEL
* Common build packages

## Setup

You'll need to create your standard RPM build directory structure as follows:

```
rpmbuild
  - BUILD
  - BUILDROOT
  - RPMS
  - SOURCES
  - SPECS
  - SRPMS
  - tmp
```

Of course put your spec files in SPECS and your source files in SOURCES.

## Usage

If you want to build just one spec in particular:

```bash
docker run \
  --name rpmbuild-rocky9 \
  -v /path/to/your/rpmbuild:/home/rpmbuilder/rpmbuild \
  --rm=true \
  jc21/rpmbuild-rocky9 \
  /bin/build-spec /home/rpmbuilder/rpmbuild/SPECS/something.spec
```

Or if you want to build all specs in your SPECS folder:

```bash
docker run \
  --name rpmbuild-rocky9 \
  -v /path/to/your/rpmbuild:/home/rpmbuilder/rpmbuild \
  --rm=true \
  jc21/rpmbuild-rocky9 \
  /bin/build-all
```

The build-spec script will go to the trouble of installing any requires that the spec file needs to build.

Built RPMS will show up in the RPMS/SRPMS folders if successful.

## Script it!

Here's an example of wrapping that stuff above in a script. Let's call it build.sh:

```bash
#!/bin/bash

SPEC=$1
RPMBUILDROOT=/path/to/your/rpmbuild

if [ "$1" == "" ]; then
  echo "Usage: build.sh specfile.spec"
  exit 1;
else
  docker run \
    --name rpmbuild-rocky9 \
    -v $RPMBUILDROOT:/home/rpmbuilder/rpmbuild \
    --rm=true \
    jc21/rpmbuild-rocky9 \
    /bin/build-spec /home/rpmbuilder/rpmbuild/SPECS/$SPEC

  exit $?
fi
```

Then to run it:

```bash
./build.sh something.spec
```
