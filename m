Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088C26529A
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Oct 2025 13:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928881; cv=none; b=jKRUf5ALh1KSNEu/wFkyfWtZ7SuOlK++OJE1Pe9t7b8XCIP/uWJzVPzHEpR5XPDItbDey05oGm2j03usX26tjFqStn//hs5kBxitYVC8MAIueL2IBY7Me9dqckp/U1V0hceBSx/xcxRN+kcy2WobGDPj0hK6GvKk9DAwZLhoxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928881; c=relaxed/simple;
	bh=1yCjkLq7KqgbkGsbmEJ4fGgWtBJutX8yqCaWnT3FR8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bt6ic0G9pFav3o/KSHnS4cBs88F0NFeuwAjv4gdCOlJVteP1/WqBYmwqkogReDFiFe2EYwKjsO6phoO5kUruWxRuXAHaTXvNn5mXKZPJlOVNUw1jmvdl5JFxtVcOntu8LXY2RzO2IfFADL0q5LqEsHV80Jqv7Xuy6QAHhhIBf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EF8Fp5ao; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EF8Fp5ao"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759928878;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=yiEbPcLx/N5bZKyAlhImQok/v9y1DdTmvMKUm4kgHp8=;
	b=EF8Fp5aoqYF+uty6oOsrsUDV43YaX0WOC1sg0dhhB7HSXrIRjdjAz0ZvXmey9TJsfsGt1G
	hUzgzxbE0y80hfaw2JDT1wqQH5VH6YADe9zr/owCJNVdd6TR4adJ6OEG5uhvYEUjH8DsqU
	ezDN0vJHrQQI4yfw5Wk/ESpLj6dbyU4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-dF9bJOtjODmGm9p81QEX3Q-1; Wed,
 08 Oct 2025 09:07:55 -0400
X-MC-Unique: dF9bJOtjODmGm9p81QEX3Q-1
X-Mimecast-MFC-AGG-ID: dF9bJOtjODmGm9p81QEX3Q_1759928874
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E3B71800291;
	Wed,  8 Oct 2025 13:07:54 +0000 (UTC)
Received: from localhost (unknown [10.44.34.252])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5A8F61800446;
	Wed,  8 Oct 2025 13:07:52 +0000 (UTC)
Date: Wed, 8 Oct 2025 09:07:51 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, 
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
Reply-To: debarbos@redhat.com
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Oct 07, 2025 at 01:50:57PM -0500, Crystal Wood wrote:
> On Thu, 2025-10-02 at 16:55 -0400, Derek Barbosa wrote:
> > In the sched_debug backend code, we conditionally parse the running
> > tasks block of the sched_debug file to support the older task format (as
> > denoted by OLD_TASK_FORMAT).
> > 
> > This task format is only present on legacy 3.X kernels. However, on said
> > legacy kernels, the current Makefile directives and #if macros in the
> > stalld.c code do not fully support compilation of stalld.
> 
> What are the build issues?
> 
> BTW, I was pretty confused by this at first since I didn't see any
> such things in the current stalld code, because when I cloned the repo
> it gave me the old master branch by default (last update 5 years ago)
> instead of main. :-P
> 
> > Add a LEGACY check to the makefile, which parses `uname -r` output for
> > the major kernel version, and adds a LEGACY compilation flag to the
> > CFLAGS. Use the compilation flag to default to sched_debug_backend in
> > the stalld.c file to avoid missing references to the queue_track code.
> 
> As patch 1/3 says in a couple of places, this format wasn't introduced
> in 4.0 exactly (it says 4.18, AFAICT it was actually 4.14).  So why are
> we focusing on the major release (which basically signifies nothing
> other than "we don't like minor numbers greater than 20")?
> 
Thanks for the clarification!

Truth be told this was a hack that I had tested to ensure that I could build
this on some (very) old kernels.

As for the error messages, I need to re-install a 3.10 kernel on compatible box
again to pull out exactly what I was seeing.

