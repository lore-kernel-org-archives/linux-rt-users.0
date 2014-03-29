From: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [BUGREPORT] Tasklet scheduled issue in Linux 3.4.x-rt
Date: Sat, 29 Mar 2014 14:35:51 +0800
Message-ID: <533669C7.0@huawei.com>
References: <53144A57.4040204@huawei.com> <20140328163753.GB14842@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>, "Li Zefan" <lizefan@huawei.com>,
	Zhangwei <jovi.zhangwei@huawei.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140328163753.GB14842@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,
   Thanks for your reply and help to look at it, thanks!

I also check the tasklet state machine changes, and didn't find
clue for this issue. So I Temporarily reverted Ingo's patch, without
this patch, my test is ok.

commit 0d9f73fc1e7270a3f8709c59c913408153d9d9f8
Author: Ingo Molnar <mingo@elte.hu>
Date:   Tue Nov 29 20:18:22 2011 -0500

    tasklet: Prevent tasklets from going into infinite spin in RT

Because this patch does not exist in the latest Linus kernel, so I
have not reported this issue to kernel bugzilla.

=46inally, I would like to thank you again.

Thanks!
Yijing.


On 2014/3/29 0:37, Sebastian Andrzej Siewior wrote:
> * Yijing Wang | 2014-03-03 17:24:39 [+0800]:
>=20
>> [2012-03-26 18:55:43][  929.252312] WARNING: at kernel/softirq.c:773=
 __tasklet_action+0x51/0x1a0()
>> [2012-03-27 03:41:06][ 3647.886005] WARNING: at kernel/softirq.c:773=
 __tasklet_action+0x51/0x1a0()
>> [2012-03-27 03:42:04][ 3705.434418] WARNING: at kernel/softirq.c:799=
 __tasklet_action+0xae/0x1a0()
>=20
>> FC card hardware  -------> FC driver interrupt handler  --------->ta=
sklet_schedule(fc driver tasklet) ------->tasklet running, call functio=
n process FC IO data.
>>                        here will disable FC card interrupt          =
                                           here will enable FC card int=
errupt again
>=20
> This looks okay.
>=20
>> We found the tasklet state is 0x1(mean state is TASKLET_STATE_SCHED)=
,count is 0, before we call tasklet_schedule().
>> So the new tasklet can not add to CPU list.
>>
>> And I also add some dynamic debug in __tasklet_action(); after the i=
ssue occur, I open the dynamic debug.
>> After we force the hardware reset to interrupt OS, we never found th=
e FC driver tasklet running in dmesg(I identify the tasklet by its data=
).
>> I guess the FC tasklet is not in CPU global tasklet list.
> You guess correct.
>=20
>> I hope somebody can help to look at it. If I missing something, let =
me know.
>=20
> The tasklet is always added to the local cpu, never cross. That list =
is
> always accessed with interrupts off.
> With TASKLET_STATE_SCHED set, the next step is to add the task let to
> the CPU's tasklet list. This isn't done if TASKLET_STATE_RUN is alrea=
dy
> set which means __tasklet_action() is already busy serving the taskle=
t.
> In that case it clears TASKLET_STATE_SCHED and invokes the tasklet
> again.
> After looking at it for a while I must say I have no idea how you
> managed to keep TASKLET_STATE_SCHED set. Further, each time
> TASKLET_STATE_RUN is cleared it is always with a cmpxchg() down to ze=
ro
> which means TASKLET_STATE_SCHED is removed earlier.
> That said, triggerring the warning at 773 is the first thing that wen=
t
> wrong. After it has been added to the list, the TASKLET_STATE_RUN is
> cleared again. I have no idea how it managed to remain still on excep=
t
> that __tasklet_common_schedule() is invoked which is protected by the
> SCHED bit=E2=80=A6
>=20
>> Thanks!
>> Yijing.
>=20
> Sebastian
>=20
> .
>=20


--=20
Thanks!
Yijing
