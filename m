Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AE1E521B
	for <linux-rt-users@vger.kernel.org>; Tue,  7 Oct 2025 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759863068; cv=none; b=iP6rX7LggHT3PaZItc3OJN8CpwCF/zlLgtdqFIKsPwzScYnR5/+SdwL+Vgcl0pox66HjDzEvJwxfpKUiJtdDgjntTyesas1TUokVhYbhsW+Nm7seWXMLvq1McTRVl8eEfFsLe6xGyO0OjlJg9G5jSW7d3oCCSteQsOmjftK2Qy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759863068; c=relaxed/simple;
	bh=OKJdREdpQFcPBOc47+2YD4EkGbzRnedTRbSC2T0+iPg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyudBWIrwDz2EzIWC78cy8qyG+CAP5NcbR1siyCkxcfWLM++mswYc65NGw/CQAPQG9Ic5dwp8vcUhmfVHZQqtu64+yYjz6pt4topazmPH1SDJH/lau9xPWbmslmw5ESp5p7q6wTs29DTPeCd1sYGI5q1TfaaF6+5kRxResAWJig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9heOgkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9heOgkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759863062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJu0A62Qgk2y5DMJzH2gr48TI5mwKEemWd54s1H6DRo=;
	b=G9heOgkM907mmYyyqE37yorvApQAxS8BpA6iJ49rqSqUyz7gii1Qg9C8CKoZYaQFcvS0lq
	b3kd4duNiixP7LTZPDQwhoWOhQHCmGy7fhGfoKJAPQChig0W0mnUwQ7tGU3eME5o0ISD/F
	0KALdjwYfyDV7lKwWQ/RFCINKppIeTQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-57RdTfyxMUWTWYjQK24PAQ-1; Tue, 07 Oct 2025 14:51:00 -0400
X-MC-Unique: 57RdTfyxMUWTWYjQK24PAQ-1
X-Mimecast-MFC-AGG-ID: 57RdTfyxMUWTWYjQK24PAQ_1759863060
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-876ee102b44so4412246d6.1
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Oct 2025 11:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759863060; x=1760467860;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJu0A62Qgk2y5DMJzH2gr48TI5mwKEemWd54s1H6DRo=;
        b=uaI/1YxpMzeLe8xIos80wW87uGymRw7SqBoD5Sw4YHtQ2VrI0/xR4nBTqcNAlicvy6
         SGzO4Hg3YVkw2NXXjf8a4GnBq3xqvvsfJRCesCRQcuuurs+TfYL+n/BuNN8pQvosw/s7
         xgWkFRJoO4wvdzVeRaZdXK6YBUf5/yibHjKxOmFRs9r2XoCkgOr3YbnNsJWaXmYP50yc
         3QwYEypG6bpjN2quTS6MxKR5eNTgoThkE/tpaG6Wo76EWEHVOO+qaCJaq5aBbncO/aX8
         ykbkXnyXdI2rlhkl63w67I+r6kTH6qrT7tet82mEhHaUtZa1n5JhERls8cUAahik4fJP
         Ccvg==
X-Gm-Message-State: AOJu0YwIHDTJfZHm6q2F2InzcxHXbcl4COPG/ggAHmsDCWW+FeOa0cQ/
	RNkplb/mEzIchFi7lXghrXBWHYqLz+gCTnp0SuZ4mUcMSnj+fS3c062FcEB/oLmp0xh6+irlFn4
	fSZiohzIL52ULC9DuuHfpj3Or98993dXBCX27rlJVEjBW4lbPpcAJ7W7VKm7ChhiQ4lvT
X-Gm-Gg: ASbGncuJsQsPk5fNtmqqyjlvxGelcykLTNQm0BRKSEHCQRKcl2DsCnsi1NDedFqYkZq
	M5Ki+AAlPqVj67hw1bkGG0PsspZ+5o2g2Po4zu28B1QibHnMfofssoYQXyEB0XpYZuzTT9KBabd
	uiFUoYvUfq21vYhucOX+2lCtq+dzMWZYovrRKi7ZfCzZ60tQon4wOvPGlBG+79SvPrdhjcl2bkp
	SSJpxYjI8ze2wf1u883J2X8x9mRhrN/ACgtgMdbecTHgT2/tySuRJkhBM3ebG2dk3/l1FKxlcRX
	/eJCMJYVuKkpwXtxPPfgubXGZ6SpXExbr5hnZiTdHfovPg9wCx77ZLXlDmnCEBQ80g4FP0tLvcG
	UEg==
