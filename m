Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A98221DB1
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Oct 2025 18:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759948886; cv=none; b=qT5iM+g0jxoqRAA4882CyIlJGAYUE7vVIiYxNWA5FSvDqZK9s0ySHHkZX115EKa3BWUWuR2aKPUJf0W/VmC8Et+VqscC5Wo1YU3vgb9AxbIlt7/xivcNndV0RGVOgda7bCn9wT2e+dtVCL2wHcFJ7uiNmrfEsc1lVkUw0cm+7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759948886; c=relaxed/simple;
	bh=4APczhvcgDRqukaHh4TvGnvJRu6rCfCysf+uowWhCy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juCi1ePCrtjjCcHOfntsVNdDfGTKbeBP3O6xe9OV+WjyLqd9U/YcDzFJO+oWMG8jw5NR82R5C48wq069B+cmbWd5MTP86a46cidtArukQmN/yVfpOvc6xQRowoT3DGUttz3ffmuXDfgMDernOnK2TUV4OV+DZzk9YuVM1AjpzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BU0AUlkm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU0AUlkm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759948882;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbcmOrl9T3QqcqdIxrHcJEdvOe9qI08ym5D1UwcymPg=;
	b=BU0AUlkmwrCEAAd/MRaGb8S5pEkZD9gMp0W1WR4BOZzLVHv+x9R29Y5/Z6er+5zMVGdDrc
	FfI4dJjXgwgvVhBxGl/seKumMHjIUL+ABHnSF00Hst796juirSHMnuogSOupT2FqHk4jYN
	v3wxzwpeKNMFdwa7KT157aU2hOA1wfE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-AVGfpEo0N-2LnO3pj83ZVg-1; Wed,
 08 Oct 2025 14:41:19 -0400
X-MC-Unique: AVGfpEo0N-2LnO3pj83ZVg-1
X-Mimecast-MFC-AGG-ID: AVGfpEo0N-2LnO3pj83ZVg_1759948873
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F8B5180057D;
	Wed,  8 Oct 2025 18:41:13 +0000 (UTC)
Received: from localhost (unknown [10.22.89.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B8C671801AD3;
	Wed,  8 Oct 2025 18:41:12 +0000 (UTC)
Date: Wed, 8 Oct 2025 14:41:11 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, 
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
Reply-To: debarbos@redhat.com
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Oct 08, 2025 at 11:50:11AM -0500, Crystal Wood wrote:
> On Wed, 2025-10-08 at 09:07 -0400, Derek Barbosa wrote:
> > On Tue, Oct 07, 2025 at 01:50:57PM -0500, Crystal Wood wrote:
> > > On Thu, 2025-10-02 at 16:55 -0400, Derek Barbosa wrote:
> > > > Also, disable Intel CET -fcf-protection and BPF support, remove
> > > > annocheck targets, and default to the c99 compiler (if present).
> > > 
> > > How are these related to the kernel version?  And I don't see any
> > > changes to annocheck.
> > > 
> > 
> > If I am not mistaken, CET [0][1] is fairly recent. Attempting to build with this
> > flag on a RHEL-7 box (I need to check the gcc version again) was met with an
> > "unknown option".
> 
> OK but that's a GCC version issue, not a kernel version issue.

Sorry for conflating the two.

> I still don't get why we only use c99 for legacy builds... does
> something in the non-legacy build need a newer standard that is now
> default?

Let me spin up an old kernel.

```
[root@rt-qe-06 stalld]# gcc --version
gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
```

IIRC, GCC 4.8.5 has incomplete support for c99, and the default is gnu90 [0].
> The default, if no C language dialect options are given, is -std=gnu90; this
> will change to -std=gnu99 or -std=gnu11 in some future release when the C99 or
> C11 support is complete.


> > > > Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> > > > ---
> > > >  Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
> > > >  src/stalld.c |  6 ++++--
> > > >  2 files changed, 43 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index 7234a46..c09d574 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -9,6 +9,14 @@ ARCH=$(shell uname -m)
> > > >  endif
> > > >  $(info ARCH=$(ARCH))
> > > >  
> > > > +LEGACY_VER := 3
> > > > +ifeq ($(strip $(KERNEL_VER)),)
> > > > +KERNEL_VER=$(shell uname -r | cut -f 1 -d .)
> > > > +endif
> > > > +$(info Kernel Major Version is $(KERNEL_VER))
> > > > +
> > > > +IS_LEGACY:= $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "true" || echo "false")
> > > 
> > > What happens when we need to test for a feature that isn't even loosely
> > > associated with 3.x versus 4.x+?  Why are all these things being lumped
> > > under one vague "legacy" label?
> > > 
> > 
> > What other features would we be testing for, outside of the ones disabled for
> > compatability purposes?
> 
> I just meant that lumping all compatibility flags into one big "LEGACY"
> made me twitch. :-)

