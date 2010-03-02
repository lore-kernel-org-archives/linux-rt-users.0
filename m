From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/2] powerpc: replace kmap_atomic with kmap in pte_offset_map
Date: Tue,  2 Mar 2010 16:51:57 -0500
Message-ID: <ffaf532c138188b526a8c623ed3c7f5067da6d68.1267566249.git.paul.gortmaker@windriver.com>
References: <1267566718-9849-1-git-send-email-paul.gortmaker@windriver.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46195 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0CBVwO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Mar 2010 16:52:14 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o22LqBa0011143
	for <linux-rt-users@vger.kernel.org>; Tue, 2 Mar 2010 13:52:11 -0800 (PST)
In-Reply-To: <1267566718-9849-1-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Kevin Hao <kexin.hao@windriver.com>

The pte_offset_map/pte_offset_map_nested use kmap_atomic to get the
virtual address for the pte table, but kmap_atomic will disable preempt.
Hence there will be call trace if we acquire a spin lock after invoking
pte_offset_map/pte_offset_map_nested in preempt-rt.  To fix it, I've
replaced kmap_atomic with kmap in these macros.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/include/asm/pgtable-ppc32.h |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 55646ad..a838099 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -307,6 +307,17 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	(((address) >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
 #define pte_offset_kernel(dir, addr)	\
 	((pte_t *) pmd_page_vaddr(*(dir)) + pte_index(addr))
+#ifdef CONFIG_PREEMPT_RT
+#define pte_offset_map(dir, addr)		\
+	((pte_t *) kmap(pmd_page(*(dir))) + pte_index(addr))
+#define pte_offset_map_nested(dir, addr)	\
+	((pte_t *) kmap(pmd_page(*(dir))) + pte_index(addr))
+
+#define pte_unmap(pte)	\
+	kunmap((struct page *)_ALIGN_DOWN((unsigned int)pte, PAGE_SIZE))
+#define pte_unmap_nested(pte)	\
+	kunmap((struct page *)_ALIGN_DOWN((unsigned int)pte, PAGE_SIZE))
+#else
 #define pte_offset_map(dir, addr)		\
 	((pte_t *) kmap_atomic(pmd_page(*(dir)), KM_PTE0) + pte_index(addr))
 #define pte_offset_map_nested(dir, addr)	\
@@ -314,6 +325,7 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 
 #define pte_unmap(pte)		kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte)	kunmap_atomic(pte, KM_PTE1)
+#endif
 
 /*
  * Encode and decode a swap entry.
-- 
1.6.5.2

