From: Johannes Bauer <hannes_bauer@aon.at>
Subject: Interrupt latency!
Date: Wed, 25 May 2011 22:47:32 +0200 (CEST)
Message-ID: <23866677.16785.1306356452677.JavaMail.root@WARSBL213.highway.telekom.at>
Reply-To: hannes_bauer@aon.at
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpout06.highway.telekom.at ([195.3.96.89]:65514 "EHLO
	email.aon.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754904Ab1EYUrg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 May 2011 16:47:36 -0400
Received: from warsbl213-nfs.highway.telekom.at (HELO WARSBL213.highway.telekom.at) ([172.18.96.92])
          (envelope-sender <hannes_bauer@aon.at>)
          by smarthub97.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <linux-rt-users@vger.kernel.org>; 25 May 2011 20:47:33 -0000
Received: from WARSBL213.highway.telekom.at (localhost.localdomain [127.0.0.1])
	by WARSBL213.highway.telekom.at (8.13.1/8.13.1) with ESMTP id p4PKlW4H006157
	for <linux-rt-users@vger.kernel.org>; Wed, 25 May 2011 22:47:32 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


Hello its me again!

yeah i am not sopping to ask question ;).

I have read through a few papers regarding interrupt latency of the preempt-patch as this one
http://lwn.net/images/conf/rtlws11/papers/proc/p19.pdf

The implementation seems to suggest that interrupt latencies of hard irqs (IRQF_NODELAY) should be better for preempt-rt.

On my machine however it is worse than for CONFIG_PREEMPT_NONE.

The userspace latency measured with cyclictest is much better for CONFIG_PREEMPT_RT then for CONFIG_PREEMPT_NONE.

The interrupt latency however (with IRQF_NODELAY) is worse than for  CONFIG_PREEMPT_NONE and the worst case is about 700us.
This makes no sense to me, because the max user space latency is about 650us.
How can it be possible that the irq latency is worse then userspace latency?

I am on the loss here, and would highly appreciate any ideas, hints or ANYTHING.

Thank you
JB
