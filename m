From: John Stultz <johnstul@us.ibm.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Thu, 15 Nov 2012 12:53:56 -0800
Message-ID: <50A55664.2090605@us.ibm.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Scot Salmon <scot.salmon@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e32.co.us.ibm.com ([32.97.110.150]:45243 "EHLO
	e32.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733Ab2KOVYp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2012 16:24:45 -0500
Received: from /spool/local
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <johnstul@us.ibm.com>;
	Thu, 15 Nov 2012 13:54:18 -0700
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com [9.17.195.226])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id A9B50C40004
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 13:53:59 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id qAFKrxHc181710
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 13:54:00 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id qAFKrxgM023380
	for <linux-rt-users@vger.kernel.org>; Thu, 15 Nov 2012 13:53:59 -0700
In-Reply-To: <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/15/2012 11:28 AM, Scot Salmon wrote:
> Thomas Gleixner <tglx@linutronix.de> wrote on 10/31/2012 03:08:45 PM:
>> What you are concerned about is keeping the machines in sync on a
>> common global timeline. Though your more fundamental requirement is
>> that you get the wakeup on each machine in the given cycle time. The
>> global synchronization mechanism just adjusts that local periodic
>> schedule.
> [...]
>> What you really want is an atomic readout facility for CLOCK_MONOTONIC
>> and CLOCK_REALTIME. That allows you to align the CLOCK_MONOTONIC based
>> timer with the global CLOCK_REALTIME based time line and in the event
>> that the CLOCK_REALTIME clock was set and jumped forward/backward you
>> have full software control over the aligning mechanism including the
>> ability to do sanity checking.
> This works for me.  We discussed it on IRC and agreed on "something
> like clock_gettime2(id, id, *t1, *t2) with a sanity check on the ids,
> that allows us other combinations than MONO/REAL as well".
Yea, there's been a few times that folks have brought up the need, and 
this sort of interface is probably the best way to go.

I suspect clock_gettime3 isn't far behind though :)

thanks
-john

