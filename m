From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Fix PTE page address mismatch in pgtable ctor/dtor
Date: Fri, 06 Dec 2013 16:08:19 +0530
Message-ID: <874n6muuw4.fsf@linux.vnet.ibm.com>
References: <1386258894-21851-1-git-send-email-hong.pham@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Hong H. Pham" <hong.pham@windriver.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-stable <stable@vger.kernel.org>
To: "Hong H. Pham" <hong.pham@windriver.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1386258894-21851-1-git-send-email-hong.pham@windriver.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

"Hong H. Pham" <hong.pham@windriver.com> writes:

> In pte_alloc_one(), pgtable_page_ctor() is passed an address that has
> not been converted by page_address() to the newly allocated PTE page.
>
> When the PTE is freed, __pte_free_tlb() calls pgtable_page_dtor()
> with an address to the PTE page that has been converted by page_address().
> The mismatch in the PTE's page address causes pgtable_page_dtor() to access
> invalid memory, so resources for that PTE (such as the page lock) is not
> properly cleaned up.
>
> This bug was introduced by commit d614bb041209fd7cb5e4b35e11a7b2f6ee8f62b8
> "powerpc: Move the pte free routines from common header".
>
> On a preempt-rt kernel, a spinlock is dynamically allocated for each
> PTE in pgtable_page_ctor().  When the PTE is freed, calling
> pgtable_page_dtor() with a mismatched page address causes a memory leak,
> as the pointer to the PTE's spinlock is bogus.
>
> On mainline, there isn't any immediately obvious symptoms, but the
> problem still exists here.


can you also specifiy the config details here. ie, 4K page size functions
are broken ?

>
> Fixes: d614bb041209fd7c "powerpc: Move the pte free routes from common header"
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: linux-stable <stable@vger.kernel.org> # v3.10+
> Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
> ---
>  arch/powerpc/include/asm/pgalloc-32.h | 2 +-
>  arch/powerpc/include/asm/pgalloc-64.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
> index 27b2386..7ff24f0 100644
> --- a/arch/powerpc/include/asm/pgalloc-32.h
> +++ b/arch/powerpc/include/asm/pgalloc-32.h
> @@ -87,7 +87,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  	struct page *page = page_address(table);
>
>  	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(page);
> +	pgtable_page_dtor(table);
>  	pgtable_free_tlb(tlb, page, 0);
>  }
>  #endif /* _ASM_POWERPC_PGALLOC_32_H */
> diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
> index f65e27b..b187dc5 100644
> --- a/arch/powerpc/include/asm/pgalloc-64.h
> +++ b/arch/powerpc/include/asm/pgalloc-64.h
> @@ -147,7 +147,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  	struct page *page = page_address(table);


That one is also wrong right ? why not 

>
>  	tlb_flush_pgtable(tlb, address);
> -	pgtable_page_dtor(page);
> +	pgtable_page_dtor(table);
>  	pgtable_free_tlb(tlb, page, 0);
>  }
>

make it closer to what it was before,

pgtable_page_dtor(table);
pgtable_free_tlb(tlb, page_address(table), 0);

This is what we had before

-static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
-                                 unsigned long address)
-{
-       tlb_flush_pgtable(tlb, address);
-       pgtable_page_dtor(ptepage);
-       pgtable_free_tlb(tlb, page_address(ptepage), 0);
-}


-aneesh
