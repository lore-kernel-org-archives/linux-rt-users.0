From: Marin Mitov <mitov@issp.bas.bg>
Subject: Re: [PATCH -v4] x86: enable preemption in delay
Date: Mon, 26 May 2008 08:14:15 +0300
Message-ID: <200805260814.15870.mitov@issp.bas.bg>
References: <200805252108.25011.mitov@issp.bas.bg> <alpine.LFD.1.10.0805260006110.3295@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>, akpm@osdl.org,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <clark.williams@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andi Kleen <andi-suse@firstfloor.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753228AbYEZFQ4@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0805260006110.3295@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

On Monday 26 May 2008 01:21:04 am Thomas Gleixner wrote:
> On Sun, 25 May 2008, Marin Mitov wrote:
> > Hi Steven,
> 
> Please do not trim CC lists without a good reason. [Restored it]
> 
> > look at this patch, proposed by me and Ingo few month ago.
> > I think it solves the problem you had fond, but unfortunately
> > it had been lost (not included in the mainline).
> 
> Yep, and it might be simply because the mail thread ended with:
> 
> http://lkml.org/lkml/2007/11/20/426

Could be. I remember to have answered to Ingo and he gave me
a long lecture (thank him for it, I am a newbee) how to use quilt 
(because I had updated the patch by hand). In any case, the final 
version is: 

http://lkml.org/lkml/2007/11/20/343

It applies to 2.6.25.4 with the following warnings:

patching file arch/x86/lib/delay_32.c
Hunk #1 succeeded at 40 (offset 2 lines).
patching file arch/x86/lib/delay_64.c
Hunk #1 succeeded at 28 (offset 2 lines).

If you find the patch usefull I will rebase it to 2.6.26-rc3.
> 
> > hi Marin,
> >
> > here's the patch we are carrying in x86.git at the moment - could you 
> > please update it with v3 of your code, and send us the patch (with the 
> > patch metadata kept intact, like you see it below)? Thanks,
> >
> >      Ingo
> 
> And there was no response. I just checked my x86 quilt archives and it
> simply went into the "wait for update" category and got dropped
> unfortunately.

Here is an extract of the Ingo's mail sent to me at that time: 

From: Ingo Molnar <mingo@elte.hu>
To: Marin Mitov <mitov@issp.bas.bg>
 CC: akpm@linux-foundation.org, tglx@linutronix.de
<snip>  
* Marin Mitov <mitov@issp.bas.bg> wrote:

> > > The difference is explained in the reference above. Ingo asked me 
> > > to send the last changes:
> > >
> > > http://lkml.org/lkml/2007/11/20/426
> > >
> > > and I have sent them to him.
> >
> > yep, and we've got that queued in the x86 tree.
> 
> According to the attachment to the e-mail I have got from Andrew, the 
> patch "added to -mm tree" is not the patch (v.3):
> 
> http://lkml.org/lkml/2007/11/20/343
> 
> but the patch (v.2) that has the flaw of a possible infinite 
> loop:
> 
> http://lkml.org/lkml/2007/11/18/5
> 
> If that is the intention, OK.

the patch that got queued up in the x86 tree 3 days ago is the one below 
- your latest.

        Ingo
<snip>

As far as the patch (in the Ingo's mail) was really the latest, 
I decided all is OK. But it did not appeared in 2.6.24. 

That is the story as I know of it ;-)

Best regards.

Marin Mitov
