From: Sbs <sbs.pub@gmail.com>
Subject: Doubt: Does RT patch reduce interrupt latency?
Date: Fri, 24 Jul 2009 23:41:42 +0530
Message-ID: <4cd511390907241111x3c6c9bbcw25230775c34ba3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.226]:4199 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZGXSLn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2009 14:11:43 -0400
Received: by rv-out-0506.google.com with SMTP id f6so524591rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jul 2009 11:11:42 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,

(Sorry if I am asking this on a wrong list. Please let me know the
correct list for this question)

We have a system which needs to be connected to a device that will
produce an interrupt during every msec. So, we want interrupt
latencies less than 1 msec (else we will miss interrupts). We tried
measuring interrupt latencies with RT patch applied. However, the
results that he got suggested that after applying patches, the worst
case latency went up.

>From what I read and understood from the site is that, the patch will
cause this kind of behaviour. Is this correct? (" Converting interrupt
handlers into preemptible kernel threads:" - RT wiki FAQ)  I have seen
some other site mentioning about rtirq patch (for 2.4). What is good
for my scenario? Should I apply an RT patch at all? Or is there
something else that I need to see?

Thanks in advance,

Regards,
Sbs
