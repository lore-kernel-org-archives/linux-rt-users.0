From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 4/5] allow preemption in
 mem_cgroup_move_account_page_stat
Date: Fri, 14 Feb 2014 14:09:10 +0100
Message-ID: <20140214130910.GE28438@linutronix.de>
References: <20140210153933.GE20017@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210153933.GE20017@opentech.at>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Nicholas Mc Guire | 2014-02-10 16:39:33 [+0100]:

>
>allow preemption in mem_cgroup_move_account_page_stat
>
>as the call sites of mem_cgroup_move_account_page_stat are under 
>move_lock_mem_cgroup move_unlock_mem_cgroup (spin_lock_irqsave/
>spin_unlock_irqrestore respectively) the move operations 
>preempt_disable/enable seem to be purely for migration protection so 
>a migrate_disable/enable should be fine here.
>
>patch on top of 3.12.10-rt15
>
>Signed-off-by: Nicholas Mc Guire <der.herr@hofr.at>

Applied.

Sebastian
