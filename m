From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/6] mm: mark all calls into the vmalloc subsystem as
        potentially sleeping
Date: Wed, 19 Oct 2016 18:31:12 +0200
Message-ID: <20161019163112.GA31091@lst.de>
References: <1476773771-11470-1-git-send-email-hch@lst.de> <1476773771-11470-3-git-send-email-hch@lst.de> <20161019111541.GQ29358@nuc-i3427.alporthouse.com> <20161019130552.GB5876@lst.de> <CALCETrVqjejgpQVUdem8RK3uxdEgfOZy4cOJqJQjCLtBDnJfyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christoph Hellwig <hch@lst.de>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>, joelaf@google.com,
        jszhang@marvell.com, joaodias@google.com,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-rt-users@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALCETrVqjejgpQVUdem8RK3uxdEgfOZy4cOJqJQjCLtBDnJfyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, Oct 19, 2016 at 08:34:40AM -0700, Andy Lutomirski wrote:
> 
> It would be quite awkward for a task stack to get freed from a
> sleepable context, because the obvious sleepable context is the task
> itself, and it still needs its stack.  This was true even in the old
> regime when task stacks were freed from RCU context.
> 
> But vfree has a magic automatic deferral mechanism.  Couldn't you make
> the non-deferred case might_sleep()?

But it's only magic from interrupt context..

Chris, does this patch make virtually mapped stack work for you again?

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f2481cb..942e02d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1533,7 +1533,7 @@ void vfree(const void *addr)
 
 	if (!addr)
 		return;
-	if (unlikely(in_interrupt())) {
+	if (in_interrupt() || in_atomic()) {
 		struct vfree_deferred *p = this_cpu_ptr(&vfree_deferred);
 		if (llist_add((struct llist_node *)addr, &p->list))
 			schedule_work(&p->wq);
