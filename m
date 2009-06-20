From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Intel graphics and kernel RT failurery
Date: Sat, 20 Jun 2009 17:35:56 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0906201725020.2784@localhost.localdomain>
References: <695e1a650906041442q445109a2p5871a1ff9f1d3f5a@mail.gmail.com>  <alpine.LSU.2.00.0906050020110.8173@fbirervta.pbzchgretzou.qr> <1244164487.27779.31.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Engelhardt <jengelh@medozas.de>,
	Hector Centeno <hcengar@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:59855 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769AbZFTPgH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 20 Jun 2009 11:36:07 -0400
In-Reply-To: <1244164487.27779.31.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 4 Jun 2009, Sven-Thorsten Dietrich wrote:
> On Fri, 2009-06-05 at 00:21 +0200, Jan Engelhardt wrote:
> > 
> > 
> > Cc'ing linux-rt. Mabye someone has a flash of an idea.
> > 
> > On Thursday 2009-06-04 23:42, Hector Centeno wrote to Jan Engelhardt:
> > >
> > >I hope it is OK to contact you directly to this email. I've been
> > >trying to use your 2.6.29 RT kernel for OpenSuse 11.1 and came across
> > >some problems related to the Intel graphics driver (I have a laptop
> > >with intel GMA 950). The problem seems to be related to the new intel
> > >driver development that is going on and that seems to affect older
> > >hardware like mine. I get a constantly growing list of errors in
> > >/var/log/mesages like these:
> > >
> 
> Try this patch:
> 
> Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>
> 
> Index: b/arch/x86/mm/iomap_32.c
> ===================================================================
> --- a/arch/x86/mm/iomap_32.c
> +++ b/arch/x86/mm/iomap_32.c
> @@ -38,7 +38,7 @@ void *kmap_atomic_prot_pfn(unsigned long
>  
>  	pagefault_disable();
>  
> -	idx = type + KM_TYPE_NR * smp_processor_id();
> +	idx = type + KM_TYPE_NR * raw_smp_processor_id();
>  	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
>  	set_pte(kmap_pte - idx, pfn_pte(pfn, prot));
>  	arch_flush_lazy_mmu_mode();
> @@ -69,7 +69,7 @@ void
>  iounmap_atomic(void *kvaddr, enum km_type type)
>  {
>  	unsigned long vaddr = (unsigned long) kvaddr & PAGE_MASK;
> -	enum fixed_addresses idx = type + KM_TYPE_NR*smp_processor_id();
> +	enum fixed_addresses idx = type + KM_TYPE_NR*raw_smp_processor_id();
>  
>  	/*
>  	 * Force other mappings to Oops if they'll try to access this pte

No, that's wrong. We need to disable preemption across that
pagefault_disabled region. We might get preempted or migrated
otherwise.

Actually the correct fix for preempt-rt is to map this atomic mapping
magic to standard mappings, but that's more than a 5 minutes job.

Thanks,

	tglx
