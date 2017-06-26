From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [linux-rt-devel:linux-4.11.y-rt-rebase 160/353]
 init/init_task.c:19:8: error: unknown field 'posix_timer_list' specified in
 initializer
Date: Mon, 26 Jun 2017 18:09:07 +0200
Message-ID: <20170626160907.u6bnkbi2atcymkac@linutronix.de>
References: <201706162151.0vcyGri3%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Stultz <johnstul@us.ibm.com>, kbuild-all@01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201706162151.0vcyGri3%fengguang.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-06-16 21:55:59 [+0800], kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-4.11.y-rt-rebase
> head:   9a5f5870d7dedcb287c4a1af27de7cf35302c56c
> commit: 470637c623fc39a4804c3611e480b5ccdf3dca1c [160/353] posix-timers: Thread posix-cpu-timers on -rt
> config: x86_64-randconfig-i0-201724 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout 470637c623fc39a4804c3611e480b5ccdf3dca1c
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All error/warnings (new ones prefixed by >>):
> 
> >> init/init_task.c:19:8: error: unknown field 'posix_timer_list' specified in initializer
>     struct task_struct init_task = INIT_TASK(init_task);
>            ^

Taking this as the fix for the v4.11 RT only fallout.

diff --git a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -167,7 +167,7 @@ extern struct cred init_cred;
 # define INIT_PERF_EVENTS(tsk)
 #endif
 
-#ifdef CONFIG_PREEMPT_RT_BASE
+#if defined(CONFIG_POSIX_TIMERS) && defined(CONFIG_PREEMPT_RT_BASE)
 # define INIT_TIMER_LIST		.posix_timer_list = NULL,
 #else
 # define INIT_TIMER_LIST

Sebastian
