From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Tue, 13 Nov 2007 08:15:44 -0800
Message-ID: <200711130815.44329.dvhltc@us.ibm.com>
References: <200711072334.40216.dvhltc@us.ibm.com> <1985e0f60711130540j43eac275p4f77bb373bb4c958@mail.gmail.com> <Pine.LNX.4.58.0711130914500.369@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33053 "EHLO e6.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbXKMRHQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 12:07:16 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lADH8pt1020082
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 12:08:51 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v8.6) with ESMTP id lADH77os1343506
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 12:07:07 -0500
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id lADH73VE017665
	for <linux-rt-users@vger.kernel.org>; Tue, 13 Nov 2007 10:07:04 -0700
In-Reply-To: <Pine.LNX.4.58.0711130914500.369@gandalf.stny.rr.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 13 November 2007 06:15:03 Steven Rostedt wrote:
> On Tue, 13 Nov 2007, Jaswinder Singh wrote:
> > On Nov 8, 2007 1:04 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> > > # ./cyclictest -n -i 10000 -l 10000 -p 95
> >
> > 10000 (10 milliseconds) interval seems to be quite big for current
> > machine. 10 milliseconds is good for 10 to 15 years old machine but
> > not for latest machines.
> >
> > I think we should try -i 1000 or -i 4000 .
>
> heh, I test with -i 250.

Someone, I'm sorry I can't recall who atm, suggested that using a larger 
interval would allow for more variance to be introduced - not keeping the 
caches so hot for this particular test by not spending so much time on the 
cpu.  Is this a valid approach?  Perhaps running multiple runs with both very 
tight intervals (like Steve's case) and some longer intervals to ensure we 
can handle both cases - since both are common in practice.

Thanks,

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
