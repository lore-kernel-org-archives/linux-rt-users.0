From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: PREEMPT_RT patch vs RTAI/Xenomai
Date: Tue, 11 May 2010 08:20:31 -0700
Message-ID: <4BE975BF.1030305@us.ibm.com>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0BF@srv-dc.ona-electroerosion.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Asier Tamayo <asier.tamayo@ona-electroerosion.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:47178 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab0EKPUe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 May 2010 11:20:34 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4BF8eRk008739
	for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2010 11:08:40 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o4BFKXrL154608
	for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2010 11:20:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id o4BFKWM3018280
	for <linux-rt-users@vger.kernel.org>; Tue, 11 May 2010 12:20:33 -0300
In-Reply-To: <DFFBF4EB468A894AB1474ED220F05AF60134C0BF@srv-dc.ona-electroerosion.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Asier Tamayo wrote:
> Hello all:
> 
> I'm just a newbie to this list, so just forgive me if my question is obvious or has been answered many times ;-)
> 
> I want to do a port from an old system running a proprietary RTOS to a new one based in Linux. My system runs many applications at the same time (GUI, parsers, ...), a few of which are hard real-time. 
> 
> I've searched the web, but am still unable to decide which system to use: RTAI, Xenomai or the PREEMPT_RT patch. Can anyone give me some clue in this issue? Are there any advantages in choosing the PREEMPT_RT patches over Xenomai or RTAI? Running the GUI, which demands a lot of CPU and RAM, can have any effect on the real-time behaviour?
> 
> I've seen many comparisons, but in this fast-changing world, most of them seem to me to be quite out of date.
> 
> Any hint will be really helpful,

What are your criteria?  Do you care about anything other
than performance (availability, upgrades, cost, support,
compatibility, tools, ...)?

If your most important criteria is how well your applications
perform (whatever that means for you), you're best off testing
the solutions that you can get hold of with your own workload,
in your own environment.

Also, fwiw, there are 2 enterprise distros (Red Hat's MRG
and Novell's SLERT) providing real-time (both based on the
Linux RT patchset).

thanks,
Nivedita