X-Received: by 2002:a05:6214:1c8d:b0:70d:ba79:251e with SMTP id 6a1803df08f44-87a052173bdmr71343436d6.13.1759863060063;
        Tue, 07 Oct 2025 11:51:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrCoVp8OVOXKotBmKXT1ZYOTZ0GnwSXF+6vlEyYYLc/45PIxiVFW+8ZIbe4c5gVkl0iU59mQ==
X-Received: by 2002:a05:6214:1c8d:b0:70d:ba79:251e with SMTP id 6a1803df08f44-87a052173bdmr71342926d6.13.1759863059464;
        Tue, 07 Oct 2025 11:50:59 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878be61fb57sm147823816d6.62.2025.10.07.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:50:59 -0700 (PDT)
Message-ID: <adb796e86ac3cd19b55ee399662b8ad97dc2bba1.camel@redhat.com>
Subject: Re: [PATCH 2/3] Makefile: Add support for legacy kernels
From: Crystal Wood <crwood@redhat.com>
To: Derek Barbosa <debarbos@redhat.com>, clrkwllms@kernel.org
Cc: linux-rt-users@vger.kernel.org, wander@redhat.com
Date: Tue, 07 Oct 2025 13:50:57 -0500
In-Reply-To: <20251002205515.1299816-3-debarbos@redhat.com>
References: <20251002205515.1299816-1-debarbos@redhat.com>
	 <20251002205515.1299816-3-debarbos@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 16:55 -0400, Derek Barbosa wrote:
> In the sched_debug backend code, we conditionally parse the running
> tasks block of the sched_debug file to support the older task format (as
> denoted by OLD_TASK_FORMAT).
>=20
> This task format is only present on legacy 3.X kernels. However, on said
> legacy kernels, the current Makefile directives and #if macros in the
> stalld.c code do not fully support compilation of stalld.

What are the build issues?

BTW, I was pretty confused by this at first since I didn't see any
such things in the current stalld code, because when I cloned the repo
it gave me the old master branch by default (last update 5 years ago)
instead of main. :-P

> Add a LEGACY check to the makefile, which parses `uname -r` output for
> the major kernel version, and adds a LEGACY compilation flag to the
> CFLAGS. Use the compilation flag to default to sched_debug_backend in
> the stalld.c file to avoid missing references to the queue_track code.

As patch 1/3 says in a couple of places, this format wasn't introduced
in 4.0 exactly (it says 4.18, AFAICT it was actually 4.14).  So why are
we focusing on the major release (which basically signifies nothing
other than "we don't like minor numbers greater than 20")?

It's generally better to test features than version numbers anyway --
especially for a component that is prone to feature backports. :-)

The queue_track issue seems to be related to BPF, not the task format.

> Also, disable Intel CET -fcf-protection and BPF support, remove
> annocheck targets, and default to the c99 compiler (if present).

How are these related to the kernel version?  And I don't see any
changes to annocheck.

> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> ---
>  Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
>  src/stalld.c |  6 ++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 7234a46..c09d574 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -9,6 +9,14 @@ ARCH=3D$(shell uname -m)
>  endif
>  $(info ARCH=3D$(ARCH))
> =20
> +LEGACY_VER :=3D 3
> +ifeq ($(strip $(KERNEL_VER)),)
> +KERNEL_VER=3D$(shell uname -r | cut -f 1 -d .)
> +endif
> +$(info Kernel Major Version is $(KERNEL_VER))
> +
> +IS_LEGACY:=3D $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "true=
" || echo "false")

What happens when we need to test for a feature that isn't even loosely
associated with 3.x versus 4.x+?  Why are all these things being lumped
under one vague "legacy" label?

