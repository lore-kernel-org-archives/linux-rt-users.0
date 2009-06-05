From: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Subject: Re: Intel graphics and kernel RT failure
Date: Thu, 04 Jun 2009 18:14:47 -0700
Message-ID: <1244164487.27779.31.camel@quadrophenia.thebigcorporation.com>
References: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>
	 <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Hector Centeno <hcengar@gmail.com>, linux-rt-users@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.169]:15261 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbZFEBOr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 4 Jun 2009 21:14:47 -0400
Received: by wf-out-1314.google.com with SMTP id 26so537600wfd.4
        for <linux-rt-users@vger.kernel.org>; Thu, 04 Jun 2009 18:14:49 -0700 (PDT)
In-Reply-To: <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-06-05 at 00:21 +0200, Jan Engelhardt wrote:
> 
> 
> Cc'ing linux-rt. Mabye someone has a flash of an idea.
> 
> On Thursday 2009-06-04 23:42, Hector Centeno wrote to Jan Engelhardt:
> >
> >I hope it is OK to contact you directly to this email. I've been
> >trying to use your 2.6.29 RT kernel for OpenSuse 11.1 and came across
> >some problems related to the Intel graphics driver (I have a laptop
> >with intel GMA 950). The problem seems to be related to the new intel
> >driver development that is going on and that seems to affect older
> >hardware like mine. I get a constantly growing list of errors in
> >/var/log/mesages like these:
> >

Try this patch:

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>

Index: b/arch/x86/mm/iomap_32.c
===================================================================
--- a/arch/x86/mm/iomap_32.c
+++ b/arch/x86/mm/iomap_32.c
@@ -38,7 +38,7 @@ void *kmap_atomic_prot_pfn(unsigned long
 
 	pagefault_disable();
 
-	idx = type + KM_TYPE_NR * smp_processor_id();
+	idx = type + KM_TYPE_NR * raw_smp_processor_id();
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
 	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
 	arch_flush_lazy_mmu_mode();
@@ -69,7 +69,7 @@ void
 iounmap_atomic(void *kvaddr, enum km_type type)
 {
 	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
-	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
+	enum fixed_addresses idx = type + KM_TYPE_NR*raw_smp_processor_id();
 
 	/*
 	 * Force other mappings to Oops if they'll try to access this pte



