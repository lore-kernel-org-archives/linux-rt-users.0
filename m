From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -rt] memcg: use migrate_disable()/migrate_enable( ) in
 memcg_check_events()
Date: Wed, 16 Nov 2011 09:12:38 -0500
Message-ID: <1321452758.4181.18.camel@frodo>
References: <alpine.LFD.2.02.1111150050590.4902@ionos>
	 <20111115084059.GA23250@zhy>  <20111116091653.GA8692@zhy>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
To: Yong Zhang <yong.zhang0@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111116091653.GA8692@zhy>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wed, 2011-11-16 at 17:16 +0800, Yong Zhang wrote:
> Looking at commit 4799401f [memcg: Fix race condition in
> memcg_check_events() with this_cpu usage], we just want
> to disable migration. So use the right API in -rt. This
> will cure below warning.
> 

>  mm/memcontrol.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6aff93c..afa1954 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -722,7 +722,7 @@ static void __mem_cgroup_target_update(struct mem_cgroup *memcg, int target)
>   */
>  static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
>  {
> -	preempt_disable();
> +	migrate_disable();

No this won't work. Not even for -rt. If we disable migration but not
preemption, then two tasks can take this path. And the checks in
__memcg_event_check() will be corrupted because nothing is protecting
the updates from two tasks going into the same path.

Perhaps a local_lock would work.

-- Steve

>  	/* threshold event is triggered in finer grain than soft limit */
>  	if (unlikely(__memcg_event_check(memcg, MEM_CGROUP_TARGET_THRESH))) {
>  		mem_cgroup_threshold(memcg);
> @@ -742,7 +742,7 @@ static void memcg_check_events(struct mem_cgroup *memcg, struct page *page)
>  		}
>  #endif
>  	}
> -	preempt_enable();
> +	migrate_enable();
>  }
>  
>  static struct mem_cgroup *mem_cgroup_from_cont(struct cgroup *cont)
