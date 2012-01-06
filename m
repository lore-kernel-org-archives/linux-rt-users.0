From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Minor page faults from pthread_create()
Date: Fri, 06 Jan 2012 21:46:29 +0100
Message-ID: <4F075DA5.1070307@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ltw.loris.tv ([89.163.167.2]:46809 "EHLO ltw.loris.tv"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759183Ab2AFUwi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 6 Jan 2012 15:52:38 -0500
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 9D8BB3524E5
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Jan 2012 21:46:31 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2+r-FEdR5G6r for <linux-rt-users@vger.kernel.org>;
	Fri,  6 Jan 2012 21:46:30 +0100 (CET)
Received: from [IPv6:2001:638:906:2:e269:95ff:fe88:796b] (foh.inf-ra.uni-jena.de [IPv6:2001:638:906:2:e269:95ff:fe88:796b])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id 5CEF23524E4
	for <linux-rt-users@vger.kernel.org>; Fri,  6 Jan 2012 21:46:30 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi!

While playing with

 
https://rt.wiki.kernel.org/articles/t/h/r/Threaded_RT-application_with_memory_locking_and_stack_handling_example_f48b.html

I was wondering why pthread_create() should cause minor page faults when
there is a pre-allocated pre-faulted 100MB memory pool.

Simply running the example causes roughly 30 minor page faults. When I
manually allocate stack memory for the stack (after mlockall() and
mallopt have been called) and use pthread_attr_setstack() before calling
pthread_create(), minor page faults drop to 2.

Does anybody happen to know what is causing these remaining two page
faults? My only guess so far is kernel memory to hold some
organizational data for the new thread after clone() has been invoked,
but this could also be completely wrong.

Note that I don't need to get page faults down to 0, I'm only looking
for an explanation to understand the issue at hand to confirm that
pthread_create() must not be used from an RT context.


TIA
