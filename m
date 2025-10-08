Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61D204F8B
	for <linux-rt-users@vger.kernel.org>; Wed,  8 Oct 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759967534; cv=none; b=DjxpTFv6LWaTnt1epH6O0a0Y+qxbdDzAZconXf154bNNYx0YEWDL5QV69p5n2hhL2thsWM82SPvs/YjcIeuDzMzem0IHhYLeCv9hIdYicK8TiU/4vmWhAc6ymtHDZ+HDUofZPiXxTIIrVTUUvePmVm+vRFeqw/oYMfmiF9/WVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759967534; c=relaxed/simple;
	bh=naqFVkth4UTZ+QPErDT3WAu0wkEXuTmJyBTzO5a3d7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNZPiPgFRnkjUXdOgoZCGI8Ly2MxwfvWvFTqBChh4h9sIed+npDiLwqCyPPTxH2XavrfE3Z+hHjVFKDd6LPeGwQ8vuXDyfSTBaAhxBhx6vdyjKaqzJWmausr+RB2EKB0hL8djK6fP14ZF+tG9RIJd3JZ3r5uEv8fQ5Y8obziH10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QrqH5Auv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrqH5Auv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759967531;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o8RD4j/UcyUyAmj3NcLx2+HxdkKHa51j2fvhprW7mgs=;
	b=QrqH5AuvpuuCl6lUev6R2MGTuKC6sroNj4FWnv1okDs/n7xH6Ynp+1d2JV4Aqc8EZZO2+J
	JQ0AUGVRCnTd8a0QToLhXmN31ehpuwqiNqdQZQ8Ye/X79SK4Z8QOO6ZmIryRI/wMhWM2AL
	ynz4Rb+dT681Me9hgVJ4NfsNF1ivDJk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-B10Ztd0VPgWfXJRKZFWm3g-1; Wed,
 08 Oct 2025 19:52:08 -0400
X-MC-Unique: B10Ztd0VPgWfXJRKZFWm3g-1
X-Mimecast-MFC-AGG-ID: B10Ztd0VPgWfXJRKZFWm3g_1759967527
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 433FA1800366;
	Wed,  8 Oct 2025 23:52:07 +0000 (UTC)
Received: from localhost (unknown [10.22.80.53])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 980563000198;
	Wed,  8 Oct 2025 23:52:06 +0000 (UTC)
Date: Wed, 8 Oct 2025 19:52:05 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Crystal Wood <crwood@redhat.com>
Cc: clrkwllms@kernel.org, linux-rt-users@vger.kernel.org, 
	wander@redhat.com
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
Message-ID: <xlsdpirj2vodtryotfqn6weo4dly3elwctxs6xcyur2skkmmix@anxl6dmzgig3>
Reply-To: debarbos@redhat.com
References: <20251002205515.1299816-1-debarbos@redhat.com>
 <20251002205515.1299816-3-debarbos@redhat.com>
 <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
 <cyk7iyu5rn72ppngwax6xn2nzgsyl5x2w5xjwj5aowmcw2ximv@cpxbkerjod3s>
 <6eef31238e5c8ee18fee7dbc1cf250bd30892941.camel@redhat.com>
 <6wtktjmptvddkeo3wibqjignaofyupiowxwsug4xp5inekvn24@qriseqkmhke6>
 <20cee89c557ca65b99637d49508c62f8a636f846.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20cee89c557ca65b99637d49508c62f8a636f846.camel@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Wed, Oct 08, 2025 at 04:38:49PM -0500, Crystal Wood wrote:
> On Wed, 2025-10-08 at 14:41 -0400, Derek Barbosa wrote:
> > On Wed, Oct 08, 2025 at 11:50:11AM -0500, Crystal Wood wrote:
> > > The default, if no C language dialect options are given, is -std=gnu90; this
> > > will change to -std=gnu99 or -std=gnu11 in some future release when the C99 or
> > > C11 support is complete.
> 
> I meant, why can't we specify c99 regardless of legacy (which would also
> help avoid introducing new stuff that breaks on legacy)?  Unless
> something in queue_track.c already does need newer than c99.
> 

Hm. I need to check if c99 breaks something in queue_track.

