From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: RT trees fail ltp futex_wait04  - culprit=65d8fc777f6d (futex:
 Remove requirement for lock_page() in get_futex_key())
Date: Sat, 04 Jun 2016 16:53:47 +0200
Message-ID: <1465052027.4104.19.camel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Mel Gorman <mgorman@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33610 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbcFDOxv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 4 Jun 2016 10:53:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id a136so5762416wme.0
        for <linux-rt-users@vger.kernel.org>; Sat, 04 Jun 2016 07:53:50 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Mel,

Doing some RT tree consolidation this weekend to see what I should try
to upstream, I found that 4.[67]-rt trees fail ltp futex_wait04, and
tracked it down to commit in $subject.

Looking at that commit, I recalled it being in SLE, and SLERT working
just fine, so I went to see what a futex.c diff looked like.  Taking
what was left after tossing THP bits (irrelevant to RT) and applying
that to my RT trees fixes the testcase failure.

Snarfed-and-munged-by: Mike Galbraith <umgwanakikbuti@gmail.com>
---
 kernel/futex.c |   39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -469,7 +469,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
-	struct page *page;
+	struct page *page, *page_head;
 	struct address_space *mapping;
 	int err, ro = 0;
 
@@ -520,6 +520,12 @@ get_futex_key(u32 __user *uaddr, int fsh
 	else
 		err = 0;
 
+	page_head = compound_head(page);
+	if (page != page_head) {
+		get_page(page_head);
+		put_page(page);
+	}
+
 	/*
 	 * The treatment of mapping from this point on is critical. The page
 	 * lock protects many things but in this context the page lock
@@ -531,11 +537,10 @@ get_futex_key(u32 __user *uaddr, int fsh
 	 * From this point on, mapping will be re-verified if necessary and
 	 * page lock will be acquired only if it is unavoidable
 	 */
-	page = compound_head(page);
-	mapping = READ_ONCE(page->mapping);
+	mapping = READ_ONCE(page_head->mapping);
 
 	/*
-	 * If page->mapping is NULL, then it cannot be a PageAnon
+	 * If mapping is NULL, then it cannot be a PageAnon
 	 * page; but it might be the ZERO_PAGE or in the gate area or
 	 * in a special mapping (all cases which we are happy to fail);
 	 * or it may have been a good file page when get_user_pages_fast
@@ -547,7 +552,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 	 *
 	 * The case we do have to guard against is when memory pressure made
 	 * shmem_writepage move it from filecache to swapcache beneath us:
-	 * an unlikely race, but we do need to retry for page->mapping.
+	 * an unlikely race, but we do need to retry for page_head->mapping.
 	 */
 	if (unlikely(!mapping)) {
 		int shmem_swizzled;
@@ -557,10 +562,10 @@ get_futex_key(u32 __user *uaddr, int fsh
 		 * applies. If this is really a shmem page then the page lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
-		unlock_page(page);
-		put_page(page);
+		lock_page(page_head);
+		shmem_swizzled = PageSwapCache(page_head) || page_head->mapping;
+		unlock_page(page_head);
+		put_page(page_head);
 
 		if (shmem_swizzled)
 			goto again;
@@ -578,7 +583,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 	 * it's a read-only handle, it's expected that futexes attach to
 	 * the object not the particular process.
 	 */
-	if (PageAnon(page)) {
+	if (PageAnon(page_head)) {
 		/*
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
@@ -599,8 +604,8 @@ get_futex_key(u32 __user *uaddr, int fsh
 
 		/*
 		 * The associated futex object in this case is the inode and
-		 * the page->mapping must be traversed. Ordinarily this should
-		 * be stabilised under page lock but it's not strictly
+		 * the page_head->mapping must be traversed. Ordinarily this
+		 * should be stabilised under page lock but it's not strictly
 		 * necessary in this case as we just want to pin the inode, not
 		 * update the radix tree or anything like that.
 		 *
@@ -610,9 +615,9 @@ get_futex_key(u32 __user *uaddr, int fsh
 		 */
 		rcu_read_lock();
 
-		if (READ_ONCE(page->mapping) != mapping) {
+		if (READ_ONCE(page_head->mapping) != mapping) {
 			rcu_read_unlock();
-			put_page(page);
+			put_page(page_head);
 
 			goto again;
 		}
@@ -620,7 +625,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 		inode = READ_ONCE(mapping->host);
 		if (!inode) {
 			rcu_read_unlock();
-			put_page(page);
+			put_page(page_head);
 
 			goto again;
 		}
@@ -638,7 +643,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 		 */
 		if (WARN_ON_ONCE(!atomic_inc_not_zero(&inode->i_count))) {
 			rcu_read_unlock();
-			put_page(page);
+			put_page(page_head);
 
 			goto again;
 		}
@@ -659,7 +664,7 @@ get_futex_key(u32 __user *uaddr, int fsh
 	}
 
 out:
-	put_page(page);
+	put_page(page_head);
 	return err;
 }
 
