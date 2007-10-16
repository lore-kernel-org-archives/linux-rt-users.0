From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 1/4] Implement {read,update}_persistent_clock.
Date: Tue, 16 Oct 2007 11:19:03 +1000
Message-ID: <1192497543.19073.0.camel@pasglop>
References: <1190345162.620000.305760830507.qpush@thor>
	 <Pine.LNX.4.58.0709261502590.4465@gandalf.stny.rr.com>
	 <46FAB56E.8080509@ru.mvista.com>
	 <Pine.LNX.4.58.0709261543080.5123@gandalf.stny.rr.com>
	 <1190836713.23376.41.camel@chaos>  <4713ABDA.2000506@ru.mvista.com>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:43346 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbXJPBTd (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 21:19:33 -0400
In-Reply-To: <4713ABDA.2000506@ru.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


>    Eh... poor you. Tony got clockevent driver reengineered for no apparent 
> reason.  And he's introduced the jiffy drift by deleting the main loop from 
> timer_interrupt(). Yet this borken version was preferred to what was known 
> working since about 2.6.18 and included into 2.6.21-rt patchset.  I don't like 
> that policy. Will you be pushing fixes from -rt to PowerPC, or will it fall on 
> my shoulders now?

Possibly because whatever implementation existed before was never
provided in a mergeable form and pushed to -rt bypassing the powerpc
architecture maintainer ?

Ben.