In general, everything that was hamfistedly cut-out --as you may have
noticed-- was preventing the compilation of stalld.

> It's generally better to test features than version numbers anyway --
> especially for a component that is prone to feature backports. :-)

Touche. I need to go back and clean it up :)

> 
> The queue_track issue seems to be related to BPF, not the task format.
> 

Right, I'm pretty sure I mentioned that in my commit message. The old task
format is pretty much only present on _really_ old kernels. So, in this patch
series we attempt to unify the different parsing techniques.

After doing so, I decided to test my changes to ensure they actually worked on
the aforementioned kernels.

It was here that I noticed that the queue_track backend was still being
referenced, even with USE_BPF being set to 0 when running the `make` commands,
which would filter out the files themselves.

```
ifeq ($(USE_BPF),0)
SRC	:=	$(filter-out src/queue_track.c, $(SRC))
HDR	:=	$(filter-out src/queue_track.h, $(SRC))
endif
```
There were some undefined reference errors.

```
#if !__powerpc__ && !__i386__
struct stalld_backend *backend = &queue_track_backend;
#else
struct stalld_backend *backend = &sched_debug_backend;
#endif
```

We don't actually check if USE_BPF is enabled here.


> > Also, disable Intel CET -fcf-protection and BPF support, remove
> > annocheck targets, and default to the c99 compiler (if present).
> 
> How are these related to the kernel version?  And I don't see any
> changes to annocheck.
> 

If I am not mistaken, CET [0][1] is fairly recent. Attempting to build with this
flag on a RHEL-7 box (I need to check the gcc version again) was met with an
"unknown option".


> > Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> > ---
> >  Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
> >  src/stalld.c |  6 ++++--
> >  2 files changed, 43 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 7234a46..c09d574 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -9,6 +9,14 @@ ARCH=$(shell uname -m)
> >  endif
> >  $(info ARCH=$(ARCH))
> >  
> > +LEGACY_VER := 3
> > +ifeq ($(strip $(KERNEL_VER)),)
> > +KERNEL_VER=$(shell uname -r | cut -f 1 -d .)
> > +endif
> > +$(info Kernel Major Version is $(KERNEL_VER))
> > +
> > +IS_LEGACY:= $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "true" || echo "false")
> 
> What happens when we need to test for a feature that isn't even loosely
> associated with 3.x versus 4.x+?  Why are all these things being lumped
> under one vague "legacy" label?
> 

What other features would we be testing for, outside of the ones disabled for
compatability purposes?

> >  USE_BPF := 1
> >  FCF_PROTECTION := -fcf-protection
> >  MTUNE	:= -mtune=generic
> > @@ -33,6 +41,10 @@ ifeq ($(ARCH),powerpc)
> >  USE_BPF := 0
> >  MTUNE := -mtune=powerpc
> >  endif
> > +ifeq ($(IS_LEGACY),true)
> > +USE_BPF := 0
> > +FCF_PROTECTION := 
> > +endif

I realize that I'm going about this the wrong way. This will be fixed in the
next version.

> >  
> >  $(info USE_BPF=$(USE_BPF))
> >  $(info FCF_PROTECTION=$(FCF_PROTECTION))
> > @@ -57,6 +69,7 @@ DEFS	:=	-DUSE_BPF=$(USE_BPF) -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S
> >  
> >  # note that RPMCFLAGS and RPMLDFLAGS are variables that come from the specfile when
> >  # building for Fedora/CentOS/RHEL/et al
> > +#
> >  
> >  ifeq ($(RPMCFLAGS),)
> >  CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPTS) $(DEFS)
> > @@ -64,6 +77,12 @@ else
> >  CFLAGS	:=	 $(RPMCFLAGS) $(DEFS)
> >  endif
> >  
> > +ifeq ($(IS_LEGACY),true)
> > +$(info Compiling with Legacy Mode enabled)
> > +$(info Overwriting RPMCFLAGS...)
> > +CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS) -std=c99 -DLEGACY
> > +endif
> 
> It's overwriting CFLAGS, not RPMCFLAGS.  And if both RPMCFLAGS and
> LEGACY are set, it looks like this ignores RPMCFLAGS.
> 
> Why is SOPTS dropped?  The closest thing I can see in the changelog is
> -fcp-protection, but that's part of FOPTS (along with many other
> things).