> > > > When building on RHEL-7, it was though SOPTS still make their way through, even
> > > > though the comment specifies that these are variables that only come from the
> > > > specfile for DNF-family distributions.I was getting errors due to annobin not
> > > > being present, so I stripped it out.
> > > 
> > > Oh, I was looking for "annocheck" which explains why I didn't notice
> > > that.
> > > 
> > > So the issue is that when you *are* building an RPM, the specfile isn't
> > > passing the right things for that OS version?  Wouldn't that be an
> > > issue with the specfile?
> > > 
> > 
> > It would be. However, annocheck/annobin gets invoked by default `make`.
> > 
> > ```
> > ifeq ($(RPMCFLAGS),)
> > CFLAGS  :=      -DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPTS) $(DEFS)
> > else
> > CFLAGS  :=       $(RPMCFLAGS) $(DEFS)
> > endif
> > ```
> > 
> > On `main`, with just disabling USE_BPF:
> > 
> > ```
> > [root@rt-qe-06 stalld]# make USE_BPF=0
> > ARCH=x86_64
> > USE_BPF=0
> > FCF_PROTECTION=-fcf-protection
> > MTUNE=-mtune=generic
> > CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
> > LDFLAGS=-ggdb -znow -pie
> > gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer -fcf-protection -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
> > gcc: error: /usr/lib/rpm/redhat/redhat-annobin-cc1: No such file or directory
> > make: *** [src/stalld.o] Error 1
> 
> Yeah, that's the "why is a basic 'make' pulling in Red Hat stuff?"
> question.
> 

That's a good question. I'll try to ask around and see if we can just strip this
stuff.

> > [root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS= FCF_PROTECTION=
> > ARCH=x86_64
> > USE_BPF=0
> > FCF_PROTECTION=
> > MTUNE=-mtune=generic
> > CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
> > LDFLAGS=-ggdb -znow -pie
> > gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
> > In file included from src/stalld.c:39:0:
> > src/queue_track.h: In function ‘find_queued_task’:
> > src/queue_track.h:61:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
> >   for (unsigned int i = 0;  \
> >   ^
> > src/queue_track.h:118:2: note: in expansion of macro ‘for_each_task_entry’
> >   for_each_task_entry(cpu_data, task) {
> >   ^
> > src/queue_track.h:61:2: note: use option -std=c99 or -std=gnu99 to compile your code
> >   for (unsigned int i = 0;  \
> >   ^
> > src/queue_track.h:118:2: note: in expansion of macro ‘for_each_task_entry’
> >   for_each_task_entry(cpu_data, task) {
> >   ^
> > make: *** [src/stalld.o] Error 1
> > ```
> 
> So I guess the makefile's definition of HDR is wrong, and it turns out
> HDR isn't even used anywhere :-P
> 
> > 
> > Appending c99 to the CFLAGS on the command-line a-la `CFLAGS+=-std=c99`
> > overrides the cflags entirely... so editing the CFLAGS to append -std=c99..
> 
> You're saying that if you do CFLAGS+=-std=c99 the only thing in CFLAGS
> is -std=c99?  That shouldn't happen...

Yeah...

```
[root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS= FCF_PROTECTION= CFLAGS+=-std=c99
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=
MTUNE=-mtune=generic
CFLAGS=-std=c99
LDFLAGS=-ggdb -znow -pie
gcc -std=c99   -c -o src/stalld.o src/stalld.c
[root@rt-qe-06 stalld]# make USE_BPF=0 SOPTS= FCF_PROTECTION= 
ARCH=x86_64
USE_BPF=0
FCF_PROTECTION=
MTUNE=-mtune=generic
CFLAGS=-DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2
LDFLAGS=-ggdb -znow -pie
gcc -DVERSION=\"1.23.1\" -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong -fasynchronous-unwind-tables -fstack-clash-protection -fno-omit-frame-pointer  -fpie -mtune=generic -m64 -mno-omit-leaf-frame-pointer -Wall -Werror=format-security  -DUSE_BPF=0 -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_STALLD=0 -g -O2   -c -o src/stalld.o src/stalld.c
```
> 
> -Crystal
> 

-- 
Derek <debarbos@redhat.com>

