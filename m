From: Mark Knecht <markknecht@gmail.com>
Subject: Re: 2.6.26.8-rt12 - No hwclock - works under 2.6.24-rt1
Date: Sat, 31 Jan 2009 09:58:28 -0800
Message-ID: <5bdc1c8b0901310958s555cfc0eg3ba649947d2581@mail.gmail.com>
References: <5bdc1c8b0901301600k13a06b0laf048293f037374c@mail.gmail.com>
	 <20090131085221.7fc4458d@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.170]:52748 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbZAaR6a (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 31 Jan 2009 12:58:30 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1022255wfd.4
        for <linux-rt-users@vger.kernel.org>; Sat, 31 Jan 2009 09:58:29 -0800 (PST)
In-Reply-To: <20090131085221.7fc4458d@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, Jan 31, 2009 at 6:52 AM, Clark Williams <williams@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On Fri, 30 Jan 2009 16:00:27 -0800
> Mark Knecht <markknecht@gmail.com> wrote:
>
>> I'm just getting around to trying 2.6.26.8-rt12 from the Gentoo
>> pro-audio overlay. I built the kernel using an older .config and make
>> oldconfig so maybe it didn't catch something correctly. Anyway, at
>> boot the system is complaining about all file times are in the future
>> and later on I see a message that it couldn't set the clock and I'll
>> have to do that by hand. The machine then finishes booting and I get
>> as far as X. Haven't tested anything more than that.
>>
>> the issue seems to be that the system cannot find my hardware clock,
>> and frankly neither can I in make menuconfig so maybe someone can tell
>> me where is the hardware clock? I'm hoping it's just misconfiguration
>> and not something more devious.
>>
>> Motherboard is an Asus A8N-E which is nVidia based. More info provided
>> if need be.
>>
>> Thanks,
>> Mark
>>
>> [NEW KERNEL]
>>
>> lightning ~ # uname -a
>> Linux lightning 2.6.26.8-rt12 #1 PREEMPT RT Fri Jan 30 12:39:38 PST
>> 2009 x86_64 AMD Athlon(tm) 64 Processor 3000+ AuthenticAMD GNU/Linux
>> lightning ~ # hwclock -r
>> Cannot access the Hardware Clock via any known method.
>> Use the --debug option to see the details of our search for an access method.
>> lightning ~ #
>
> As I recall this was a change in the rtc driver where it uses classes
> (and you can have multiple rtc device instances).  The result is that
> the rtc driver no longer creates /dev/rtc but rather /dev/rtc0.
>
> You might try just creating a symlink in /dev from rtc -> rtc0 and see
> if that makes your startup logic happy. I don't think that using udev
> to create your symlink on the fly is an option, because most distros
> access the RTC before udev gets run.
>
> You might also make sure that CONFIG_RTC_DRV_CMOS=y, so that you don't
> have to load a module from an initrd to get to the cmos clock.
>
> Clark

Norval,
   I'll see about using a newer one soon. Thanks!

Clark,
   CONFIG_RTC_DRV_CMOS=y is set. However all of the specific chip
versions immediately below it are not set so without at least one of
those is the CONFIG_RTC_DRV_CMOS doing anything?

   If by change I need to set at least one of those chip options how
do I determine what's on this motherboard?

   Scanning around this area I also notice that I've going none of the
I2C RTC drivers selected either.

   I haven't had time to check yet but the 2.6.27-gentoo-r8 kernel
didn't have this problem. I'll compare .config files between the two
and see what differences I can find.

Thanks,
Mark
