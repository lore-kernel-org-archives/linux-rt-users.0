From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Problem with hrtimer_cancel() does not cancel timer
Date: Sat, 18 Feb 2017 01:15:22 +0300
Message-ID: <20170218011522.09d42119@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: zlobin_d@redlab-i.ru
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from off.redlab-i.ru ([195.16.34.157]:46592 "EHLO mail.gerasiov.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935000AbdBQWWH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 17 Feb 2017 17:22:07 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello folks,

I met some problem with preempt version of kernel 4.4.

I have hrtimer which runs callback, it forwards time and returns
HRTIMER_RESTART. Very common scheme. When I stop the routine I call
hrtimer_cancel(). It should wait for callback completion if any and
unqueue any future timers.

But suddenly I noticed, that sometimes hrtimer's routine continue to
work and work after hrtimer_cancel(). It could be reproduced with simple
test:

Start hrtimer.
In callback increase counter and restart.
In the other thread cancel timer, save counter, sleep, check that
counter is not changed, restart timer, repeat.
Here is sample module:
https://gist.github.com/gerasiov/010e6c2cb96fd891c1802facf816fe84

It works OK on v3.10.74-rt79 with PREEMPL FULL.
It works OK on v4.4.47-rt59 with preempt patch but PREEMPT NONE.
But on 4.4 (tested on v4.4.47-rt59 and v4.4.32-rt43) with PREEMPT FULL
it fails: counter continue to increase (BUG_ON() line 45 hits), that
means that hrtimer continue to work after cancel(). And I must say,
that this is not single iteration, it continues to work in cycle.

It was reproduced on i386 SMP box.
kernel config:
https://github.com/redlab-i/linux/blob/v4.4.47-rt59-stand2/.config

Do anyone have any ideas where could be the problem? Or may be I missed
something in my research?

-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
