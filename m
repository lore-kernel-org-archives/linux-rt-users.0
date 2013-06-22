From: Qiang Huang <h.huangqiang@huawei.com>
Subject: Re: [PATCH] sched: don't clear PF_THREAD_BOUND in select_fallback_rq
Date: Sat, 22 Jun 2013 11:27:34 +0800
Message-ID: <51C519A6.4090902@huawei.com>
References: <5178F0DE.8030808@huawei.com> <20130607205048.GA22550@linutronix.de> <20130607205917.GA3395@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Li Zefan <lizefan@huawei.com>,
	zhangwei <jovi.zhangwei@huawei.com>, <bitbucket@online.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:46804 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423471Ab3FVDb0 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 21 Jun 2013 23:31:26 -0400
In-Reply-To: <20130607205917.GA3395@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Sebastian,

=46irst of all, thanks for your work!

On 2013/6/8 4:59, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2013-06-07 22:50:48 [+0200]:
>=20
>> * Qiang Huang | 2013-04-25 17:01:18 [+0800]:
>>
>>> select_fallback_rq() is called and PF_THREAD_BOUND is cleared. In m=
y
>>> box, 1/3 bounded kernel threads will clear that flag after boot.
>>
>> Please tell me _which_ threads lose this flag. I don't see this=E2=80=
=A6
>=20
> The only way I lose this flag is by starting a workqueue on a CPU whi=
ch
> if offline. Now that is wrong. I am not sure if the workqueue re-uses

How do you judge a thread lost PF_THREAD_BOUND flag or not?

