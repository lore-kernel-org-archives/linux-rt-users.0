From: Kimmo Taskinen <kimmo.taskinen@me.com>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of my
 machines
Date: Sun, 09 Mar 2014 20:26:24 +0200
Message-ID: <531CB250.6010007@me.com>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
 <20140207152250.GC2382@linutronix.de>
 <CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com>
 <52FA43C8.5000102@linutronix.de> <5313185A.3040301@me.com>
 <5319B382.1050208@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from st11p00mm-asmtpout004.mac.com ([17.172.81.3]:46814 "EHLO
	st11p00mm-asmtp004.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751242AbaCIS01 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 9 Mar 2014 14:26:27 -0400
Received: from [10.0.1.102] (cs181219184.pp.htv.fi [82.181.219.184])
 by st11p00mm-asmtp004.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0N26006O2LW0XG40@st11p00mm-asmtp004.mac.com> for
 linux-rt-users@vger.kernel.org; Sun, 09 Mar 2014 18:26:27 +0000 (GMT)
In-reply-to: <5319B382.1050208@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07.03.2014 13:54, Sebastian Andrzej Siewior wrote:
> On 03/02/2014 12:39 PM, Kimmo Taskinen wrote:
>> Hi,
> Hi,
>
>> Phenom has had boot problems with all patches after 3.12.5-rt7.
> The difference between 3.12.5-rt7 and v3.12.6-rt8 is just the stable
> .6. I don't have anything close to the hardware to look at this myself.
>
>> Today I noticed that an old Turion64 laptop didn't boot even with
>> 3.12.5-rt7. I tried 3.10.32-rt30 and that worked fine.
>>
>> Cheers
>> Kimmo
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Hi,

I found out that the reason for the Turion boot problem is 
CONFIG_X86_POWERNOW_K8. As soon as I disabled it Turion booted fine.
And this test was done with linux-3.12.13-aufs-rt21.

However the Phenom (AMD Phenom II X4 910e) boot problem seems to be 
something else and it remains. I disabled CONFIG_CPU_FREQ completely but 
that didn't help.

Cheers
Kimmo
