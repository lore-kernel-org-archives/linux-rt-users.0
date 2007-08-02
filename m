From: Satyam Sharma <satyam@infradead.org>
Subject: Re: Section mismatch: reference to .init.text: (between 'kthreadd'
 and 'init_waitqueue_head')
Date: Thu, 2 Aug 2007 16:05:24 +0530 (IST)
Message-ID: <alpine.LFD.0.999.0708021603380.8258@enigma.security.iitk.ac.in>
References: <46B1A9DE.4090907@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:50038 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbXHBKW7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 2 Aug 2007 06:22:59 -0400
In-Reply-To: <46B1A9DE.4090907@free.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Thu, 2 Aug 2007, John Sigler wrote:

> Hello,
> 
> I'm trying to build a 2.6.22.1-rt9 kernel for a P3.
> 
> I used 'make xconfig' to create .config
> http://linux.kernel.free.fr/latency/config-2.6.22.1-rt9-adlink
> 
> I get the following warning:
> 
>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   MODPOST vmlinux
> WARNING: kernel/built-in.o(.text+0x19152): Section mismatch: reference to
> .init.text: (between 'kthreadd' and 'init_waitqueue_head')

This is a bogus warning, already taken care of in 2.6.23-rc1-latestgit.

> Finally, I note that X86_CMPXCHG64 is no longer defined since its
> specification was changed between 2.6.20 and 2.6.22.
> 
>  config X86_CMPXCHG64
>     bool
> -   depends on !M386 && !M486
> +   depends on X86_PAE
>     default y
> 
> Will this have an impact on spinlocks? RCU? something else?

No idea about this one.
