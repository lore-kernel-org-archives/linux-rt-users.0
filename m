From: jordan <triplesquarednine@gmail.com>
Subject: Re: Solving Nvidia (blob) latency spikes + convert (nvidia's)
 semaphores into mutexes patches for 331.20 [patches and links provided]
Date: Thu, 5 Dec 2013 18:43:54 -0500
Message-ID: <CAOcfFMwQ1-QOOFeLqWD8zNuCfQ9gELsqK8Zq69Zb=+EMzVKd4A@mail.gmail.com>
References: <CAOcfFMzTXoSBJm8Rss6XKugc5knfDfdNaYT34bV=N2qcqeKkeg@mail.gmail.com>
	<52A1067D.8070009@pavlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: pavel@pavlinux.ru
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ve0-f178.google.com ([209.85.128.178]:49186 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756030Ab3LEXnz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Dec 2013 18:43:55 -0500
Received: by mail-ve0-f178.google.com with SMTP id c14so14640655vea.37
        for <linux-rt-users@vger.kernel.org>; Thu, 05 Dec 2013 15:43:54 -0800 (PST)
In-Reply-To: <52A1067D.8070009@pavlinux.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 1. Blob after 325.xx.xx does not compile and does not work with our RT patches!

Sure it does.

make IGNORE_PREEMPT_RT_PRESENCE=1
SYSSRC=/usr/lib/modules/"${_kernver}/build" module

I've used every nvidia stable (or beta) driver post-325xx just fine on
-rt. The last remaning issues (for me) is getting nvidia to
remove/replace wbinvd(); and fix up scheduling bugs (with
semaphores)... or I will use mutexes, instead, i guess.

> 2. Nvidia developers specifically inserted function WBINVD to slowly work? :)

well, to find out this answer, i started a thread at nvidia's
developer forums and inquired about this. But i can tell you that the
Intel OSS driver was using wbinvdt() at some point in 3.10 cycle and
it was problematic there too, from what I understand.

> 3. SFENCE need on SMP systems. Although, delay in 1000 nanoseconds - it's awful

Would you care to goto into more detail on this?  - I have seen no
negative impacts on my systems (I've been watching all system
resources and H/w related info, etc), but am curious about this, as
like i said, it is the source of problems in the nvidia blob and if
the Intel OSS driver was able to work around it, i don't see why
Nvidia couldn't do the same.

> 4. Do you really think, that mutex_lock/unlock more realtime than up/down?

Did i say that, Pavel ...What i can tell you is;

1. nvidia's driver on -rt when using semaphores, causing scheduling
bugs (ie: "scheduling while atomic"... that kind of thing),
periodically. It's non-fatal but happens 5-6 times a day on my
machines.  I've yet to see even one scheduling while atomic bug, when
using  mutexes. - so whether or not semaphores are more realtime, is
sort of a moot point for me - i use linux-rt for Proaudio - ie: GFX is
NOT as important, but what is important is that the (nvidia) driver
works properly (safely).

2. With Semaphores i seem to get more variance/jitter in my cyclictest
results or slightly higher latency spikes, then when i am using
mutexes. (and i feel a little safer without seeing a bunch of
scheduling while atomic bugs).

Jordan
