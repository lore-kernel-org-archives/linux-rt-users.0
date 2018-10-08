From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] kasan: convert kasan/quarantine_lock to raw_spinlock
Date: Sun, 7 Oct 2018 19:47:26 -0500
Message-ID: <20181007194726.78d8464f@tagon>
References: <20180918152931.17322-1-williams@redhat.com>
        <20181005163018.icbknlzymwjhdehi@linutronix.de>
        <20181005163320.zkacovxvlih6blpp@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181005163320.zkacovxvlih6blpp@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I applied this patch to a fairly stock 4.18-rt5 kernel and booted with no complaints, then
ran rteval for 12h with no stack splats reported. I'll keep banging on it but preliminary
reports look good. 

Clark

On Fri, 5 Oct 2018 18:33:20 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-10-05 18:30:18 [+0200], To Clark Williams wrote:
> > This is the minimum to get this working on RT splat free. There is one
> > memory deallocation with irqs off which should work on RT in its current
> > way.
> > Once this and the on_each_cpu() invocation, I was wondering if…  
> 
> the patch at the bottom wouldn't work just fine for everyone.
> It would have the beaty of annotating the locking scope a little and
> avoiding the on_each_cpu() invocation. No local_irq_save() but actually
> the proper locking primitives.
> I haven't fully decoded the srcu part in the code.
> 
> Wouldn't that work for you?
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  mm/kasan/quarantine.c | 45 +++++++++++++++++++++++++------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> index 3a8ddf8baf7dc..8ed595960e3c1 100644
> --- a/mm/kasan/quarantine.c
> +++ b/mm/kasan/quarantine.c
> @@ -39,12 +39,13 @@
>   * objects inside of it.
>   */
>  struct qlist_head {
> +	spinlock_t	lock;
>  	struct qlist_node *head;
>  	struct qlist_node *tail;
>  	size_t bytes;
>  };
>  
> -#define QLIST_INIT { NULL, NULL, 0 }
> +#define QLIST_INIT {.head = NULL, .tail = NULL, .bytes = 0 }
>  
>  static bool qlist_empty(struct qlist_head *q)
>  {
> @@ -95,7 +96,9 @@ static void qlist_move_all(struct qlist_head *from, struct qlist_head *to)
>   * The object quarantine consists of per-cpu queues and a global queue,
>   * guarded by quarantine_lock.
>   */
> -static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine);
> +static DEFINE_PER_CPU(struct qlist_head, cpu_quarantine) = {
> +	.lock = __SPIN_LOCK_UNLOCKED(cpu_quarantine.lock),
> +};
>  
>  /* Round-robin FIFO array of batches. */
>  static struct qlist_head global_quarantine[QUARANTINE_BATCHES];
> @@ -183,12 +186,13 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
>  	 * beginning which ensures that it either sees the objects in per-cpu
>  	 * lists or in the global quarantine.
>  	 */
> -	local_irq_save(flags);
> +	q = raw_cpu_ptr(&cpu_quarantine);
> +	spin_lock_irqsave(&q->lock, flags);
>  
> -	q = this_cpu_ptr(&cpu_quarantine);
>  	qlist_put(q, &info->quarantine_link, cache->size);
>  	if (unlikely(q->bytes > QUARANTINE_PERCPU_SIZE)) {
>  		qlist_move_all(q, &temp);
> +		spin_unlock(&q->lock);
>  
>  		spin_lock(&quarantine_lock);
>  		WRITE_ONCE(quarantine_size, quarantine_size + temp.bytes);
> @@ -203,10 +207,10 @@ void quarantine_put(struct kasan_free_meta *info, struct kmem_cache *cache)
>  			if (new_tail != quarantine_head)
>  				quarantine_tail = new_tail;
>  		}
> -		spin_unlock(&quarantine_lock);
> +		spin_unlock_irqrestore(&quarantine_lock, flags);
> +	} else {
> +		spin_unlock_irqrestore(&q->lock, flags);
>  	}
> -
> -	local_irq_restore(flags);
>  }
>  
>  void quarantine_reduce(void)
> @@ -284,21 +288,11 @@ static void qlist_move_cache(struct qlist_head *from,
>  	}
>  }
>  
> -static void per_cpu_remove_cache(void *arg)
> -{
> -	struct kmem_cache *cache = arg;
> -	struct qlist_head to_free = QLIST_INIT;
> -	struct qlist_head *q;
> -
> -	q = this_cpu_ptr(&cpu_quarantine);
> -	qlist_move_cache(q, &to_free, cache);
> -	qlist_free_all(&to_free, cache);
> -}
> -
>  /* Free all quarantined objects belonging to cache. */
>  void quarantine_remove_cache(struct kmem_cache *cache)
>  {
>  	unsigned long flags, i;
> +	unsigned int cpu;
>  	struct qlist_head to_free = QLIST_INIT;
>  
>  	/*
> @@ -308,7 +302,20 @@ void quarantine_remove_cache(struct kmem_cache *cache)
>  	 * achieves the first goal, while synchronize_srcu() achieves the
>  	 * second.
>  	 */
> -	on_each_cpu(per_cpu_remove_cache, cache, 1);
> +	/* get_online_cpus() invoked by caller */
> +	for_each_online_cpu(cpu) {
> +		struct qlist_head *q;
> +		unsigned long flags;
> +		struct qlist_head to_free = QLIST_INIT;
> +
> +		q = per_cpu_ptr(&cpu_quarantine, cpu);
> +		spin_lock_irqsave(&q->lock, flags);
> +		qlist_move_cache(q, &to_free, cache);
> +		spin_unlock_irqrestore(&q->lock, flags);
> +
> +		qlist_free_all(&to_free, cache);
> +
> +	}
>  
>  	spin_lock_irqsave(&quarantine_lock, flags);
>  	for (i = 0; i < QUARANTINE_BATCHES; i++) {
> -- 
> 2.19.0
> 


-- 
The United States Coast Guard
Ruining Natural Selection since 1790
