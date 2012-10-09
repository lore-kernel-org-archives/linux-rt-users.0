From: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Subject: Re: [ANNOUNCE] 3.6.1-rt1
Date: Tue, 9 Oct 2012 23:28:22 +0200
Message-ID: <201210092328.22862.tim01@vlsi.informatik.tu-darmstadt.de>
References: <alpine.LFD.2.02.1210091535140.10988@ionos>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-rt-users" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lnx141.hrz.tu-darmstadt.de ([130.83.156.236]:50431 "EHLO
	lnx141.hrz.tu-darmstadt.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754600Ab2JIVeT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2012 17:34:19 -0400
In-Reply-To: <alpine.LFD.2.02.1210091535140.10988@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Thomas
> I'm pleased to announce the 3.6.1-rt1 release.
I also have to second the big thanks of Steven!

>    * Fix for a potential deadlock in mm/slab.c. This had been reported
>      as lockdep splats several times and stupidly ignored as a false
>      positive, but in fact it's a real (though almost impossible to
>      trigger) deadlock lurking.
Mh, just an unverified (i.e. i haven't had the time to dig into it) 
information from my side: I think i have been seeing a total lockup on an OOM 
condition. Is it possible that this possible deadlock
might have been triggered in such a condition more "reliably"?

Best regards
Tim
