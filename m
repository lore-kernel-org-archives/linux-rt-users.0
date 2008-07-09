From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: add mlockall option to cyclictest, et al
Date: Wed, 9 Jul 2008 15:10:11 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0807091504470.3228@apollo.tec.linutronix.de>
References: <48249E2C.3010601@gmail.com> <4825F7DB.6000808@gmail.com> <alpine.LFD.1.10.0805252321140.3295@apollo.tec.linutronix.de> <200807081049.10704.dgollub@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clark Williams <clark.williams@gmail.com>,
	Robert de Vries <robert.h.de.vries@gmail.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Luis Claudio Goncalves <lclaudio@uudg.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Daniel Gollub <dgollub@suse.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:33129 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751889AbYGINKf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Jul 2008 09:10:35 -0400
In-Reply-To: <200807081049.10704.dgollub@suse.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 8 Jul 2008, Daniel Gollub wrote:
> > > >> Got a couple of requests for mlockall() in cyclictest, so I added an
> > > >> --mlockall
> > > >> option to cyclictest, signaltest and pi_stress.
> > > >
> > > > One small remark: it would be better to do the mlockall() by default.
> > > > As far as I know this should be done always for real-time applications.
> > > > I am actually surprised that it is not done already. It is also
> > > > mentioned in the Howto build an RT-application on the RT linux wiki.
> > > >
> > > >    Robert
> > >
> > > I thought about that, but figured it would be better just to have the
> > > option rather than change long-standing behavior.

Right.

Nope. We dont want to change the applications default behaviour.

Also mlockall is only relevant if your system supports swap.

> > >
> > > It's Thomas's call though :)
> >
> > I prefer an option. That gives the mm folks less of an excuse why they
> > swap out hot memory :)

Hehe
 
> Hi Thomas,
> 
> unfortunately this nice feature didn't made it into rt-tests 0.23 release. Is 
> there any plan to include this for upcoming rt-tests releases?

Yup. Thanks for the reminder. It just got lost in my ever growing
inbox :(

Thanks,

	tglx
