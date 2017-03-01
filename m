From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: Problem with hrtimer_cancel() does not cancel timer
Date: Thu, 2 Mar 2017 02:48:08 +0300
Message-ID: <20170302024808.7f5f29d9@brick.gerasiov.net>
References: <20170218011522.09d42119@brick.gerasiov.net>
        <20170301150103.4ttnvz72d4jsgui6@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, zlobin_d@redlab-i.ru
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from off.redlab-i.ru ([195.16.34.157]:58078 "EHLO mail.gerasiov.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753424AbdCBAFt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Mar 2017 19:05:49 -0500
In-Reply-To: <20170301150103.4ttnvz72d4jsgui6@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Sebastian,

On Wed, 1 Mar 2017 16:01:04 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2017-02-18 01:15:22 [+0300], Alexander Gerasiov wrote:
> > Hello folks,  
> Hi,
> 
> > I met some problem with preempt version of kernel 4.4.
> > 
> > I have hrtimer which runs callback, it forwards time and returns
> > HRTIMER_RESTART. Very common scheme. When I stop the routine I call
> > hrtimer_cancel(). It should wait for callback completion if any and
> > unqueue any future timers.  
> 
> Could you please check if the hunk here fixes the problem you see?

Great! Looks like the problem is solved.

When submitting patch to git, take a note, that not only 4.4 is
affected. I'm quite sure, that 4.1 was affected too when I tested it and
Dmitry comfirmed 4.9 is also broken.

-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
