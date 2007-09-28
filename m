From: Daniel Walker <dwalker@mvista.com>
Subject: Re: Network hangs when rt-preempt patch is applied
Date: Fri, 28 Sep 2007 10:53:58 -0700
Message-ID: <1191002038.17385.5.camel@imap.mvista.com>
References: <200709281213.34994.jbe@pengutronix.de>
	 <1190990989.17385.0.camel@imap.mvista.com>
	 <200709281710.25613.jbe@pengutronix.de>
	 <1191001424.17385.3.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Juergen Beisert <jbe@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:19980 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbXI1SAf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 28 Sep 2007 14:00:35 -0400
In-Reply-To: <1191001424.17385.3.camel@imap.mvista.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 2007-09-28 at 10:43 -0700, Daniel Walker wrote:
> On Fri, 2007-09-28 at 17:10 +0200, Juergen Beisert wrote:
> > On Friday 28 September 2007 16:49, Daniel Walker wrote:
> > > On Fri, 2007-09-28 at 12:13 +0200, Juergen Beisert wrote:
> > > > Hi,
> > > >
> > > > I'm trying to find out if this is an MPC5200B related driver problem or
> > > > RT-Preempt related one: Under some network (nmap, nc) load the network
> > > > dies on my target.
> > > >
> > > > Target (PowerPC) runs 2.6.23-rc8 plus patch-2.6.23-rc8-rt1.
> > > >
> > > > Sometimes it survives the nmap, but mostly it dies immediately. Here it
> > > > was successfull in the first nmap run, but dies on the second one:
> > >
> > > Which networking driver are you using?
> > 
> > Domen Puncer's FEC driver and Sylvain Munaut's bestcomm driver.
> 
> I don't think either of these are network drivers .. After talking to
> some powerpc people, it seems there aren't any mpc52xx network drivers
> in mainline .. So I wonder what tree (or kernel) your using? I could
> inspect the driver if I could find it ..

I found the FEC driver actually, 

http://lwn.net/Articles/249013/

Daniel