My way is:
# for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
taskset: failed to parse pid: 'PID'
pid 1's current affinity list: 0-7
pid 1's new affinity list: 0-7
pid 2's current affinity list: 0-7
pid 2's new affinity list: 0-7
pid 3's current affinity list: 0
taskset: failed to set pid 3's affinity: Invalid argument
pid 4's current affinity list: 0
taskset: failed to set pid 4's affinity: Invalid argument
pid 6's current affinity list: 0
taskset: failed to set pid 6's affinity: Invalid argument
pid 7's current affinity list: 1
taskset: failed to set pid 7's affinity: Invalid argument
pid 8's current affinity list: 1
taskset: failed to set pid 8's affinity: Invalid argument
pid 9's current affinity list: 1
taskset: failed to set pid 9's affinity: Invalid argument
pid 11's current affinity list: 2
taskset: failed to set pid 11's affinity: Invalid argument
pid 13's current affinity list: 2
taskset: failed to set pid 13's affinity: Invalid argument
pid 14's current affinity list: 3
taskset: failed to set pid 14's affinity: Invalid argument
pid 16's current affinity list: 3
taskset: failed to set pid 16's affinity: Invalid argument
pid 17's current affinity list: 4
pid 17's new affinity list: 0-7			// [migration/4]
pid 18's current affinity list: 4
pid 18's new affinity list: 0-7			// [kworker/4:0]
pid 19's current affinity list: 4
pid 19's new affinity list: 0-7			// [ksoftirqd/4]
pid 20's current affinity list: 5
pid 20's new affinity list: 0-7			// [migration/5]
pid 21's current affinity list: 5
pid 21's new affinity list: 0-7			// [kworker/5:0]
pid 22's current affinity list: 5
pid 22's new affinity list: 0-7			// [ksoftirqd/5]
pid 23's current affinity list: 6
pid 23's new affinity list: 0-7			// [migration/6]
pid 25's current affinity list: 6
pid 25's new affinity list: 0-7			// [ksoftirqd/6]
pid 26's current affinity list: 7
pid 26's new affinity list: 0-7			// [migration/7]
pid 27's current affinity list: 7
pid 27's new affinity list: 0-7			// [kworker/7:0]
pid 28's current affinity list: 7
pid 28's new affinity list: 0-7			// [ksoftirqd/7]
pid 29's current affinity list: 0-7
taskset: failed to set pid 29's affinity: Invalid argument
pid 30's current affinity list: 0-7
taskset: failed to set pid 30's affinity: Invalid argument
pid 31's current affinity list: 0-7
pid 31's new affinity list: 0-7
pid 32's current affinity list: 0-7
taskset: failed to set pid 32's affinity: Invalid argument
pid 33's current affinity list: 0-7
pid 33's new affinity list: 0-7
pid 34's current affinity list: 0-7
pid 34's new affinity list: 0-7
pid 35's current affinity list: 0-7
taskset: failed to set pid 35's affinity: Invalid argument
pid 36's current affinity list: 0-7
taskset: failed to set pid 36's affinity: Invalid argument
pid 37's current affinity list: 0-7
taskset: failed to set pid 37's affinity: Invalid argument
pid 39's current affinity list: 0-7
pid 39's new affinity list: 0-7
pid 40's current affinity list: 4-7
pid 40's new affinity list: 0-7
pid 41's current affinity list: 0-3
pid 41's new affinity list: 0-7
pid 42's current affinity list: 0-7
pid 42's new affinity list: 0-7
pid 43's current affinity list: 0-7
pid 43's new affinity list: 0-7
pid 44's current affinity list: 0-7
taskset: failed to set pid 44's affinity: Invalid argument
pid 47's current affinity list: 0-7
taskset: failed to set pid 47's affinity: Invalid argument
pid 48's current affinity list: 6
pid 48's new affinity list: 0-7			// [kworker/6:1]
pid 49's current affinity list: 0-7
taskset: failed to set pid 49's affinity: Invalid argument
pid 95's current affinity list: 0-7
pid 95's new affinity list: 0-7
pid 103's current affinity list: 0-7
taskset: failed to set pid 103's affinity: Invalid argument
pid 108's current affinity list: 0-7
pid 108's new affinity list: 0-7
pid 109's current affinity list: 0-7
pid 109's new affinity list: 0-7
pid 110's current affinity list: 0-7
taskset: failed to set pid 110's affinity: Invalid argument
pid 111's current affinity list: 0-7
taskset: failed to set pid 111's affinity: Invalid argument
pid 112's current affinity list: 0-7
pid 112's new affinity list: 0-7
pid 113's current affinity list: 0-7
pid 113's new affinity list: 0-7
pid 114's current affinity list: 3
taskset: failed to set pid 114's affinity: Invalid argument
pid 115's current affinity list: 2
pid 115's new affinity list: 0-7		// [kworker/2:1]
pid 116's current affinity list: 1
pid 116's new affinity list: 0-7		// [kworker/1:1]
pid 135's current affinity list: 0-7
taskset: failed to set pid 135's affinity: Invalid argument
pid 322's current affinity list: 0-7
pid 322's new affinity list: 0-7
pid 394's current affinity list: 6
pid 394's new affinity list: 0-7		// [kworker/6:2]
pid 395's current affinity list: 5
pid 395's new affinity list: 0-7		// [kworker/5:2]
pid 409's current affinity list: 4
pid 409's new affinity list: 0-7		// [kworker/4:2]
pid 479's current affinity list: 7
pid 479's new affinity list: 0-7		// [kworker/7:2]
pid 486's current affinity list: 0
taskset: failed to set pid 486's affinity: Invalid argument
pid 506's current affinity list: 0-7
pid 506's new affinity list: 0-7
pid 512's current affinity list: 0-7
pid 512's new affinity list: 0-7
pid 577's current affinity list: 0-7
pid 577's new affinity list: 0-7
pid 1162's current affinity list: 0-7
pid 1162's new affinity list: 0-7
pid 1715's current affinity list: 0-7
pid 1715's new affinity list: 0-7
pid 1728's current affinity list: 0-7
pid 1728's new affinity list: 0-7
pid 1744's current affinity list: 0-7
pid 1744's new affinity list: 0-7
pid 1747's current affinity list: 0-7
pid 1747's new affinity list: 0-7
pid 1810's current affinity list: 0-7
pid 1810's new affinity list: 0-7
pid 1813's current affinity list: 0-7
pid 1813's new affinity list: 0-7
pid 1814's current affinity list: 0-7
pid 1814's new affinity list: 0-7
pid 1909's current affinity list: 0-7
pid 1909's new affinity list: 0-7
pid 1926's current affinity list: 0-7
pid 1926's new affinity list: 0-7
pid 1927's current affinity list: 0-7
pid 1927's new affinity list: 0-7
pid 1928's current affinity list: 3
pid 1928's new affinity list: 0-7		// [kworker/3:2]
pid 2575's current affinity list: 0-7
pid 2575's new affinity list: 0-7
pid 2580's current affinity list: 0-7
pid 2580's new affinity list: 0-7
pid 2582's current affinity list: 2
pid 2582's new affinity list: 0-7		// [kworker/2:2]
pid 2803's current affinity list: 0-7
pid 2803's new affinity list: 0-7
pid 2805's current affinity list: 0-7
pid 2805's new affinity list: 0-7
pid 2825's current affinity list: 0-7
pid 2825's new affinity list: 0-7
pid 2834's current affinity list: 0-7
pid 2834's new affinity list: 0-7
pid 2950's current affinity list: 0-7
pid 2950's new affinity list: 0-7
pid 2963's current affinity list: 0-7
pid 2963's new affinity list: 0-7
pid 3378's current affinity list: 0-7
pid 3378's new affinity list: 0-7
pid 3383's current affinity list: 0-7
pid 3383's new affinity list: 0-7
pid 3385's current affinity list: 0-7
pid 3385's new affinity list: 0-7
pid 3451's current affinity list: 0-7
pid 3451's new affinity list: 0-7
pid 3476's current affinity list: 0-7
pid 3476's new affinity list: 0-7
pid 3477's current affinity list: 0-7
pid 3477's new affinity list: 0-7
pid 3511's current affinity list: 0-7
pid 3511's new affinity list: 0-7
pid 3529's current affinity list: 0-7
pid 3529's new affinity list: 0-7
pid 3542's current affinity list: 0-7
pid 3542's new affinity list: 0-7
pid 3551's current affinity list: 0-7
pid 3551's new affinity list: 0-7
pid 3563's current affinity list: 0-7
pid 3563's new affinity list: 0-7
pid 3564's current affinity list: 0-7
pid 3564's new affinity list: 0-7
pid 3593's current affinity list: 0-7
pid 3593's new affinity list: 0-7
pid 3594's current affinity list: 0-7
pid 3594's new affinity list: 0-7
pid 3595's current affinity list: 0-7
pid 3595's new affinity list: 0-7
pid 3596's current affinity list: 0-7
pid 3596's new affinity list: 0-7
pid 3597's current affinity list: 0-7
pid 3597's new affinity list: 0-7
pid 3598's current affinity list: 0-7
pid 3598's new affinity list: 0-7
pid 3731's current affinity list: 0-7
pid 3731's new affinity list: 0-7
pid 3732's current affinity list: 0-7
pid 3732's new affinity list: 0-7
pid 3733's current affinity list: 0-7
pid 3733's new affinity list: 0-7
pid 3744's current affinity list: 0-7
pid 3744's new affinity list: 0-7
pid 3747's current affinity list: 0-7
pid 3747's new affinity list: 0-7
pid 3748's current affinity list: 0-7
pid 3748's new affinity list: 0-7
pid 3751's current affinity list: 0-7
pid 3751's new affinity list: 0-7
pid 3757's current affinity list: 0-7
pid 3757's new affinity list: 0-7
pid 3759's current affinity list: 0-7
pid 3759's new affinity list: 0-7
pid 3760's current affinity list: 0-7
pid 3760's new affinity list: 0-7
pid 3762's current affinity list: 0-7
pid 3762's new affinity list: 0-7
pid 3767's current affinity list: 0-7
pid 3767's new affinity list: 0-7
pid 3778's current affinity list: 0-7
pid 3778's new affinity list: 0-7
pid 3781's current affinity list: 0-7
pid 3781's new affinity list: 0-7
pid 3782's current affinity list: 0-7
pid 3782's new affinity list: 0-7
pid 3864's current affinity list: 0-7
pid 3864's new affinity list: 0-7
pid 3867's current affinity list: 0-7
pid 3867's new affinity list: 0-7
pid 7452's current affinity list: 0-7
pid 7452's new affinity list: 0-7
pid 9479's current affinity list: 0-7
pid 9479's new affinity list: 0-7
pid 9482's current affinity list: 0-7
pid 9482's new affinity list: 0-7
pid 9483's current affinity list: 0-7
pid 9483's new affinity list: 0-7
pid 9531's current affinity list: 0-7
pid 9531's new affinity list: 0-7
pid 9534's current affinity list: 0-7
pid 9534's new affinity list: 0-7
pid 11555's current affinity list: 0-7
pid 11555's new affinity list: 0-7
pid 11556's current affinity list: 0-7
pid 11556's new affinity list: 0-7
pid 11559's current affinity list: 0-7
pid 11559's new affinity list: 0-7
pid 11560's current affinity list: 0-7
pid 11560's new affinity list: 0-7
pid 11592's current affinity list: 0-7
pid 11592's new affinity list: 0-7
pid 11594's current affinity list: 0-7
pid 11594's new affinity list: 0-7
pid 11595's current affinity list: 0-7
pid 11595's new affinity list: 0-7
taskset: failed to get pid 11609's affinity: No such process


