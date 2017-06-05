From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: RCU simplification and RT needs
Date: Mon, 5 Jun 2017 13:35:50 -0700
Message-ID: <20170605203550.GA7126@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tglx@linutronix.de, bigeasy@linutronix.de,
        anna-maria@linutronix.de, williams@redhat.com, mingo@kernel.org,
        rostedt@goodmis.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48279 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751180AbdFEUfw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Jun 2017 16:35:52 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v55KYbBp135784
        for <linux-rt-users@vger.kernel.org>; Mon, 5 Jun 2017 16:35:51 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2awb99qaue-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Jun 2017 16:35:51 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 5 Jun 2017 16:35:50 -0400
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello!

At Linus's request, I am simplifying the Linux-kernel RCU implementation,
which includes removing code that implements features and options that
are no longer needed.  This is not a half-hearted effort.  In fact,
I expect that my submission to the next merge window will be a net
removal of more than 2500 lines of code.

But wait, there is more!  ;-)

Although the following two features are not being axed in v4.13, they
will be in v4.14 unless someone makes a convincing case for them:

1.	The ability to build a CONFIG_RCU_NOCB_CPUS=y kernel without
	also specifying CONFIG_NO_HZ_FULL.

	Unless someone speaks for this configuration option,
	CONFIG_RCU_NOCB_CPUS will be slaved off of CONFIG_NO_HZ_FULL,
	and the rcu_nocbs= boot parameter will be dropped.  (RCU would
	instead use the nohz_full= boot parameter to determine which
	CPUs get their callbacks offloaded.)

2.	The ability to specify polling for callback-offloaded CPUs.  This
	means that the rcu_nocb_poll= boot parameter will be dropped,
	and the CPU doing call_rcu() would do explicit wakeups, when
	needed, to get the corresponding rcuo kthread on the job.

	I have no evidence that anyone has ever used this option, other
	than me running the occasional rcutorture test.

So, anyone need either of these?  If not, out they go!  ;-)

							Thanx, Paul

