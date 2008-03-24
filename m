From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Subject: [PATCH -rt] avoid deadlock related with PG_nonewrefs and swap_lock
Date: Mon, 24 Mar 2008 11:24:17 -0700
Message-ID: <47E7F1D1.6010407@ct.jp.nec.com>
References: <47DEB7F0.8040207@ct.jp.nec.com>	 <47DF097B.4090200@ct.jp.nec.com>	 <Pine.LNX.4.58.0803172150360.8231@gandalf.stny.rr.com> <1205833218.8514.338.camel@twins>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763545AbYCXSYf@vger.kernel.org>
In-Reply-To: <1205833218.8514.338.camel@twins>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Peter,

I've updated the patch. Could you please review it?

I'm also thinking that it can be in the mainline because it makes
the lock period shorter, correct?

---
From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

There is a deadlock scenario; remove_mapping() vs free_swap_and_cache().
remove_mapping() turns PG_nonewrefs bit on, then locks swap_lock.
free_swap_and_cache() locks swap_lock, then wait to turn PG_nonewrefs bit
off in find_get_page().

swap_lock can be unlocked before calling find_get_page().

In remove_exclusive_swap_page(), there is similar lock sequence;
swap_lock, then PG_nonewrefs bit. swap_lock can be unlocked before
turning PG_nonewrefs bit on.

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---
 mm/swapfile.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5036b70..6fbc77e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -366,6 +366,7 @@ int remove_exclusive_swap_page(struct page *page)
 	/* Is the only swap cache user the cache itself? */
 	retval = 0;
 	if (p->swap_map[swp_offset(entry)] == 1) {
+		spin_unlock(&swap_lock);
 		/* Recheck the page count with the swapcache lock held.. */
 		lock_page_ref_irq(page);
 		if ((page_count(page) == 2) && !PageWriteback(page)) {
@@ -374,8 +375,8 @@ int remove_exclusive_swap_page(struct page *page)
 			retval = 1;
 		}
 		unlock_page_ref_irq(page);
-	}
-	spin_unlock(&swap_lock);
+	} else
+		spin_unlock(&swap_lock);
 
 	if (retval) {
 		swap_free(entry);
@@ -400,13 +401,14 @@ void free_swap_and_cache(swp_entry_t entry)
 	p = swap_info_get(entry);
 	if (p) {
 		if (swap_entry_free(p, swp_offset(entry)) == 1) {
+			spin_unlock(&swap_lock);
 			page = find_get_page(&swapper_space, entry.val);
 			if (page && unlikely(TestSetPageLocked(page))) {
 				page_cache_release(page);
 				page = NULL;
 			}
-		}
-		spin_unlock(&swap_lock);
+		} else
+			spin_unlock(&swap_lock);
 	}
 	if (page) {
 		int one_user;
-- 
1.5.4.1
