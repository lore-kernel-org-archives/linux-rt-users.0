From: Vucsics Krisztian <krisztian.vucsics@evosoft.com>
Subject: Re: Looking for "Hello world"
Date: Tue, 05 Dec 2006 16:27:57 +0100
Message-ID: <45758FFD.3030401@evosoft.com>
References: <45743DAF.6020205@evosoft.com> <200612040813.19018.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from evo2.evosoft.com ([195.228.139.85]:55837 "HELO evo2.evosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S967540AbWLEQHC (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 5 Dec 2006 11:07:02 -0500
To: Darren Hart <dvhltc@us.ibm.com>
In-Reply-To: <200612040813.19018.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Darren,

> http://www.kernel.org/pub/linux/kernel/people/dvhart/realtime/tests/

I've downloaded your testcases but some of them cannot be compiled, e.g.
 func/prio-preempt:
../../include/librt.h:597: error: `PTHREAD_PRIO_INHERIT' undeclared
(first use in this function)

I've google'd this error and I've found some bug reports for that at
January 2006 -- those bugs are reported as "fix in mext versions" but I
have the same problem with the most recent kernel also.

coms01:~ # uname -a
Linux coms01 2.6.19 #1 PREEMPT Tue Dec 5 14:51:33 PST 2006 i686 i686
i386 GNU/Linux

Do I need perhaps a patch for that?

Thanks,
Krisztian
