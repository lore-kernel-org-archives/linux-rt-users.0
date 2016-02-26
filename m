From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [RFC PATCH] kernfs: create raw version kernfs_path_len and
 kernfs_path
Date: Fri, 26 Feb 2016 11:37:34 -0800
Message-ID: <56D0A97E.90706@linaro.org>
References: <1456510505-6620-1-git-send-email-yang.shi@linaro.org>
 <20160226135628.09ce727c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
	tglx@linutronix.de, bigeasy@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	linaro-kernel@lists.linaro.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33522 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561AbcBZThg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 26 Feb 2016 14:37:36 -0500
Received: by mail-pf0-f179.google.com with SMTP id q63so56770823pfb.0
        for <linux-rt-users@vger.kernel.org>; Fri, 26 Feb 2016 11:37:36 -0800 (PST)
In-Reply-To: <20160226135628.09ce727c@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2/26/2016 10:56 AM, Steven Rostedt wrote:
> On Fri, 26 Feb 2016 10:15:05 -0800
> Yang Shi <yang.shi@linaro.org> wrote:
>
>> commit 5634cc2aa9aebc77bc862992e7805469dcf83dac ("writeback: update writeback
>> tracepoints to report cgroup") made writeback tracepoints report cgroup
>> writeback, but it may trigger the below bug on -rt kernel since kernfs_path
>> and kernfs_path_len are called by tracepoints, which acquire sleeping lock.
>>
>> BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:930
>> in_atomic(): 1, irqs_disabled(): 0, pid: 625, name: kworker/u16:3
>> INFO: lockdep is turned off.
>> Preemption disabled at:[<ffffffc000374a5c>] wb_writeback+0xec/0x830
>>
>> CPU: 7 PID: 625 Comm: kworker/u16:3 Not tainted 4.4.1-rt5 #20
>> Hardware name: Freescale Layerscape 2085a RDB Board (DT)
>> Workqueue: writeback wb_workfn (flush-7:0)
>> Call trace:
>> [<ffffffc00008d708>] dump_backtrace+0x0/0x200
>> [<ffffffc00008d92c>] show_stack+0x24/0x30
>> [<ffffffc0007b0f40>] dump_stack+0x88/0xa8
>> [<ffffffc000127d74>] ___might_sleep+0x2ec/0x300
>> [<ffffffc000d5d550>] rt_spin_lock+0x38/0xb8
>> [<ffffffc0003e0548>] kernfs_path_len+0x30/0x90
>> [<ffffffc00036b360>] trace_event_raw_event_writeback_work_class+0xe8/0x2e8
>> [<ffffffc000374f90>] wb_writeback+0x620/0x830
>> [<ffffffc000376224>] wb_workfn+0x61c/0x950
>> [<ffffffc000110adc>] process_one_work+0x3ac/0xb30
>> [<ffffffc0001112fc>] worker_thread+0x9c/0x7a8
>> [<ffffffc00011a9e8>] kthread+0x190/0x1b0
>> [<ffffffc000086ca0>] ret_from_fork+0x10/0x30
>>
>> Since kernfs_* functions are heavily used by cgroup, so it sounds not
>> reasonable to convert kernfs_rename_lock to raw lock.
>>
>> Create raw version kernfs_path, kernfs_path_len and cgroup_path, which don't
>> acquire lock and are used by tracepoints only.
>>
>
> And what prevents name from being freed while the tracepoint is reading
> it?
>
> Perhaps we need this change as well:

Thanks for pointing this out. Yes, it looks we need this since the 
tracepoints are protected by rcu_read_lock_sched.

Will add this in V2.

Yang

>
> -- Steve
>
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 996b7742c90b..d2ef153145c0 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -1397,6 +1397,12 @@ int kernfs_rename_ns(struct kernfs_node *kn, struct kernfs_node *new_parent,
>   	kn->hash = kernfs_name_hash(kn->name, kn->ns);
>   	kernfs_link_sibling(kn);
>
> +	/*
> +	 * Tracepoints may be reading the old name. They are protected
> +	 * by rcu_read_lock_sched().
> +	 */
> +	synchronize_sched();
> +
>   	kernfs_put(old_parent);
>   	kfree_const(old_name);
>
>

