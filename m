From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Announce] 2.6.29.1-rt4
Date: Sun, 5 Apr 2009 15:53:29 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904051552320.747@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>  <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>  <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>  <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>  <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>  <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>  <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
 <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain>  <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain>  <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain>  <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
 <1238799852.3871.6.camel@localhost.localdomain>  <alpine.LFD.2.00.0904040628310.12916@localhost.localdomain> <1238828273.15225.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Will Schmidt <will_schmidt@vnet.ibm.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:47116 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbZDENyY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 5 Apr 2009 09:54:24 -0400
In-Reply-To: <1238828273.15225.17.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 3 Apr 2009, Fernando Lopez-Lezcano wrote:
> > > Just a heads up. I'm still having shutdown/suspend problems with this
> > > release as before (I had not reported the suspend problem, I think -
> > > machine hangs and has to be power cycled). Booting with "noreplace-smp"
> > > fixes both. Is this something I could disable through configuration
> > > options?
> > 
> > No. I have this shutdown/suspend thing on my todo list. 
> 
> Ah, ok. No problem. If it were not for this feature I'd probably release
> a test version for Planet CCRMA. 

Happens this shutdown/suspend problem every time or is this sporadic ?

Thanks,

	tglx
