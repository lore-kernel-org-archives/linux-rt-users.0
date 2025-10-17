Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E48E21B9F5
	for <linux-rt-users@vger.kernel.org>; Fri, 17 Oct 2025 12:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760705421; cv=none; b=G4xgwubBWdOlXK23YiaKz04Ku8+6j2md0KkyckoVDIqQICouH5aSgrahIolC9dCTBYMhL0o8YjpcZd3BMqyBOJPSYbKA7RnL8cfaWAzgOKS1j3Vk7xcNO8HrHqDuKMAKZhiFuJlm7IY/vXXZU6fjE0JsPnUnvfybNHGtqyA87D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760705421; c=relaxed/simple;
	bh=gCAr9LakapIIv5j37MK1aTAPDkt74pKQUmchLETiVbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDT+U3Tj0ntPmprCDuJwytDH1uy2yyg0VFXE0dQ5lJFaxSguiRaeSKjvnnlO9FxJihJ0Wm/P6KGC3haSkpp2wUtE3GJvLfXLzR5v95XX1zJoADBwPED8f9NYhcvFaAv802nNS76X01xiwJRuum2sVxKYoptFn+IKpH+ZP/ucDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6TWLpQC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6TWLpQC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760705418;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=NAB6yXayk6HQSaKbDN+GCZkiuw7cqQq3wUgbFLO+YXw=;
	b=T6TWLpQCVn6Wx84quxOBGyzLlahpU8VmmY8NbFjaNGxK9srhqJLjaOd+dJ82y7UJl8r549
	+iip2J2jXtz7JTj33Ef1v12f0gSiVMb6eY6UmXUqPPBAA4sI5YEWMfev5AR7r3wD3ACHJM
	pVM6NQItI8SxGC/77KTLmsQeCxXVjV0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-wosKLtduOGqjs-3b-SvkRg-1; Fri,
 17 Oct 2025 08:50:14 -0400
X-MC-Unique: wosKLtduOGqjs-3b-SvkRg-1
X-Mimecast-MFC-AGG-ID: wosKLtduOGqjs-3b-SvkRg_1760705411
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 98DCF19541B0;
	Fri, 17 Oct 2025 12:50:11 +0000 (UTC)
Received: from localhost (unknown [10.22.80.250])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABF5F180057C;
	Fri, 17 Oct 2025 12:50:10 +0000 (UTC)
Date: Fri, 17 Oct 2025 08:50:09 -0400
From: Derek Barbosa <debarbos@redhat.com>
To: Clark Williams <clrkwllms@kernel.org>
Cc: linux-rt-users@vger.kernel.org, Clark Williams <williams@redhat.com>, 
	wander@redhat.com, marco.chiappero@suse.com, chris.friesen@windriver.com, 
	luochunsheng@ustc.edu
Subject: Re: [PATCH 10/12] Makefile: Add support for legacy kernels
Message-ID: <2yasdc5znmfzyiy2bm4p2yi5hcdfbwd2cu46nv2sxnusrmhc3h@jk6fmyaehpqi>
Reply-To: debarbos@redhat.com
References: <20251017022444.118802-1-clrkwllms@kernel.org>
 <20251017022444.118802-10-clrkwllms@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017022444.118802-10-clrkwllms@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Oct 16, 2025 at 09:24:42PM -0500, Clark Williams wrote:
