From: Stanislav Meduna <stano@meduna.org>
Subject: Re: timerfd read does not return [Was: Re: timerfd and softirqd]
Date: Fri, 19 Apr 2013 21:53:52 +0200
Message-ID: <5171A0D0.8050100@meduna.org>
References: <516BDE52.90200@meduna.org> <alpine.LFD.2.02.1304151416580.21884@ionos> <516BF8FD.2000700@meduna.org> <516EC3F3.1080406@meduna.org> <516FB8B9.9090506@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:35449 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753519Ab3DSTyG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Apr 2013 15:54:06 -0400
Received: from dial-95-105-165-4-orange.orange.sk ([95.105.165.4] helo=[192.168.130.22])
	by meduna.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <stano@meduna.org>)
	id 1UTHNd-00086l-05
	for linux-rt-users@vger.kernel.org; Fri, 19 Apr 2013 21:54:00 +0200
In-Reply-To: <516FB8B9.9090506@meduna.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18.04.2013 11:11, Stanislav Meduna wrote:

> There is no return from the read until the RT throttler got activated.
> Kernel version 3.4.25-rt37 - I'll check whether anything relevant
> has changed since then.

I changed the RT throttler to do show_state_filter(0); (sysrq-t).
No idea whether this is the sane way to do in that context
and how relevant the results are, but from the failing thread
I am getting


TimerT     R running      0   671    636 0x10000000
 ceb76a70 b7633158 c01169b0 ceb51ed4 c0116acb 00000029 ceb51e6c c012385d
 ceb51edc cea6d248 cd8024b0 cea6d200 00000002 00000029 c012385d 00000001
 00000000 00000000 ceb51ea0 c0146476 00000030 ceb51ea8 c012385d ceb51ed4
Call Trace:
 [<c01169b0>] ? mm_fault_error+0x170/0x170
 [<c0116acb>] ? do_page_fault+0x11b/0x390
 [<c012385d>] ? irq_exit+0x6d/0x80
 [<c012385d>] ? irq_exit+0x6d/0x80
 [<c0146476>] ? sub_preempt_count+0x36/0x50
 [<c012385d>] ? irq_exit+0x6d/0x80
 [<c03a9718>] ? do_IRQ+0x48/0x94
 [<c01169b0>] ? mm_fault_error+0x170/0x170
last message repeated 2 times
 [<c03a8e3d>] ? error_code+0x5d/0x70
 [<c0130000>] ? sys_rt_sigqueueinfo+0x70/0x90
 [<c01169b0>] ? mm_fault_error+0x170/0x170
 [<c027cb51>] ? __put_user_8+0x11/0x19
 [<c01fa323>] ? timerfd_read+0x183/0x280
 [<c013aa40>] ? wake_up_bit+0x60/0x60
 [<c01bffcf>] ? vfs_read+0x9f/0x150
 [<c01c08e7>] ? fget_light+0x87/0xe0
 [<c01fa1a0>] ? sys_timerfd_gettime+0x140/0x140
 [<c01c0152>] ? sys_read+0x42/0x70
 [<c03a8b95>] ? syscall_call+0x7/0xb
 [<c03a0000>] ? init_memory_mapping+0x1a0/0x410


I have two instances of this trace and one another:

Call Trace:
 [<c027bffc>] ? trace_hardirqs_on_thunk+0xc/0x10
 [<c03a7dbd>] ? restore_all+0xf/0xf
 [<c027007b>] ? cfq_completed_request+0x58b/0x5f0
 [<c0119ea0>] ? __kunmap_atomic+0x50/0x60
 [<c01aadd1>] ? handle_pte_fault+0x141/0xa00
 [<c01ab710>] ? handle_mm_fault+0x80/0xc0
 [<c015b26d>] ? rt_up_read+0x1d/0x30
 [<c0116b18>] ? do_page_fault+0x168/0x390
 [<c012385d>] ? irq_exit+0x6d/0x80
 [<c0161684>] ? irq_to_desc+0x14/0x20
 [<c0103c3f>] ? handle_irq+0x1f/0x90
 [<c03a890f>] ? do_IRQ+0x3f/0x94
 [<c011007b>] ? x86_schedule_events+0x34b/0x4b0
 [<c03a882e>] ? common_interrupt+0x2e/0x40
 [<c0130000>] ? sys_rt_sigqueueinfo+0x70/0x90
 [<c027bd51>] ? __put_user_8+0x11/0x19
 [<c01f9523>] ? timerfd_read+0x183/0x280
 [<c013aa40>] ? wake_up_bit+0x60/0x60
 [<c01bf1cf>] ? vfs_read+0x9f/0x150
 [<c01bfae7>] ? fget_light+0x87/0xe0
 [<c01f93a0>] ? sys_timerfd_gettime+0x140/0x140
 [<c01bf352>] ? sys_read+0x42/0x70
 [<c03a7d95>] ? syscall_call+0x7/0xb


The __put_user_8 looks like the put_user at the end of the
timerfd_read. Where does the sys_rt_sigqueueinfo come from?

The read destination is just a normal 8-byte variable on stack,
I don't see how this can become invalid while the thread is
in kernel

  uint64_t exp;
  ...
  read(tmrFd, &exp, sizeof(exp))

The timer fd _does_ eventually return - after 200 ms to 5 seconds -
and works normally afterwards. Unfortunately I don't know whether
it returns with 8 or with -EFAULT. In any case there is no crash,
I do not catch SIGSEGV, SIGBUS and similar.

I'm puzzled. Does this make sense to anyone? Is this better suited
for the general Linux list?

Unrelated questions: I am not so familiar with Linux on this level,
but shouldn't interrupts be handled on their own stack?

Thanks
-- 
                                      Stano

