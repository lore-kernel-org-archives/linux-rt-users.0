From: Carol Wong <carolw@netacquire.com>
Subject: 4.9.33-rt23 latency under high load
Date: Thu, 27 Jul 2017 22:45:38 +0000
Message-ID: <efca9200a0d04af788a7f32322091337@S1P7MBX1A.EXCHPROD.USA.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gateout01.ct.mbox.net ([165.212.182.18]:45030 "EHLO
        goe1.ct.mbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbdG0Wur (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Jul 2017 18:50:47 -0400
Received: from goe1.ct.mbox.net (localhost [127.0.0.1])
        by goe1.ct.mbox.net (Postfix) with ESMTP id 3xJRrp53nQztvrn
        for <linux-rt-users@vger.kernel.org>; Thu, 27 Jul 2017 22:45:30 +0000 (UTC)
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On my test setup, cyclictest is reporting max latency > 500 us in 4.9.33-rt23 and 4.9.35-rt25. Max latency is small in 4.9.33-rt22 and 4.9.33-rt21 (< 50 us) under the same conditions. 

My test setup uses a Core i7 (3.4GHz 3rd gen) with hyper-threading disabled. The system is under heavy load (60-90% each core) servicing network traffic and performing arithmetic on the packet payloads. Interrupt rate is approximately 60K intr/s. I've tried a few different NICs (e1000, e1000e, and ixgbe) with the same result. Occasional big hits start occurring within 30 minutes.

I tried a modified 4.9.33-rt23 kernel with the following commit removed: 
<https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/commit/kernel/sched/core.c?h=v4.9-rt&id=1dc89be37874bfc7bb4a0ea7c45492d7db39f62b>
The big latency hits do not happen with this commit backed out.

I've not yet had a chance to try a 4.11 kernel, but it looks like there's been recent work on migrate_disable/enable in that branch. Maybe a backport to 4.9 is needed?
	
Cheers,
Carol

