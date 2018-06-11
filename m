Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:37557 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753933AbeFKP3l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jun 2018 11:29:41 -0400
Date: Mon, 11 Jun 2018 17:29:40 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [missing 4.16-rt5 patch ?]  mm/memcontrol: Don't call
 schedule_work_on in preemption disabled context
Message-ID: <20180611152940.ul5xunrepa5ine4s@linutronix.de>
References: <20180529164210.4os2rn5femjpku6a@linutronix.de>
 <1528606772.13494.14.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528606772.13494.14.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>

On 2018-06-10 06:59:32 [+0200], Mike Galbraith wrote:
> Was dropping this patch unintentional?
> 
> (met the gripe in my tip-rt5 tree, so resurrected it)

Not sure. I remember the local_irq_save() block was dealing with
counters only and it was safe to drop it.
The schedule_work_on() part is obvious (not to mention the possible
latency part).

So that css_put() is not a problem? I'm mostly curious in the callback
which would run irq-off section. How does not get into that code path
anyway, is there something in the LTP that would trigger that?

Sebastian
