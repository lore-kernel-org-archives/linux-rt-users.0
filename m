From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/1] ARM mm: Fix RT life lock on ASID rollover
Date: Wed, 5 Jun 2013 11:17:25 +0100
Message-ID: <20130605101725.GC8577@mudshark.cambridge.arm.com>
References: <20130604211255.861340476@osadl.org>
 <20130604212217.241724859@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: RT-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:40848 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab3FEKRr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Jun 2013 06:17:47 -0400
Content-Disposition: inline
In-Reply-To: <20130604212217.241724859@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Carsten,

On Tue, Jun 04, 2013 at 10:12:56PM +0100, Carsten Emde wrote:
> The original mechanism to synchronize all online CPUs after ASID
> reallocation used an IPI mechanism with IRQs enabled. This is a valid
> mechanism in mainline. An RT kernel, however, may hang forever due to a
> life lock between sending the IPI and waiting for the ASID lock to be
> freed. Such hangers were observed and analyzed using JTAG hardware
> debugging on an OMAP4430 board. Mean uptime was about two days with a
> maximum of seven days observed once.
> 
> In 2012, Will Deacon provided a new ASID rollover synchronization
> mechanism without IPI broadcasting. This *improved* a suboptimal
> implementation in mainline - but it *fixed* a disastrous bug in RT
> kernels that was extremely hard to decode.

Ha, that's a nice and unanticipated side-effect :)

> Original commits:
> 
> 37f47e3d62533c931b04cb409f2eb299e6342331
> ARM: 7658/1: mm: fix race updating mm->context.id on ASID rollover
> 
> bf51bb82ccd9a74e9702d06107b23e54b27a5707
> ARM: mm: use bitmap operations when allocating new ASIDs
> 
> 4b883160835faf38c9356f0885cf491a1e661e88
> ARM: mm: avoid taking ASID spinlock on fastpath
> 
> b5466f8728527a05a493cc4abe9e6f034a1bbaab
> ARM: mm: remove IPI broadcasting on ASID rollover

You seem to have a few extra bits and pieces in here, which you might not
care about:

> Index: linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
> ===================================================================
> --- linux-3.0.80-rt108.orig/arch/arm/include/asm/tlbflush.h
> +++ linux-3.0.80-rt108/arch/arm/include/asm/tlbflush.h
> @@ -14,7 +14,6 @@
> 
>  #include <asm/glue.h>
> 
> -#define TLB_V3_PAGE    (1 << 0)
>  #define TLB_V4_U_PAGE  (1 << 1)
>  #define TLB_V4_D_PAGE  (1 << 2)
>  #define TLB_V4_I_PAGE  (1 << 3)
> @@ -22,7 +21,6 @@
>  #define TLB_V6_D_PAGE  (1 << 5)
>  #define TLB_V6_I_PAGE  (1 << 6)
> 
> -#define TLB_V3_FULL    (1 << 8)
>  #define TLB_V4_U_FULL  (1 << 9)
>  #define TLB_V4_D_FULL  (1 << 10)
>  #define TLB_V4_I_FULL  (1 << 11)
> @@ -34,16 +32,15 @@
>  #define TLB_V6_D_ASID  (1 << 17)
>  #define TLB_V6_I_ASID  (1 << 18)
> 
> -#define TLB_BTB                (1 << 28)
> +#define TLB_V6_BP      (1 << 19)

This hunk (and related ones) are from a patch adding branch predictor
maintenance that I also wrote. It's harmless, but you likely don't need
it.

> +#ifdef CONFIG_ARM_ERRATA_798181
> +static inline void dummy_flush_tlb_a15_erratum(void)
> +{
> +       /*
> +        * Dummy TLBIMVAIS. Using the unmapped address 0 and ASID 0.
> +        */
> +       asm("mcr p15, 0, %0, c8, c3, 1" : : "r" (0));
> +       dsb();
> +}
> +#else
> +static inline void dummy_flush_tlb_a15_erratum(void)
> +{
> +}
> +#endif

And this is an A15 erratum workaround from Catalin. Actually, the original
version of that workaround didn't interact nicely with PREEMPT kernels, so
you should double-check what you've got (it was fixed recently in mainline).

Furthermore, the workaround requires IPIs on TLB invalidation, so you might
have your livelock problem again...

>  /*
> Index: linux-3.0.80-rt108/arch/arm/mm/alignment.c
> ===================================================================
> --- linux-3.0.80-rt108.orig/arch/arm/mm/alignment.c
> +++ linux-3.0.80-rt108/arch/arm/mm/alignment.c
> @@ -819,6 +819,7 @@ do_alignment(unsigned long addr, unsigne
>                 break;
> 
>         case 0x08000000:        /* ldm or stm, or thumb-2 32bit instruction */
> +               offset.un = 0;
>                 if (thumb2_32b)
>                         handler = do_alignment_t32_to_handler(&instr, regs, &offset);
>                 else

Unrelated?

Will
