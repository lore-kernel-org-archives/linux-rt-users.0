From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH 0/3] update to cpupri algorithm
Date: Mon, 01 Aug 2011 10:18:33 -0400
Message-ID: <1312208313.18583.28.camel@gandalf.stny.rr.com>
References: <20110729151340.419467771@goodmis.org>
	 <1312017596.8752.78.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Peter Zijlstra <peterz@infradead.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Mike Galbraith <mgalbraith@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:58590 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab1HAOSg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Aug 2011 10:18:36 -0400
In-Reply-To: <1312017596.8752.78.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-07-30 at 11:19 +0200, Mike Galbraith wrote:
> On Fri, 2011-07-29 at 11:13 -0400, Steven Rostedt wrote:
> > Hi Mike,
> > 
> > Could you try this patch set out. Add the first patch and then
> > run your tests. The first patch only adds benchmarking, and does not
> > modify the scheduler algorithm.
> > 
> > Do this:
> > 
> > 1. apply first patch, build and boot
> > 2. # mount -t debugfs nodev /sys/kernel/debug
> > 3. # echo 0 > /sys/kernel/debug/cpupri; ./runtest; cat /sys/kernel/debug/cpupri > output
> > 
> > The output will give you the contention of the vector locks in the
> > cpupri algorithm.
> > 
> > Then apply the second patch and do the same thing.
> > 
> > Then apply the third patch and do the same thing.
> > 
> > After that, could you send me the results of the output file for all
> > three runs?  The final patch should probably be the best overall
> > results.
> 
> These patches are RFC, so here's my Comment.  Steven rocks.

/me blushes!

Thanks for testing! I'll redo the patches to remove the logging, and
send them to you again. Could you return back a 'Tested-by' tag
afterward.

I'll also post the numbers from most of those that sent them to me.

> 
> Below is what cyclictest has to say with the patches listed below
> applied, and simulation model running on 56 isolated cores.
> 
> The model squeaks once in a while with jitter ever so slightly over the
> 30us squeak threshold, so I have yet more perturbation sources, but wrt
> your patches, they are mana from heaven for largish boxen ;-)
> 
> patches/ipc-sem-Optimize-update_queue-for-bulk-wakeup-calls
> patches/ipc-sem-Move-wake_up_process-out-of-the-spinlock-section
> patches/ipc-sem-Cacheline-align-the-ipc-spinlock-for-semaphores
> patches/ipc-sem-Update-description-of-the-implementation
> patches/ipc-sem-Use-ERR_CAST
> patches/ipc-sem-Bugfix-for-semop-not-reporting-successful-operation
> patches/ipc-sys_semctl-Fix-kernel-stack-leakage
> patches/cpupri-2-3-nolock.patch
> patches/cpupri-3-3-atomic.patch
> patches/posix-timers-RCU-conversion
> 
> cyclictest -Smqp 99 -D 30m; ./killit.sh

Could you also post the results without the two cpupri patches?

Thanks,

-- Steve

