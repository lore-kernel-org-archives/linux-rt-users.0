From: John Kacur <jkacur@redhat.com>
Subject: Re: Makefile: be more friendly with user supplied CFLAGS
Date: Tue, 16 Oct 2012 00:56:15 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210160038030.6335@tycho>
References: <1346616775-11714-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806542-1513530193-1350341782=:6335"
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46946 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab2JOWyd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 18:54:33 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2707787bkc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 15:54:32 -0700 (PDT)
In-Reply-To: <1346616775-11714-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-1513530193-1350341782=:6335
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Your Subject lines need to be improved. First of all, can you preface them 
with something like [PATCH RT-TESTS]? Second, your descriptions are not 
good. I have also been accused of having poor descriptions, so you are not 
alone in this. However, "be more friendly" - that is not exactly a good 
technical description. Something like, "Separate CFLAGS and CPPFLAGS" 
would be better in my opinion.

Did you test this?!!!

I get errors like this
src/pi_tests/pip_stress.c:57:24: fatal error: pip_stress.h: No such file 
or directory

I believe you just need to add CPPFLAGS to the dependency part like this
B 
diff --git a/Makefile b/Makefile
index a6f7a1b..33e8d60 100644
--- a/Makefile
+++ b/Makefile
@@ -54,7 +54,7 @@ VPATH += src/hackbench
 
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
-       @$(CC) -MM $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ 
|| rm
+       @$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o 
$@ : ,g
 
 .PHONY: all
 all: $(TARGETS) hwlatdetect

Finally, I'm not sure I understand the benefit of separating the two, why 
do we need this? What is improved? Are you saying that the Debian build 
system breaks without it?

Thanks

John

On Sun, 2 Sep 2012, Uwe Kleine-König wrote:

> For compilation to work
> 
> 	-D_GNU_SOURCE -Isrc/include
> 
> is needed to be passed to the compiler. For Debian packaging several
> things are added but not these two from above. So be a bit more friendly
> and add them unconditionally. There is no harm if they are included in
> the user supplied CFLAGS and so passed twice.
> 
> Moreover be a bit more correct about CFLAGS/CPPFLAGS. Both should be
> passed to the compiler with CFLAGS taking options for the compiler and
> CPPFLAGS taking options for the preprocessor. This is also needed for
> Debian packaging where the helper scripts set CPPFLAGS.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de> 
> ---
>  Makefile |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> Index: rt-tests/Makefile
> ===================================================================
> --- rt-tests.orig/Makefile	2012-09-02 22:04:06.547562496 +0200
> +++ rt-tests/Makefile	2012-09-02 22:06:56.169496678 +0200
> @@ -20,7 +20,8 @@
>  NUMA 	:= 1
>  endif
>  
> -CFLAGS ?= -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
> +CFLAGS ?= -Wall -Wno-nonnull
> +CPPFLAGS += -D_GNU_SOURCE -Isrc/include
>  LDFLAGS ?=
>  
>  ifndef DEBUG
> @@ -47,7 +48,7 @@
>  VPATH	+= src/hackbench
>  
>  %.o: %.c
> -	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS)
> +	$(CC) -D VERSION_STRING=$(VERSION_STRING) -c $< $(CFLAGS) $(CPPFLAGS)
>  
>  # Pattern rule to generate dependency files from .c files
>  %.d: %.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
---1463806542-1513530193-1350341782=:6335--
