From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.33.9-rt31 boot problem
Date: Wed, 15 Jun 2011 12:28:17 -0700
Message-ID: <4DF907D1.1040008@localhost>
References: <BANLkTiknsZhD2XHYoW4x2M8RfDku8righg@mail.gmail.com>	<4DF8F05A.6050203@localhost> <BANLkTikywL79BpXj44Ve24SbmwB1Wr1Ckg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: dashesy <dashesy@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp3.Stanford.EDU ([171.67.219.83]:44474 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752383Ab1FOT2Y (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 15 Jun 2011 15:28:24 -0400
In-Reply-To: <BANLkTikywL79BpXj44Ve24SbmwB1Wr1Ckg@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/15/2011 12:18 PM, dashesy wrote:
> On Wed, Jun 15, 2011 at 11:48 AM, Fernando Lopez-Lezcano
> <nando@ccrma.stanford.edu>  wrote:
>> On 06/12/2011 09:21 AM, dashesy wrote:
>>>
>>> First, sorry for double post, I did not know if my email went through
>>> first time (maybe for large config file attached)
>>>
>>> Same machine 2.6.33.7.2-rt30 boots fine with Ubuntu and no problem at
>>> all, today I tried the new version with Fedora 15 but it crashes early
>>> in the boot process.
>>
>> A workaround in Fedora 15 (posted in another message to another list so you
>> may not have seen it) is to use upstart instead of systemd for startup
>> (systemd requires features only found on newer kernels).
>>
>> In the kernel boot line add "init=/sbin/upstart" and of course make sure you
>> have the upstart package installed.
>
> Thanks for the reply,
> Actually oops is much earlier than init, as you can see in the
> attached boot.log I have "init=/bin/sh"
> [    0.000000] Linux version 2.6.33.9-rt31 (ehsan@ehsan) (gcc version
> 4.6.0 20110530 (Red Hat 4.6.0-9) (GCC) ) #3 SMP PREEMPT RT Wed Jun 8
> 16:16:46 MDT 2011
>
> [    0.000000] Command line: console=ttyS0 root=/dev/sda rw init=/bin/sh

I see, yes (sorry I did not look at the log before), very very early... 
don't know what to make of it, sorry...

-- Fernando
