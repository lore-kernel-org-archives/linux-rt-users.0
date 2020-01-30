Return-Path: <SRS0=DFOT=3T=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09639C2D0DB
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 19:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C590D20707
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Jan 2020 19:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4Ak1ZEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgA3Tpo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:45:44 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35999 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3Tpn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Jan 2020 14:45:43 -0500
Received: by mail-qt1-f194.google.com with SMTP id t13so3485419qto.3
        for <linux-rt-users@vger.kernel.org>; Thu, 30 Jan 2020 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1sq1eszP5ghAkCAXoqYdrbqyEFz3kg8V3Xqw3gojGJ8=;
        b=Y4Ak1ZEsC02IG9yYur4J/qMCpcRD+2q62T9GmAeJ0xGKBwC5WHkjI43uwCI2/T9ElG
         q77N/ewkN77RVX7H4iNbpjh+hpDqiM4yUbZriBN5mGHdUrK5Utopaz7y0iMBNBKE0kx+
         kqkytwQQbjX77CEglphSDFRf73ry1hBAHNdUJcgJlH3ON2XjRnFptDAua2PiaWVbWuSm
         lrOWxEimRgm/yH46O8XUNjYbsG1rJyaiaHWmNgX06gX4yS1uz1bp0vClQJdN1MweOsA1
         2uggKvrv4MMe/yqolA54jdrXimHCYvWKD8C1m3HW823AXzVaRsuLwKUBCFRn6paK4B/4
         pJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=1sq1eszP5ghAkCAXoqYdrbqyEFz3kg8V3Xqw3gojGJ8=;
        b=hnsxIv0OgEha9M6FYNkKskBgcPYxzvTdQEdbinc4KrvyM5L/19ze+zN/g2YKVvXqHv
         McODZ4YkPu48HPNIg6iO79ism8kFkTAiXj1HGDJ0Ta7q/xR2f2llRJ1rLW6/0NnZwkZV
         HQqKfCN317GkWlWO3Ex20do0HL494KQxoDI48xugFgww98O/9VZLCyXH/yw7mr3SOucr
         XPigS8YkCE04SRhMqLAHlokDXQ8GAjs1OES0YsXL788sD8P+lBRuH9afo6w/xJ971K2T
         NdaDOiCzsRFrENxmkSQGq7Zy4uLv+GkIqQyOFpl8S640b5CwtQ1Y3LbpoSK6VsbhCgkl
         cxtQ==
X-Gm-Message-State: APjAAAU3RwRMa/mxROiw/Jjrj0wH1wQdv5ciZzfcIQn356kKv5sIT3vx
        dsJ0tzFX0MPW5fPjI0eXXr0=
X-Google-Smtp-Source: APXvYqxOv/IlJhl4+ZiFAw5RJYiKTWOllF+Z0EN9rTHCLQvLVkkUrXG3zxZ8mRoJxPl3plQkCYqL4A==
X-Received: by 2002:aed:2a32:: with SMTP id c47mr6538964qtd.289.1580413542454;
        Thu, 30 Jan 2020 11:45:42 -0800 (PST)
Received: from planxty (rdwyon0600w-lp130-03-64-231-46-127.dsl.bell.ca. [64.231.46.127])
        by smtp.gmail.com with ESMTPSA id i19sm3166455qki.124.2020.01.30.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:45:41 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:45:33 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] make: Make man page compression configurable
In-Reply-To: <20200130082949.9647-1-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.2001301444460.6499@planxty>
References: <20200130082949.9647-1-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 30 Jan 2020, Kurt Kanzenbach wrote:

