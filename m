From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: interrupt priority
Date: Thu, 30 Nov 2017 17:14:17 +0100
Message-ID: <20171130161416.GE11362@linutronix.de>
References: <CAJ2oMhJ-jnjTV3JbBSyV8iewsJD3mqfMjCpM71z22WvJYRnUVA@mail.gmail.com>
 <20171129163521.GB7707@linutronix.de>
 <CAJ2oMhJcuPAjk=RJiYx5SXwdPM++L6XOTOB2obEBA-oxTJn=RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org
To: Ran Shalit <ranshalit@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:45863 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751992AbdK3QOS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Nov 2017 11:14:18 -0500
Content-Disposition: inline
In-Reply-To: <CAJ2oMhJcuPAjk=RJiYx5SXwdPM++L6XOTOB2obEBA-oxTJn=RA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

please don't drop the list.

On 2017-11-29 19:07:58 [+0200], Ran Shalit wrote:
> I mean the priority of interrupts (not threads).
> For example if we connect usb/mouse will it take precedence before the
> timer interrupt ?

That is SoC specific and documented in the reference manual.

> Thanks,
> 
> 
Sebastian
