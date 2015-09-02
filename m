From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 2/4] rt-tests: Break out install_hwlatdetect
Date: Wed, 2 Sep 2015 14:56:26 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509021456000.19826@riemann>
References: <cover.1440720422.git.joshc@ni.com> <7bc5d10cf841febd5c511934cfed3ddcf512ffec.1440720422.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Darren Hart <dvhart@linux.intel.com>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34671 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754730AbbIBM43 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 08:56:29 -0400
Received: by wicfx3 with SMTP id fx3so16729471wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Sep 2015 05:56:28 -0700 (PDT)
In-Reply-To: <7bc5d10cf841febd5c511934cfed3ddcf512ffec.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 27 Aug 2015, Josh Cartwright wrote:

> From: Darren Hart <dvhart@linux.intel.com>
> 
> Allow hwlatdetect to be installed independently of the rest of the
> tests. This is convenient for build systems that package it separately
> due to the python dependency.
> 
> Signed-off-by: Darren Hart <dvhart@linux.intel.com>
> CC: Clark Williams <williams@redhat.com>
> CC: John Kacur <jkacur@redhat.com>
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  Makefile | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1ec7f6a..e5a9942 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -131,21 +131,15 @@ changelog:
>  	git log >ChangeLog
>  
>  .PHONY: install
> -install: all
> +install: all install_hwlatdetect
>  	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
>  	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
>  	cp $(TARGETS) "$(DESTDIR)$(bindir)"
> -	if test -n "$(PYLIB)" ; then \
> -		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
> -		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -	fi
>  	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
>  	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Makefile"
>  	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
>  	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
>  	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
> -	gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz"
>  	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
>  	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
>  	gzip src/svsematest/svsematest.8 -c >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
> @@ -153,6 +147,16 @@ install: all
>  	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
>  	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
>  
> +.PHONY: install_hwlatdetect
> +install_hwlatdetect: hwlatdetect
> +	if test -n "$(PYLIB)" ; then \
> +		mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8" ; \
> +		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
> +		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> +		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> +		gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
> +	fi
> +
>  .PHONY: release
>  release: distclean changelog
>  	mkdir -p releases
> -- 
> 2.5.0

Signed-off-by: John Kacur <jkacur@redhat.com>
