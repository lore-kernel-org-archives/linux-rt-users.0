From: Joe Korty <joe.korty@ccur.com>
Subject: Re: UDP jitter
Date: Sat, 9 Nov 2013 11:33:20 -0500
Message-ID: <20131109163319.GA31884@tsunami.ccur.com>
References: <20130430192653.5c6c08b6@sanja.asnn.org>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at>
 <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at>
 <20131107103325.65938975@sanja.asnn.org>
 <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
 <527CB16D.3040909@meduna.org>
 <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de>
 <12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from flusers.ccur.com ([173.221.59.2]:54644 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753700Ab3KIRRt (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 9 Nov 2013 12:17:49 -0500
Content-Disposition: inline
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 08, 2013 at 07:07:41AM -0500, eg Engleder Gerhard wrote:
>  > -----Urspr?ngliche Nachricht-----
> > Von: Thomas Gleixner [mailto:tglx@linutronix.de] 
> > Gesendet: Freitag, 08. November 2013 12:31
> > An: Stanislav Meduna
> > Cc: Neboj?a ?osi?; eg Engleder Gerhard; linux-rt-users
> > Betreff: Re: UDP jitter
> > 
> > There are other ways to solve this without touching a single 
> > line of kernel code. The technology is all there, you just 
> > have to use it. Of course that requires to understand it in 
> > the first place, though this seems to be way harder than 
> > spending a lot of time tracing the problem and then yelling 
> > "priority inversion" and hope that the RT folks are going to "fix" it.
> 
> Can you give us a hint which technology to use? Currently I am
> trying to use QoS Multi Band Priority Queueing.


Look into OpenOnload.  The software is GPLed, tho it
requires a custom Ethernet card that is perhaps 50% more
expensive than other 10GigE cards.

Regards
Joe

