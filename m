From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: [PATCH] net: detect recursive dev_queue_xmit() on RT properly
Date: Tue, 29 Nov 2016 19:35:14 -0500
Message-ID: <CAGt3f4nCZRtdDFeC8bjf+xJn9mX=CFLAPAUmgmbYHy_L8Xui+Q@mail.gmail.com>
References: <1476325561-16755-1-git-send-email-brian@peloton-tech.com> <20161028144412.7mk22zboiwupfsi4@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>,
        mark.beauchemin@sycamorenet.com, mbeauch@cox.net, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33512 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754590AbcK3Afp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Nov 2016 19:35:45 -0500
Received: by mail-qk0-f169.google.com with SMTP id x190so193745499qkb.0
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Nov 2016 16:35:45 -0800 (PST)
In-Reply-To: <20161028144412.7mk22zboiwupfsi4@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is already fixed by 0f27b2b421a4 ("net: move xmit_recursion to
per-task variable on -RT"), which is in the various stable-rts too.
Apologies for the noise.

>> This also includes "543a589a00e8 net: xmit lock owner cleanup" from
>> v2.6.33.9-rt31 by mingo and tglx, which was just some cleanups to the
>> original patch which make porting to to current upstream easier.
>>
>> Signed-off-by: Mark Beauchemin <mark.beauchemin@sycamorenet.com>
>> [ ported to latest upstream ]
>> Signed-off-by: Ingo Molnar <mingo@elte.hu>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> [ ported to 4.8 and used struct task_struct instead of void ]
>> Signed-off-by: Brian Silverman <brian@peloton-tech.com>
>
> The signed-off-by chain suggest that Mark passed the patch to Ingo,
> Thomas and to Brian. I doubt that. I can't resolve the sha1 id mentioned
> here.

It's from the rt-history repository. The original commit in the
rt-history repository has that Signed-off-by chain except I added me
at the bottom. I guess it would make more sense to remove the other
people who just cherry-picked it if I run into this again.

> Is this still broken as of v4.8-RT? I remember fixing something similar
> with bridge devices.

Indeed you did it. It was cherry-picked to v4.1.19-rt22 too, which
matches the 4.1 kernel I originally found this on. I thought I checked
for the problem one or both of those, but apparently not... My bad.
