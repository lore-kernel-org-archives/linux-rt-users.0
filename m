From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Looking for "Hello world"
Date: Tue, 5 Dec 2006 08:16:38 -0800
Message-ID: <200612050816.39252.dvhltc@us.ibm.com>
References: <45743DAF.6020205@evosoft.com> <200612040813.19018.dvhltc@us.ibm.com> <45758FFD.3030401@evosoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e34.co.us.ibm.com ([32.97.110.152]:51390 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968414AbWLEQQp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 11:16:45 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB5GGjNY020617
	for <linux-rt-users@vger.kernel.org>; Tue, 5 Dec 2006 11:16:45 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kB5GGgTn521010
	for <linux-rt-users@vger.kernel.org>; Tue, 5 Dec 2006 09:16:44 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kB5GGgZE016578
	for <linux-rt-users@vger.kernel.org>; Tue, 5 Dec 2006 09:16:42 -0700
To: Vucsics Krisztian <krisztian.vucsics@evosoft.com>
In-Reply-To: <45758FFD.3030401@evosoft.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tuesday 05 December 2006 07:27, Vucsics Krisztian wrote:
> Hi Darren,
>
> > http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/
>
> I've downloaded your testcases but some of them cannot be compiled, e.g.
>  func/prio-preempt:
> ../../include/librt.h:597: error: `PTHREAD_PRIO_INHERIT' undeclared
> (first use in this function)

You will need an updated glibc to get this.  I am not sure what most folks are 
doing to get this now a days.  Can s omeone chip in here and share with 
Vucsics how to go about getting the glibc?  If this isn't on the wiki 
somewhere I can add it once I know what the common practice is.

Thanks,

--Darren

>
> I've google'd this error and I've found some bug reports for that at
> January 2006 -- those bugs are reported as "fix in mext versions" but I
> have the same problem with the most recent kernel also.
>
> coms01:~ # uname -a
> Linux coms01 2.6.19 #1 PREEMPT Tue Dec 5 14:51:33 PST 2006 i686 i686
> i386 GNU/Linux
>
> Do I need perhaps a patch for that?
>
> Thanks,
> Krisztian

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