As you can see, many kernel threads' affinity can be changed, which wer=
e
supposed to be attached to only one cpu, most of them are kworkers, as
well as some other kernel threads.

After applying my patch, turns out:
# for pid in `ps -e -o pid`; do taskset -p -c 0-15 $pid; done
taskset: failed to parse pid: 'PID'
pid 1's current affinity list: 0-7
pid 1's new affinity list: 0-7
pid 2's current affinity list: 0-7
pid 2's new affinity list: 0-7
pid 3's current affinity list: 0
taskset: failed to set pid 3's affinity: Invalid argument
pid 4's current affinity list: 0
taskset: failed to set pid 4's affinity: Invalid argument
pid 5's current affinity list: 0-7
taskset: failed to set pid 5's affinity: Invalid argument
pid 6's current affinity list: 0
taskset: failed to set pid 6's affinity: Invalid argument
pid 7's current affinity list: 1
taskset: failed to set pid 7's affinity: Invalid argument
pid 8's current affinity list: 1
taskset: failed to set pid 8's affinity: Invalid argument
pid 9's current affinity list: 1
taskset: failed to set pid 9's affinity: Invalid argument
pid 10's current affinity list: 0
taskset: failed to set pid 10's affinity: Invalid argument
pid 11's current affinity list: 2
taskset: failed to set pid 11's affinity: Invalid argument
pid 12's current affinity list: 2
taskset: failed to set pid 12's affinity: Invalid argument
pid 13's current affinity list: 2
taskset: failed to set pid 13's affinity: Invalid argument
pid 14's current affinity list: 3
taskset: failed to set pid 14's affinity: Invalid argument
pid 15's current affinity list: 3
taskset: failed to set pid 15's affinity: Invalid argument
pid 16's current affinity list: 3
taskset: failed to set pid 16's affinity: Invalid argument
pid 17's current affinity list: 4
taskset: failed to set pid 17's affinity: Invalid argument
pid 18's current affinity list: 4
taskset: failed to set pid 18's affinity: Invalid argument
pid 19's current affinity list: 4
taskset: failed to set pid 19's affinity: Invalid argument
pid 20's current affinity list: 5
taskset: failed to set pid 20's affinity: Invalid argument
pid 21's current affinity list: 5
taskset: failed to set pid 21's affinity: Invalid argument
pid 22's current affinity list: 5
taskset: failed to set pid 22's affinity: Invalid argument
pid 23's current affinity list: 6
taskset: failed to set pid 23's affinity: Invalid argument
pid 24's current affinity list: 6
taskset: failed to set pid 24's affinity: Invalid argument
pid 25's current affinity list: 6
taskset: failed to set pid 25's affinity: Invalid argument
pid 26's current affinity list: 7
taskset: failed to set pid 26's affinity: Invalid argument
pid 27's current affinity list: 7
taskset: failed to set pid 27's affinity: Invalid argument
pid 28's current affinity list: 7
taskset: failed to set pid 28's affinity: Invalid argument
pid 29's current affinity list: 0-7
taskset: failed to set pid 29's affinity: Invalid argument
pid 30's current affinity list: 0-7
taskset: failed to set pid 30's affinity: Invalid argument
pid 31's current affinity list: 0-7
pid 31's new affinity list: 0-7
pid 32's current affinity list: 0-7
taskset: failed to set pid 32's affinity: Invalid argument
pid 33's current affinity list: 0-7
pid 33's new affinity list: 0-7
pid 34's current affinity list: 0-7
pid 34's new affinity list: 0-7
pid 35's current affinity list: 0-7
taskset: failed to set pid 35's affinity: Invalid argument
pid 36's current affinity list: 0-7
taskset: failed to set pid 36's affinity: Invalid argument
pid 37's current affinity list: 0-7
taskset: failed to set pid 37's affinity: Invalid argument
pid 38's current affinity list: 7
taskset: failed to set pid 38's affinity: Invalid argument
pid 39's current affinity list: 0-7
pid 39's new affinity list: 0-7
pid 40's current affinity list: 4-7
pid 40's new affinity list: 0-7
pid 41's current affinity list: 0-3
pid 41's new affinity list: 0-7
pid 42's current affinity list: 0-7
pid 42's new affinity list: 0-7
pid 43's current affinity list: 0-7
pid 43's new affinity list: 0-7
pid 44's current affinity list: 0-7
taskset: failed to set pid 44's affinity: Invalid argument
pid 46's current affinity list: 4
taskset: failed to set pid 46's affinity: Invalid argument
pid 47's current affinity list: 0-7
taskset: failed to set pid 47's affinity: Invalid argument
pid 48's current affinity list: 6
taskset: failed to set pid 48's affinity: Invalid argument
pid 49's current affinity list: 0-7
taskset: failed to set pid 49's affinity: Invalid argument
pid 50's current affinity list: 0-7
taskset: failed to set pid 50's affinity: Invalid argument
pid 95's current affinity list: 0-7
pid 95's new affinity list: 0-7
pid 103's current affinity list: 0-7
taskset: failed to set pid 103's affinity: Invalid argument
pid 108's current affinity list: 0-7
pid 108's new affinity list: 0-7
pid 109's current affinity list: 0-7
pid 109's new affinity list: 0-7
pid 110's current affinity list: 0-7
taskset: failed to set pid 110's affinity: Invalid argument
pid 111's current affinity list: 0-7
taskset: failed to set pid 111's affinity: Invalid argument
pid 112's current affinity list: 0-7
pid 112's new affinity list: 0-7
pid 113's current affinity list: 0-7
pid 113's new affinity list: 0-7
pid 114's current affinity list: 3
taskset: failed to set pid 114's affinity: Invalid argument
pid 115's current affinity list: 2
taskset: failed to set pid 115's affinity: Invalid argument
pid 116's current affinity list: 1
taskset: failed to set pid 116's affinity: Invalid argument
pid 117's current affinity list: 0-7
taskset: failed to set pid 117's affinity: Invalid argument
pid 118's current affinity list: 0-7
taskset: failed to set pid 118's affinity: Invalid argument
pid 126's current affinity list: 5
taskset: failed to set pid 126's affinity: Invalid argument
pid 135's current affinity list: 0-7
taskset: failed to set pid 135's affinity: Invalid argument
pid 321's current affinity list: 0-7
pid 321's new affinity list: 0-7
pid 420's current affinity list: 7
taskset: failed to set pid 420's affinity: Invalid argument
pid 496's current affinity list: 4
taskset: failed to set pid 496's affinity: Invalid argument
pid 516's current affinity list: 5
taskset: failed to set pid 516's affinity: Invalid argument
pid 517's current affinity list: 0-7
pid 517's new affinity list: 0-7
pid 523's current affinity list: 0-7
pid 523's new affinity list: 0-7
pid 588's current affinity list: 0-7
pid 588's new affinity list: 0-7
pid 1047's current affinity list: 0
taskset: failed to set pid 1047's affinity: Invalid argument
pid 1048's current affinity list: 1
taskset: failed to set pid 1048's affinity: Invalid argument
pid 1141's current affinity list: 2
taskset: failed to set pid 1141's affinity: Invalid argument
pid 1205's current affinity list: 0-7
pid 1205's new affinity list: 0-7
pid 1758's current affinity list: 0-7
pid 1758's new affinity list: 0-7
pid 1771's current affinity list: 0-7
pid 1771's new affinity list: 0-7
pid 1787's current affinity list: 0-7
pid 1787's new affinity list: 0-7
pid 1790's current affinity list: 0-7
pid 1790's new affinity list: 0-7
pid 1853's current affinity list: 0-7
pid 1853's new affinity list: 0-7
pid 1856's current affinity list: 0-7
pid 1856's new affinity list: 0-7
pid 1857's current affinity list: 0-7
pid 1857's new affinity list: 0-7
pid 1952's current affinity list: 0-7
pid 1952's new affinity list: 0-7
pid 1956's current affinity list: 3
taskset: failed to set pid 1956's affinity: Invalid argument
pid 1979's current affinity list: 0-7
pid 1979's new affinity list: 0-7
pid 1980's current affinity list: 0-7
pid 1980's new affinity list: 0-7
pid 2617's current affinity list: 0-7
pid 2617's new affinity list: 0-7
pid 2622's current affinity list: 0-7
pid 2622's new affinity list: 0-7
pid 2844's current affinity list: 0-7
pid 2844's new affinity list: 0-7
pid 2846's current affinity list: 0-7
pid 2846's new affinity list: 0-7
pid 2866's current affinity list: 0-7
pid 2866's new affinity list: 0-7
pid 2875's current affinity list: 0-7
pid 2875's new affinity list: 0-7
pid 2991's current affinity list: 0-7
pid 2991's new affinity list: 0-7
pid 3004's current affinity list: 0-7
pid 3004's new affinity list: 0-7
pid 3410's current affinity list: 0-7
pid 3410's new affinity list: 0-7
pid 3416's current affinity list: 0-7
pid 3416's new affinity list: 0-7
pid 3426's current affinity list: 0-7
pid 3426's new affinity list: 0-7
pid 3492's current affinity list: 0-7
pid 3492's new affinity list: 0-7
pid 3509's current affinity list: 0-7
pid 3509's new affinity list: 0-7
pid 3510's current affinity list: 0-7
pid 3510's new affinity list: 0-7
pid 3552's current affinity list: 0-7
pid 3552's new affinity list: 0-7
pid 3570's current affinity list: 0-7
pid 3570's new affinity list: 0-7
pid 3576's current affinity list: 0-7
pid 3576's new affinity list: 0-7
pid 3592's current affinity list: 0-7
pid 3592's new affinity list: 0-7
pid 3613's current affinity list: 0-7
pid 3613's new affinity list: 0-7
pid 3617's current affinity list: 0-7
pid 3617's new affinity list: 0-7
pid 3634's current affinity list: 0-7
pid 3634's new affinity list: 0-7
pid 3635's current affinity list: 0-7
pid 3635's new affinity list: 0-7
pid 3636's current affinity list: 0-7
pid 3636's new affinity list: 0-7
pid 3637's current affinity list: 0-7
pid 3637's new affinity list: 0-7
pid 3638's current affinity list: 0-7
pid 3638's new affinity list: 0-7
pid 3639's current affinity list: 0-7
pid 3639's new affinity list: 0-7
pid 3773's current affinity list: 0-7
pid 3773's new affinity list: 0-7
pid 3774's current affinity list: 0-7
pid 3774's new affinity list: 0-7
pid 3775's current affinity list: 0-7
pid 3775's new affinity list: 0-7
pid 3786's current affinity list: 0-7
pid 3786's new affinity list: 0-7
pid 3789's current affinity list: 0-7
pid 3789's new affinity list: 0-7
pid 3790's current affinity list: 0-7
pid 3790's new affinity list: 0-7
pid 3793's current affinity list: 0-7
pid 3793's new affinity list: 0-7
pid 3799's current affinity list: 0-7
pid 3799's new affinity list: 0-7
pid 3801's current affinity list: 0-7
pid 3801's new affinity list: 0-7
pid 3802's current affinity list: 0-7
pid 3802's new affinity list: 0-7
pid 3804's current affinity list: 0-7
pid 3804's new affinity list: 0-7
pid 3807's current affinity list: 0-7
pid 3807's new affinity list: 0-7
pid 3809's current affinity list: 0-7
pid 3809's new affinity list: 0-7
pid 3815's current affinity list: 0-7
pid 3815's new affinity list: 0-7
pid 3820's current affinity list: 0-7
pid 3820's new affinity list: 0-7
pid 3823's current affinity list: 0-7
pid 3823's new affinity list: 0-7
pid 3824's current affinity list: 0-7
pid 3824's new affinity list: 0-7
pid 3854's current affinity list: 0-7
pid 3854's new affinity list: 0-7
pid 3857's current affinity list: 0-7
pid 3857's new affinity list: 0-7
pid 3858's current affinity list: 0-7
pid 3858's new affinity list: 0-7
pid 3888's current affinity list: 0-7
pid 3888's new affinity list: 0-7
pid 3889's current affinity list: 0-7
pid 3889's new affinity list: 0-7
pid 3922's current affinity list: 0-7
pid 3922's new affinity list: 0-7
pid 3926's current affinity list: 0-7
pid 3926's new affinity list: 0-7
taskset: failed to get pid 3952's affinity: No such process


