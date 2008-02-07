From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: IBM test question
Date: Thu, 07 Feb 2008 14:49:07 +0100
Message-ID: <47AB0C53.3050703@parrot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:35216 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754693AbYBGOPV (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Feb 2008 09:15:21 -0500
Received: from toronto.xi-lite.net (localhost.localdomain [127.0.0.1])
	by toronto.xi-lite.net (Postfix) with ESMTP id 0C0E26581E5
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Feb 2008 13:49:58 +0000 (GMT)
Received: from mail.xi-lite.com (unknown [193.34.35.248])
	by toronto.xi-lite.net (Postfix) with ESMTP id EDB236581E5
	for <linux-rt-users@vger.kernel.org>; Thu,  7 Feb 2008 13:49:57 +0000 (GMT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

hi,

I am trying to use some IBM rt test on arm.


I define atomic_add to
assert(i==1);
return ++(v->counter);

That's a bit ugly, but that should work for my need.

But I have a problem with the sched_latency test.
On my platform the thread creation is quite slow (25ms), so with the 
default value, I got a PERIOD MISSED.

I wonder why the test account thread creation time and not compute start 
at the beginning of the thread ?

Also my cpu is quite slow (compared to last intel core or powerpc). For 
example a sched_jitter run take 6s.
Couldn't be some static or runtime configuration to configure the test 
according to the cpu speed ?


Matthieu
