From: Steven Rostedt <rostedt-nx8X9YLhiw1AfugRpC6u6w@public.gmane.org>
Subject: [PATCH RT 12/15] iommu/amd: Use raw_cpu_ptr() instead of
	get_cpu_ptr() for ->flush_queue
Date: Fri, 01 Dec 2017 10:48:49 -0500
Message-ID: <20171201154913.211774599@goodmis.org>
References: <20171201154837.379265211@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: tom.zanussi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Daniel Wagner <daniel.wagner-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
	Julia Cartwright <julia-acOepvfBmUk@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Vinod Adhikary <vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carsten Emde <C.Emde-Q945KHDl0DbYtjvyW6yDsg@public.gmane.org>,
	Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>,
	iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Alex Shi <alex.shi-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	rt-stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Kacur <jkacur-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rt-users <linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline;
	filename=0012-iommu-amd-Use-raw_cpu_ptr-instead-of-get_cpu_ptr-for.patch
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

4.9.65-rt57-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

get_cpu_ptr() disabled preemption and returns the ->flush_queue object
of the current CPU. raw_cpu_ptr() does the same except that it not
disable preemption which means the scheduler can move it to another CPU
after it obtained the per-CPU object.
In this case this is not bad because the data structure itself is
protected with a spin_lock. This change shouldn't matter however on RT
it does because the sleeping lock can't be accessed with disabled
preemption.

Cc: rt-stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Reported-by: Vinod Adhikary <vinadhy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
---
 drivers/iommu/amd_iommu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index a88595b21111..ff5c2424eb9e 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2283,7 +2283,7 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 	pages     = __roundup_pow_of_two(pages);
 	address >>= PAGE_SHIFT;
 
-	queue = get_cpu_ptr(&flush_queue);
+	queue = raw_cpu_ptr(&flush_queue);
 	spin_lock_irqsave(&queue->lock, flags);
 
 	if (queue->next == FLUSH_QUEUE_SIZE)
@@ -2300,8 +2300,6 @@ static void queue_add(struct dma_ops_domain *dma_dom,
 
 	if (atomic_cmpxchg(&queue_timer_on, 0, 1) == 0)
 		mod_timer(&queue_timer, jiffies + msecs_to_jiffies(10));
-
-	put_cpu_ptr(&flush_queue);
 }
 
 
-- 
2.13.2