> Currently the man pages are unconditionally gzip compressed. However, users
> might want to use something else such as bzip2 or none.
> 
> When using package management systems it makes sense to use no compression at
> all, as the package system might chose the appropriate one. Therefore, introduce
> MAN_COMPRESSION. This variable is handling how the compression is done. Default
> is gzip.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  Makefile | 60 ++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 19 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e2142ba3f4e9..ecbd5b1cb98b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -34,6 +34,32 @@ LDFLAGS ?=
>  
>  PYLIB  ?= $(shell python3 -c 'import distutils.sysconfig;  print (distutils.sysconfig.get_python_lib())')
>  
> +MANPAGES = src/cyclictest/cyclictest.8 \
> +	   src/pi_tests/pi_stress.8 \
> +	   src/ptsematest/ptsematest.8 \
> +	   src/rt-migrate-test/rt-migrate-test.8 \
> +	   src/sigwaittest/sigwaittest.8 \
> +	   src/svsematest/svsematest.8 \
> +	   src/pmqtest/pmqtest.8 \
> +	   src/hackbench/hackbench.8 \
> +	   src/signaltest/signaltest.8 \
> +	   src/pi_tests/pip_stress.8 \
> +	   src/queuelat/queuelat.8 \
> +	   src/sched_deadline/deadline_test.8 \
> +	   src/ssdd/ssdd.8 \
> +	   src/sched_deadline/cyclicdeadline.8
> +
> +ifdef PYLIB
> +	MANPAGES += src/hwlatdetect/hwlatdetect.8
> +endif
> +
> +MAN_COMPRESSION ?= gzip
> +ifeq ($(MAN_COMPRESSION),gzip)
> +	MANPAGES := $(MANPAGES:.8=.8.gz)
> +else ifeq ($(MAN_COMPRESSION),bzip2)
> +	MANPAGES := $(MANPAGES:.8=.8.bz2)
> +endif
> +
>  ifndef DEBUG
>  	CFLAGS	+= -O2 -g
>  else
> @@ -150,11 +176,17 @@ queuelat: $(OBJDIR)/queuelat.o $(OBJDIR)/librttest.a
>  ssdd: $(OBJDIR)/ssdd.o $(OBJDIR)/librttest.a
>  	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
>  
> +%.8.gz: %.8
> +	gzip -c $< > $@
> +
> +%.8.bz2: %.8
> +	bzip2 -c $< > $@
> +
>  LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
>  $(OBJDIR)/librttest.a: $(LIBOBJS)
>  	$(AR) rcs $@ $^
>  
> -CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a
> +CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej *.d *.a *.8.gz *.8.bz2
>  CLEANUP += $(if $(wildcard .git), ChangeLog)
>  
>  .PHONY: clean
> @@ -175,36 +207,26 @@ rebuild:
>  	$(MAKE) all
>  
>  .PHONY: install
> -install: all install_hwlatdetect
> -	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8"
> +install: all install_manpages install_hwlatdetect
> +	mkdir -p "$(DESTDIR)$(bindir)"
>  	cp $(TARGETS) "$(DESTDIR)$(bindir)"
>  	install src/queuelat/get_cpuinfo_mhz.sh "$(DESTDIR)$(bindir)"
>  	install src/queuelat/determine_maximum_mpps.sh "${DESTDIR}${bindir}"
> -	gzip -c src/cyclictest/cyclictest.8 >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
> -	gzip -c src/pi_tests/pi_stress.8 >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
> -	gzip -c src/ptsematest/ptsematest.8 >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
> -	gzip -c src/rt-migrate-test/rt-migrate-test.8 >"$(DESTDIR)$(mandir)/man8/rt-migrate-test.8.gz"
> -	gzip -c src/sigwaittest/sigwaittest.8 >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
> -	gzip -c src/svsematest/svsematest.8 >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
> -	gzip -c src/pmqtest/pmqtest.8 >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
> -	gzip -c src/hackbench/hackbench.8 >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
> -	gzip -c src/signaltest/signaltest.8 >"$(DESTDIR)$(mandir)/man8/signaltest.8.gz"
> -	gzip -c src/pi_tests/pip_stress.8 >"$(DESTDIR)$(mandir)/man8/pip_stress.8.gz"
> -	gzip -c src/queuelat/queuelat.8 >"$(DESTDIR)$(mandir)/man8/queuelat.8.gz"
> -	gzip -c src/sched_deadline/deadline_test.8 >"$(DESTDIR)$(mandir)/man8/deadline_test.8.gz"
> -	gzip -c src/ssdd/ssdd.8 >"$(DESTDIR)$(mandir)/man8/ssdd.8.gz"
> -	gzip -c src/sched_deadline/cyclicdeadline.8 >"$(DESTDIR)$(mandir)/man8/cyclicdeadline.8.gz"
>  
>  .PHONY: install_hwlatdetect
>  install_hwlatdetect: hwlatdetect
>  	if test -n "$(PYLIB)" ; then \
> -		mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8" ; \
> +		mkdir -p "$(DESTDIR)$(bindir)" ; \
>  		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
>  		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
>  		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
>  	fi
>  
> +.PHONY: install_manpages
> +install_manpages: $(MANPAGES)
> +	mkdir -p "$(DESTDIR)$(mandir)/man8"
> +	cp $(MANPAGES) "$(DESTDIR)$(mandir)/man8"
> +
>  .PHONY: tarball
>  tarball:
>  	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
> -- 
> 2.20.1
> 
> 

Thanks

Signed-off-by: John Kacur <jkacur@redhat.com>
