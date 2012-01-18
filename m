From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/4] [ANNOUNCE] 3.0.14-rt32-rc1
Date: Wed, 18 Jan 2012 10:41:54 -0500
Message-ID: <1326901314.17534.81.camel@gandalf.stny.rr.com>
References: <20120118034531.335521323@goodmis.org>
	 <201201181450.17680.tim.sander@hbm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>
To: Tim Sander <tim.sander@hbm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.123]:54656 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755445Ab2ARPl4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Jan 2012 10:41:56 -0500
In-Reply-To: <201201181450.17680.tim.sander@hbm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-01-18 at 14:50 +0100, Tim Sander wrote:
> Hi Steve
> > This is the RT stable review cycle of patch 3.0.14-rt32-rc1.
> > 
> > Please scream at me if I messed something up. Please test the patches too.
> Well the error i described in other mails to this list are still persistent:
> * ksoftirq running wild due to fec ethernet tx interrupt.
> 

I would be surprised if it went away, as none of these patches would
have touched that code.

> Does patch nr 2 possibly fix the error reboot fails with "Unable to execute 
> shutdown: Bad address". The error occurs not to often so it is hard to say if 
> this 3.0.14-rt32 is still showing this error.

Honestly I don't know about that error. But wait queues have been a
thorn in -rt for a while, and this patch fixes a few areas I'm sure.
That being one of them, I guess you'll find out if you see the bug
again ;-)

-- Steve


