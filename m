From: Jan Blunck <jblunck@infradead.org>
Subject: NOHZ: local_softirq_pending 02
Date: Fri, 29 May 2009 13:58:38 +0200
Message-ID: <4de7f8a60905290458y478c73ban1275d92ff01997c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f168.google.com ([209.85.220.168]:52187 "EHLO
	mail-fx0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756561AbZE2L6h (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 29 May 2009 07:58:37 -0400
Received: by fxm12 with SMTP id 12so4336087fxm.37
        for <linux-rt-users@vger.kernel.org>; Fri, 29 May 2009 04:58:38 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

With 2.6.29.4-rt16 I get after some time under load following warnings:

NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
NOHZ: local_softirq_pending 02
Clocksource tsc unstable (delta = 65308166 ns)

Seems that TIMER_SOFTIRQ is not run when properly. Any idea who caused this?

Cheers,
Jan
