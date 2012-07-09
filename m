From: PRINGLE Chris <chris.pringle@miranda.com>
Subject: RE: Lookaside cache with high volume of objects hangs the kernel on
 destruction (deadlock)
Date: Mon, 9 Jul 2012 16:40:08 +0000
Message-ID: <E7D6489E57008E4088E37F78D30C62E60C693E@LB-OPS-EXCH01.miranda.com>
References: <E7D6489E57008E4088E37F78D30C62E60BAB7A@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60BC983@LB-OPS-EXCH01.miranda.com>
 <E7D6489E57008E4088E37F78D30C62E60C0120@LB-OPS-EXCH01.miranda.com>
 <20120704131520.GH9200@uudg.org>
 <E7D6489E57008E4088E37F78D30C62E60C4957@LB-OPS-EXCH01.miranda.com>
 <alpine.LFD.2.02.1207091211060.32033@ionos>
 <alpine.LFD.2.02.1207091539190.32033@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from stanmail.omnibus.co.uk ([194.201.223.253]:33148 "EHLO
	exch-lb.miranda.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752163Ab2GIQkg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Jul 2012 12:40:36 -0400
In-Reply-To: <alpine.LFD.2.02.1207091539190.32033@ionos>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> 
> Chris,
> 
> On Mon, 9 Jul 2012, Thomas Gleixner wrote:
> > On Fri, 6 Jul 2012, PRINGLE Chris wrote:
> > > It worries me a bit because this could potentially go wrong during
> > > runtime if the kernel ever reaps the lookaside cache for memory;
> > > this will then crash the entire system.
> >
> > Found the root cause, working on a fix.
> 
> Does the patch below work for you?
> 
> Thanks,
> 
> 	tglx
>

Supplied patch seems to have fixed the issue. Thanks a lot for looking at this; I'll do some more testing with the patch applied to make sure everything works as expected.

Cheers,
Chris
 