```
SOPTS	:= 	-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
-specs=/usr/lib/rpm/redhat/redhat-annobin-cc1
```
When building on RHEL-7, it was though SOPTS still make their way through, even
though the comment specifies that these are variables that only come from the
specfile for DNF-family distributions.I was getting errors due to annobin not
being present, so I stripped it out.

> 
> Speaking of SOPTS, is this tool intended to be Red Hat specific
> (and require redhat-rpm-config even if no RPM building is intended)?
> 

That I am somewhat fuzzy on. Clark, could you help me out here? :)

> > @@ -200,7 +219,7 @@ uninstall:
> >  	rm -f $(DESTDIR)$(BINDIR)/throttlectl
> >  	make -C systemd DESTDIR=$(INSPATH) uninstall
> >  
> > -.PHONY: clean tarball systemd push annocheck
> > +.PHONY: clean tarball systemd push annocheck help
> >  clean:
> >  	@test ! -f stalld || rm stalld
> >  	@test ! -f stalld-static || rm stalld-static
> > @@ -221,3 +240,22 @@ tarball:  clean
> >  
> >  annocheck: stalld
> >  	annocheck --ignore-unknown --verbose --profile=el10 --debug-dir=/usr/lib/debug/ ./stalld
> > +
> > +help:
> > +	@echo  'Cleaning targets:'
> > +	@echo  '  clean            - Clean the main executable, tests, objects, and tarballs.'
> > +	@echo  ''
> > +	@echo 'Building targets:'
> > +	@echo '  stalld            - Build the main executable (stalld).'
> > +	@echo '  static            - Build a statically linked executable (stalld-static).'
> > +	@echo '  tests             - Run tests in the "tests" subdirectory.'
> > +	@echo '  tarball           - Create a source tarball: $(NAME)-$(VERSION).tar.$(CEXT)'
> > +	@echo ''
> > +	@echo 'Installation targets:'
> > +	@echo '  install           - Install the executable, man page, docs, and licenses.'
> > +	@echo '  uninstall         - Remove all installed files.'
> > +	@echo ''
> > +	@echo 'Utility targets:'
> > +	@echo '  annocheck         - Run the annocheck security analysis tool on the stalld executable.'
> > +	@echo '  help              - Display this help message.'
> > +
> 
> This seems unrelated?
> 

Sorry, I am unsure what you're referring to. Are you saying the addition of a
`make help` target is unrelated?

> > diff --git a/src/stalld.c b/src/stalld.c
> > index 4c00158..b47d21c 100644
> > --- a/src/stalld.c
> > +++ b/src/stalld.c
> > @@ -153,14 +153,16 @@ int config_reservation = 0;
> >  
> >  /*
> >   * Select a backend.
> > - * Note that eBPF not supported on i686 and powerpc
> > + * Note that eBPF not supported on i686, powerpc, and on x86 3.X kernels.
> >   */
> > -#if !__powerpc__ && !__i386__
> > +#if !__powerpc__ && !__i386__ && !LEGACY
> >  struct stalld_backend *backend = &queue_track_backend;
> >  #else
> >  struct stalld_backend *backend = &sched_debug_backend;
> >  #endif
> 
> The file is guarded by USE_BPF, so why not use that here too?

Thanks for pointing that out.

> 
> -Crystal
> 

[0] https://docs.kernel.org/next/x86/shstk.html
[1] https://www.phoronix.com/news/Linux-6.4-Shadow-Stack-Coming

-- 
Derek <debarbos@redhat.com>

