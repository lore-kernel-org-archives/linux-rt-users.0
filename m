From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PREEMPT_RT + HIGHMEM = segfaults during boot on ppc32
Date: Mon, 6 Jul 2009 17:43:25 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0907061730560.19480@localhost.localdomain>
References: <4A4D161D.6080405@pentek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Steve Rottinger <steve@pentek.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47755 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754889AbZGFPoN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Jul 2009 11:44:13 -0400
In-Reply-To: <4A4D161D.6080405@pentek.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Steve,

On Thu, 2 Jul 2009, Steve Rottinger wrote:
> I'm using 2.6.29.5-rt22 on a custom ppc32 (8641D) board.  About half the
> time, the board will boot up correctly. The other half of the time, I'll
> get segfaults in various parts of the init process.  I've also noticed
> that if I remove CONFIG_HIGHMEM from my configuration, I am able to boot
> consistently without running into this problem.  Is there anyone else
> experiencing this, or does anyone have any suggestions?

does the patch below help ?

Thanks,

	tglx
---
Subject: powerpc-fixup-pagefault-disable-changes.patch
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 06 Jul 2009 17:36:01 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/include/asm/highmem.h |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6-tip/arch/powerpc/include/asm/highmem.h
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/include/asm/highmem.h
+++ linux-2.6-tip/arch/powerpc/include/asm/highmem.h
@@ -90,6 +90,7 @@ static inline void *kmap_atomic_prot(str
 	unsigned long vaddr;
 
 	/* even !CONFIG_PREEMPT needs this, for in_atomic in do_page_fault */
+	preempt_disable();
 	pagefault_disable();
 	if (!PageHighMem(page))
 		return page_address(page);
@@ -118,6 +119,7 @@ static inline void kunmap_atomic(void *k
 
 	if (vaddr < __fix_to_virt(FIX_KMAP_END)) {
 		pagefault_enable();
+		preempt_enable();
 		return;
 	}
 
@@ -131,6 +133,7 @@ static inline void kunmap_atomic(void *k
 	local_flush_tlb_page(NULL, vaddr);
 #endif
 	pagefault_enable();
+	preempt_enable();
 }
 
 static inline struct page *kmap_atomic_to_page(void *ptr)
