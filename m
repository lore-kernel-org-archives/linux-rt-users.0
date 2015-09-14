From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: PowerPC: massive "scheduling while atomic" reports
Date: Tue, 15 Sep 2015 00:05:31 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1509142235440.3971@nanos>
References: <201509101106.56931.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Juergen Borleis <jbe@pengutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201509101106.56931.jbe@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 10 Sep 2015, Juergen Borleis wrote:

Please CC lkml on bug reports for RT.

> When running the system at least every other boot this kernel spits out
> massive "scheduling while atomic" reports.

I doubt that this only happens on every other boot. This is a
systematic failure.

> Anyone with an idea what's going wrong here? I already tried with some
> debug options enabled but the highly optimised code confuses me where and
> what the code does.

Let's look at the confusing problem.
 
> [c3ba1cb0] [c0352d64] rt_spin_lock+0x34/0x64
> [c3ba1cc0] [c007f144] __lru_cache_add+0x30/0x10c
> [c3ba1cd0] [c0092064] handle_mm_fault+0xbb8/0x158c

> [c3ab7dd0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
> [c3ab7de0] [c0090b28] copy_page_range+0x154/0x478
> [c3ab7e60] [c0015530] copy_process.part.62+0xb84/0x1204

> [c3be7e80] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
> [c3be7e90] [c0092028] handle_mm_fault+0xb7c/0x158c
> [c3be7f00] [c000ea78] do_page_fault+0x33c/0x550
> [c3be7f40] [c000dda4] handle_page_fault+0xc/0x80

> [c2cd5bc0] [c0352d64] rt_spin_lock+0x34/0x64
> [c2cd5bd0] [c007a068] get_page_from_freelist+0x148/0x6cc
> [c2cd5c50] [c007a710] __alloc_pages_nodemask+0x124/0x5f0
> [c2cd5cc0] [c007abf8] __get_free_pages+0x1c/0x50
> [c2cd5cd0] [c008f958] __tlb_remove_page+0x6c/0xcc
> [c2cd5ce0] [c009064c] unmap_single_vma+0x2e0/0x430
> [c2cd5d60] [c0090e98] unmap_vmas+0x4c/0x5c

> [c3b5fdc0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
> [c3b5fdd0] [c008dbac] follow_page_mask+0xa8/0x388
> [c3b5fe00] [c008e000] __get_user_pages.part.26+0x174/0x358
> [c3b5fe60] [c00adad8] copy_strings+0x158/0x2a0

> [c3b5fdb0] [c0352d5c] rt_spin_lock+0x2c/0x64 (unreliable)
> [c3b5fdc0] [c0090508] unmap_single_vma+0x19c/0x430
> [c3b5fe40] [c0090e98] unmap_vmas+0x4c/0x5c

All of these:

   - call rt_spin_lock with preemption disabled
   - are related to mm functions

So something in the mm code is causing that issue. The interesting
part are the call chains which lead to rt_spin_lock.

#1

> [c3ba1cb0] [c0352d64] rt_spin_lock+0x34/0x64
> [c3ba1cc0] [c007f144] __lru_cache_add+0x30/0x10c
> [c3ba1cd0] [c0092064] handle_mm_fault+0xbb8/0x158c

__lru_cache_add is called via a wrapper from handle_mm_fault()

# git grep -n lru_cache mm/memory.c
mm/memory.c:2116:               lru_cache_add_active_or_unevictable(new_page, vma);
mm/memory.c:2575:               lru_cache_add_active_or_unevictable(page, vma);
mm/memory.c:2717:       lru_cache_add_active_or_unevictable(page, vma);
mm/memory.c:3008:       lru_cache_add_active_or_unevictable(new_page, vma);

Not very helpful at the first glance, so lets look at the next one:

#2

copy_page_range() looks pretty innocent unless you follow the do {}
while loop:

      copy_pud_range
        copy_pmd_range
	  copy_pte_range

That one fiddles with two spinlocks:

     spinlock_t *src_ptl, *dst_ptl;

And one of them seems to be taken in

    dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);

That's defined in include/linux/mm.h:

#define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
	((unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, NULL,	\
							pmd, address))?	\
		NULL: pte_offset_map_lock(mm, pmd, address, ptlp))

pte_offset_map_lock() does:

#define pte_offset_map_lock(mm, pmd, address, ptlp)	\
({							\
	spinlock_t *__ptl = pte_lockptr(mm, pmd);	\
	pte_t *__pte = pte_offset_map(pmd, address);	\
	*(ptlp) = __ptl;				\
	spin_lock(__ptl);				\
	__pte;						\
})

Let's look at the lru_cache_add_active_or_unevictable() once
more. They have a very similar construct:

      spinlock_t *ptl = NULL;

      ...
     
      page_table = pte_offset_map_lock(mm, pmd, address, &ptl); 

So we found a commonality. Lets look at pte_offset_map(), which is
defined in arch/powerpc/include/asm/pgtable-ppc32.h:

#define pte_offset_map(dir, addr)               \
        ((pte_t *) kmap_atomic(pmd_page(*(dir))) + pte_index(addr))

So we need to look at kmap_atomic(), which is defined in
include/linux/highmem.h:

static inline void *kmap_atomic(struct page *page)
{
	preempt_disable();
	pagefault_disable();
	return page_address(page);
}

Now that's weird. Why is that not exploding on x86_32?

Because it's conditional:

#ifndef ARCH_HAS_KMAP

Hmm, no. ARCH_HAS_KMAP is only defined by PARISC. But it's also
conditional on:

#ifdef CONFIG_HIGHMEM

which is usually enabled on x86_32.

So now if you look at the changes to the highmem implementation on x86
and ARM, you'll notice that there is:

-	preempt_disable();
+	preempt_disable_nort();
	pagefault_disable();

We never converted PPC to the RT-safe variant of highmem kmaps, so
CONFIG_HIGHMEM is disabled on RT_FULL for PPC and it has to use the
!HIGHMEM variant.

Looking at older RT kernels, we never had to deal with that
preempt_disable() in the !HIGHMEM variant. Simply because that did not
exist. It got introduced via the mainline patchset which decouples
pagefault disable from preemption disable. That patchset is a generic
variant of the changes which we had in RT for a long time.

4.1-rt simply overlooked that preempt_disable/enable pair in the
!HIGHMEM variant of k[un]map_atomic. Fix is below.

If you encounter such a 'confusing' problem the next time, then look
out for commonalities, AKA patterns. 99% of all problems can be
decoded via patterns. And if you look at the other call chains you'll
find more instances of those pte_*_lock() calls, which all end up in
kmap_atomic().

Thanks,

	tglx

------------->

--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -66,7 +66,7 @@ static inline void kunmap(struct page *page)
 
 static inline void *kmap_atomic(struct page *page)
 {
-	preempt_disable();
+	preempt_disable_nort();
 	pagefault_disable();
 	return page_address(page);
 }
@@ -75,7 +75,7 @@ static inline void *kmap_atomic(struct page *page)
 static inline void __kunmap_atomic(void *addr)
 {
 	pagefault_enable();
-	preempt_enable();
+	preempt_enable_nort();
 }
 
 #define kmap_atomic_pfn(pfn)	kmap_atomic(pfn_to_page(pfn))
