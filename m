From: Gregory Haskins <ghaskins@novell.com>
Subject: Re: How to talk to DAQ Hardware?
Date: Sun, 26 Aug 2007 01:24:04 -0400
Message-ID: <1188105844.11884.65.camel@ghaskins-t60p.haskins.net>
References: <42568.15578.qm@web36109.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org
To: Calin Culianu <cculianu@yahoo.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:35480 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbXHZFZ5 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Aug 2007 01:25:57 -0400
In-Reply-To: <42568.15578.qm@web36109.mail.mud.yahoo.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 2007-08-25 at 19:08 -0700, Calin Culianu wrote:
> --- Daniel Walker <dwalker@mvista.com> wrote:
> 
> > > process?
> > 
> > ISR's are kernel threads, and you can change the priority of them .. If
> > you look 'ps' or 'top' you'll notice some processes that looks like,
> 
> Wow, thanks for the thorough answer.  So basically interrupts come in from
> hardware, are dispatched by waking up a thread.. and then the thread decides to
> call a device driver's ISR or not?

Close.  There is one thread per IRQ, so each interrupt vector wakes a
specific thread which executes the registered handler unconditionally
once scheduled to run.  By default, all IRQ threads run at priority
RT50, but you can tweak this via tools like chrt like Daniel mentioned.


>   So if another lower priority interupt calls
> in, the thread is woken up but processing resumes again in the
> previously-running higher priority thread?  I guess I should just read the
> sources..

That's exactly right, but note that sometimes the opposite is not true
if you are not careful.  The interrupt controller itself often supports
its own concept of priority, and disparity between the hardware/software
priority can cause inadvertent masking.  In this scenario, the hardware
fails to dispatch what it perceives as the lower-priority vector until
the perceived higher one completes its EOI.  What it perceives as higher
and lower may differ from your RT priorities.

If you find yourself configuring your vectors to a RT priority
relationship that differs from their hardware relationship, you have a
few choices.  

1) Change the hardware relationship (if you are on a platform that
allows programmable priority in the interrupt-controller: e.g. some
powerpcs).

OR

2) Make sure the vectors in question are using fasteoi which (IIUC)
effectively moves the priority back into the control of the scheduler by
EOI'ing the vector immediately.

HTH

Regards,
-Greg