> From: Derek Barbosa <debarbos@redhat.com>
> 
> In the sched_debug backend code, we conditionally parse the running
> tasks block of the sched_debug file to support the older task format (as
> denoted by OLD_TASK_FORMAT).
> 
> This task format is only present on legacy 3.X kernels. However, on said
> legacy kernels, the current Makefile directives and #if macros in the
> stalld.c code do not fully support compilation of stalld.
> 
> Add a LEGACY check to the makefile, which parses `uname -r` output for
> the major kernel version, and adds a LEGACY compilation flag to the
> CFLAGS. Use the compilation flag to default to sched_debug_backend in
> the stalld.c file to avoid missing references to the queue_track code.
> 
> Also, disable Intel CET -fcf-protection and BPF support, remove
> annocheck targets, and default to the c99 compiler (if present).
> 
> Signed-off-by: Derek Barbosa <debarbos@redhat.com>
> Signed-off-by: Clark Williams <clrkwllms@kernel.org>
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  Makefile     | 40 +++++++++++++++++++++++++++++++++++++++-
>  src/stalld.c |  6 ++++--
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 7234a46976aa..c09d5743b696 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -9,6 +9,14 @@ ARCH=$(shell uname -m)
>  endif
>  $(info ARCH=$(ARCH))
>  
> +LEGACY_VER := 3
> +ifeq ($(strip $(KERNEL_VER)),)
> +KERNEL_VER=$(shell uname -r | cut -f 1 -d .)
> +endif
> +$(info Kernel Major Version is $(KERNEL_VER))
> +
> +IS_LEGACY:= $(shell test $(KERNEL_VER) -le $(LEGACY_VER) && echo "true" || echo "false")
> +
>  USE_BPF := 1
>  FCF_PROTECTION := -fcf-protection
>  MTUNE	:= -mtune=generic
> @@ -33,6 +41,10 @@ ifeq ($(ARCH),powerpc)
>  USE_BPF := 0
>  MTUNE := -mtune=powerpc
>  endif
> +ifeq ($(IS_LEGACY),true)
> +USE_BPF := 0
> +FCF_PROTECTION := 
> +endif
>  
>  $(info USE_BPF=$(USE_BPF))
>  $(info FCF_PROTECTION=$(FCF_PROTECTION))
> @@ -57,6 +69,7 @@ DEFS	:=	-DUSE_BPF=$(USE_BPF) -D_FORTIFY_SOURCE=3 -D_GLIBCXX_ASSERTIONS -DDEBUG_S
>  
>  # note that RPMCFLAGS and RPMLDFLAGS are variables that come from the specfile when
>  # building for Fedora/CentOS/RHEL/et al
> +#
>  
>  ifeq ($(RPMCFLAGS),)
>  CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(SOPTS) $(DEFS)
> @@ -64,6 +77,12 @@ else
>  CFLAGS	:=	 $(RPMCFLAGS) $(DEFS)
>  endif
>  
> +ifeq ($(IS_LEGACY),true)
> +$(info Compiling with Legacy Mode enabled)
> +$(info Overwriting RPMCFLAGS...)
> +CFLAGS	:=	-DVERSION=\"$(VERSION)\" $(FOPTS) $(MOPTS) $(WOPTS) $(DEFS) -std=c99 -DLEGACY
> +endif
> +
>  ifeq ($(DEBUG),0)
>  CFLAGS	+=	-g -O2
>  else
> @@ -200,7 +219,7 @@ install: stalld
>  	rm -f $(DESTDIR)$(BINDIR)/throttlectl
>  	make -C systemd DESTDIR=$(INSPATH) uninstall
>  
> -.PHONY: clean tarball systemd push annocheck
> +.PHONY: clean tarball systemd push annocheck help
>  clean:
>  	@test ! -f stalld || rm stalld
>  	@test ! -f stalld-static || rm stalld-static
> @@ -221,3 +240,22 @@ tarball:  clean
>  
>  annocheck: stalld
>  	annocheck --ignore-unknown --verbose --profile=el10 --debug-dir=/usr/lib/debug/ ./stalld
> +
> +help:
> +	@echo  'Cleaning targets:'
> +	@echo  '  clean            - Clean the main executable, tests, objects, and tarballs.'
> +	@echo  ''
> +	@echo 'Building targets:'
> +	@echo '  stalld            - Build the main executable (stalld).'
> +	@echo '  static            - Build a statically linked executable (stalld-static).'
> +	@echo '  tests             - Run tests in the "tests" subdirectory.'
> +	@echo '  tarball           - Create a source tarball: $(NAME)-$(VERSION).tar.$(CEXT)'
> +	@echo ''
> +	@echo 'Installation targets:'
> +	@echo '  install           - Install the executable, man page, docs, and licenses.'
> +	@echo '  uninstall         - Remove all installed files.'
> +	@echo ''
> +	@echo 'Utility targets:'
> +	@echo '  annocheck         - Run the annocheck security analysis tool on the stalld executable.'
> +	@echo '  help              - Display this help message.'
> +
> diff --git a/src/stalld.c b/src/stalld.c
> index 466b6db15668..305618e577fc 100644
> --- a/src/stalld.c
> +++ b/src/stalld.c
> @@ -153,14 +153,16 @@ int config_reservation = 0;
>  
>  /*
>   * Select a backend.
> - * Note that eBPF not supported on i686 and powerpc
> + * Note that eBPF not supported on i686, powerpc, and on x86 3.X kernels.
>   */
> -#if !__powerpc__ && !__i386__
> +#if !__powerpc__ && !__i386__ && !LEGACY
>  struct stalld_backend *backend = &queue_track_backend;
>  #else
>  struct stalld_backend *backend = &sched_debug_backend;
>  #endif
>  
> +
> +
>  /*
>   * Set of CPUs in which stalld should run.
>   */
> -- 
> 2.51.0
> 

Hey Clark.

I still have to implement Crystal's suggestions[0] which also means grabbing
access to a compatible box. I haven't had time today, but I don't think we
should take this patch as-is at the moment.

Would you also mind replying to a few of the questions there? Specifically:

>
> Speaking of SOPTS, is this tool intended to be Red Hat specific
> (and require redhat-rpm-config even if no RPM building is intended)?
>

> Of course, we could always go the direction of just dropping the functionality
> of parsing said "old" sched_debug files. Clark said that this may make some
> people upset though :P


Cheers,

[0] https://lore.kernel.org/linux-rt-users/367f7c89f0915f586a133914fe509d2913941cc4.camel@redhat.com/T/#u

-- 
Derek <debarbos@redhat.com>

