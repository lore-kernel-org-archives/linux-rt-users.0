From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2] rt-tests: NUMA optional for make rpm
Date: Fri, 15 Feb 2013 14:56:31 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1302151455230.13838@tycho>
References: <511966B6.8080008@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>, jkacur@redhat.com,
	sven@thebigcorporation.com, linux-rt-users@vger.kernel.org
To: Frank Rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:37950 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752893Ab3BON4q (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 15 Feb 2013 08:56:46 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so3032562wey.28
        for <linux-rt-users@vger.kernel.org>; Fri, 15 Feb 2013 05:56:45 -0800 (PST)
In-Reply-To: <511966B6.8080008@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 11 Feb 2013, Frank Rowand wrote:

> 
> version 2:
>   - Add new placeholders in rt-tests.spec-in to make the replacements by
>     "make rpm" more visible to future maintainers of rt-tests.spec-in
>   - fix typo of my name in rt-tests.spec-in
> 
> rt-tests can be built without NUMA:
> 
>    make NUMA=0
> 
> But "make rpm" does not have a way to be successful without NUMA:
> 
>    build_rt-tests_0.85> make rpm
>    for F in cyclictest signaltest pi_stress rt-migrate-test ptsematest sigwaittest svsematest pmqtest sendme pip_stress hackbench *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a  ChangeLog; do find -type f -name $F | xargs rm -f; done
>    rm -f hwlatdetect
>    rm -f tags
>    rm -rf BUILD BUILDROOT RPMS SRPMS SPECS releases *.tar.gz rt-tests.spec tmp
>    git log >ChangeLog
>    mkdir -p releases
>    mkdir -p tmp/rt-tests
>    cp -r Makefile COPYING ChangeLog src tmp/rt-tests
>    tar -C tmp -czf rt-tests-0.85.tar.gz rt-tests
>    rm -f ChangeLog
>    cp rt-tests-0.85.tar.gz releases
>    sed s/__VERSION__/0.85/ <rt-tests.spec-in >rt-tests.spec
>    rpmbuild -ba --define "_topdir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85" --define "_sourcedir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85/releases" --define "_builddir /a/home/frowand/me/src/rt-tests/build_rt-tests_0.85/BUILD"  rt-tests.spec
>    error: Failed build dependencies:
>            numactl-devel is needed by rt-tests-0.85-1.fc12.src
>    make: *** [rpm] Error 1
> 
> 
> The following patch allows the rpm to be built without NUMA, with the command:
> 
>    make NUMA=0 rpm
> 
> 
> Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>
> 
> ---
>  Makefile         |    8 	8 +	0 -	0 !
>  rt-tests.spec-in |    9 	6 +	3 -	0 !
>  2 files changed, 14 insertions(+), 3 deletions(-)
> 
> Index: b/Makefile
> ===================================================================
> --- a/Makefile
> +++ b/Makefile
> @@ -161,6 +161,14 @@ pushtest: release
>  
>  rt-tests.spec: Makefile rt-tests.spec-in
>  	sed s/__VERSION__/$(VERSION_STRING)/ <$@-in >$@
> +ifeq ($(NUMA),1)
> +	sed -i -e 's/__MAKE_NUMA__/NUMA=1/' $@
> +	sed -i -e 's/__BUILDREQUIRES_NUMA__/numactl-devel/' $@
> +else
> +	sed -i -e 's/__MAKE_NUMA__//' $@
> +	sed -i -e 's/__BUILDREQUIRES_NUMA__//' $@
> +endif
> +
>  
>  HERE	:=	$(shell pwd)
>  RPMARGS	:=	--define "_topdir $(HERE)" 	\
> Index: b/rt-tests.spec-in
> ===================================================================
> --- a/rt-tests.spec-in
> +++ b/rt-tests.spec-in
> @@ -2,6 +2,7 @@
>  
>  Summary: Programs that test various rt-features
>  Name: rt-tests
> +# __VERSION__ will be replaced by "make rpm"
>  Version: __VERSION__
>  Release: 1%{?dist}
>  License: GPLv2
> @@ -10,7 +11,8 @@ URL: git://git.kernel.org/pub/scm/linux/
>  Source0: %{name}-%{version}.tar.gz
>  BuildRoot: %{_tmppath}/%{name}-%{version}-%{release}-root
>  Obsoletes: cyclictest signaltest pi_tests
> -BuildRequires: numactl-devel python
> +# __BUILDREQUIRES__ will be replaced by "make rpm"
> +BuildRequires: __BUILDREQUIRES_NUMA__ python
>  
>  %description
>  rt-tests is a set of programs that test and measure various components of
> @@ -21,7 +23,8 @@ latency. It also tests the functioning o
>  %setup -qn rt-tests
>  
>  %build
> -make NUMA=1
> +# __MAKE_NUMA__ will be replaced by "make rpm"
> +make __MAKE_NUMA__
>  
>  %install
>  rm -rf $RPM_BUILD_ROOT
> @@ -64,7 +67,7 @@ rm -rf $RPM_BUILD_ROOT
>  %changelog
>  * Tue Nov 13 2012 Clark Williams <williams@redhat.com> - 0.85-1
>  - [cyclictest] add tracemark function back to breaktrace logic
> -- from Frank Rowland <frank.rowand@am.sony.com>:
> +- from Frank Rowand <frank.rowand@am.sony.com>:
>    - [cyclictest] report large measured clock latency
>    - [cyclictest] cleanup getopt_long() parameters
>  - from John Kacur <jkacur@redhat.com>:
> 

Thanks Frank, I added this to my queue, will push to Clark for the next 
build.

John
