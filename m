From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question regarding RT patches for ARM
Date: Thu, 18 May 2017 22:10:33 +0200
Message-ID: <20170518201033.ygdgdhdslbqypcoj@linutronix.de>
References: <CAGgoGu6=EKCkzbZ0=i+4e+9rJUvxG-SUix1AQVch8VF=OmokVw@mail.gmail.com>
 <3aa42082.b247.15c0c29ca5e.Coremail.qiledexin@163.com>
 <CAGgoGu72RebHt5yf-2WE6Dt3jUNqMph2Uwu+VRK2akRYXo8aow@mail.gmail.com>
 <646e1a43-78a7-3d04-ee29-1299b7d9d4d8@nelint.com>
 <CAGgoGu7z1KUve8G_Ld_Yk-1umDq1qO=HCw2vjMuU=YXqxzt0tA@mail.gmail.com>
 <CAGgoGu4LHrZJHzwBFgpEYCzBRtH24N_Y1UUspkoZJKPPdQmuvQ@mail.gmail.com>
 <c0fc9f9b-ae0b-66d3-71c7-e2b98f6900e0@nelint.com>
 <20170517160213.go3fiyhf5vmr7bmj@linutronix.de>
 <CAGgoGu7qJegvp8o_33rfVbSWHNH8N4bbiTORXJYziRvKB9=O3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Nelson <eric@nelint.com>, GuJiangfei <qiledexin@163.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-rt-users@vger.kernel.org
To: Fawad Lateef <fawadlateef@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52927 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751155AbdERUKn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 May 2017 16:10:43 -0400
Content-Disposition: inline
In-Reply-To: <CAGgoGu7qJegvp8o_33rfVbSWHNH8N4bbiTORXJYziRvKB9=O3w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-05-18 13:08:32 [+0200], Fawad Lateef wrote:
> Hi Sebastian,
Hi Fawad,

> > Of this "page fault" happens on boot, it has to do something without
> > your .config + hw combination. If it happens at rune-time it is probably
> > triggered by a driver or an application is triggering this.
> >
> 
> Yes, this happens at run-time and not always. Sometimes hardware just
> hangs/stalls.

So this sounds like a race condition.

> As now RT is widely used on ARM so to me seems like it something
> related to hardware design/setting OR application.
> 
> Another question: Is RT user-space application can make kernel/system
> crash? As to me kernel should kill the app but let itself running
> _but_ not sure in the case of RT patched kernel.

This is correct. With RT or without it: a use space should not be able
to crash the kernel.
It is possible that a race within a driver triggers more reliably on RT.
I would recommend to strip down the system to the minimum where the
issue should not trigger. And then slowly increase the "enabled"
hardware components so you might get an idea when or what could cause
it.

> Thanks,
> 
> Fawad Lateef

Sebastian
