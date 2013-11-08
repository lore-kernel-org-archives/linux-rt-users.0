From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: AW: UDP jitter
Date: Fri, 8 Nov 2013 14:35:44 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311081432300.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de> <527CB16D.3040909@meduna.org>
 <alpine.DEB.2.02.1311081121190.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1004509738-1383917744=:23353"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: eg Engleder Gerhard <eg@keba.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58430 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab3KHNfr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 08:35:47 -0500
In-Reply-To: <12C1B74BDFD05D40B2356A9B12DFA33967BEB687E6@KEBMXSPMB01.keba.co.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1004509738-1383917744=:23353
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

On Fri, 8 Nov 2013, eg Engleder Gerhard wrote:
>  > -----Ursprüngliche Nachricht-----
> > Von: Thomas Gleixner [mailto:tglx@linutronix.de] 
> > Gesendet: Freitag, 08. November 2013 12:31
> > An: Stanislav Meduna
> > Cc: Neboj¹a Æosiæ; eg Engleder Gerhard; linux-rt-users
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

Well, it really depends on your requirements. Assuming you have a
simple binary decision (Bulk and VIP traffic) a simple 2 band priority
queue should work.

Thanks,

	tglx
--8323329-1004509738-1383917744=:23353--
