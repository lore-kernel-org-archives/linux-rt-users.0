From: Alexander Gerasiov <gq@cs.msu.su>
Subject: Re: Problem with hrtimer_cancel() does not cancel timer
Date: Tue, 28 Feb 2017 16:02:08 +0300
Message-ID: <20170228160208.24bb89a8@brick.gerasiov.net>
References: <20170218011522.09d42119@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: zlobin_d@redlab-i.ru
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from off.redlab-i.ru ([195.16.34.157]:54008 "EHLO mail.gerasiov.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbdB1NKb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Feb 2017 08:10:31 -0500
In-Reply-To: <20170218011522.09d42119@brick.gerasiov.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Alexander,

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

So guys, did anybody reproduce this problem?
If no, could you provide more info on your config?
If yes, do anyone work on the problem or we need to deal with it
ourselves?




-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
