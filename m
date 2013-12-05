From: "Hong H. Pham" <hong.pham@windriver.com>
Subject: [PATCH] powerpc: Fix PTE page address mismatch in pgtable ctor/dtor
Date: Thu, 5 Dec 2013 10:54:54 -0500
Message-ID: <1386258894-21851-1-git-send-email-hong.pham@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Hong H. Pham" <hong.pham@windriver.com>,
	Paul Mackerras <paulus@samba.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linux-stable <stable@vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:63417 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545Ab3LEPzr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 10:55:47 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

In pte_alloc_one(), pgtable_page_ctor() is passed an address that has
not been converted by page_address() to the newly allocated PTE page.

When the PTE is freed, __pte_free_tlb() calls pgtable_page_dtor()
with an address to the PTE page that has been converted by page_address().
The mismatch in the PTE's page address causes pgtable_page_dtor() to access
invalid memory, so resources for that PTE (such as the page lock) is not
properly cleaned up.

This bug was introduced by commit d614bb041209fd7cb5e4b35e11a7b2f6ee8f62b8
"powerpc: Move the pte free routines from common header".

On a preempt-rt kernel, a spinlock is dynamically allocated for each
PTE in pgtable_page_ctor().  When the PTE is freed, calling
pgtable_page_dtor() with a mismatched page address causes a memory leak,
as the pointer to the PTE's spinlock is bogus.

On mainline, there isn't any immediately obvious symptoms, but the
problem still exists here.

Fixes: d614bb041209fd7c "powerpc: Move the pte free routes from common header"
Cc: Paul Mackerras <paulus@samba.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-stable <stable@vger.kernel.org> # v3.10+
Signed-off-by: Hong H. Pham <hong.pham@windriver.com>
---
 arch/powerpc/include/asm/pgalloc-32.h | 2 +-
 arch/powerpc/include/asm/pgalloc-64.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
index 27b2386..7ff24f0 100644
--- a/arch/powerpc/include/asm/pgalloc-32.h
+++ b/arch/powerpc/include/asm/pgalloc-32.h
@@ -87,7 +87,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	struct page *page = page_address(table);
 
 	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(page);
+	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page, 0);
 }
 #endif /* _ASM_POWERPC_PGALLOC_32_H */
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index f65e27b..b187dc5 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -147,7 +147,7 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 	struct page *page = page_address(table);
 
 	tlb_flush_pgtable(tlb, address);
-	pgtable_page_dtor(page);
+	pgtable_page_dtor(table);
 	pgtable_free_tlb(tlb, page, 0);
 }
 
-- 
1.8.3.2

