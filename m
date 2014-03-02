From: Kimmo Taskinen <kimmo.taskinen@me.com>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of my
 machines
Date: Sun, 02 Mar 2014 13:13:44 +0200
Message-ID: <53131268.4070806@me.com>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
 <20140207152250.GC2382@linutronix.de>
 <CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from st11p00mm-asmtp002.mac.com ([17.172.81.1]:38043 "EHLO
	st11p00mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752563AbaCBMNr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Mar 2014 07:13:47 -0500
Received: from [10.0.1.102] (cs181219184.pp.htv.fi [82.181.219.184])
 by st11p00mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0N1T00KI836WCW20@st11p00mm-asmtp002.mac.com> for
 linux-rt-users@vger.kernel.org; Sun, 02 Mar 2014 11:13:46 +0000 (GMT)
In-reply-to: <CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Phenom has had boot problems with all patches after 3.12.5-rt7.

Today I noticed that an old Turion64 laptop didn't boot even with 
3.12.5-rt7. I tried 3.10.32-rt30 and that worked fine.

Cheers
Kimmo

On 11.02.2014 17:16, jordan wrote:
> Hi,
>
> sorry for the late reply. but i have an update / tested the latest patchset.
>
> On Fri, Feb 7, 2014 at 10:22 AM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> * jordan | 2014-02-05 20:54:59 [-0500]:
>>
>>> On 3.12.8-rt11 - i was able to get the kernel to boot via reverting two
>>> patches, from the split queue;
>>>
>>> 'timer-Raise-softirq-if-there-s-irq_work.patch'
>>> 'timers-do-not-raise-softirq-unconditionally.patch'
>> It was reported to the list that
>> timers-do-not-raise-softirq-unconditionally.patch sometimes stalled the
>> machine. The timer-Raise-softirq-if-there-s-irq_work.patch should have
>> fixes one common case and -rt13 should have coverted them all.
> Well, i know for my processor [AMD Phenom 965 x4] -rt11 definitely
> failed to boot [likewise so did -rt13]. Here is another user reporting
> boot failure, with the same CPU [he was reporting on -rt11, IIRC];
> https://aur.archlinux.org/packages/linux-rt/ ...vvd writes:  "I am
> having the same problem as Ninez has. This does not boot. I am also
> running an AMD Phenom II 965 x4. "... I'm going to ask him about
> -rt15, if he has had a chance to try it out.
>
>>> (i haven't tried reverting on -rt13, as i haven't had the time to do that).
>> It should work on -rt13 without reverting them.
> No. -rt13 fails just the same...And just now, I have tested -rt15 -
> which also fails to boot.
>
> I am going to revert the patches that you suggested [below] and see if
> i can get the machine to boot. However, this won't solve the problem -
> as i package my kernel for others to use.
>
>>> however, while this was enough to boot - my system was unstable. thus i
>>> downgraded my kernel back to trusty 3.12.5-rt7 - which works flawlessly for
>>> me. Next, I saw the -rt13 release, thinking maybe the boot issue was
>>> finally solved [according to the change log], but no - it fails just as
>>> before... I tried to add debug to grub's commandline but in the end, it
>>> wasn't really helpful. [the last thing shown is something about PnP and
>>> then ACPI];
>>>
>>> [    0.255329] pnp: PnP ACPI: found 10 devices
>>> [    0.255330] ACPI: bus type PNP unregistered
>>>
>>> (which i would normally see anyway.)
>> this looks like a missing event (like timer interrupt or RCU wakeup and
>> "timers-do-not-raise-softi..." might be a source of this but then it
>> should be fixed).
> It's not fixed in -rt15 [or -rt13] for me. It fails just the same.
>
>> At [0] is my quilt queue containing tags for releases between the
>> working and non-working release. As mentioned before,
>> timers-do-not-raise-softirq-unconditionally.patch will cause stalls
>> which is finally fixed by
>> timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch.
>>
>> Looking at my queue between -rt8 and now there is nothing big except for
>> the "raise softirq unconditional" patch.
>> If you decide to bisect the queue to find the offending post -rt8 patch
>> that causes trouble, please note that take these patches
>> | timers-do-not-raise-softirq-unconditionally.patch
>> | timer-Raise-softirq-if-there-s-irq_work.patch
>> | timer-rt-Always-raise-the-softirq-if-there-s-irq_wor.patch
>> should be applied together since the later two are fixes for the former.
>>
>> [0] git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/rt-devel.git
> you would be looking at differences between -rt7 and now, as -rt8
> fails to boot. [-rt7 is stable, -rt8+ doesn't boot].
>
> When i get home tonight, i will revert those three patches and see if
> i get a working kernel, but again - because i package my kernel [for
> other users], this is problematic. [ie: i can't update packages until
> i am sure that linux-rt patchset will boot for everyone okay - right
> now, i know it won't boot for some and if i revert those 3 patches,
> while it may boot for me/possibly those who it doesn't boot for - it's
> likely going to cause issues for other users... it's a bit of a
> pickle! ;) ].
>
> anyway, let me know if there is anything i can do - as is - i will
> report back if reverting those three patches allows my machine to at
> least boot.
>
>> Sebastian
> Jordan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

