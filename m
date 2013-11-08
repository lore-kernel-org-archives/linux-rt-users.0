From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 12:48:46 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311081230580.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org> <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de> <527CB16D.3040909@meduna.org>
 <20131108113250.2abdb8b7@sth491dt.servo.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1571742799-1383911326=:23353"
Cc: Stanislav Meduna <stano@meduna.org>,
	eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-2?Q?Neboj=B9a_=C6osi=E6?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57780 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753274Ab3KHLsv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Nov 2013 06:48:51 -0500
In-Reply-To: <20131108113250.2abdb8b7@sth491dt.servo.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1571742799-1383911326=:23353
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 8 Nov 2013, Nebojša Ćosić wrote:
> I have to repeat that the code in question worked in my case, which is
> very specific, and that reason for discussing it is to try to come to a
> proper solution to this problem.
> And yes, I do believe that, even if behaviour is documented, it is still
> a problem and can be dealt with in a better way.

I have to repeat what the real problem is:

 You are not understanding at all how networking, queueing, traffic
 control and other advanced concepts are working. You are not even
 trying it.

 You just insist that your view of the problem is correct and there
 must be a magic technical solution to it.

Again, there is no technical solution to cure ignorance.

Thanks,

	tglx









--8323329-1571742799-1383911326=:23353--
