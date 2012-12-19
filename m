From: John Kacur <jkacur@redhat.com>
Subject: Re: Real-time kernel thread performance and optimization
Date: Wed, 19 Dec 2012 15:59:27 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1212191559180.4850@tycho>
References: <6b5093025753dbc76e1d23af7c999826@mail.gmail.com> <50B933A5.3020400@am.sony.com> <50BCB40E.9050304@osadl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: frank.rowand@am.sony.com, Simon Falsig <simon@newtec.dk>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:49633 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab2LSPEn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 10:04:43 -0500
Received: by mail-we0-f176.google.com with SMTP id r5so999400wey.7
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Dec 2012 07:04:41 -0800 (PST)
In-Reply-To: <50BCB40E.9050304@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 3 Dec 2012, Carsten Emde wrote:

> On 11/30/2012 11:31 PM, Frank Rowand wrote:
> > On 11/30/12 07:46, Simon Falsig wrote:
> > > [..]
> > > Bonus-question:
> > >   - Additionally, I've tried running cyclictest alongside with all the
> > > above, and it actually performs rather well, without any substantial
> > > spikes. A strange thing is though, that the results are actually better
> > > with load than without? (running with -t1 -p 80 -n -i 10000 -l 10000)
> > >   - Loaded: Min: 16, Avg: 41, Max: 177
> > >   - No load: Min: 16, Avg: 97, Max: 263
> > 
> > If the system is less loaded, then the idle thread might be able to
> > enter deeper levels of sleep.  Deeper levels of sleep have larger
> > latencies to exit.  You would have to look at your processor specific
> > values for exiting sleep states to see if this is sufficient to explain
> > the difference.
> If running a half-decent version of cyclictest, sleep states are generally
> disabled while cyclictest is running. Please watch the line
>   # /dev/cpu_dma_latency set to 0us
> which essentially documents this mechanism. Yes, the name of the variable
> "cpu_dma_latency" is not obvious and cyclictest could do a better job by
> writing
>   Wrote 0 to /dev/cpu_dma_latency and keeping the path open to prevent
>   all cores from entering any sleep state
> but this is another story.

Not sure what you mean here, doesn't it keep the path open?

John> 
