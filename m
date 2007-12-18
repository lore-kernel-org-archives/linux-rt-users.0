From: Remy Bohmer <remy@bohmer.net>
Subject: [patch 0/3] add kernel-cmdline support for interrupt threads
	priorities
Date: Tue, 18 Dec 2007 23:05:05 +0100
Message-ID: <4768450c.2134440a.279e.5fbe@mx.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users@vger.kernel.org, Remy Bohmer <linux@bohmer.net>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.191]:3058 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751758AbXLRWJT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 18 Dec 2007 17:09:19 -0500
Received: by fk-out-0910.google.com with SMTP id z23so2266787fkz.5
        for <linux-rt-users@vger.kernel.org>; Tue, 18 Dec 2007 14:09:17 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Steven,

Back in August we all had a discussion about the default priorities of
IRQ-threads and softirqs, and the lack of a mechanism to configure them from
within the kernel.
(see http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg01022.html)

Here is a patchset that implements such a nice feature from the kernel cmdline,
similar to what we all agreed on, back then.

The set exist of 3 parts:
1) add a generic routine to the kernel commandline-parse-library to parse the
format of the map as we agreed on.
2) Add a __setup(irq_pmap=) routine to kernel/irq/manage.c
3) Add a __setup(sirq_pmap=) routine to kernel/softirq.c

I hope you can find the time to review this set.


Kind Regards,

Remy Bohmer


-- 
