From: Yao Zhao <yao.zhao@windriver.com>
Subject: rt-tester testcase t4-l2-pi-deboost.tst failed
Date: Wed, 27 Feb 2013 14:23:45 -0500
Message-ID: <512E5D41.3000103@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:41979 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805Ab3B0TXq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 27 Feb 2013 14:23:46 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r1RJNkwL004472
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <linux-rt-users@vger.kernel.org>; Wed, 27 Feb 2013 11:23:46 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

I tested rt-tester with mainline 3.8.0 kernel and
the kernel scripts/rt-tester/t4-l2-pi-deboost.tst failed at

# Verify prio of T0 (still pending owner,
# but T2 is enqueued due to the previous boost by T3
T: prioeq:              0:      82

The current T0's prio is -21 so it failed.

Reading source code, it should be 82 as T2 is at prio 82 and
T0 owns the L1 and T2 is waiting for the L1.

Can I ask
1.is the rt-tester test only for preempt-rt kernel?
2.any idea why it failed?

thanks,
yao
