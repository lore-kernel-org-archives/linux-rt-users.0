From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] RFC: Set irq thread to RT priority on creation
Date: Thu, 30 May 2013 10:54:41 -0400
Message-ID: <1369925681.26799.6.camel@gandalf.local.home>
References: <1369915975-28797-1-git-send-email-meltedpianoman@gmail.com>
	 <alpine.LFD.2.02.1305301602490.2905@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ivo Sieben <meltedpianoman@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:29741 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757463Ab3E3Oyn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 30 May 2013 10:54:43 -0400
In-Reply-To: <alpine.LFD.2.02.1305301602490.2905@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2013-05-30 at 16:07 +0200, Thomas Gleixner wrote:

> > This patch solves an issue for me where a device driver is expected to handle an
> > interrupt immediatly after irq handlers are installed and interrupts enabled.
> 
> You miss to explain what kind of issue that is.

I could envision the case where the interrupt is initialized but doesn't
go off until much later. If it never ran, then it would still be in
SCHED_OTHER(), and that first interrupt could have a large delay.

-- Steve


