From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] Makefile:add cross_compiler for Makefile
Date: Mon, 28 Sep 2015 14:22:44 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509281419510.8775@riemann.fritz.box>
References: <20150928061205.GA6382@debian.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: williams@redhat.com, jkacur@redhat.com,
	linux-rt-users@vger.kernel.org
To: Yuanbin Zhou <hduffddybz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34656 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbbI1MWx (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Sep 2015 08:22:53 -0400
Received: by wicfx3 with SMTP id fx3so101886258wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Sep 2015 05:22:52 -0700 (PDT)
In-Reply-To: <20150928061205.GA6382@debian.debian>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sun, 27 Sep 2015, Yuanbin Zhou wrote:

> In this site(https://rt.wiki.kernel.org/index.php/Cyclictest), It has been shown that you can use "make CROSS_COPILE=<your-compiler-prefix>" to build software ran in other platform like arm & mips, but in fact it does not work, this patch is used to solve this problem.
> 
> Signed-off-by: Yuanbin Zhou <hduffddybz@gmail.com>
> ---
>  Makefile | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index a48e759..9b31ce4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -11,6 +11,17 @@ sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
>  
>  TARGETS = $(sources:.c=)
>  
> +CROSS_COMPILE ?= $(CONFIG_CROSS_COMPILE:"%"=%)
> +AS = $(CROSS_COMPILE)as
> +LD = $(CROSS_COMPILE)ld
> +CC = $(CROSS_COMPILE)gcc
> +CPP = $(CC) -E
> +AR = $(CROSS_COMPILE)ar
> +NM = $(CROSS_COMPILE)nm
> +STRIP = $(CROSS_COMPILE)strip
> +OBJCOPY = $(CROSS_COMPILE)objcopy
> +OBJDUMP = $(CROSS_COMPILE)objdump
> +
>  LIBS	= -lrt -lpthread
>  RTTESTLIB = -lrttest -L.
>  EXTRA_LIBS ?= -ldl	# for get_cpu
> -- 
> 2.1.4


Thank you for your patch, it looks sane. I'm not sure what version it 
applies against though, when I tried to apply it, it failed.
I did accept the first cross-compile patch, that wasn't suffiencient for 
your purposes, so you need to apply your patch on top of that.

Can you respin it against the following branch please? (and resend it of 
course)

repo: git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
branch: devel/v0.95-devel

Thanks

John
