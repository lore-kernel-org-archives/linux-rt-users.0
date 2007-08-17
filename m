From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Fri, 17 Aug 2007 10:39:27 +0200
Message-ID: <1187339967.7007.71.camel@chaos>
References: <20070817003751.GN3954@unix.sh>
	 <1187323117.23789.55.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:55476 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756525AbXHQIja (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Aug 2007 04:39:30 -0400
In-Reply-To: <1187323117.23789.55.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 2007-08-16 at 20:58 -0700, Daniel Walker wrote:
> On Thu, 2007-08-16 at 21:37 -0300, Luis Claudio R. Goncalves wrote:
> > Fixes spurious system load spikes observed in /proc/loadavgrt, as described in:
> > 
> >   Bug 253103: /proc/loadavgrt issues weird results
> >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=253103
>
> It would be nice if you explained better what the code defect was, and
> how you fixed it .. One could extract that from the code, but it's nice
> if it's backed up with a text description.. Also you should CC lkml next
> time.

It would be nice if you'd stop being uber schoolmasterly. Luis
explanation of the defect is entirely clear and the resulting fix is
obvious. .. You could really look at the patch and figure out your self,
that it needs no text description at all. Also you should comment on the
nice patch itself next time.

	tglx
