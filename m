From: Dmitry <zlobin_d@redlab-i.ru>
Subject: Re: Problem with hrtimer_cancel() does not cancel timer
Date: Tue, 21 Feb 2017 17:15:08 +0300
Message-ID: <20170221171508.6fe14572@app.int.redlab-i.ru>
References: <20170218011522.09d42119@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Alexander Gerasiov <gq@cs.msu.su>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx.redlab-i.ru ([195.16.34.155]:59280 "EHLO mail.redlab-i.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752574AbdBUOPR (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2017 09:15:17 -0500
In-Reply-To: <20170218011522.09d42119@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On v4.9.11-rt9 with PREEMPT FULL this test also fails.

On Sat, 18 Feb 2017 01:15:22 +0300
Alexander Gerasiov <gq@cs.msu.su> wrote:

> Hello folks,
> 
> I met some problem with preempt version of kernel 4.4.
> 
> I have hrtimer which runs callback, it forwards time and returns
> HRTIMER_RESTART. Very common scheme. When I stop the routine I call
> hrtimer_cancel(). It should wait for callback completion if any and
> unqueue any future timers.
> 
> But suddenly I noticed, that sometimes hrtimer's routine continue to
> work and work after hrtimer_cancel(). It could be reproduced with
> simple test:
> 
> Start hrtimer.
> In callback increase counter and restart.
> In the other thread cancel timer, save counter, sleep, check that
> counter is not changed, restart timer, repeat.
> Here is sample module:
> https://gist.github.com/gerasiov/010e6c2cb96fd891c1802facf816fe84
> 
> It works OK on v3.10.74-rt79 with PREEMPL FULL.
> It works OK on v4.4.47-rt59 with preempt patch but PREEMPT NONE.
> But on 4.4 (tested on v4.4.47-rt59 and v4.4.32-rt43) with PREEMPT FULL
> it fails: counter continue to increase (BUG_ON() line 45 hits), that
> means that hrtimer continue to work after cancel(). And I must say,
> that this is not single iteration, it continues to work in cycle.
> 
> It was reproduced on i386 SMP box.
> kernel config:
> https://github.com/redlab-i/linux/blob/v4.4.47-rt59-stand2/.config
> 
> Do anyone have any ideas where could be the problem? Or may be I
> missed something in my research?
> 

-- 
Best regards,
 Dmitry Zlobin
