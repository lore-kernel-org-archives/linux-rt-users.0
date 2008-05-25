From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: add mlockall option to cyclictest, et al
Date: Sun, 25 May 2008 23:22:22 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0805252321140.3295@apollo.tec.linutronix.de>
References: <48249E2C.3010601@gmail.com> <4825F5AF.7010700@gmail.com> <4825F7DB.6000808@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robert de Vries <robert.h.de.vries@gmail.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Luis Claudio Goncalves <lclaudio@uudg.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <clark.williams@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:51496 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750881AbYEYVWi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 25 May 2008 17:22:38 -0400
In-Reply-To: <4825F7DB.6000808@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 10 May 2008, Clark Williams wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Robert de Vries wrote:
> > Clark Williams wrote:
> >> -----BEGIN PGP SIGNED MESSAGE-----
> >> Hash: SHA1
> >>
> >> Thomas,
> >>
> >> Got a couple of requests for mlockall() in cyclictest, so I added an
> >> --mlockall
> >> option to cyclictest, signaltest and pi_stress.
> >>   
> > One small remark: it would be better to do the mlockall() by default. As
> > far as I know this should be done always for real-time applications.
> > I am actually surprised that it is not done already. It is also
> > mentioned in the Howto build an RT-application on the RT linux wiki.
> > 
> >    Robert
> > 
> > 
> 
> I thought about that, but figured it would be better just to have the option rather
> than change long-standing behavior.
> 
> It's Thomas's call though :)

I prefer an option. That gives the mm folks less of an excuse why they
swap out hot memory :)

Thanks,
	tglx