>  USE_BPF :=3D 1
>  FCF_PROTECTION :=3D -fcf-protection
>  MTUNE	:=3D -mtune=3Dgeneric
> @@ -33,6 +41,10 @@ ifeq ($(ARCH),powerpc)
>  USE_BPF :=3D 0
>  MTUNE :=3D -mtune=3Dpowerpc
>  endif
> +ifeq ($(IS_LEGACY),true)
> +USE_BPF :=3D 0
> +FCF_PROTECTION :=3D=20
> +endif
> =20
>  $(info USE_BPF=3D$(USE_BPF))
>  $(info FCF_PROTECTION=3D$(FCF_PROTECTION))
> @@ -57,6 +69,7 @@ DEFS	:=3D	-DUSE_BPF=3D$(USE_BPF) -D_FORTIFY_SOURCE=3D3 =
-D_GLIBCXX_ASSERTIONS -DDEBUG_S
> =20
>  # note that RPMCFLAGS and RPMLDFLAGS are variables that come from the sp=
ecfile when
>  # building for Fedora/CentOS/RHEL/et al
> +#
> =20
>  ifeq ($(RPMCFLAGS),)
>  CFLAGS	:=3D	-DVERSION=3D\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPT=
S) $(DEFS)
> @@ -64,6 +77,12 @@ else
>  CFLAGS	:=3D	 $(RPMCFLAGS) $(DEFS)
>  endif
> =20
> +ifeq ($(IS_LEGACY),true)
> +$(info Compiling with Legacy Mode enabled)
> +$(info Overwriting RPMCFLAGS...)
> +CFLAGS	:=3D	-DVERSION=3D\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS=
) -std=3Dc99 -DLEGACY
> +endif

It's overwriting CFLAGS, not RPMCFLAGS.  And if both RPMCFLAGS and
LEGACY are set, it looks like this ignores RPMCFLAGS.

Why is SOPTS dropped?  The closest thing I can see in the changelog is
-fcp-protection, but that's part of FOPTS (along with many other
things).

Speaking of SOPTS, is this tool intended to be Red Hat specific
(and require redhat-rpm-config even if no RPM building is intended)?

> @@ -200,7 +219,7 @@ uninstall:
>  	rm -f $(DESTDIR)$(BINDIR)/throttlectl
>  	make -C systemd DESTDIR=3D$(INSPATH) uninstall
> =20
> -.PHONY: clean tarball systemd push annocheck
> +.PHONY: clean tarball systemd push annocheck help
>  clean:
>  	@test ! -f stalld || rm stalld
>  	@test ! -f stalld-static || rm stalld-static
> @@ -221,3 +240,22 @@ tarball:  clean
> =20
>  annocheck: stalld
>  	annocheck --ignore-unknown --verbose --profile=3Del10 --debug-dir=3D/us=
r/lib/debug/ ./stalld
> +
> +help:
> +	@echo  'Cleaning targets:'
> +	@echo  '  clean            - Clean the main executable, tests, objects,=
 and tarballs.'
> +	@echo  ''
> +	@echo 'Building targets:'
> +	@echo '  stalld            - Build the main executable (stalld).'
> +	@echo '  static            - Build a statically linked executable (stal=
ld-static).'
> +	@echo '  tests             - Run tests in the "tests" subdirectory.'
> +	@echo '  tarball           - Create a source tarball: $(NAME)-$(VERSION=
).tar.$(CEXT)'
> +	@echo ''
> +	@echo 'Installation targets:'
> +	@echo '  install           - Install the executable, man page, docs, an=
d licenses.'
> +	@echo '  uninstall         - Remove all installed files.'
> +	@echo ''
> +	@echo 'Utility targets:'
> +	@echo '  annocheck         - Run the annocheck security analysis tool o=
n the stalld executable.'
> +	@echo '  help              - Display this help message.'
> +

This seems unrelated?

> diff --git a/src/stalld.c b/src/stalld.c
> index 4c00158..b47d21c 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -153,14 +153,16 @@ int config_reservation =3D 0;
> =20
>  /*
>   * Select a backend.
> - * Note that eBPF not supported on i686 and powerpc
> + * Note that eBPF not supported on i686, powerpc, and on x86 3.X kernels=
.
>   */
> -#if !__powerpc__ && !__i386__
> +#if !__powerpc__ && !__i386__ && !LEGACY
>  struct stalld_backend *backend =3D &queue_track_backend;
>  #else
>  struct stalld_backend *backend =3D &sched_debug_backend;
>  #endif

The file is guarded by USE_BPF, so why not use that here too?

-Crystal

