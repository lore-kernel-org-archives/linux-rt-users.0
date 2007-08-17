From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Fri, 17 Aug 2007 23:37:12 +0200
Message-ID: <1187386632.7007.100.camel@chaos>
References: <20070817003751.GN3954@unix.sh>
	 <1187323117.23789.55.camel@imap.mvista.com>
	 <1187339967.7007.71.camel@chaos>
	 <1187367845.23789.62.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
To: Daniel Walker <dwalker@mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.osadl.org ([213.239.205.134]:40449 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752742AbXHQVhW (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Aug 2007 17:37:22 -0400
In-Reply-To: <1187367845.23789.62.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-17 at 09:24 -0700, Daniel Walker wrote:
> > > It would be nice if you explained better what the code defect was, and
> > > how you fixed it .. One could extract that from the code, but it's nice
> > > if it's backed up with a text description.. Also you should CC lkml next
> > > time.
> > 
> > It would be nice if you'd stop being uber schoolmasterly. Luis
> > explanation of the defect is entirely clear and the resulting fix is
> > obvious. .. You could really look at the patch and figure out your self,
> > that it needs no text description at all. Also you should comment on the
> > nice patch itself next time.
> 
> If all you've said was true I wouldn't have commented on it. There was
> no text description of the code defect, and yes as I said I can get it
> from the code but it's _nice_ when it's backed up with a text
> description ..

You really start to annoy me. There was a detailed bug description and
the code defect is easy to see. If you neither have the interest nor the
time to look at the actual _trivial_ _self explaining_ patch, then
please look for some other playground to live out your wisenheimer airs
and graces.

> If your just going to start flames Thomas take it off list.

Flames are only flames when they happen in public.

	tglx
