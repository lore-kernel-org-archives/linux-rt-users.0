From: "K.R. Foley" <kr@cybsft.com>
Subject: Re: Problems with cyclictest and ps
Date: Wed, 05 Dec 2007 15:29:12 -0600
Message-ID: <47571828.6000406@cybsft.com>
References: <47570B50.9060502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Phil K." <binutz@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xmnp015.utc.com ([159.82.164.203]:50933 "EHLO xmnp015.utc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751814AbXLEV3V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Dec 2007 16:29:21 -0500
In-Reply-To: <47570B50.9060502@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Phil K. wrote:
> Hi,
> 
> I tried cyclictest under Debian Lenny with Kernel-2.6.23.8-hrt3 and
> Kernel-2.6.22 as user root. As decribed on the cyclictest-wikipage all
> cyclictest-tasks run with the scheduler class SCHED_FIFO. I controlled
> the scheduler class with "ps -ce" and ps showed me SCHED_OTHER for the
> cyclictest-task.
> 
> #> ./cyclictest -t 1 -p 80 -n -i 10000
> 
> #> ps -ce | grep cyclic
>    PID CLS PRI TTY          TIME CMD
>   9693 TS   19 pts/5    00:00:00 cyclictest
> 
> I am wondering why cyclictest runs as SCHED_OTHER I expected SCHED_FIFO
> instead. Any explanations of this behavior are welcome.
> 
> Regards,
> 
> Phil
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

try "ps -eLc | grep cyclic"

Without the "L" you don't see threads/lightweight processes.

-- 
   kr
