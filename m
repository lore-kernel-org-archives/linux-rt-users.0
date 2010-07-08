From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: 2.6.33.[56]-rt23: howto create repeatable explosion in wakeup_next_waiter()
Date: Thu, 08 Jul 2010 07:12:15 -0700
Message-ID: <4C35DCBF.9070109@us.ibm.com>
References: <1278478019.10245.77.camel@marge.simson.net> <alpine.LFD.2.00.1007071356480.2604@localhost.localdomain> <4C348940.9070805@us.ibm.com> <1278590730.10399.3.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Mike Galbraith <efault@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:53753 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282Ab0GHOMv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 8 Jul 2010 10:12:51 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o68E9Ll6029392
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 08:09:21 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o68ECYDl111308
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 08:12:35 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o68ECKMn025430
	for <linux-rt-users@vger.kernel.org>; Thu, 8 Jul 2010 08:12:21 -0600
In-Reply-To: <1278590730.10399.3.camel@marge.simson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/08/2010 05:05 AM, Mike Galbraith wrote:
> On Wed, 2010-07-07 at 07:03 -0700, Darren Hart wrote:
>
>> I see kernel version is: 2.6.33.6-rt23, have you reproduced this on
>> earlier kernel versions as well? Any 2.6.31 rt kernel would be a good
>> data point.
>
> FUTEX_CMP/WAIT_REQUEUE_PI first appeared in 2.6.29-rt, as does the
> explosion.
>

Right. I haven't had a chance to look into this yet. I will have some 
time today.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
