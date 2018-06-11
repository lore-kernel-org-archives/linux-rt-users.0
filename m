Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:55043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750965AbeFKPzy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Jun 2018 11:55:54 -0400
Message-ID: <1528732547.5463.4.camel@gmx.de>
Subject: Re: [missing 4.16-rt5 patch ?]  mm/memcontrol: Don't call
 schedule_work_on in preemption disabled context
From: Mike Galbraith <efault@gmx.de>
Date: Mon, 11 Jun 2018 17:55:47 +0200
In-Reply-To: <20180611152940.ul5xunrepa5ine4s@linutronix.de>
References: <20180529164210.4os2rn5femjpku6a@linutronix.de>
         <1528606772.13494.14.camel@gmx.de>
         <20180611152940.ul5xunrepa5ine4s@linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-users <linux-rt-users@vger.kernel.org>

On Mon, 2018-06-11 at 17:29 +0200, Sebastian Andrzej Siewior wrote:
> So that css_put() is not a problem? I'm mostly curious in the callback
> which would run irq-off section. How does not get into that code path
> anyway, is there something in the LTP that would trigger that?

No idea.  The only thing I've _met_ is the schedule_work_on() bit.

	-Mike
