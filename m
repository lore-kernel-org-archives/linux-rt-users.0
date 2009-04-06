From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [Announce] 2.6.29.1-rt4
Date: Mon, 6 Apr 2009 21:54:13 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.0904062151020.21577@localhost.localdomain>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>  <alpine.LFD.2.00.0902122353050.16972@localhost.localdomain>  <alpine.LFD.2.00.0902231854360.3523@localhost.localdomain>  <alpine.LFD.2.00.0902241849230.3523@localhost.localdomain>
 <alpine.LFD.2.00.0902241856480.9135@localhost.localdomain>  <alpine.LFD.2.00.0903122013230.29264@localhost.localdomain>  <alpine.LFD.2.00.0903200014320.29264@localhost.localdomain>  <alpine.LFD.2.00.0903201832590.29264@localhost.localdomain>
 <alpine.LFD.2.00.0903231723090.29264@localhost.localdomain>  <alpine.LFD.2.00.0903252154040.3397@localhost.localdomain>  <alpine.LFD.2.00.0904020155320.12916@localhost.localdomain>  <alpine.LFD.2.00.0904031918090.12916@localhost.localdomain>
 <1238799852.3871.6.camel@localhost.localdomain>  <alpine.LFD.2.00.0904040628310.12916@localhost.localdomain>  <1238828273.15225.17.camel@localhost.localdomain>  <alpine.LFD.2.00.0904051552320.747@localhost.localdomain>  <1238968196.4995.15.camel@localhost.localdomain>
  <alpine.LFD.2.00.0904060001480.747@localhost.localdomain> <1238973052.4995.29.camel@localhost.localdomain>
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
Received: from www.tglx.de ([62.245.132.106]:54188 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751792AbZDFT4J (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 6 Apr 2009 15:56:09 -0400
In-Reply-To: <1238973052.4995.29.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fernando,

On Sun, 5 Apr 2009, Fernando Lopez-Lezcano wrote:
> > Hmm. Can you upload your full patch queue and the binary rpm so I can
> > give it a test ride ?
> 
> Sure, no problem. I just did a release to planetcore-testing repo (with
> a warning to the planetccrma list), you can find it here:
> 
> http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetcore/testing/10/i386/repoview/index.html
> http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetcore/testing/10/x86_64/repoview/index.html
> 
> (the one I have tested and hangs is the i386 PAE version)
> Source here:
> 
> http://ccrma.stanford.edu/planetccrma/mirror/fedora/linux/planetcore/testing/10/SRPMS/
> 
> (if you don't want to figure out the .src.rpm - I would not blame you -
> I can give you a list of the patches that were actually applied - of the
> ones that are included in the package)

No problem. I know how to distangle those beasts.

Still I have no reproducer yet. One of my 32bit test machines survived
a 200 cycle test w/o showing it.

Is there anything special what you run, load ... ?

Looks like I need to add a 32bit install to my T61 in the hope to
reproduce.

Thanks,

	tglx
