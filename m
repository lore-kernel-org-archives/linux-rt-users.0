Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB0C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 22:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E37F206BF
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 22:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfFTWZK (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:25:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbfFTWZK (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 18:25:10 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KMOMcY035463
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 18:25:09 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t8hsx26my-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 18:25:09 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 23:25:08 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 23:25:04 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KMP3O044761490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:25:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD847B205F;
        Thu, 20 Jun 2019 22:25:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA9BDB2067;
        Thu, 20 Jun 2019 22:25:03 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 22:25:03 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B7EF816C2FA6; Thu, 20 Jun 2019 15:25:05 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:25:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 3/4] rcu: unlock special: Treat irq and preempt
 disabled the same
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-4-swood@redhat.com>
 <20190620211005.GW26519@linux.ibm.com>
 <cf42d8516ac99f69913b1f7a7e8abe578ad27e7f.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf42d8516ac99f69913b1f7a7e8abe578ad27e7f.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062022-0064-0000-0000-000003F08FA7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011299; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220891; UDB=6.00642289; IPR=6.01002030;
 MB=3.00027398; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 22:25:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062022-0065-0000-0000-00003DF6536E
Message-Id: <20190620222505.GB26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200159
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 20, 2019 at 04:59:30PM -0500, Scott Wood wrote:
> On Thu, 2019-06-20 at 14:10 -0700, Paul E. McKenney wrote:
> > On Tue, Jun 18, 2019 at 08:19:07PM -0500, Scott Wood wrote:
> > > [Note: Just before posting this I noticed that the invoke_rcu_core stuff
> > >  is part of the latest RCU pull request, and it has a patch that
> > >  addresses this in a more complicated way that appears to deal with the
> > >  bare irq-disabled sequence as well.
> > 
> > Far easier to deal with it than to debug the lack of it.  ;-)
> > 
> > >  Assuming we need/want to support such sequences, is the
> > >  invoke_rcu_core() call actually going to result in scheduling any
> > >  sooner?  resched_curr() just does the same setting of need_resched
> > >  when it's the same cpu.
> > > ]
> > 
> > Yes, invoke_rcu_core() can in some cases invoke the scheduler sooner.
> > Setting the CPU-local bits might not have effect until the next interrupt.
> 
> Maybe I'm missing something, but I don't see how (in the non-use_softirq
> case).  It just calls wake_up_process(), which in resched_curr() will set
> need_resched but not do an IPI-to-self.

The common non-rt case will be use_softirq.  Or are you referring
specifically to this block of code in current -rcu?

		} else if (exp && irqs_were_disabled && !use_softirq &&
			   !t->rcu_read_unlock_special.b.deferred_qs) {
			// Safe to awaken and we get no help from enabling
			// irqs, unlike bh/preempt.
			invoke_rcu_core();

								Thanx, Paul

