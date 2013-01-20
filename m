From: John Morris <john@zultron.com>
Subject: Re: Detecting PREEMPT_RT
Date: Sun, 20 Jan 2013 12:39:32 -0600
Message-ID: <50FC39E4.1090208@zultron.com>
References: <50FB36A0.7000702@zultron.com> <50FB4BB1.7070005@osadl.org> <1819DC75-5826-4882-A2B7-20953DE3392A@mah.priv.at> <50FC2A33.5010001@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Haberler <mail17@mah.priv.at>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from kayako.ext.zultron.com ([67.18.89.240]:51520 "EHLO
	kayako.ext.zultron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab3ATSjg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Jan 2013 13:39:36 -0500
In-Reply-To: <50FC2A33.5010001@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 01/20/2013 11:32 AM, Carsten Emde wrote:
> Hi Michael,
> 
>>> Unfortunately, this wiki article is old and unmaintained. You're
probably right to be a bit suspicious when checking for the "-rt" suffix
of the kernel release (uname -r). But looking for the occurrence of
"PREEMPT RT" in the kernel version (uname -v) should work. An
application may use the system call uname() and check the version
element of the utsname structure.
>>
>> the utsname.version string match is fine, however:
>>
>>> In addition you may want to make sure the system has
>>> high-resolution
timers. If so, the timers in /proc/timer_list have ".resolution: 1
nsecs". An application may use the function check_timer() from
cyclictest for this purpose:
>>> static int check_timer(void)
>>> {
>>>   struct timespec ts;
>>>
>>>   if (clock_getres(CLOCK_MONOTONIC, &ts))
>>>     return 1;
>>>
>>>   return (ts.tv_sec != 0 || ts.tv_nsec != 1);
>>> }
>>
>> Just tried this on a generic kernel (2.6.32-45-generic #102-Ubuntu
SMP Wed Jan 2 21:53:06 UTC 2013 i686 GNU/Linux) and I get ts.tv_sec == 0
and ts.tv_nsec == 1, so it looks this cant be used to tell an RT_PREEMPT
from a vanilla kernel
> I meant boolean AND when I said "In addition".

Oh, I interpreted the timer check not as a PREEMPT_RT check, but a
separate check for timers, which we must confirm are available before
driving heavy machinery.

So, if utsname.version contains "PREEMPT RT", then load the preempt-rt
module.  Once the module is loaded, from an init() function, run sanity
checks, including the clock_getres check above.  Is that about right?

Thanks for the tips, Carsten!

	John
