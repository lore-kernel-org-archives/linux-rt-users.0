From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [patch-rt v2] rtmutex: Fix lock stealing logic
Date: Mon, 26 Jun 2017 15:47:44 +0200
Message-ID: <20170626134743.67ym3cxwwl7jj2ia@linutronix.de>
References: <20170616105610.rbc6itylcrsla56l@linutronix.de>
 <1497805317.6229.3.camel@gmx.de>
 <1498203434.3988.5.camel@gmx.de>
 <1498212458.5248.0.camel@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:40751 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdFZNrr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 09:47:47 -0400
Content-Disposition: inline
In-Reply-To: <1498212458.5248.0.camel@gmx.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-06-23 12:07:38 [+0200], Mike Galbraith wrote:
> On Fri, 2017-06-23 at 09:37 +0200, Mike Galbraith wrote:
> > V2 changes:
> >   - beautification (ymmv)
> >   - enable lock stealing when waiter is queued

Applied.

> (V3 s/steal/claim)

Sebastian
