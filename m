From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest: avoid using libnuma cpumask parsing
 functions
Date: Tue, 19 Apr 2016 15:17:33 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1604191514540.9751@riemann>
References: <20160413153700.7a930369@sluggy.hsv.redhat.com> <20160414103018.3a07cf27@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160414103018.3a07cf27@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Thu, 14 Apr 2016, Luiz Capitulino wrote:

> On Wed, 13 Apr 2016 15:37:00 -0500
> Clark Williams <williams@redhat.com> wrote:
> 
> > John,
> > 
> > I ran into issues with parsing cpu masks when trying to run this command:
> > 
> > sudo ./cyclictest -i100 -qmu -h 2000 -p95 -t1 -a3
> > 
> > I had previously booted a 4-core system with these boot options:
> > 
> > 	isolcpus=3 nohz_full=3 rcu_nocbs=3
> > 
> > The intent was to run loads on cpus 0-2 while running cyclictest on the isolated cpu 3. 
> > 
> > Unfortunately, the libnuma function numa_parse_cpumask() (which we use when it's available) seems to check the current affinity mask and fails the parse if any of the cpus in the input string are not in the current affinity mask. I find this "unhelpful" when trying to place a measurement thread on an isolated cpu. 
> > 
> > This patch removes the wrapper function which uses libnuma cpumask parsing functions and instead uses the parser function we wrote for when libnuma is not available. 
> 
> There's an alternative solution that I was working on some time ago,
> which is having a simple configure script. This is usually done
> by simple projects that don't need a full blown autoconf machinery.
> 
> The patch below adds such a script. It detects librt, libpthread and
> libnuma. It solves the problem you mention and it removes hardcoded
> lib details from the Makefile.
> 
> If there's interest for this solution I can finish it and post for
> inclusion.

I find this interesting, maybe for the coming new devel system, I wouldn't 
want to stick it in now right before a stable release though. Also, I 
like this much better than full blown auto-tools, but I don't want to lose control over 
the compiling process either. In otherwords, there should be some way to 
override what the script detects.

Thanks

John

> 
> From 4228140e9dbb7fbb1bb495663ae3d896fc447f8f Mon Sep 17 00:00:00 2001
> From: Luiz Capitulino <lcapitulino@redhat.com>
> Date: Tue, 23 Feb 2016 15:53:43 -0500
> Subject: [PATCH] add configure script
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  .gitignore |   1 +
>  Makefile   |  22 ++----------
>  configure  | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 120 insertions(+), 19 deletions(-)
>  create mode 100755 configure
> 
> diff --git a/.gitignore b/.gitignore
> index ceee8bf..5b3e4cc 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -34,3 +34,4 @@ SRPMS
>  rt-tests.spec
>  tags
>  TAGS
> +config.mk
> diff --git a/Makefile b/Makefile
> index 280fd3b..dad0175 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,3 +1,5 @@
> +include config.mk
> +
>  VERSION = 0.97
>  CC?=$(CROSS_COMPILE)gcc
>  AR?=$(CROSS_COMPILE)ar
> @@ -17,7 +19,6 @@ sources = cyclictest.c \
>  	  svsematest.c
>  
>  TARGETS = $(sources:.c=)
> -LIBS	= -lrt -lpthread
>  RTTESTLIB = -lrttest -L$(OBJDIR)
>  EXTRA_LIBS ?= -ldl	# for get_cpu
>  DESTDIR	?=
> @@ -48,26 +49,9 @@ ostype := $(lastword $(subst -, ,$(dumpmachine)))
>  machinetype := $(shell echo $(dumpmachine)| \
>      sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
>  
> -# The default is to assume you have libnuma installed, which is fine to do
> -# even on non-numa machines. If you don't want to install the numa libs, for
> -# example, they might not be available in an embedded environment, then
> -# compile with
> -# make NUMA=0
> -ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
> -NUMA 	:= 1
> -endif
> -
> -# The default is to assume that you only have numa_parse_cpustring
> -# If you are sure you have a version of libnuma with numa_parse_cpustring_all
> -# then compile with
> -# make HAVE_PARSE_CPUSTRING_ALL=1
> -ifeq ($(NUMA),1)
> -	CFLAGS += -DNUMA
> -	NUMA_LIBS = -lnuma
>  ifdef HAVE_PARSE_CPUSTRING_ALL
>  	CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
>  endif
> -endif
>  
>  include src/arch/android/Makefile
>  
> @@ -100,7 +84,7 @@ $(OBJDIR):
>  -include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
>  
>  cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
>  signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> diff --git a/configure b/configure
> new file mode 100755
> index 0000000..1d17ef9
> --- /dev/null
> +++ b/configure
> @@ -0,0 +1,116 @@
> +#!/bin/sh
> +
> +build_config=config.mk
> +temp_dir=$(mktemp -d)
> +temp_file=$temp_dir/file.c
> +
> +LIBS=
> +NUMA_LIBS=
> +EXTRA_CFLAGS=
> +has_numa=n
> +has_numa_cpustring_all=n
> +
> +build_test()
> +{
> +	local libs=$*
> +	local ret=
> +
> +	cd $temp_dir
> +	cc -o prog $temp_file $libs 2> /dev/null
> +	ret=$?
> +	cd - > /dev/null
> +	return $ret
> +}
> +
> +#
> +# -lpthread
> +#
> +pthread_lib=-lpthread
> +
> +cat > $temp_file << EOF
> +#include <pthread.h>
> +static void *func(void *p) { return NULL; }
> +int main(void) {
> +	pthread_t thread;
> +	pthread_create(&thread, 0, func, 0);
> +	return 0;
> +}
> +EOF
> +
> +if ! build_test $pthread_lib; then
> +	echo ERROR: missing pthread library
> +	exit 1
> +else
> +	LIBS="$LIBS $pthread_lib"
> +fi
> +
> +#
> +# -lrt
> +#
> +rt_lib=-lrt
> +
> +cat > $temp_file << EOF
> +#include <sys/mman.h>
> +#include <sys/stat.h>
> +#include <fcntl.h>
> +int main(void) {
> +	shm_open("", 0, 0);
> +	return 0;
> +}
> +EOF
> +
> +if ! build_test $rt_lib; then
> +	echo ERROR: missing rt library
> +	exit 1
> +else
> +	LIBS="$LIBS $rt_lib"
> +fi
> +
> +#
> +# -lnuma
> +#
> +numa_lib=-lnuma
> +
> +cat > $temp_file << EOF
> +#include <numa.h>
> +int main(void) {
> +	numa_available();
> +	return 0;
> +}
> +EOF
> +
> +if build_test $numa_lib; then
> +	LIBS="$LIBS $numa_lib"
> +	EXTRA_CFLAGS="$EXTRA_CFLAGS -DNUMA"
> +	has_numa=y
> +fi
> +
> +#
> +# numa_parse_cpustring_all
> +#
> +if [ $has_numa = "y" ]; then
> +
> +	cat > $temp_file << EOF
> +#include <numa.h>
> +int main(void) {
> +	numa_parse_cpustring_all("");
> +	return 0;
> +}
> +EOF
> +
> +	if build_test $numa_lib; then
> +		has_numa_cpustring_all=y;
> +	fi
> +fi
> +
> +#
> +# Write $build_config
> +#
> +echo "LIBS = $LIBS" > $build_config
> +echo "EXTRA_CFLAGS = $EXTRA_CFLAGS" >> $build_config
> +
> +if [ "$has_numa_cpustring_all" = "y" ]; then
> +	echo "HAVE_PARSE_CPUSTRING_ALL := 1" >> $build_config
> +fi
> +
> +rm -rf $temp_dir
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
