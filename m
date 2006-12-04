From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Looking for "Hello world"
Date: Mon, 4 Dec 2006 08:13:18 -0800
Message-ID: <200612040813.19018.dvhltc@us.ibm.com>
References: <45743DAF.6020205@evosoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:60663 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937062AbWLDQNd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Dec 2006 11:13:33 -0500
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB4GDMao029795
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 11:13:22 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kB4GDLmK530592
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 09:13:22 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kB4GDLMe021286
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 09:13:21 -0700
To: Vucsics Krisztian <krisztian.vucsics@evosoft.com>
In-Reply-To: <45743DAF.6020205@evosoft.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Monday 04 December 2006 07:24, Vucsics Krisztian wrote:
> Hello Everybody,
>
> I've checked the RT_PREEMPT_HOWTO but there is no "Hello World" example
> at the moment. I don't know, whether and how it is possible to send
> something via the serial port exactly scheduled, "without changing the
> given programming APIs". I would like to send at least a single 'H' :-)
> to a given serial port, precisely scheduled.
>
> Could you please send me an example for that?

Also, if you are looking for code examples, I suggest taking a look at the 
numerous test cases provided here (linked off the wiki):

http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/

These tests use a simple pthread/realtime wrapper called librt.h.  You will 
find numerous uses of clock_gettime() and clock_nanosleep() as well as the 
pthread_cond_* routines.

>
> Thank you in advance,
> Krisztian
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