Fair. I will openly admit that it isn't "clean". It is a hack at best.
"LEGACY" is also a misnomer in the sense that users could interpret it as any
kernel version that isn't actively supported...

The reasoning came about that StallD, as is, doesn't compile on pretty old
environments such as RHEL-7, which runs a 3.10 franken-kernel. Considering the
code has config flags to determine whether or not the sched_debug file is of
"old" format or "new" format, I figured we want to support such environments.

I made the incorrect assumption that systems running such "old" kernels, would
by extension have equally-as-old compilers.

Of course, we could always go the direction of just dropping the functionality
of parsing said "old" sched_debug files. Clark said that this may make some
people upset though :P

> 
> If we're going to do that anyway (e.g. to simplify testing) I'd at
> least have a comment indicating that this is being used as a heuristic
> for older systems in general to avoid the need for a more complicated
> build system (at least for now), to save readers some head scratching.
> 
Agreed. I'll clean this up and add some more comments soon.

> > > > +ifeq ($(IS_LEGACY),true)
> > > > +$(info Compiling with Legacy Mode enabled)
> > > > +$(info Overwriting RPMCFLAGS...)
> > > > +CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS) -std=c99 -DLEGACY
> > > > +endif
> > > 
> > > It's overwriting CFLAGS, not RPMCFLAGS.  And if both RPMCFLAGS and
> > > LEGACY are set, it looks like this ignores RPMCFLAGS.
> 
> I think my confusion here was that it's overriding rather than
> overwriting.  If we do end up doing this, a comment explaining why
> would be helpful.
> 
> > > 
> > > Why is SOPTS dropped?  The closest thing I can see in the changelog is
> > > -fcp-protection, but that's part of FOPTS (along with many other
> > > things).
> > 
> > ```
> > SOPTS	:= 	-specs=/usr/lib/rpm/redhat/redhat-hardened-cc1
> > -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1
> > ```
> > When building on RHEL-7, it was though SOPTS still make their way through, even
> > though the comment specifies that these are variables that only come from the
> > specfile for DNF-family distributions.I was getting errors due to annobin not
> > being present, so I stripped it out.
> 
> Oh, I was looking for "annocheck" which explains why I didn't notice
> that.
> 
> So the issue is that when you *are* building an RPM, the specfile isn't
> passing the right things for that OS version?  Wouldn't that be an
> issue with the specfile?
> 

It would be. However, annocheck/annobin gets invoked by default `make`.

```
ifeq ($(RPMCFLAGS),)
CFLAGS  :=      -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPTS) $(DEFS)
else
CFLAGS  :=       $(RPMCFLAGS) $(DEFS)
endif
```

On `main`, with just disabling USE_BPF:

```
[root@rt-qe-06 stalld]# make USE_BPF=0
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=-fcf-protection
MTUNE=-mtune=generic
CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
LDFLAGS=-ggdb -znow -pie
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
gcc: error: /usr/lib/rpm/redhat/redhat-annobin-cc1: No such file or directory
make: *** [src/stalld.o] Error 1
```

Ok, ignoring SOPTS

