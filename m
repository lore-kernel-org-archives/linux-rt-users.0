From: Remy Bohmer <linux@bohmer.net>
Subject: [patch 0/3] add kernel-cmdline support for interrupt thread
	priorities (repost:CC to LKML)
Date: Wed, 19 Dec 2007 20:45:51 +0100
Message-ID: <47697877.08aa420a.4404.ffff8bed@mx.google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
	Ingo Molnar <mingo@elte.hu>,
	Juergen Beisert <jbe@pengutronix.de>,
	Darren Hart <dvhltc@us.ibm.com>,
	linux-rt-users@vger.kernel.org,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:42609 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085AbXLSUA7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2007 15:00:59 -0500
Received: by ug-out-1314.google.com with SMTP id z38so343262ugc.16
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Dec 2007 12:00:57 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello All,

Back in August we had a discussion about the default priorities of
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
