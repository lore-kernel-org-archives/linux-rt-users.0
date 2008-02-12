From: Esben Nielsen <nielsen.esben@googlemail.com>
Subject: Re: IBM test question
Date: Tue, 12 Feb 2008 11:19:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802121108010.11973@frodo.shire>
References: <47AB0C53.3050703@parrot.com> <20080207163440.174181f2@frecb000686.frec.bull.fr>
 <47AB3189.7080505@parrot.com> <20080208100603.0d825e1d@frecb000686.frec.bull.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-22478338-988720567-1202811587=:11973"
Cc: Matthieu CASTET <matthieu.castet@parrot.com>,
	linux-rt-users@vger.kernel.org
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:24665 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760276AbYBLKT6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Feb 2008 05:19:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so4063677fga.17
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Feb 2008 02:19:57 -0800 (PST)
In-Reply-To: <20080208100603.0d825e1d@frecb000686.frec.bull.fr>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---22478338-988720567-1202811587=:11973
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Fri, 8 Feb 2008, S=E9bastien Dugu=E9 wrote:

> On Thu, 07 Feb 2008 17:27:53 +0100 Matthieu CASTET <matthieu.castet@parro=
t.com> wrote:
>
>> Hi S=E9bastien,
>>
>> S=E9bastien Dugu=E9 wrote:
>>>   Hello Matthieu,
>>>
>>> On Thu, 07 Feb 2008 14:49:07 +0100 Matthieu CASTET <matthieu.castet@par=
rot.com> wrote:
>>>
>>>> hi,
>>>>
>>>> I am trying to use some IBM rt test on arm.
>>>>
>>>>
>>>> I define atomic_add to
>>>> assert(i=3D=3D1);
>>>> return ++(v->counter);
>>>>
>>>> That's a bit ugly, but that should work for my need.
>>>
>>>   That would be the poor man's atomic_inc() and not sure it really does
>>> what you think it does ;). Just for the record, pre-armv6 cores have no=
 support
>>> for userland atomic operations (aside from swapping).
>> I can, if I use a kernel helper :) [1]
>
>  Yep, but much slower.
>

I worked with an ARMv4 at my former job and wanted to run Linux on=20
it. I thus gave this problem a thought. I got the following idea:
Make a user space preemt-disable counter just like the in-kernel one. This=
=20
can be done by registering a address in userspace per thread pointing=20
where to find the counter. When the kernel wants to schedule it checks if=
=20
the counter is non-zero. If it is (the very rare case), it doesn't=20
reschedule but sets up a timer of some configurable time (say 1 ms or
whatever you need). If the counter is not back to 0 after the timer has=20
expired we schedule anyway and signals the thread to let it know that an
atomic operation have failed. Notice, that this can only happen due to an
error in the program: You must always be able finish your atomic=20
operations in 1 ms.

(There are a lot of details to this, ofcourse.  Forinstance. in the case=20
the kernel wanted to schedule and sets up he timer, the user space program=
=20
needs to know it so it can disable the timer reschedule as soon as the=20
counter reaches 0. And there is the problem of not swapping out the page=20
where the counter is stored....)

Esben




>>
>> BTW what should do the atomic_add.
>> On i386 it does the atomic add and return the value in memory before the
>> add (Exchange and Add).
>
>  Looking at the kernel and glibc, i386's atomic_add seems to be a void
> function (unless I missed something).
>
>> On powerpc, it seems to do the atomic add and return the new value.
>
>  Yes, both for kernel and glibc implementations.
>
>>
>>
>>>
>>>> But I have a problem with the sched_latency test.
>>>> On my platform the thread creation is quite slow (25ms), so with the
>>>> default value, I got a PERIOD MISSED.
>>>
>>>   The IBM RT tests have been integrated into the LTP and I recently
>>> sent some updates to those testcases. Notably one the patches did impro=
ve
>>> the thread starting time. Other patches did touch this particular test =
too.
>>>
>>>   Could you try the latest release (from LTP) and tell me if things
>>> have improved for you.
>> Ok I will try them.
>>>
>>>   Also, the PASS/FAIL criteria are quite arbitrary. They happen to be f=
ine
>>> for most recent PC-class hardware but surely not for embedded systems a=
nd
>>> should be tuned according to your RT requirements.
>> Yes I saw that.
>>
>>
>>>
>>>> Also my cpu is quite slow (compared to last intel core or powerpc). Fo=
r
>>>> example a sched_jitter run take 6s.
>>>
>>>   Ouch! What's your CPU (core type, clock speed)?
>> Arm926 ~104.65 Mhz
>
>  ARMv5 core then. You'll need the kernel helper then to be trully atomic.
>
>  Sebastien.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
---22478338-988720567-1202811587=:11973--
