Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C85C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 19:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665E02084A
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 19:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbfFTTNF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 15:13:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbfFTTNF (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 15:13:05 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KIgAQs071240
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 15:13:04 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8d9ypp2b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 15:13:03 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 20:13:02 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 20:12:58 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KJCwAR53084670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 19:12:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF170B205F;
        Thu, 20 Jun 2019 19:12:57 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB237B2067;
        Thu, 20 Jun 2019 19:12:57 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 19:12:57 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A5F2216C2A15; Thu, 20 Jun 2019 12:12:59 -0700 (PDT)
Date:   Thu, 20 Jun 2019 12:12:59 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 0/4] Address rcutorture issues
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619011908.25026-1-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062019-0052-0000-0000-000003D34D0E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011298; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220827; UDB=6.00642250; IPR=6.01001966;
 MB=3.00027396; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 19:13:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062019-0053-0000-0000-000061654082
Message-Id: <20190620191259.GT26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200135
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 18, 2019 at 08:19:04PM -0500, Scott Wood wrote:
> With these patches, rcutorture mostly works on PREEMPT_RT_FULL.  I still
> once in a while get forward progress complaints (particularly,
> rcu_torture_fwd_prog_cr) when a grace period is held up for a few seconds
> after which point so many callbacks have been enqueued that even making
> reasonable progress isn't going to beat the timeout.  I believe I've only
> seen this when running heavy loads in addition to rcutorture (though I've
> done more testing under load than without); I don't know whether the
> forward progress tests are expected to work under such load.

With current -rcu, the torture tests are ahead of RCU's forward-progress
code, so rcu_torture_fwd_prog_cr() failures are expected behavior,
particularly in the TREE04 and TREE07 scenarios.  This is more of a
problem for real-time because of callback offloading, which removes the
backpressure that normally exists from callback processing to whatever
is running on that same CPU generating so many callbacks.  So this issue
has been providing me some entertainment.  ;-)

If you put lots of load on the system while running rcutorture, but
leave the CPU running rcu_torture_fwd_prog_cr() otherwise idle, then yes,
you can eventually force rcu_torture_fwd_prog_cr() pretty much no matter
what RCU does otherwise.  Particularly given that rcutorture is running
within a guest OS.  There has been some discussion of RCU asking for help
from the hypervisor, but it hasn't yet gotten further than discussion.

For another example, if all but one of the CPUs is an no-CBs CPU
(or, equivalently, a nohz_full CPU), and all of the rcuo kthreads
are constrained to run on the remaining CPU, it is not hard to create
workloads that produce more callbacks than that remaining CPU can possibly
keep up with.  The traditional position has of course been the Spiderman
principle "With great power comes great responsibility".  ;-)

							Thanx, Paul

> Scott Wood (4):
>   rcu: Acquire RCU lock when disabling BHs
>   sched: migrate_enable: Use sleeping_lock to indicate involuntary sleep
>   rcu: unlock special: Treat irq and preempt disabled the same
>   rcutorture: Avoid problematic critical section nesting
> 
>  include/linux/rcupdate.h |  4 +++
>  include/linux/sched.h    |  4 +--
>  kernel/rcu/rcutorture.c  | 92 ++++++++++++++++++++++++++++++++++++++++--------
>  kernel/rcu/tree_plugin.h | 12 ++-----
>  kernel/rcu/update.c      |  4 +++
>  kernel/sched/core.c      |  2 ++
>  kernel/softirq.c         | 12 +++++--
>  7 files changed, 102 insertions(+), 28 deletions(-)
> 
> -- 
> 1.8.3.1
> 

