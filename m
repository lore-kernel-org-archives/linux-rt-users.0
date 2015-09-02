From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 3/4] rt-tests: workaround poor gzip
 implementations
Date: Wed, 2 Sep 2015 14:58:48 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509021458250.19826@riemann>
References: <cover.1440720422.git.joshc@ni.com> <c2b24f2ac77833c8bf32d3e1a7d2fe8ff22ffda9.1440720422.git.joshc@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Robert Yang <liezhi.yang@windriver.com>,
	Kai Kang <kai.kang@windriver.com>
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:35058 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbIBM6v (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 2 Sep 2015 08:58:51 -0400
Received: by wicge5 with SMTP id ge5so40002227wic.0
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Sep 2015 05:58:50 -0700 (PDT)
In-Reply-To: <c2b24f2ac77833c8bf32d3e1a7d2fe8ff22ffda9.1440720422.git.joshc@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 27 Aug 2015, Josh Cartwright wrote:

> Some 'gzip' implementations, in particular 'pigz' don't properly handle
> the '-c' argument if it's passed after the name of the input files.
> 
> Work around this by putting the '-c' option before the file names.
> 
> Inspired by patches in OpenEmbedded by Robert Yang and Kai Kang.
> 
> Cc: Robert Yang <liezhi.yang@windriver.com>
> Cc: Kai Kang <kai.kang@windriver.com>
> Signed-off-by: Josh Cartwright <joshc@ni.com>
> ---
>  Makefile | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index e5a9942..5c4dd04 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -137,15 +137,15 @@ install: all install_hwlatdetect
>  	cp $(TARGETS) "$(DESTDIR)$(bindir)"
>  	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
>  	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Makefile"
> -	gzip src/backfire/backfire.4 -c >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
> -	gzip src/cyclictest/cyclictest.8 -c >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
> -	gzip src/pi_tests/pi_stress.8 -c >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
> -	gzip src/ptsematest/ptsematest.8 -c >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
> -	gzip src/sigwaittest/sigwaittest.8 -c >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
> -	gzip src/svsematest/svsematest.8 -c >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
> -	gzip src/pmqtest/pmqtest.8 -c >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
> -	gzip src/backfire/sendme.8 -c >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
> -	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
> +	gzip -c src/backfire/backfire.4 >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
> +	gzip -c src/cyclictest/cyclictest.8 >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
> +	gzip -c src/pi_tests/pi_stress.8 >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
> +	gzip -c src/ptsematest/ptsematest.8 >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
> +	gzip -c src/sigwaittest/sigwaittest.8 >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
> +	gzip -c src/svsematest/svsematest.8 >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
> +	gzip -c src/pmqtest/pmqtest.8 >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
> +	gzip -c src/backfire/sendme.8 >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
> +	gzip -c src/hackbench/hackbench.8 >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
>  
>  .PHONY: install_hwlatdetect
>  install_hwlatdetect: hwlatdetect
> @@ -154,7 +154,7 @@ install_hwlatdetect: hwlatdetect
>  		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
>  		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
>  		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -		gzip src/hwlatdetect/hwlatdetect.8 -c >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
> +		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
>  	fi
>  
>  .PHONY: release
> -- 
> 2.5.0

Signed-off-by: John Kacur <jkacur@redhat.com>
