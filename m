From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a
 value
Date: Tue, 5 Jan 2016 23:59:27 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1601052356510.1732@riemann>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org
To: Khem Raj <raj.khem@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34103 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcAEW7f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Jan 2016 17:59:35 -0500
Received: by mail-wm0-f42.google.com with SMTP id u188so41088443wmu.1
        for <linux-rt-users@vger.kernel.org>; Tue, 05 Jan 2016 14:59:34 -0800 (PST)
In-Reply-To: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Sun, 3 Jan 2016, Khem Raj wrote:

> This helps it compile with clang or any other compilers besides gcc
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 1e4b7d1..2c2d396 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,6 @@
>  VERSION = 0.96
> -CC=$(CROSS_COMPILE)gcc
> -AR=$(CROSS_COMPILE)ar
> +CC?=$(CROSS_COMPILE)gcc
> +AR?=$(CROSS_COMPILE)ar
>  
>  OBJDIR = bld
>  
> -- 

Signed-off-by: John Kacur <jkacur@gmail.com>

I added this to the next build.

Note, I read everything in the thread, and I think there was a bit of 
confusion over thinking this was a kernel Makefile and not
the rt-tests one. As clark said, this is indeed the appropriate place to
discuss user space tools that are to do with real-time.
Perhaps after [PATCH] add rt-tests: to make it clear.

This patch is fine, it changes nothing other than letting the Khem and 
others specify CC and AR from the command line when typing make.

Thanks