> 
> T: 0 ( 7362) P:99 I:1000 C:1799001 Min:      1 Act:    2 Avg:    1 Max:      19
> T: 1 ( 7363) P:99 I:1500 C:1199333 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 2 ( 7364) P:99 I:2000 C: 899498 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 3 ( 7365) P:99 I:2500 C: 719597 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 4 ( 7366) P:99 I:3000 C: 599664 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 5 ( 7367) P:99 I:3500 C: 513997 Min:      1 Act:    2 Avg:    1 Max:       5
> T: 6 ( 7368) P:99 I:4000 C: 449746 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 7 ( 7369) P:99 I:4500 C: 399774 Min:      1 Act:    2 Avg:    1 Max:       4
> T: 8 ( 7370) P:99 I:5000 C: 359796 Min:      1 Act:    3 Avg:    2 Max:       5
> T: 9 ( 7371) P:99 I:5500 C: 327087 Min:      1 Act:    3 Avg:    2 Max:       7
> T:10 ( 7372) P:99 I:6000 C: 299829 Min:      1 Act:    3 Avg:    2 Max:       7
> T:11 ( 7373) P:99 I:6500 C: 276765 Min:      1 Act:    3 Avg:    2 Max:      13
> T:12 ( 7374) P:99 I:7000 C: 256995 Min:      1 Act:    3 Avg:    2 Max:       6
> T:13 ( 7375) P:99 I:7500 C: 239862 Min:      1 Act:    3 Avg:    2 Max:      10
> T:14 ( 7376) P:99 I:8000 C: 224870 Min:      1 Act:    2 Avg:    2 Max:       6
> T:15 ( 7377) P:99 I:8500 C: 211642 Min:      1 Act:    4 Avg:    2 Max:       7
> T:16 ( 7378) P:99 I:9000 C: 199884 Min:      1 Act:    3 Avg:    2 Max:      13
> T:17 ( 7379) P:99 I:9500 C: 189364 Min:      1 Act:    4 Avg:    2 Max:       6
> T:18 ( 7380) P:99 I:10000 C: 179895 Min:      1 Act:    3 Avg:    2 Max:       5
> T:19 ( 7381) P:99 I:10500 C: 171328 Min:      1 Act:    3 Avg:    2 Max:       9
> T:20 ( 7382) P:99 I:11000 C: 163540 Min:      1 Act:    4 Avg:    2 Max:       8
> T:21 ( 7383) P:99 I:11500 C: 156430 Min:      2 Act:    3 Avg:    2 Max:       7
> T:22 ( 7384) P:99 I:12000 C: 149912 Min:      2 Act:    3 Avg:    2 Max:      10
> T:23 ( 7385) P:99 I:12500 C: 143915 Min:      2 Act:    3 Avg:    3 Max:       8
> T:24 ( 7386) P:99 I:13000 C: 138380 Min:      2 Act:    4 Avg:    3 Max:       7
> T:25 ( 7387) P:99 I:13500 C: 133254 Min:      2 Act:    2 Avg:    3 Max:       7
> T:26 ( 7388) P:99 I:14000 C: 128495 Min:      1 Act:    3 Avg:    3 Max:       6
> T:27 ( 7389) P:99 I:14500 C: 124064 Min:      1 Act:    4 Avg:    3 Max:      10
> T:28 ( 7390) P:99 I:15000 C: 119928 Min:      2 Act:    4 Avg:    3 Max:       7
> T:29 ( 7391) P:99 I:15500 C: 116059 Min:      2 Act:    3 Avg:    2 Max:       6
> T:30 ( 7392) P:99 I:16000 C: 112432 Min:      2 Act:    4 Avg:    3 Max:       6
> T:31 ( 7393) P:99 I:16500 C: 109025 Min:      1 Act:    3 Avg:    3 Max:       6
> T:32 ( 7394) P:99 I:17000 C: 105818 Min:      2 Act:    4 Avg:    3 Max:       7
> T:33 ( 7395) P:99 I:17500 C: 102795 Min:      2 Act:    4 Avg:    3 Max:       7
> T:34 ( 7396) P:99 I:18000 C:  99939 Min:      1 Act:    3 Avg:    3 Max:       7
> T:35 ( 7397) P:99 I:18500 C:  97238 Min:      2 Act:    4 Avg:    3 Max:       8
> T:36 ( 7398) P:99 I:19000 C:  94679 Min:      2 Act:    3 Avg:    3 Max:       7
> T:37 ( 7399) P:99 I:19500 C:  92251 Min:      1 Act:    3 Avg:    3 Max:       8
> T:38 ( 7400) P:99 I:20000 C:  89945 Min:      2 Act:    4 Avg:    3 Max:       8
> T:39 ( 7401) P:99 I:20500 C:  87751 Min:      2 Act:    4 Avg:    3 Max:      13
> T:40 ( 7402) P:99 I:21000 C:  85661 Min:      2 Act:    3 Avg:    3 Max:      10
> T:41 ( 7403) P:99 I:21500 C:  83669 Min:      1 Act:    3 Avg:    3 Max:       7
> T:42 ( 7404) P:99 I:22000 C:  81767 Min:      2 Act:    3 Avg:    3 Max:      10
> T:43 ( 7405) P:99 I:22500 C:  79950 Min:      2 Act:    4 Avg:    3 Max:       9
> T:44 ( 7406) P:99 I:23000 C:  78212 Min:      1 Act:    2 Avg:    3 Max:       8
> T:45 ( 7407) P:99 I:23500 C:  76548 Min:      1 Act:    3 Avg:    3 Max:       7
> T:46 ( 7408) P:99 I:24000 C:  74953 Min:      1 Act:    3 Avg:    3 Max:       6
> T:47 ( 7409) P:99 I:24500 C:  73423 Min:      1 Act:    3 Avg:    3 Max:       6
> T:48 ( 7410) P:99 I:25000 C:  71955 Min:      2 Act:    4 Avg:    3 Max:       7
> T:49 ( 7411) P:99 I:25500 C:  70544 Min:      1 Act:    3 Avg:    3 Max:       6
> T:50 ( 7412) P:99 I:26000 C:  69187 Min:      2 Act:    4 Avg:    3 Max:      11
> T:51 ( 7413) P:99 I:26500 C:  67881 Min:      1 Act:    3 Avg:    3 Max:       6
> T:52 ( 7414) P:99 I:27000 C:  66624 Min:      2 Act:    3 Avg:    3 Max:       7
> T:53 ( 7415) P:99 I:27500 C:  65413 Min:      1 Act:    4 Avg:    3 Max:       6
> T:54 ( 7416) P:99 I:28000 C:  64245 Min:      2 Act:    4 Avg:    3 Max:       6
> T:55 ( 7417) P:99 I:28500 C:  63118 Min:      2 Act:    3 Avg:    3 Max:       6
> T:56 ( 7418) P:99 I:29000 C:  62029 Min:      2 Act:    3 Avg:    3 Max:       8
> T:57 ( 7419) P:99 I:29500 C:  60978 Min:      2 Act:    3 Avg:    2 Max:       5
> T:58 ( 7420) P:99 I:30000 C:  59961 Min:      2 Act:    3 Avg:    2 Max:       5
> T:59 ( 7421) P:99 I:30500 C:  58978 Min:      2 Act:    3 Avg:    2 Max:       5
> T:60 ( 7422) P:99 I:31000 C:  58027 Min:      2 Act:    3 Avg:    3 Max:      10
> T:61 ( 7423) P:99 I:31500 C:  57106 Min:      2 Act:    3 Avg:    3 Max:       9
> T:62 ( 7424) P:99 I:32000 C:  56213 Min:      2 Act:    2 Avg:    2 Max:       5
> T:63 ( 7425) P:99 I:32500 C:  55349 Min:      2 Act:    5 Avg:    3 Max:       6
> 


