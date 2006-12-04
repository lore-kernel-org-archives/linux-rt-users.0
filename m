From: Darren Hart <dvhltc@us.ibm.com>
Subject: Re: Looking for "Hello world"
Date: Mon, 4 Dec 2006 08:10:37 -0800
Message-ID: <200612040810.38126.dvhltc@us.ibm.com>
References: <45743DAF.6020205@evosoft.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:44552 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937053AbWLDQK4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Dec 2006 11:10:56 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB4GAkGY023534
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 11:10:46 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kB4GAjNZ215030
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 11:10:45 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kB4GAjAq027717
	for <linux-rt-users@vger.kernel.org>; Mon, 4 Dec 2006 11:10:45 -0500
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

The general approach would be to setup an event that wakes a thread to do the 
writing to the serial port at a specific time.  There are several ways to 
accomplish this.  The simplest approach would be to check the time using 
clock_gettime() (using CLOCK_MONOTONIC) and then sleep for the exact interval 
between that time and the time you want to write your 'H' using 
clock_nanosleep (again with CLOCK_MONOTONIC).  The clock routines have 
nanosecond resolution (and probably 10s of microsecond accuracy, depending on 
your platform).  When you wakeup, write the 'H', then repeat to schedule the 
next write.  There are certainly more advanced approaches using 
pthread_cond_wait() and pthread_cond_signal() from master and slave threads, 
etc.

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