```
[root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS=
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=-fcf-protection
MTUNE=-mtune=generic
CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
LDFLAGS=-ggdb -znow -pie
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
gcc: error: unrecognized command line option ‘-fcf-protection’
make: *** [src/stalld.o] Error 1
```

Ignoring FCF_PROTECTION...

```
[root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS= FCF_PROTECTION=
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=
MTUNE=-mtune=generic
CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
LDFLAGS=-ggdb -znow -pie
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
In file included from src/stalld.c:39:0:
src/queue_track.h: In function ‘find_queued_task’:
src/queue_track.h:61:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
  for (unsigned int i = 0;  \
  ^
src/queue_track.h:118:2: note: in expansion of macro ‘for_each_task_entry’
  for_each_task_entry(cpu_data, task) {
  ^
src/queue_track.h:61:2: note: use option -std=c99 or -std=gnu99 to compile your code
  for (unsigned int i = 0;  \
  ^
src/queue_track.h:118:2: note: in expansion of macro ‘for_each_task_entry’
  for_each_task_entry(cpu_data, task) {
  ^
make: *** [src/stalld.o] Error 1
```

Appending c99 to the CFLAGS on the command-line a-la `CFLAGS+=-std=c99`
overrides the cflags entirely... so editing the CFLAGS to append -std=c99..

```
[root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS= FCF_PROTECTION=""
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=
MTUNE=-mtune=generic
CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -std=c99 -g -O2
LDFLAGS=-ggdb -znow -pie
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -std=c99 -g -O2   -c -o src/stalld.o src/stalld.c
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -std=c99 -g -O2   -c -o src/sched_debug.o src/sched_debug.c
gcc -o stalld	-ggdb -znow -pie src/stalld.o src/throttling.o src/sched_debug.o src/utils.o -lpthread
src/stalld.o:(.data.rel+0x0): undefined reference to `queue_track_backend'
collect2: error: ld returned 1 exit status
make: *** [stalld] Error 1
```

And there's where some of the hamfisted-hackery with the LEGACY flag came into
the picture.


> > > > @@ -221,3 +240,22 @@ tarball:  clean
> > > >  
> > > >  annocheck: stalld
> > > >  	annocheck --ignore-unknown --verbose --profile=el10 --debug-dir=/usr/lib/debug/ ./stalld
> > > > +
> > > > +help:
> > > > +	@echo  'Cleaning targets:'
> > > > +	@echo  '  clean            - Clean the main executable, tests, objects, and tarballs.'
> > > > +	@echo  ''
> > > > +	@echo 'Building targets:'
> > > > +	@echo '  stalld            - Build the main executable (stalld).'
> > > > +	@echo '  static            - Build a statically linked executable (stalld-static).'
> > > > +	@echo '  tests             - Run tests in the "tests" subdirectory.'
> > > > +	@echo '  tarball           - Create a source tarball: $(NAME)-$(VERSION).tar.$(CEXT)'
> > > > +	@echo ''
> > > > +	@echo 'Installation targets:'
> > > > +	@echo '  install           - Install the executable, man page, docs, and licenses.'
> > > > +	@echo '  uninstall         - Remove all installed files.'
> > > > +	@echo ''
> > > > +	@echo 'Utility targets:'
> > > > +	@echo '  annocheck         - Run the annocheck security analysis tool on the stalld executable.'
> > > > +	@echo '  help              - Display this help message.'
> > > > +
> > > 
> > > This seems unrelated?
> > > 
> > 
> > Sorry, I am unsure what you're referring to. Are you saying the addition of a
> > `make help` target is unrelated?
> 
> Yes, it seemed like something that would normally be a separate
> patch, though that may be me getting stuck in kernel development mode
> :-)
> 
> I wouldn't have mentioned it if the patch didn't feel off in other
> ways.

Fair! It is trivial for me to split this up. I'll include it in the next series.
Currently debugging a weird corner case in the new "unified" parser, so it may
take some time.

> 
> -Crystal
> 

[0] https://gcc.gnu.org/onlinedocs/gcc-4.8.5/gcc/Standards.html#Standards

-- 
Derek <debarbos@redhat.com>

