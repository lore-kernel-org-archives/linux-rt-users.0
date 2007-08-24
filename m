From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH RFC] Priority boosting for preemptible RCU
Date: Fri, 24 Aug 2007 11:09:05 +0100
Message-ID: <46CEAE41.7060001@shadowen.org>
References: <20070822190254.GA1135@linux.vnet.ibm.com> <20070822124340.16a891f2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: paulmck@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org, mingo@elte.hu, dipankar@in.ibm.com,
	josht@linux.vnet.ibm.com, tytso@us.ibm.com, dvhltc@us.ibm.com,
	tglx@linutronix.de
To: Andrew Morton <akpm@linux-foundation.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hellhawk.shadowen.org ([80.68.90.175]:2430 "EHLO
	hellhawk.shadowen.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765821AbXHXKJt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Aug 2007 06:09:49 -0400
In-Reply-To: <20070822124340.16a891f2.akpm@linux-foundation.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Andrew Morton wrote:

>> +	for_each_possible_cpu(cpu) {
>> +		rbdp = per_cpu(rcu_boost_dat, cpu);
>> +		for (i = 0; i < RCU_BOOST_ELEMENTS; i++) {
>> +			rbdp[i].rbs_mutex = SPIN_LOCK_UNLOCKED;
> 
> Doesn't this confound lockdep?   We're supposed to use spin_lock_init().
> 
> Andy, can we have a checkpatch rule for SPIN_LOCK_UNLOCKED please?  It's
> basically always wrong.

ERROR: Use of SPIN_LOCK_UNLOCKED is deprecated: see
Documentation/spinlocks.txt
#58: FILE: Z17.c:55:
+       rbdp[i].rbs_mutex = SPIN_LOCK_UNLOCKED;

Also picks up the RW_LOCK_UNLOCKED version too.

-apw
