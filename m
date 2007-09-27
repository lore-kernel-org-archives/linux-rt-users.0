From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Thu, 27 Sep 2007 11:59:56 +1000
Message-ID: <1190858397.11034.22.camel@pasglop>
References: <1190345162.620000.305760830507.qpush@thor>
	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	 <46FAB56E.8080509@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Mackerras <paulus@samba.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:47880 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbXI0CAu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 26 Sep 2007 22:00:50 -0400
In-Reply-To: <46FAB56E.8080509@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Wed, 2007-09-26 at 23:39 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Steven Rostedt wrote:
> > Tony,
> 
> > I'm about to release a new -rt patch based on -rc8. This patch series
> > blew up totally in trying to get it applied. I'm leaving it out, so after
> > I release the next series, could you update these patches.
> 
>     No wonder here: the -rt patch already has much of this code since around 
> 2.6.21.  They have been submitted by me, mostly... and this patchset is 
> against the Linus' tree.

Proper approach is to rip off what is altready in -rt there and replace
it with Tony patch set.

Ben.
