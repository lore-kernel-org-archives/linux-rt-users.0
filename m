From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [BUGREPORT] Tasklet scheduled issue in Linux 3.4.x-rt
Date: Fri, 28 Mar 2014 17:37:53 +0100
Message-ID: <20140328163753.GB14842@linutronix.de>
References: <53144A57.4040204@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
	Zhangwei <jovi.zhangwei@huawei.com>
To: Yijing Wang <wangyijing@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53144A57.4040204@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

* Yijing Wang | 2014-03-03 17:24:39 [+0800]:

>[2012-03-26 18:55:43][  929.252312] WARNING: at kernel/softirq.c:773 _=
_tasklet_action+0x51/0x1a0()
>[2012-03-27 03:41:06][ 3647.886005] WARNING: at kernel/softirq.c:773 _=
_tasklet_action+0x51/0x1a0()
>[2012-03-27 03:42:04][ 3705.434418] WARNING: at kernel/softirq.c:799 _=
_tasklet_action+0xae/0x1a0()

>FC card hardware  -------> FC driver interrupt handler  --------->task=
let_schedule(fc driver tasklet) ------->tasklet running, call function =
process FC IO data.
>                        here will disable FC card interrupt           =
                                          here will enable FC card inte=
rrupt again

This looks okay.

>We found the tasklet state is 0x1(mean state is TASKLET_STATE_SCHED),c=
ount is 0, before we call tasklet_schedule().
>So the new tasklet can not add to CPU list.
>
>And I also add some dynamic debug in __tasklet_action(); after the iss=
ue occur, I open the dynamic debug.
>After we force the hardware reset to interrupt OS, we never found the =
=46C driver tasklet running in dmesg(I identify the tasklet by its data=
).
>I guess the FC tasklet is not in CPU global tasklet list.
You guess correct.

>I hope somebody can help to look at it. If I missing something, let me=
 know.

The tasklet is always added to the local cpu, never cross. That list is
always accessed with interrupts off.
With TASKLET_STATE_SCHED set, the next step is to add the task let to
the CPU's tasklet list. This isn't done if TASKLET_STATE_RUN is already
set which means __tasklet_action() is already busy serving the tasklet.
In that case it clears TASKLET_STATE_SCHED and invokes the tasklet
again.
After looking at it for a while I must say I have no idea how you
managed to keep TASKLET_STATE_SCHED set. Further, each time
TASKLET_STATE_RUN is cleared it is always with a cmpxchg() down to zero
which means TASKLET_STATE_SCHED is removed earlier.
That said, triggerring the warning at 773 is the first thing that went
wrong. After it has been added to the list, the TASKLET_STATE_RUN is
cleared again. I have no idea how it managed to remain still on except
that __tasklet_common_schedule() is invoked which is protected by the
SCHED bit=E2=80=A6

>Thanks!
>Yijing.

Sebastian
