From: John Kacur <jkacur@redhat.com>
Subject: Re: Detecting PREEMPT_RT
Date: Mon, 21 Jan 2013 12:36:19 +0100
Message-ID: <CAONaPpHFwj7zCPXb7tmZ6rODHrXXO==4HJe_zQxRGrS7dR2V_A@mail.gmail.com>
References: <50FB36A0.7000702@zultron.com>
	<50FB4BB1.7070005@osadl.org>
	<1819DC75-5826-4882-A2B7-20953DE3392A@mah.priv.at>
	<50FC2A33.5010001@osadl.org>
	<50FC39E4.1090208@zultron.com>
	<50FC512A.5040909@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Morris <john@zultron.com>,
	Michael Haberler <mail17@mah.priv.at>,
	linux-rt-users@vger.kernel.org
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44]:48610 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab3AULgT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 06:36:19 -0500
Received: by mail-oa0-f44.google.com with SMTP id n5so5985223oag.31
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 03:36:19 -0800 (PST)
In-Reply-To: <50FC512A.5040909@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, Jan 20, 2013 at 9:18 PM, Carsten Emde <C.Emde@osadl.org> wrote:
> John,
>
>
>>>>> Unfortunately, this wiki article is old and unmaintained. You're
>>>>> probably right to be a bit suspicious when checking for the "-rt"
>>>>> suffix
>>>>> of the kernel release (uname -r). But looking for the occurrence of
>>>>> "PREEMPT RT" in the kernel version (uname -v) should work. An
>>>>> application may use the system call uname() and check the version
>>>>> element of the utsname structure.
>>>>
>>>> the utsname.version string match is fine, however:
>>>>>
>>>>> In addition you may want to make sure the system has
>>>>> high-resolution
>>>>
>>>> timers. If so, the timers in /proc/timer_list have ".resolution: 1
>>>> nsecs". An application may use the function check_timer() from
>>>> cyclictest for this purpose:
>>>>>
>>>>> static int check_timer(void)
>>>>> {
>>>>>    struct timespec ts;
>>>>>
>>>>>    if (clock_getres(CLOCK_MONOTONIC, &ts))
>>>>>      return 1;
>>>>>
>>>>>    return (ts.tv_sec != 0 || ts.tv_nsec != 1);
>>>>> }
>>>>
>>>>
>>>> Just tried this on a generic kernel (2.6.32-45-generic #102-Ubuntu
>>>> SMP Wed Jan 2 21:53:06 UTC 2013 i686 GNU/Linux) and I get ts.tv_sec == 0
>>>> and ts.tv_nsec == 1, so it looks this cant be used to tell an RT_PREEMPT
>>>> from a vanilla kernel
>>>
>>> I meant boolean AND when I said "In addition".
>>
>> Oh, I interpreted the timer check not as a PREEMPT_RT check, but a
>> separate check for timers, which we must confirm are available before
>> driving heavy machinery.
>> So, if utsname.version contains "PREEMPT RT", then load the preempt-rt
>> module.  Once the module is loaded, from an init() function, run sanity
>> checks, including the clock_getres check above.  Is that about right?
>
> Yes. Sounds good to me.
>
Note we added a patch, called sysfs-realtime-entry.patch, but I'm not
sure how far back it goes, at least it's in 3.x-rt kernels.

This is the text from the patch

"Add a /sys/kernel entry to indicate that the kernel is a
realtime kernel.

Clark says that he needs this for udev rules, udev needs to evaluate
if its a PREEMPT_RT kernel a few thousand times and parsing uname
output is too slow or so.

Are there better solutions? Should it exist and return 0 on !-rt?"

To use it, you do something like
test -e /sys/kernel/realtime

If you need it in an older kernel that doesn't have it, it should port
trivially.

Thanks
