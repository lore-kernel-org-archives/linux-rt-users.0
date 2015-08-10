From: Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [PATCH RT 2/7] mm/slub: move slab initialization into irq
 enabled region
Date: Mon, 10 Aug 2015 08:33:43 +0200
Message-ID: <1439188423.13546.0.camel@gmail.com>
References: <20150805011826.881627614@goodmis.org>
	 <20150805011852.582403660@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150805011852.582403660@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2015-08-04 at 21:18 -0400, Steven Rostedt wrote:
> @@ -1310,6 +1317,8 @@ static struct page *allocate_slab(struct
> kmem_cache *s, gfp_t flags, int node)
>         struct kmem_cache_order_objects oo = s->oo;
>         gfp_t alloc_gfp;
>         bool enableirqs;
> +       void *start, *p;
> +       int idx, order;
>  
>         flags &= gfp_allowed_mask;
>  

Nit: idx is unused.
