From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: 2.6.24.7-rt16
Date: Mon, 28 Jul 2008 11:48:36 +0200
Message-ID: <1217238516.6331.10.camel@twins>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>
	 <alpine.LFD.1.10.0807271719130.574@apollo.tec.linutronix.de>
	 <488D7F5D.8090400@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	Carsten Emde <ce@ceag.ch>, Luotao Fu <l.fu@pengutronix.de>
To: Wolfgang Grandegger <wg@grandegger.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:44998 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbYG1Jsl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 28 Jul 2008 05:48:41 -0400
In-Reply-To: <488D7F5D.8090400@grandegger.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2008-07-28 at 10:12 +0200, Wolfgang Grandegger wrote:

> Thomas Gleixner wrote:

> >      - powerpc ftrace backport (tglx)
> 
> Backport? It's not yet available for 2.6.25.

But it seems to be upstream ;-)

root@twins:/mnt/build/linux-2.6# find arch/powerpc/ | grep ftrace
arch/powerpc/kernel/ftrace.c


