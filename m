From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-tests: incorrect first latency value for --verbose
 option
Date: Tue, 8 May 2012 00:03:52 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1205072353210.3886@tycho>
References: <4FA1CB20.5000209@am.sony.com> <alpine.LFD.2.02.1205072322250.3886@tycho> <4FA8428B.4050809@am.sony.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	"Rowand, Frank" <Frank_Rowand@sonyusa.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"williams@redhat.com" <williams@redhat.com>
To: Frank Rowand <frank.rowand@am.sony.com>,
	Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53518 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2EGWEF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 7 May 2012 18:04:05 -0400
Received: by wibhj6 with SMTP id hj6so39085wib.1
        for <linux-rt-users@vger.kernel.org>; Mon, 07 May 2012 15:04:04 -0700 (PDT)
In-Reply-To: <4FA8428B.4050809@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 7 May 2012, Frank Rowand wrote:

> On 05/07/12 14:41, John Kacur wrote:
> > 
> > 
> > On Wed, 2 May 2012, Frank Rowand wrote:
> > 
> >>
> >> When the --verbose option is selected, the first value for each thread is
> >> incorrectly reported as zero.
> >>
> >> This is because when collecting the first value, the index into stat->values is
> >> incremented from zero to one before storing the value.  But when printing the
> >> values, the first value printed is stat->values[0], which has been initialized
> >> to zero.
> > 
> > Hi Frank
> > 
> > Ok, no more posting from me after winning a bottle of whiskey at the Irish 
> > Pub on quiz night. :)
> 
> Or if you do, you should share a bit of the whiskey with me.

You get the bottle and 30 shot glasses and share it with everyone at the 
pub, so if you want some you have to come, and then help my team win too 
:)

 > 
> > 
> > I've been looking at this one, and I'm not sure about it.
> > According to the help output, 
> > 
> > "-v       --verbose         output values on stdout for statistics
> >                            format: n:c:v n=tasknum c=count v=value in us"
> > 
> > ./cyclictest --verbose -p99 -t | awk '$2~/^0/{ print }' 
> > 
> >        0:       0:       0
> >        1:       0:       0
> >        2:       0:       0
> >        3:       0:       0
> >        4:       0:       0
> >        5:       0:       0
> >        6:       0:       0
> >        7:       0:       0
> > 
> > So, it looks like the values are 0 at count 0, doesn't that make sense?
> 
> Nope.  The event for count == 0 is the first event.  And the first event
> has an actual latency that is not zero on the system I tested it on.
> 

Hmmm, this may be a quibble about definitions. I know that in the c-world 
we're used to start counting at 0, but to me, count == 0 is before the 
first event. You're not losing any data here, it's just that the first 
event is stored in the first count. Or am I still missing something here? 

It looks like it was very deliberately programmed this way, unless Thomas 
tells us otherwise.

Thanks

John 
