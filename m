From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Can jitter also be smaller than amount of time or only bigger ?
Date: Wed, 29 Nov 2017 17:33:26 +0100
Message-ID: <20171129163326.GA7707@linutronix.de>
References: <CAJ2oMhLh0V0k1Awf5OM-FKmMB7Ex9=D+CtVxZv+cr0MgNR5n9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40446 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbdK2Qd2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Nov 2017 11:33:28 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhLh0V0k1Awf5OM-FKmMB7Ex9=D+CtVxZv+cr0MgNR5n9Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-11-27 18:25:23 [+0200], Ran Shalit wrote:
> Hello,
Hi,

> When using rt linux, does it mean that the jitter is in both direction
> or only bigger than amount of time for wait ?
> For example, if we set periodic timer for 1msec, can it also be that
> we get the interrupt before the 1msec period ended ?

With or without RT: the timer must not fire too early. I can fire
_after_ the 1ms deadline but never before that.

> Thank you.
> Ran

Sebastian
