From: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [ANNOUNCE] 2.6.31-rc6-rt2
Date: Wed, 19 Aug 2009 12:12:26 -0500
Message-ID: <1250701946.516.390.camel@lexx>
References: <alpine.LFD.2.00.0902112332370.415@localhost.localdomain>
	 <alpine.LFD.2.00.0904092046440.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904110003370.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904181204420.21577@localhost.localdomain>
	 <alpine.LFD.2.00.0904251500150.4529@localhost.localdomain>
	 <alpine.LFD.2.00.0904290036500.4529@localhost.localdomain>
	 <alpine.LFD.2.00.0905012348200.3375@localhost.localdomain>
	 <alpine.LFD.2.00.0905130122250.3561@localhost.localdomain>
	 <alpine.LFD.2.00.0905221459030.3570@localhost.localdomain>
	 <alpine.LFD.2.00.0906101803210.3367@localhost.localdomain>
	 <alpine.LFD.2.00.0906121800590.3369@localhost.localdomain>
	 <alpine.LFD.2.00.0906151117440.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906170903370.2800@localhost.localdomain>
	 <alpine.LFD.2.00.0906231418500.2767@localhost.localdomain>
	 <alpine.LFD.2.00.0907092020410.2768@localhost.localdomain>
	 <alpine.LFD.2.00.0907300006250.2936@localhost.localdomain>
	 <alpine.LFD.2.00.0908162207370.2782@localhost.localdomain>
	 <1250629478.516.249.camel@lexx>
	 <alpine.LFD.2.00.0908182311250.3361@localhost.localdomain>
Reply-To: will_schmidt@vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>,
	Clark Williams <williams@redhat.com>,
	Frank Rowand <frank.rowand@am.sony.com>,
	Robin Gareus <robin@gareus.org>,
	Gregory Haskins <ghaskins@novell.com>,
	Philippe Reynes <philippe.reynes@isismpp.fr>,
	Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
	Darren Hart <dvhltc@us.ibm.com>, Jan Blunck <jblunck@suse.de>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	Jon Masters <jcm@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.145]:55782 "EHLO e5.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbZHSRMb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Aug 2009 13:12:31 -0400
In-Reply-To: <alpine.LFD.2.00.0908182311250.3361@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2009-08-18 at 23:14 +0200, Thomas Gleixner wrote:
> Will,
> 
> On Tue, 18 Aug 2009, Will Schmidt wrote:
> > 
> > Booting the system seems mostly OK with maxcpus=1, though this INFO
> > message appears on the console.  (This does repeat after a while..) :
> > 
> >  INFO: task irq/16-IPI:3 blocked for more than 120 seconds.
> 
> Hmm. Why is the IPI threaded ? Can you check older (working) RT
> versions whether the IPIs were threaded there as well ?

Hi Thomas, 
   fyi and for list awareness, I was able to boot 2.6.31-rc6-rt5 (out
of .git tip/rt/...)  successfully on my system. (power6 pseries JS22).
Currently up and running kernbench, all cpus utilized.. good stuff. :-)

Thanks, 
-Will


> Thanks,
> 
> 	tglx
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

