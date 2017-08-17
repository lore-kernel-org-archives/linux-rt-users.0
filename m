From: Corey Minyard <cminyard@mvista.com>
Subject: Re: Kdump not working with rt patch, tested under
 4.4.32/4.4.79/4.9.40
Date: Thu, 17 Aug 2017 07:19:46 -0500
Message-ID: <5985de84-db52-05d9-5899-95b9bbecf91a@mvista.com>
References: <CAF6bL9=e4Ah6iwmvj+PponVgYaSGKYJ1WW98sZgvAY9cK8_9Eg@mail.gmail.com>
 <20170809153524.GY8384@jcartwri.amer.corp.natinst.com>
 <CAF6bL9k1zzPR6Y7-LrSXSqBc2S-v+zspb+1JLvSamrF+Zcd3OA@mail.gmail.com>
 <CAF6bL9mRqHqf8tdGk53EHwRnHM_BSbpSWMechfHh4OJJz_XMRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Journey Journey <journeywang123@gmail.com>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34027 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbdHQMTs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 17 Aug 2017 08:19:48 -0400
Received: by mail-pg0-f43.google.com with SMTP id u185so41787038pgb.1
        for <linux-rt-users@vger.kernel.org>; Thu, 17 Aug 2017 05:19:48 -0700 (PDT)
In-Reply-To: <CAF6bL9mRqHqf8tdGk53EHwRnHM_BSbpSWMechfHh4OJJz_XMRQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 08/17/2017 05:05 AM, Journey Journey wrote:
> Anyone reproduce this problem?

You need to read Julia's previous email on this.  I think it has the 
answers you need.

-corey

> Thanks
>
> On Wed, Aug 16, 2017 at 12:39 PM, Journey Journey
> <journeywang123@gmail.com> wrote:
>> Thank you all for replying my question. The Details following:
>>
>> Kernel Version: 4.4.32                from
>> https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.4.32.tar.xz
>> Rt Patch Version: 4.4.32-rt43     from
>> https://www.kernel.org/pub/linux/kernel/projects/rt/4.4/older/patch-4.4.32-rt43.patch.gz
>>
>> Configs as attached,
>> (1) config.4.4.32 for non rt kernel
>> (2) config.4.4.32.rt for rt kernel
>>
>> Testcase code as attached,
>> (1) softlockup-nonrt.c for non rt kernel;
>> (2) softlockup-rt.c for rt kernel, using raw_spinlock
>> (3) softlockup-rt-fifo.c for rt kernel, using sched_fifo & priority 99
>> (4) sample Makefile for building kernel module
>>
>>
>> Test Case 1: non rt kernel + softlockup-nonrt.c
>>       Picture attached  nonrt-1.png
>> The kernel had no response for keyboard input....
>>       Picture attached  nonrt-2.png
>> After several minutes, the kdump is triggered.
>>
>> Test Case 2:  rt kernel + softlockup-rt.c
>>       Picture attached  rt-1.png
>> The kernel had no response for keyboard input....
>> Hangs forever ........
>>
>> Test Case 3:  rt kernel + softlockup-rt-fifo.c
>>            Picture attached  rt-2.png
>> The kernel had no response for keyboard input....
>> Hangs forever ........
>>
>> Test Case 4:  rt kernel + softlockup-rt-fifo.c + throttling
>>           Picture attached  rt-3.png
>> The kernel had no response for keyboard input....
>> Hangs forever ........
>>
>> By the way, my test environment  is virtualbox with ubuntu.
>> Virtualbox Configration:
>>    Picture attached  Virtualbox-1.png Virtualbox-2.png  Virtualbox-3.png
>>
>> crashkernel config
>>   crashkernel=512M
>>
>> Please help me, thanks all!!
>>
>>
>> On Wed, Aug 9, 2017 at 11:35 PM, Julia Cartwright <julia@ni.com> wrote:
>>> On Wed, Aug 09, 2017 at 05:05:42PM +0800, Journey Journey wrote:
>>>> Test case: https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c
>>>>
>>> Please in the future provide more information as to what you are trying
>>> to do, what it is you are trying, what you are seeing, and why you think
>>> it's wrong.
>>>
>>> Because otherwise, we're forced to reverse engineer your intent. :(
>>>
>>> I'm _guessing_ that what you meant to say was:
>>>
>>>     I have a testcase module that I use that attempts to trigger the
>>>     kernels softlockup detection.  Here is a link:
>>>
>>>        https://github.com/saiyamd/softlockup_test/blob/master/softlockup_test.c
>>>
>>>     I'm expecting it to fire the softlockup detector and panic the system
>>>     (I use CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC in my test rig), however,
>>>     when I load this module on an RT system, it doesn't appear to trigger
>>>     the softlockup detector![1]
>>>
>>>     What could be wrong?
>>>
>>> If that's what you meant, then the answer is:
>>>
>>> The way that you are "hogging" the CPU, on PREEMPT_RT, doesn't prevent
>>> the kernel from scheduling other tasks in and out (including the
>>> watchdog thread which pets the watchdog!).
>>>
>>> Your test case, effectively is:
>>>
>>>      spin_lock(&lock)
>>>      while (1)
>>>         printk("...");
>>>      spin_unlock(&lock)
>>>
>>> On RT, spin-lock protected regions are preemptible.  When the watchdog
>>> hrtimer fires and wakes up the softlockup thread, that thread preempts
>>> the thread stuck in this region and touches the watchdog.  This prevents
>>> the watchdog threshold from being reached.
>>>
>>> The good news for you is that it should be entirely possible for you to
>>> trigger the softlockup detector on RT entirely in usermode.  All you'd
>>> need to do is disable RT throttling, and set a thread SCHED_FIFO w/ prio
>>> 99 spinning.
>>>
>>>     Julia
>>>
>>> 1: Note: this has nothing to do with Kdump whatsoever.


