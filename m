From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH] Fixes spurious system load spikes in /proc/loadavgrt
Date: Fri, 17 Aug 2007 09:24:05 -0700
Message-ID: <1187367845.23789.62.camel@imap.mvista.com>
References: <20070817003751.GN3954@unix.sh>
	 <1187323117.23789.55.camel@imap.mvista.com>
	 <1187339967.7007.71.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:65384 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752705AbXHQQZi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 17 Aug 2007 12:25:38 -0400
In-Reply-To: <1187339967.7007.71.camel@chaos>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-08-17 at 10:39 +0200, Thomas Gleixner wrote:
> On Thu, 2007-08-16 at 20:58 -0700, Daniel Walker wrote:
> > On Thu, 2007-08-16 at 21:37 -0300, Luis Claudio R. Goncalves wrote:
> > > Fixes spurious system load spikes observed in /proc/loadavgrt, as described in:
> > > 
> > >   Bug 253103: /proc/loadavgrt issues weird results
> > >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=253103
> >
> > It would be nice if you explained better what the code defect was, and
> > how you fixed it .. One could extract that from the code, but it's nice
> > if it's backed up with a text description.. Also you should CC lkml next
> > time.
> 
> It would be nice if you'd stop being uber schoolmasterly. Luis
> explanation of the defect is entirely clear and the resulting fix is
> obvious. .. You could really look at the patch and figure out your self,
> that it needs no text description at all. Also you should comment on the
> nice patch itself next time.

If all you've said was true I wouldn't have commented on it. There was
no text description of the code defect, and yes as I said I can get it
from the code but it's _nice_ when it's backed up with a text
description ..

If your just going to start flames Thomas take it off list.

Daniel
