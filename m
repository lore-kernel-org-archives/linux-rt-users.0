From: Nathan Grennan <linux-rt-users@cygnusx-1.org>
Subject: Re: Soft lock issue with 2.6.33.7-rt29
Date: Fri, 19 Nov 2010 11:21:56 -0800
Message-ID: <4CE6CE54.5010600@cygnusx-1.org>
References: <4CE428CB.20808@willowgarage.com> <4CE480BF.7050603@linux.intel.com> <4CE5A4A3.4040202@cygnusx-1.org> <4CE6C61B.6090608@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from okcforum.org ([173.8.189.10]:59739 "EHLO mail.okcforum.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755190Ab0KSTV6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 19 Nov 2010 14:21:58 -0500
In-Reply-To: <4CE6C61B.6090608@linux.intel.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/19/2010 10:46 AM, Darren Hart wrote:
> On 11/18/2010 02:11 PM, Nathan Grennan wrote:
>> On 11/17/2010 05:26 PM, Darren Hart wrote:
>>> On 11/17/2010 11:11 AM, Nathan Grennan wrote:
>>>> I have been working for weeks to get a stable rt kernel. I had been
>>>> focusing on 2.6.31.6-rt19. It is stable for about four days under 
>>>> stress
>>>> testing before it soft locks. I am using rt19 instead of rt21, because
>>>> rt19 seems to be more stable. The rtmutex issue that seems to still be
>>>> in rt29 is in rt21. I also had to backport the iptables fix to rt19.
>>>>
>>>> I just started looking at 2.6.33.7-rt29 again, since I can reproduce a
>>>> soft lock with it in 10-15 minutes. I have yet to get sysrq output for
>>>> rt19, since it takes four days. The soft lock with rt29 as far as I 
>>>> can
>>>> tell seems to relate to disk i/o.
>>>>
>>>> There are links to two logs of rt29 from a serial console below. They
>>>> include sysrq output like "Show Blocked State" and "Show State". The
>>>> level7 file is with nfsd enable, and level9 is with it disable. So 
>>>> nfsd
>>>> doesn't seem to be the issue.
>>>>
>>>> If any other debugging information is useful or needed, just say the
>>>> word.
>>>
>>> A reproducible test-case is always the first thing we ask for :-) What
>>> is your stress test?
>>
>> I have been able to boil it down the script below. If I just run yes it
>> is fine, if I just run dd, it is fine. If you just run octave, it is
>> fine. Run yes+dd, gets it most of the way there, but will wake up
>> sometimes, off and on. Do all three together and it soft locks. It takes
>> 5-15 minutes. I did it on our main example hardware, which is a server.
>> I have also reproduced it on a desktop. Sometimes sysrq-n, to renice
>> realtime processes, brings it out of it enough you can kill processes 
>> off.
>
>
> Interesting, so you're locking up a preempt-rt kernel with SCHED_OTHER 
> tasks running at the least favorable priority.
>
> Note: nice -n 19 is actually the valid nice value (20 and higher seem 
> to be accepted, but have the same effect as 19). NICE(1)
>
> How many CPUs on your test machine?
>
The server is dual quad-core. The desktop is a quad-core with 
hyperthreading. Both are i7 based.