These changing all failed. We can't change the cpu affinity of those
threads which are attached to only one cpu.

I don't kown if that's enought to say many threads' PF_THREAD_BOUND fla=
g
is cleared which should not be. But your patches definitely not resolve
this problem, the taskset result is similar to my first one. I don't kn=
ow
if this is the direct reason for the hung problem, but this is truly a
problem, right?

And my test shows the same thing, after applying your patches, my
cgroup_fj test will still cause system hung, after reboot, log message
shows the same as I sent before:
=2E..
Jun 22 10:57:42 sles25 kernel: [  295.223396] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.243264] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.243269] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.243318] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.245647] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.247330] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.251289] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.251396] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.273380] NOHZ: local_softirq_pendi=
ng 200
Jun 22 10:57:42 sles25 kernel: [  295.275274] NOHZ: local_softirq_pendi=
ng 200
Jun 22 11:00:40 sles25 sshd[5401]: Accepted keyboard-interactive/pam fo=
r h00177757 from 128.5.64.198 port 58075 ssh2
Jun 22 11:00:40 sles25 sshd[5752]: error: bind: Address already in use
Jun 22 11:00:40 sles25 sshd[5752]: error: channel_setup_fwd_listener: c=
annot listen to port: 8080
Jun 22 11:03:24 sles25 kernel: [  636.968624] ------------[ cut here ]-=
-----------
Jun 22 11:03:24 sles25 kernel: [  636.968634] WARNING: at kernel/workqu=
eue.c:1209 worker_enter_idle+0x102/0x150()
Jun 22 11:03:24 sles25 kernel: [  636.968637] Hardware name: Tecal RH22=
85
Jun 22 11:03:24 sles25 kernel: [  636.968639] Modules linked in: bridge=
 stp edd cpufreq_conservative cpufreq_userspace cpufreq_powersave acpi_=
