From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC V2 PATCH] kernfs: create raw version kernfs_path_len and kernfs_path
Date: Fri, 26 Feb 2016 23:01:55 +0000
Message-ID: <20160226230154.GB11672@kroah.com>
References: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: <tj@kernel.org>, <lizefan@huawei.com>, <tglx@linutronix.de>,
	<rostedt@goodmis.org>, <bigeasy@linutronix.de>,
	<linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>,
	<linaro-kernel@lists.linaro.org>
To: Yang Shi <yang.shi@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456523259-8588-1-git-send-email-yang.shi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, Feb 26, 2016 at 01:47:39PM -0800, Yang Shi wrote:
> commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
> tracepoints to report cgroup") made writeback tracepoints report cgroup
> writeback, but it may trigger the below bug on -rt kernel since kernfs_path
> and kernfs_path_len are called by tracepoints, which acquire sleeping lock.
> 
> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:930
> in_atomic(): 1, irqs_disabled(): 0, pid: 625, name: kworker/u16:3
> INFO: lockdep is turned off.
> Preemption disabled at:[<ffffffc000374a5c>] wb_writeback+0xec/0x830
> 
> CPU: 7 PID: 625 Comm: kworker/u16:3 Not tainted 4.4.1-rt5 #20
> Hardware name: Freescale Layerscape 2085a RDB Board (DT)
> Workqueue: writeback wb_workfn (flush-7:0)
> Call trace:
> [<ffffffc00008d708>] dump_backtrace+0x0/0x200
> [<ffffffc00008d92c>] show_stack+0x24/0x30
> [<ffffffc0007b0f40>] dump_stack+0x88/0xa8
> [<ffffffc000127d74>] ___might_sleep+0x2ec/0x300
> [<ffffffc000d5d550>] rt_spin_lock+0x38/0xb8
> [<ffffffc0003e0548>] kernfs_path_len+0x30/0x90
> [<ffffffc00036b360>] trace_event_raw_event_writeback_work_class+0xe8/0x2e8
> [<ffffffc000374f90>] wb_writeback+0x620/0x830
> [<ffffffc000376224>] wb_workfn+0x61c/0x950
> [<ffffffc000110adc>] process_one_work+0x3ac/0xb30
> [<ffffffc0001112fc>] worker_thread+0x9c/0x7a8
> [<ffffffc00011a9e8>] kthread+0x190/0x1b0
> [<ffffffc000086ca0>] ret_from_fork+0x10/0x30
> 
> Since kernfs_* functions are heavily used by cgroup, so it sounds not
> reasonable to convert kernfs_rename_lock to raw lock.
> 
> Call synchronize_sched() when kernfs_node is updated since tracepoints are
> protected by rcu_read_lock_sched.
> 
> Create raw version kernfs_path, kernfs_path_len and cgroup_path, which don't
> acquire lock and are used by tracepoints only.
> 
> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> ---
> It should be applicable to both mainline and -rt kernel.
> The change survives ftrace stress test in ltp.
> 
> v2:
>   * Adopted Steven's suggestion to call synchronize_sched in kernfs_rename_ns.
> 
>  fs/kernfs/dir.c                  | 30 +++++++++++++++++++++++++++---
>  include/linux/cgroup.h           | 10 ++++++++++
>  include/linux/kernfs.h           | 10 ++++++++++
>  include/trace/events/writeback.h |  4 ++--
>  4 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 996b774..70a9687 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -44,7 +44,7 @@ static int kernfs_name_locked(struct kernfs_node *kn, char *buf, size_t buflen)
>  	return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
>  }
>  
> -static char * __must_check kernfs_path_locked(struct kernfs_node *kn, char *buf,
> +static char * __must_check __kernfs_path(struct kernfs_node *kn, char *buf,
>  					      size_t buflen)
>  {
>  	char *p = buf + buflen;
> @@ -131,12 +131,33 @@ char *kernfs_path(struct kernfs_node *kn, char *buf, size_t buflen)
>  	char *p;
>  
>  	spin_lock_irqsave(&kernfs_rename_lock, flags);
> -	p = kernfs_path_locked(kn, buf, buflen);
> +	p = __kernfs_path(kn, buf, buflen);
>  	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
>  	return p;
>  }
>  EXPORT_SYMBOL_GPL(kernfs_path);
>  
> +/* Raw version. Used by tracepoints only without acquiring lock */
> +size_t _kernfs_path_len(struct kernfs_node *kn)
> +{
> +	size_t len = 0;
> +
> +	do {
> +		len += strlen(kn->name) + 1;
> +		kn = kn->parent;
> +	} while (kn && kn->parent);
> +
> +	return len;
> +}
> +
> +char *_kernfs_path(struct kernfs_node *kn, char *buf, size_t buflen)
> +{
> +	char *p;
> +
> +	p = __kernfs_path(kn, buf, buflen);
> +	return p;
> +}
> +
>  /**
>   * pr_cont_kernfs_name - pr_cont name of a kernfs_node
>   * @kn: kernfs_node of interest
> @@ -168,7 +189,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>  
>  	spin_lock_irqsave(&kernfs_rename_lock, flags);
>  
> -	p = kernfs_path_locked(kn, kernfs_pr_cont_buf,
> +	p = __kernfs_path(kn, kernfs_pr_cont_buf,
>  			       sizeof(kernfs_pr_cont_buf));
>  	if (p)
>  		pr_cont("%s", p);
> @@ -1397,6 +1418,9 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>  	kn->hash = kernfs_name_hash(kn->name, kn->ns);
>  	kernfs_link_sibling(kn);
>  
> +	/* Tracepoints are protected by rcu_read_lock_sched */
> +	synchronize_sched();
> +
>  	kernfs_put(old_parent);
>  	kfree_const(old_name);
>  
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 2162dca..bbd88d3 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -538,6 +538,16 @@ static inline char * __must_check cgroup_path(struct cgroup *cgrp, char *buf,
>  	return kernfs_path(cgrp->kn, buf, buflen);
>  }
>  
> +/*
> + * Without acquiring kernfs_rename_lock in _kernfs_path.
> + * Used by tracepoints only.
> + */
> +static inline char * __must_check _cgroup_path(struct cgroup *cgrp, char *buf,
> +					      size_t buflen)
> +{
> +	return _kernfs_path(cgrp->kn, buf, buflen);
> +}
> +
>  static inline void pr_cont_cgroup_name(struct cgroup *cgrp)
>  {
>  	pr_cont_kernfs_name(cgrp->kn);
> diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
> index af51df3..14c01cdc 100644
> --- a/include/linux/kernfs.h
> +++ b/include/linux/kernfs.h
> @@ -267,8 +267,11 @@ static inline bool kernfs_ns_enabled(struct kernfs_node *kn)
>  
>  int kernfs_name(struct kernfs_node *kn, char *buf, size_t buflen);
>  size_t kernfs_path_len(struct kernfs_node *kn);
> +size_t _kernfs_path_len(struct kernfs_node *kn);
>  char * __must_check kernfs_path(struct kernfs_node *kn, char *buf,
>  				size_t buflen);
> +char * __must_check _kernfs_path(struct kernfs_node *kn, char *buf,
> +				size_t buflen);

I despise functions with just a _ in the front of them, you don't give
anyone a clue as to what they are for, or why to use one vs. the other.
Trust me, you will not remember it either in 1 month, let alone 5 years.

Please change the whole function name to be obvious as to what to use,
or not use.

thanks,

greg k-h
