From: John Kacur <jkacur@redhat.com>
Subject: Re: Detecting PREEMPT_RT
Date: Mon, 21 Jan 2013 13:17:34 +0100
Message-ID: <CAONaPpHxvc3_fsGE=r11D9ztyBmT2GfWazWP01yneyEFFCqc2g@mail.gmail.com>
References: <50FB36A0.7000702@zultron.com>
	<50FB4BB1.7070005@osadl.org>
	<1819DC75-5826-4882-A2B7-20953DE3392A@mah.priv.at>
	<50FC2A33.5010001@osadl.org>
	<50FC39E4.1090208@zultron.com>
	<50FC512A.5040909@osadl.org>
	<CAONaPpHFwj7zCPXb7tmZ6rODHrXXO==4HJe_zQxRGrS7dR2V_A@mail.gmail.com>
	<11A0CCD5-A89C-4173-8F94-EB06DFC765FE@mah.priv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: John Morris <john@zultron.com>, linux-rt-users@vger.kernel.org
To: Michael Haberler <mail17@mah.priv.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:52726 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab3AUMRf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Jan 2013 07:17:35 -0500
Received: by mail-ob0-f176.google.com with SMTP id un3so5703163obb.7
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Jan 2013 04:17:35 -0800 (PST)
In-Reply-To: <11A0CCD5-A89C-4173-8F94-EB06DFC765FE@mah.priv.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 21, 2013 at 1:14 PM, Michael Haberler <mail17@mah.priv.at> wrote:
> John,
>
>
> Am 21.01.2013 um 12:36 schrieb John Kacur:
>
>> On Sun, Jan 20, 2013 at 9:18 PM, Carsten Emde <C.Emde@osadl.org> wrote:
>>> John,
>>>
>>>
>>>>>>> Unfortunately, this wiki article is old and unmaintained. You're
>>>>>>> probably right to be a bit suspicious when checking for the "-rt"
>>>>>>> suffix
>>>>>>> of the kernel release (uname -r). But looking for the occurrence of
>>>>>>> "PREEMPT RT" in the kernel version (uname -v) should work. An
>>>>>>> application may use the system call uname() and check the version
>>>>>>> element of the utsname structure.
>>>>>>
>>>>>> the utsname.version string match is fine, however:
>>>>>>>
>>>>>>> In addition you may want to make sure the system has
>>>>>>> high-resolution
>>>>>>
>>>>>> timers. If so, the timers in /proc/timer_list have ".resolution: 1
>>>>>> nsecs". An application may use the function check_timer() from
>>>>>> cyclictest for this purpose:
>>>>>>>
>>>>>>> static int check_timer(void)
>>>>>>> {
>>>>>>>   struct timespec ts;
>>>>>>>
>>>>>>>   if (clock_getres(CLOCK_MONOTONIC, &ts))
>>>>>>>     return 1;
>>>>>>>
>>>>>>>   return (ts.tv_sec != 0 || ts.tv_nsec != 1);
>>>>>>> }
>>>>>>
>>>>>>
>>>>>> Just tried this on a generic kernel (2.6.32-45-generic #102-Ubuntu
>>>>>> SMP Wed Jan 2 21:53:06 UTC 2013 i686 GNU/Linux) and I get ts.tv_sec == 0
>>>>>> and ts.tv_nsec == 1, so it looks this cant be used to tell an RT_PREEMPT
>>>>>> from a vanilla kernel
>>>>>
>>>>> I meant boolean AND when I said "In addition".
>>>>
>>>> Oh, I interpreted the timer check not as a PREEMPT_RT check, but a
>>>> separate check for timers, which we must confirm are available before
>>>> driving heavy machinery.
>>>> So, if utsname.version contains "PREEMPT RT", then load the preempt-rt
>>>> module.  Once the module is loaded, from an init() function, run sanity
>>>> checks, including the clock_getres check above.  Is that about right?
>>>
>>> Yes. Sounds good to me.
>>>
>> Note we added a patch, called sysfs-realtime-entry.patch, but I'm not
>> sure how far back it goes, at least it's in 3.x-rt kernels.
>>
>> This is the text from the patch
>>
>> "Add a /sys/kernel entry to indicate that the kernel is a
>> realtime kernel.
>
> found this: https://bugzilla.redhat.com/show_bug.cgi?id=728551 and this:
> https://github.com/clrkwllms/rt-linux/commit/274ca2cb72e013602cebb8dc142a7c69d42f92db
>
> looks like it is being used elsewhere: http://softballinfo.net/ret/root/usr/lib/python2.6/site-packages/sos/plugins/kernel_realtime.py
>
>>
>> Clark says that he needs this for udev rules, udev needs to evaluate
>> if its a PREEMPT_RT kernel a few thousand times and parsing uname
>> output is too slow or so.
>>
>> Are there better solutions? Should it exist and return 0 on !-rt?"
>>
>> To use it, you do something like
>> test -e /sys/kernel/realtime
>
> excellent - this works fine for me (I dont see us going back further than 3.4):
>
> mah@atom:~$ uname -a
> Linux atom 3.4.13-rt-preempt-rt22+ #2 SMP PREEMPT RT Fri Oct 19 08:56:20 CEST 2012 i686 GNU/Linux
>
> mah@atom:~$ ls -l /sys/kernel/realtime
> -r--r--r-- 1 root root 4096 2013-01-21 12:53 /sys/kernel/realtime
>
> mah@atom:~$ cat /sys/kernel/realtime
> 1
>
> The way I read it the fingerprint is - '/sys/kernel/realtime' exists and contents is '1'
>
> thanks a lot!
>

No problem, now if you want to give back, please feel free to update
the wiki as well!

John
