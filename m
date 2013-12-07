From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc: Fix PTE page address mismatch in pgtable
 ctor/dtor
Date: Sun, 08 Dec 2013 07:32:25 +1100
Message-ID: <1386448345.21910.106.camel@pasglop>
References: <874n6muuw4.fsf@linux.vnet.ibm.com>
	 <1386425193-24015-1-git-send-email-hong.pham@windriver.com>
	 <1386448079.21910.105.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linux-stable <stable@vger.kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: "Hong H. Pham" <hong.pham@windriver.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1386448079.21910.105.camel@pasglop>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sun, 2013-12-08 at 07:27 +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2013-12-07 at 09:06 -0500, Hong H. Pham wrote:
> 
> > diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
> > index 27b2386..842846c 100644
> > --- a/arch/powerpc/include/asm/pgalloc-32.h
> > +++ b/arch/powerpc/include/asm/pgalloc-32.h
> > @@ -84,10 +84,8 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
> >  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
> >  				  unsigned long address)
> >  {
> > -	struct page *page = page_address(table);
> > -
> >  	tlb_flush_pgtable(tlb, address);
> > -	pgtable_page_dtor(page);
> > -	pgtable_free_tlb(tlb, page, 0);
> > +	pgtable_page_dtor(table);
> > +	pgtable_free_tlb(tlb, page_address(table), 0);
> >  }
> 
> Ok so your description of the problem confused me a bit, but I see that
> in the !64K page, pgtable_t is already a struct page so yes, the
> page_address() call here is bogus.
> 
> However, I also noticed that in the 64k page case, we don't call the dto
> at all. Is that a problem ?

Actually we do, just elsewhere... ignore the above.

> Also, Aneesh, shouldn't we just fix the disconnect here and have
> pgtable_t always be the same type ? The way this is now is confusing
> and error prone...
> 
> >  #endif /* _ASM_POWERPC_PGALLOC_32_H */
> > diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
> > index f65e27b..256d6f8 100644
> > --- a/arch/powerpc/include/asm/pgalloc-64.h
> > +++ b/arch/powerpc/include/asm/pgalloc-64.h
> > @@ -144,11 +144,9 @@ static inline void pgtable_free_tlb(struct mmu_gather *tlb,
> >  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
> >  				  unsigned long address)
> >  {
> > -	struct page *page = page_address(table);
> > -
> >  	tlb_flush_pgtable(tlb, address);
> > -	pgtable_page_dtor(page);
> > -	pgtable_free_tlb(tlb, page, 0);
> > +	pgtable_page_dtor(table);
> > +	pgtable_free_tlb(tlb, page_address(table), 0);
> >  }
> >  
> >  #else /* if CONFIG_PPC_64K_PAGES */
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
