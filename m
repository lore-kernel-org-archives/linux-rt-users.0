From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: 4.14-rt timer issues using PREEMPT_RT_FULL=y and NO_HZ_FULL_ALL=y
Date: Thu, 14 Dec 2017 17:25:03 +0100
Message-ID: <20171214162503.wjyko5jnisjgaq5e@linutronix.de>
References: <20171212215818.GA18168@a.fritz.box>
 <20171213175339.udcexwcmscotipwc@linutronix.de>
 <20171213191454.GA17027@a.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rt-users@vger.kernel.org
To: bert schulze <spambemyguest@googlemail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37881 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753013AbdLNQZF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Dec 2017 11:25:05 -0500
Content-Disposition: inline
In-Reply-To: <20171213191454.GA17027@a.fritz.box>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-12-13 20:14:54 [+0100], bert schulze wrote:
> Yes as timer migration kicked in on boot causing the interrupt storm.
> Disabling it all together there are no more hangs on boot.

and with the patch I Cced you one we have fix for that but there is
more…

> This is sleep from coreutils, I'm not setting up anything here.
> top, cyclictest whatever using nanosleep is broken.

that sleep should be also affected.

> Tried that as mentioned, no interrupt storm and nothing fails to expire.
> (Add mainline 4.14 upto 4.14.5 to the list of working versions).
…

> Do you need anything else that would be helpful?

bisect with RT is an exercise of its own.
It looks that if you set rcu_normal_after_boot to 0 in
kernel/rcu/update.c then other problem should go away and everything is
"normal" now, right?
Now I need to figure why that is broken…

Sebastian