cpufreq mperf fuse loop dm_mod coretemp crc32c_intel
ghash_clmulni_intel usbhid aesni_intel igb hid i7core_edac ipv6 cryptd =
sg iTCO_wdt bnx2 edac_core button aes_x86_64 aes_generic rtc_cmos i2c_i=
801 i2c_core iTCO_vendor_support serio_raw dca ses
enclosure microcode pcspkr ext3 jbd mbcache uhci_hcd ehci_hcd usbcore s=
d_mod crc_t10dif usb_common processor thermal_sys hwmon scsi_dh_emc scs=
i_dh_alua scsi_dh_hp_sw scsi_dh_rdac scsi_dh ata_generic
ata_piix libata megaraid_sas scsi_mod
Jun 22 11:03:24 sles25 kernel: [  636.968695] Pid: 1167, comm: kworker/=
4:2 Not tainted 3.4.24.09-hq-apply-Sebastian-patch+ #25
Jun 22 11:03:24 sles25 kernel: [  636.968697] Call Trace:
Jun 22 11:03:24 sles25 kernel: [  636.968703]  [<ffffffff8105d5f2>] ? w=
orker_enter_idle+0x102/0x150
Jun 22 11:03:24 sles25 kernel: [  636.968709]  [<ffffffff8104320a>] war=
n_slowpath_common+0x7a/0xb0
Jun 22 11:03:24 sles25 kernel: [  636.968713]  [<ffffffff81043255>] war=
n_slowpath_null+0x15/0x20
Jun 22 11:03:24 sles25 kernel: [  636.968716]  [<ffffffff8105d5f2>] wor=
ker_enter_idle+0x102/0x150
Jun 22 11:03:24 sles25 kernel: [  636.968721]  [<ffffffff810607f8>] wor=
ker_thread+0x248/0x430
Jun 22 11:03:24 sles25 kernel: [  636.968725]  [<ffffffff810605b0>] ? m=
anage_workers+0x120/0x120
Jun 22 11:03:24 sles25 kernel: [  636.968730]  [<ffffffff8106546e>] kth=
read+0x9e/0xb0
Jun 22 11:03:24 sles25 kernel: [  636.968736]  [<ffffffff8146f7d4>] ker=
nel_thread_helper+0x4/0x10
Jun 22 11:03:24 sles25 kernel: [  636.968740]  [<ffffffff810653d0>] ? k=
thread_freezable_should_stop+0x70/0x70
Jun 22 11:03:24 sles25 kernel: [  636.968744]  [<ffffffff8146f7d0>] ? g=
s_change+0x13/0x13
Jun 22 11:03:24 sles25 kernel: [  636.968746] ---[ end trace 10ce88b902=
763137 ]---
=2E..

So right now, my patch is still my only solution.

One thing need to be clear, my test is on 3.4.45-rt60, but I think all =
3.4-rt
versions have this problem.


> the "idle" workers later. In the up path it sets the CPU mask and
> PF_THREAD_BOUND is usually set (unless it was lost due to
> select_fallback_rq()). So we can set this back on:
>=20
> Subject: [PATCH] kernel/workqueue: Add PF_THREAD_BOUND after set_cpu
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/workqueue.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 11285e4..aff5841 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1637,8 +1637,10 @@ __acquires(&gcwq->lock)
>  		 * it races with cpu hotunplug operation.  Verify
>  		 * against GCWQ_DISASSOCIATED.
>  		 */
> -		if (!(gcwq->flags & GCWQ_DISASSOCIATED))
> +		if (!(gcwq->flags & GCWQ_DISASSOCIATED)) {
>  			set_cpus_allowed_ptr(task, get_cpu_mask(gcwq->cpu));
> +			task->flags |=3D PF_THREAD_BOUND;
> +		}
> =20
>  		spin_lock_irq(&gcwq->lock);
>  		if (gcwq->flags & GCWQ_DISASSOCIATED)
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
