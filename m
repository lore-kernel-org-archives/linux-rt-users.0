From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [4.4-rc6-rt1 PATCH 0/2] ARM: am437x: boot test report
Date: Thu, 14 Jan 2016 21:30:48 +0000
Message-ID: <20160114213048.GB19062@n2100.arm.linux.org.uk>
References: <1451325611-21678-1-git-send-email-grygorii.strashko@ti.com>
 <20160112171556.GB31009@linutronix.de>
 <569637ED.1030304@ti.com>
 <5696B025.8020909@ti.com>
 <569800DD.7090102@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sekhar Nori <nsekhar@ti.com>, linux-rt-users@vger.kernel.org,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	linux-kernel@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <569800DD.7090102@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, Jan 14, 2016 at 10:11:09PM +0200, Grygorii Strashko wrote:
> diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
> index deabc36..b9b4f9c 100644
> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -167,7 +167,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
>          * Clear @prev's kmap_atomic mappings
>          */
>         for (i = 0; i < prev_p->kmap_idx; i++) {
> -               int idx = i + KM_TYPE_NR * smp_processor_id();
> +               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
>  
>                 set_fixmap_pte(idx, __pte(0));
>         }
> @@ -175,7 +175,7 @@ void switch_kmaps(struct task_struct *prev_p, struct task_struct *next_p)
>          * Restore @next_p's kmap_atomic mappings
>          */
>         for (i = 0; i < next_p->kmap_idx; i++) {
> -               int idx = i + KM_TYPE_NR * smp_processor_id();
> +               int idx = FIX_KMAP_BEGIN + i + KM_TYPE_NR * smp_processor_id();
>  
>                 if (!pte_none(next_p->kmap_pte[i]))
>                         set_fixmap_pte(idx, next_p->kmap_pte[i]);

This looks like it introduces the 4th and 5th copies of the same
calcuation, so can I suggest that we do this to prevent this kind
of error?

diff --git a/arch/arm/mm/highmem.c b/arch/arm/mm/highmem.c
index d02f8187b1cc..61f0d5941116 100644
--- a/arch/arm/mm/highmem.c
+++ b/arch/arm/mm/highmem.c
@@ -34,6 +34,11 @@ static inline pte_t get_fixmap_pte(unsigned long vaddr)
 	return *ptep;
 }
 
+static unsigned int fixmap_idx(int type)
+{
+	return FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
+}
+
 void *kmap(struct page *page)
 {
 	might_sleep();
@@ -79,7 +84,7 @@ void *kmap_atomic(struct page *page)
 
 	type = kmap_atomic_idx_push();
 
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
+	idx = fixmap_idx(type);
 	vaddr = __fix_to_virt(idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
 	/*
@@ -106,7 +111,7 @@ void __kunmap_atomic(void *kvaddr)
 
 	if (kvaddr >= (void *)FIXADDR_START) {
 		type = kmap_atomic_idx();
-		idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
+		idx = fixmap_idx(type);
 
 		if (cache_is_vivt())
 			__cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
@@ -138,7 +143,7 @@ void *kmap_atomic_pfn(unsigned long pfn)
 		return page_address(page);
 
 	type = kmap_atomic_idx_push();
-	idx = FIX_KMAP_BEGIN + type + KM_TYPE_NR * smp_processor_id();
+	idx = fixmap_idx(type);
 	vaddr = __fix_to_virt(idx);
 #ifdef CONFIG_DEBUG_HIGHMEM
 	BUG_ON(!pte_none(get_fixmap_pte(vaddr)));


-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
