From: jordan <triplesquarednine@gmail.com>
Subject: Re: Solving Nvidia (blob) latency spikes + convert (nvidia's)
 semaphores into mutexes patches for 331.20 [patches and links provided]
Date: Thu, 5 Dec 2013 20:16:17 -0500
Message-ID: <CAOcfFMwkBaqAFYKnt15JQgVn10F00UQrPa2HQi42P8=kawk3ug@mail.gmail.com>
References: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
	<52A1067D.8070009@pavlinux.ru>
	<CAOcfFMwQ1-QOOFeLqWD8zNuCfQ9gELsqK8Zq69Zb=+EMzVKd4A@mail.gmail.com>
	<52A121F8.7010607@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181]:33631 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750970Ab3LFBQS (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 20:16:18 -0500
Received: by mail-vc0-f181.google.com with SMTP id ks9so29962vcb.40
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Dec 2013 17:16:18 -0800 (PST)
In-Reply-To: <52A121F8.7010607@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Pavel

> Wow, I did not know, thanks. I until on 319.xx

I had wondered. lol. ~ because telling someone who is using nvidia-rt
>325xx that it doesn't work on rt is a bit odd. ;)  ... I thought you
must have been mistaken :)

take a look in kernel/conftest.sh (of nvidia installer/sources) - You
were mistaken because nvidia has changed some of the internals around
/ how their installer works. It actually appears they are making it
more RT friendly... Which is great because i (personally) have been
bugging them every couple of months about PREEMPT_RT_FULL :)

>>> 3. SFENCE need on SMP systems. Although, delay in 1000 nanoseconds - it's awful
>> Would you care to goto into more detail on this?
>
> https://www.kernel.org/doc/Documentation/memory-barriers.txt

Thanks, i'll have a read through + wait for some feedback from nvidia
in my thread.

jordan
