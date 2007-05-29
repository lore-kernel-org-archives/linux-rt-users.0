From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] Powerpc compiler error fix for 2.6.21-rt8
Date: Tue, 29 May 2007 18:41:02 +0400
Message-ID: <465C3B7E.1000209@ru.mvista.com>
References: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linuxppc-embedded@ozlabs.org, linux-rt-users@vger.kernel.org
To: Pradyumna Sampath <pradyumna.sampath@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:28809 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752020AbXE2Oj2 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 May 2007 10:39:28 -0400
In-Reply-To: <f87351060705282124q6d6b1562ic1dd4da4b8a62886@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hello.

Pradyumna Sampath wrote:

> Attached is a small patch to fix compile time errors which is broken
> in 2.6.21-rt8 for powerpc.

    NAK. It's been deleted on purpose (not used anymore), and I've already 
sent a patch to kill the leftover reference.

> ------------------------------------------------------------------------
> 
> diff -ur latest/linux-2.6.21/arch/powerpc/kernel/time.c linux-2.6.21/arch/powerpc/kernel/time.c
> --- latest/linux-2.6.21/arch/powerpc/kernel/time.c	2007-05-29 09:58:12.000000000 +0530
> +++ linux-2.6.21/arch/powerpc/kernel/time.c	2007-05-29 08:58:56.000000000 +0530
> @@ -95,6 +95,8 @@
>  #define SCALE_XSEC(xsec, max)	mulhwu((xsec) << 12, max)
>  #endif
>  
> +unsigned long cpu_khz;  /* Detected as we calibrate the TSC */
> +EXPORT_SYMBOL(cpu_khz);
>  unsigned long tb_ticks_per_jiffy;
>  unsigned long tb_ticks_per_usec = 100; /* sane default */
>  EXPORT_SYMBOL(tb_ticks_per_usec);
> Only in linux-2.6.21/arch/powerpc/kernel: vmlinux.lds
> Only in linux-2.6.21/scripts/kconfig: mconf

    Please cut off such garbage from yoour patches...

WBR, Sergei
