Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from Galois.linutronix.de ([146.0.238.70]:39119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933554AbeCHP5o (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Mar 2018 10:57:44 -0500
Date: Thu, 8 Mar 2018 16:57:42 +0100
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: Re: inconsistent lock state on v4.14.20-rt17
Message-ID: <20180308155741.vbdqprs6stx5zu4q@linutronix.de>
References: <1520350053.1744.6.camel@ginzinger.com>
 <20180306182154.nkia5hl4r3r2ncru@linutronix.de>
 <1520411200.1744.11.camel@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1520411200.1744.11.camel@ginzinger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Roosen Henri <Henri.Roosen@ginzinger.com>
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>

On 2018-03-07 08:26:40 [+0000], Roosen Henri wrote:
> > The backtrace suggests that the rq lock is taken with interrupts
> > disabled and then with interrupts enabled. But based on the call-
> > trace
> > it should be with interrupts disabled in both cases.
> > I do have a imx6q running hackbench on a regular basis and I haven't
> > seen this. Do you see this backtrace on every hackbench invocation or
> > just after some time. The uptime suggest after ~5 hours.
> 
> The crashes are not seen at every invocation of hackbench, but
> unfortunately after a few hours to after a few weeks. The test is based
> on a "dohell.sh" script from the Xenomai project.

I kicked a hackbench on a imx6 with your config.
Is the backtrace, that you receive from lockdep, always the same or is
it different sometimes?

Sebastian
