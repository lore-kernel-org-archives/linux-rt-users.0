From: Steve Rottinger <steve@pentek.com>
Subject: Re: PREEMPT_RT + HIGHMEM = segfaults during boot on ppc32
Date: Tue, 07 Jul 2009 14:46:13 -0400
Message-ID: <4A5397F5.30500@pentek.com>
References: <4A51F4C1.6060604@pentek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: tglx@linutronix.de
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.pentek.com ([12.35.250.145]:1083 "HELO mailhost.pentek.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753394AbZGGSrW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jul 2009 14:47:22 -0400
In-Reply-To: <4A51F4C1.6060604@pentek.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas,

This patch solved my problem.

Thanks!

-Steve

Thomas Gleixner wrote:

> does the patch below help ?
>
> Thanks,
>
>	tglx
> ---
> Subject: powerpc-fixup-pagefault-disable-changes.patch
> From: Thomas Gleixner <tglx@xxxxxxxxxxxxx>
> Date: Mon, 06 Jul 2009 17:36:01 +0200
>
> Signed-off-by: Thomas Gleixner <tglx@xxxxxxxxxxxxx>
> ---
> arch/powerpc/include/asm/highmem.h |    3 +++
> 1 file changed, 3 insertions(+)
>
> Index: linux-2.6-tip/arch/powerpc/include/asm/highmem.h
> ===================================================================
> --- linux-2.6-tip.orig/arch/powerpc/include/asm/highmem.h
> +++ linux-2.6-tip/arch/powerpc/include/asm/highmem.h
> @@ -90,6 +90,7 @@ static inline void *kmap_atomic_prot(str
>  	unsigned long vaddr;
>
>  	/* even !CONFIG_PREEMPT needs this, for in_atomic in
> do_page_fault */
> +	preempt_disable();
> 	pagefault_disable();
> 	if (!PageHighMem(page))
> 		return page_address(page);
> @@ -118,6 +119,7 @@ static inline void kunmap_atomic(void *k
>
> 	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
> 		pagefault_enable();
> +		preempt_enable();
> 		return;
> 	}
>
> @@ -131,6 +133,7 @@ static inline void kunmap_atomic(void *k
>  	local_flush_tlb_page(NULL, vaddr);
>  #endif
> 	pagefault_enable();
> +	preempt_enable();
> }
>
> static inline struct page *kmap_atomic_to_page(void *ptr)
