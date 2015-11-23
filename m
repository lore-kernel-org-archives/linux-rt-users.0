From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] locking_selftest: Save/restore migrate_disable_atomic
 in locking selftest
Date: Mon, 23 Nov 2015 08:43:25 -0500
Message-ID: <20151123084325.4f0b4d62@gandalf.local.home>
References: <1448263178-28397-1-git-send-email-jianchuan.wang@windriver.com>
	<201511231529.iE0YvIjj%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: jianchuan.wang@windriver.com, kbuild-all@01.org,
	bigeasy@linutronix.de, tglx@linutronix.de, yang.shi@windriver.com,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201511231529.iE0YvIjj%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, 23 Nov 2015 15:30:30 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Jianchuan,
> 
> [auto build test ERROR on: v4.4-rc2]
> [also build test ERROR on: next-20151120]
> 
> url:    https://github.com/0day-ci/linux/commits/jianchuan-wang-windriver-com/locking_selftest-Save-restore-migrate_disable_atomic-in-locking-selftest/20151123-152217
> config: x86_64-randconfig-x013-11230343 (attached as .config)
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    lib/locking-selftest.c: In function 'dotest':
> >> lib/locking-selftest.c:981:25: error: 'struct task_struct' has no member named 'migrate_disable_atomic'  
>      save_migrate_atomic = p->migrate_disable_atomic;
>                             ^
>    lib/locking-selftest.c:987:3: error: 'struct task_struct' has no member named 'migrate_disable_atomic'
>      p->migrate_disable_atomic = save_migrate_atomic;
>       ^


Need to add RT in the subject like "[PATCH RT]". Then perhaps Fengguang
can have his tests either ignore these or test against the -rt trees.

-- Steve

> 
> vim +981 lib/locking-selftest.c
> 
>    975		int save_migrate_atomic;
>    976	#endif
>    977	
>    978		WARN_ON(irqs_disabled());
>    979	
>    980	#ifdef CONFIG_SCHED_DEBUG
>  > 981		save_migrate_atomic = p->migrate_disable_atomic;  
>    982	#endif
>    983	
>    984		testcase_fn();
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
