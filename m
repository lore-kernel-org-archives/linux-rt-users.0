From: Kimmo Taskinen <kimmo.taskinen@me.com>
Subject: Re: Linux-rt fails to boot [any release past 3.12.5-rt7] on all of my
 machines
Date: Sun, 02 Mar 2014 13:39:06 +0200
Message-ID: <5313185A.3040301@me.com>
References: <CAOcfFMw2P9QwQrzUYL4rpvrJ2_d7L8Q3fi3-U=dgB=krjd2QoQ@mail.gmail.com>
 <20140207152250.GC2382@linutronix.de>
 <CAOcfFMzcymuyoi+Ox6pQ=U7KBbmbwFOYwHZHKBQPQpmjBLkQJQ@mail.gmail.com>
 <52FA43C8.5000102@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	jordan <triplesquarednine@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from st11p00mm-asmtp004.mac.com ([17.172.81.3]:39769 "EHLO
	st11p00mm-asmtp004.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752453AbaCBLjJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 2 Mar 2014 06:39:09 -0500
Received: from [10.0.1.102] (cs181219184.pp.htv.fi [82.181.219.184])
 by st11p00mm-asmtp004.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0N1T00DQS4D6LS00@st11p00mm-asmtp004.mac.com> for
 linux-rt-users@vger.kernel.org; Sun, 02 Mar 2014 11:39:08 +0000 (GMT)
In-reply-to: <52FA43C8.5000102@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

Phenom has had boot problems with all patches after 3.12.5-rt7.

Today I noticed that an old Turion64 laptop didn't boot even with 
3.12.5-rt7. I tried 3.10.32-rt30 and that worked fine.

Cheers
Kimmo

On 11.02.2014 17:37, Sebastian Andrzej Siewior wrote:
> On 02/11/2014 04:16 PM, jordan wrote:
>> Hi,
> Hi Jordan,
>
>> you would be looking at differences between -rt7 and now, as -rt8
>> fails to boot. [-rt7 is stable, -rt8+ doesn't boot].
>>
>> When i get home tonight, i will revert those three patches and see if
>> i get a working kernel, but again - because i package my kernel [for
>> other users], this is problematic. [ie: i can't update packages until
>> i am sure that linux-rt patchset will boot for everyone okay - right
>> now, i know it won't boot for some and if i revert those 3 patches,
>> while it may boot for me/possibly those who it doesn't boot for - it's
>> likely going to cause issues for other users... it's a bit of a
>> pickle! ;) ].
>>
>> anyway, let me know if there is anything i can do - as is - i will
>> report back if reverting those three patches allows my machine to at
>> least boot.
> Okay. v3.12.5-rt7 is something I released with -RT changes. v3.12.6-rt8
> has zero -RT changes, only stable increment. That means, the -RT patch
> should be exactly the same (except for localversion).
> So whatever breaks booting v3.12.6-rt8 is something that came via
> stable queue.
>
>> Jordan
>>
> Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

