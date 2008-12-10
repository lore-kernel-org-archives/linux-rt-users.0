From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH][RT] Compile-time fix.
Date: Wed, 10 Dec 2008 12:47:35 -0500 (EST)
Message-ID: <alpine.DEB.1.10.0812101247220.11248@gandalf.stny.rr.com>
References: <alpine.DEB.1.10.0812090946210.16798@gandalf.stny.rr.com>  <1228890920.9542.2.camel@dd> <1228892002.9542.4.camel@dd> <alpine.DEB.1.10.0812100643130.5912@gandalf.stny.rr.com> <493FED0D.4080204@novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sven-Thorsten Dietrich <sven@thebigcorporation.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Clark Williams <clark.williams@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Darren Hart <dvhltc@us.ibm.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:42839 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320AbYLJRrj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Dec 2008 12:47:39 -0500
In-Reply-To: <493FED0D.4080204@novell.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


On Wed, 10 Dec 2008, Gregory Haskins wrote:

> Steven Rostedt wrote:
> >
> > If you do want to help, look at any of the other branches. Some have not 
> > been updated yet, and they all should be able to compile and boot on their 
> > own. If they do not, then those need to be fixed.
> >   
> 
> A good place to start for some low-hanging fruit would be rt/workqueue. 
> I ported the patches, but it doesn't yet boot (assuming Steve merged the
> work I had done...I havent looked recently).  I think its a relatively
> trivial problem, but I have not had a chance to track it down yet.

I have not pulled it yet, I'll do it now.

-- Steve

