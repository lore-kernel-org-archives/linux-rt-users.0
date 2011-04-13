From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [ANNOUNCE] 2.6.33.9-rt31
Date: Wed, 13 Apr 2011 15:39:18 +0200
Message-ID: <4DA5A786.8060001@siemens.com>
References: <alpine.LFD.2.00.1104111723020.4501@localhost6.localdomain6> <4DA582AE.9020706@autostatic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeremy Jongepier <jeremy@autostatic.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fmmailgate02.web.de ([217.72.192.227]:43421 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab1DMNjW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Apr 2011 09:39:22 -0400
In-Reply-To: <4DA582AE.9020706@autostatic.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2011-04-13 13:02, Jeremy Jongepier wrote:
> On 04/11/2011 05:35 PM, Thomas Gleixner wrote:
>> We are pleased to announce the next update to our new preempt-rt
>> series which is mostly a forward to 2.6.33.9. Thanks Greg !
>>
>> RT specific patches since 2.6.33.7.2-rt30
>>
>> 8a97f01: arm: mxc: Add sched_clock to mxc-platform
>> a5a2b75: arm: mxc: Add add dummy_get_cycles()
>> c1d6834: trace: Add timestamp to maxlatproc data
>> cfe9ed2: trace: Add current task to maxlatproc data
>> 70fdd17: trace: Add timeroffset to maxlatproc data
>> db2aacd: trace: timer offsets histogram consider smp same prio
>> 3115eb2: x86, hotplug: Revert 74a6e0fd8 (x86, hotplug: Use mwait to ...)
>> 250bf15: ARM: sched_clock: make minsec argument to clocks_calc_mult_shift() zero
>> c04f3a8: ARM: sched_clock: allow init_sched_clock() to be called early
>> 4d79f92: ARM: sched_clock: provide common infrastructure for sched_clock()
>> 7443ac2: asm-generic/percpu: fixup RT mismerge
>> 7e1c4f9: rtmutex: Ensure only the top waiter or higher priority task can take the lock
>> 47b3309: rtmutex: Fix comment about why new_owner can be NULL in wake_futex_pi()
>> 2ce1161: rtmutex: Revert Optimize rt lock wakeup
>> 9704792: rtmutex: Try to take lock early in rt_spin_lock_slowlock()
>> 5995a44: rtmutex: Only save lock depth once in spin_slowlock
>>
>> Download locations:
>>    
>>     http://www.kernel.org/pub/linux/kernel/projects/rt/
>>
>> Git release branch:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip.git rt/2.6.33
>>   
>> Gitweb:
>>     http://git.kernel.org/?p=linux/kernel/git/tip/linux-2.6-tip.git;a=shortlog;h=rt/2.6.33
>>   
>> Information on the RT patch can be found at:
>>
>>     http://rt.wiki.kernel.org/index.php/Main_Page
>>
>> to build the 2.6.33.9-rt31 tree, the following patches should be
>> applied:
>>
>>     http://www.kernel.org/pub/linux/kernel/v2.6/linux-2.6.33.9.tar.bz2
>>     http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.33.9-rt31.bz2
>>
>> Enjoy !
>>
>>       tglx
> 
> Thanks for this! Still can't use my two displays with the nouveau kernel
> module though :(

A nouveau hacker recently explained to me that it's fairly hard to
backport their improvements to older kernels as they heavily depend on
infrastructure changes. That likely explains why you don't see many
stable fixes or a nouveau-compat package.

If you can live with the nvidia driver, I can share a patch that makes
it build&work for me (Quadro FX 880M).

Jan

-- 
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
