From: Daniel Gollub <dgollub@suse.de>
Subject: Re: add mlockall option to cyclictest, et al
Date: Tue, 8 Jul 2008 10:49:10 +0200
Message-ID: <200807081049.10704.dgollub@suse.de>
References: <48249E2C.3010601@gmail.com> <4825F7DB.6000808@gmail.com> <alpine.LFD.1.10.0805252321140.3295@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <clark.williams@gmail.com>,
	Robert de Vries <robert.h.de.vries@gmail.com>,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Luis Claudio Goncalves <lclaudio@uudg.org>,
	RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:53147 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751038AbYGHItT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jul 2008 04:49:19 -0400
In-Reply-To: <alpine.LFD.1.10.0805252321140.3295@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sunday 25 May 2008 23:22:22 Thomas Gleixner wrote:
> On Sat, 10 May 2008, Clark Williams wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > Robert de Vries wrote:
> > > Clark Williams wrote:
> > >> -----BEGIN PGP SIGNED MESSAGE-----
> > >> Hash: SHA1
> > >>
> > >> Thomas,
> > >>
> > >> Got a couple of requests for mlockall() in cyclictest, so I added an
> > >> --mlockall
> > >> option to cyclictest, signaltest and pi_stress.
> > >
> > > One small remark: it would be better to do the mlockall() by default.
> > > As far as I know this should be done always for real-time applications.
> > > I am actually surprised that it is not done already. It is also
> > > mentioned in the Howto build an RT-application on the RT linux wiki.
> > >
> > >    Robert
> >
> > I thought about that, but figured it would be better just to have the
> > option rather than change long-standing behavior.
> >
> > It's Thomas's call though :)
>
> I prefer an option. That gives the mm folks less of an excuse why they
> swap out hot memory :)

Hi Thomas,

unfortunately this nice feature didn't made it into rt-tests 0.23 release. Is 
there any plan to include this for upcoming rt-tests releases?

best regards,
Daniel
