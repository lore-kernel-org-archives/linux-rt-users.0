From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT LATENCY] 249 microsecond latency caused by slub's
 unfreeze_partials() code.
Date: Mon, 08 Apr 2013 08:25:26 -0400
Message-ID: <1365423926.25498.3.camel@gandalf.local.home>
References: <1364010673.6345.156.camel@gandalf.local.home>
	 <0000013da1f93be3-c3d42ae8-ff34-4c63-8094-77a83291ea19-000000@email.amazonses.com>
	 <1364227073.6345.182.camel@gandalf.local.home>
	 <1364228039.6345.183.camel@gandalf.local.home>
	 <0000013da2ace21a-9e87fe8a-75c2-4b7c-b5e1-37ad196ce012-000000@email.amazonses.com>
	 <1364234613.6345.184.camel@gandalf.local.home>
	 <0000013da2ce20f8-0e3a64ef-67ed-4ab4-9f20-b77980c876c3-000000@email.amazonses.com>
	 <1364236355.6345.185.camel@gandalf.local.home>
	 <20130327025957.GA17125@lge.com>
	 <1364355032.6345.200.camel@gandalf.local.home>
	 <20130327061351.GB17125@lge.com>
	 <0000013db20bb0bd-221640a3-e8f8-4140-a3d7-d8e129632ffe-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <clark@redhat.com>,
	Pekka Enberg <penberg@kernel.org>
To: Christoph Lameter <cl@linux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000013db20bb0bd-221640a3-e8f8-4140-a3d7-d8e129632ffe-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Sorry for the late reply, but I just got back from vacation.

On Thu, 2013-03-28 at 17:29 +0000, Christoph Lameter wrote:
> Two patches against slub to enable deconfiguring cpu_partial support.
> 
> First one is a bug fix (Pekka please pick up this one or use Joonsoo's
> earlier one).
> 
> 
> Subject: slub: Fix object counts in acquire_slab
> 
> It seems that we were overallocating objects from the slab queues
> since get_partial_node() assumed that page->inuse was undisturbed by
> acquire_slab(). Save the # of objects in page->lru.next in acquire_slab()
> and pass it to get_partial_node() that way.
> 
> I have a vague memory that Joonsoo also ran into this issue awhile back.
> 
> Signed-off-by: Christoph Lameter <cl@linux.com>
> 
> Index: linux/mm/slub.c
> ===================================================================
> --- linux.orig/mm/slub.c	2013-03-28 12:14:26.958358688 -0500
> +++ linux/mm/slub.c	2013-03-28 12:16:57.240785613 -0500
> @@ -1498,6 +1498,7 @@ static inline void *acquire_slab(struct
>  	void *freelist;
>  	unsigned long counters;
>  	struct page new;
> +	unsigned long objects;
> 
>  	/*
>  	 * Zap the freelist and set the frozen bit.
> @@ -1507,6 +1508,7 @@ static inline void *acquire_slab(struct
>  	freelist = page->freelist;
>  	counters = page->counters;
>  	new.counters = counters;
> +	objects = page->objects;
>  	if (mode) {
>  		new.inuse = page->objects;
>  		new.freelist = NULL;
> @@ -1524,6 +1526,7 @@ static inline void *acquire_slab(struct
>  		return NULL;
> 
>  	remove_partial(n, page);
> +	page->lru.next = (void *)objects;
>  	WARN_ON(!freelist);
>  	return freelist;
>  }
> @@ -1565,7 +1568,7 @@ static void *get_partial_node(struct kme
>  			c->page = page;
>  			stat(s, ALLOC_FROM_PARTIAL);
>  			object = t;
> -			available =  page->objects - page->inuse;
> +			available =  page->objects - (unsigned long)page->lru.next;

Ug, this is a really nasty hack. To avoid the curses you will get by the
one that takes over this code when you retire, I suggest just have
"objects" passed back as a reference parameter. I only see
acquire_slab() used here. Why not just pass in a pointer and have that
assigned objects instead of using a error prone use of lru.next?

-- Steve

>  		} else {
>  			available = put_cpu_partial(s, page, 0);
>  			stat(s, CPU_PARTIAL_NODE);
