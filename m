From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [BUGREPORT] Tasklet scheduled issue in Linux 3.4.x-rt
Date: Tue, 1 Apr 2014 10:24:18 +0800
Message-ID: <533A2352.7000306@huawei.com>
References: <53144A57.4040204@huawei.com> <20140328163753.GB14842@linutronix.de> <533669C7.0@huawei.com> <53394296.5030906@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>, "Li Zefan" <lizefan@huawei.com>,
	Zhangwei <jovi.zhangwei@huawei.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <53394296.5030906@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

>> Because this patch does not exist in the latest Linus kernel, so I
>> have not reported this issue to kernel bugzilla.
> 
> This patch exists in all -RT releases up to 3.12. If there is an issue
> with it, it should be solved.
> 
> If the sched bit set is and you can't get lock later then the tasklet
> has be to active. Finally, not getting the lock in the tasklet code
> itself means it is still occupied by the "add-to-the-list" part which
> actually can't happen according to the code.
> You said, that you have an eight-way. Is this also NUMA? If so, does
> this problem happen if you disable NUMA (i.e. run only one NUMA node
> and use only the memory that is directly attached to the node).

Hi Sebastian,
   The target platform is not NUMA, there is only one node.

Thanks!
Yijing.

> 
> 


-- 
Thanks!
Yijing
