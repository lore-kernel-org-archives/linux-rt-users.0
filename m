Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F90C43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D3DE2070B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfFTVUk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 17:20:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725905AbfFTVUk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 17:20:40 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KL8Lpk089137
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 17:20:39 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8hsygcny-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 17:20:38 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 22:20:38 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 22:20:34 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KLKXUn23134518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 21:20:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38B55B2064;
        Thu, 20 Jun 2019 21:20:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B6C8B205F;
        Thu, 20 Jun 2019 21:20:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 21:20:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1D16816C2A15; Thu, 20 Jun 2019 14:20:35 -0700 (PDT)
Date:   Thu, 20 Jun 2019 14:20:35 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RT 1/4] rcu: Acquire RCU lock when disabling BHs
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-2-swood@redhat.com>
 <20190620205352.GV26519@linux.ibm.com>
 <1b6dfc95bba69aa53e4e84eebf6af60f0b9ed95c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b6dfc95bba69aa53e4e84eebf6af60f0b9ed95c.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062021-0064-0000-0000-000003F08BF6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011299; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220870; UDB=6.00642276; IPR=6.01002009;
 MB=3.00027397; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 21:20:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062021-0065-0000-0000-00003DF630BE
Message-Id: <20190620212035.GY26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200152
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 20, 2019 at 04:06:02PM -0500, Scott Wood wrote:
> On Thu, 2019-06-20 at 13:53 -0700, Paul E. McKenney wrote:
> > On Tue, Jun 18, 2019 at 08:19:05PM -0500, Scott Wood wrote:
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index fb267bc04fdf..aca4e5e25ace 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -637,10 +637,12 @@ static inline void rcu_read_unlock(void)
> > >  static inline void rcu_read_lock_bh(void)
> > >  {
> > >  	local_bh_disable();
> > > +#ifndef CONFIG_PREEMPT_RT_FULL
> > 
> > How about this instead?
> > 
> > 	if (IS_ENABLED(CONFIG_PREEMPT_RT_FULL))
> > 		return;
> 
> OK.
> 
> > > @@ -189,8 +193,10 @@ void __local_bh_enable_ip(unsigned long ip,
> > > unsigned int cnt)
> > >  	WARN_ON_ONCE(count < 0);
> > >  	local_irq_enable();
> > >  
> > > -	if (!in_atomic())
> > > +	if (!in_atomic()) {
> > > +		rcu_read_unlock();
> > >  		local_unlock(bh_lock);
> > > +	}
> > >  
> > >  	preempt_check_resched();
> > >  }
> > 
> > And I have to ask...
> > 
> > What did you do to test this change to kernel/softirq.c?  My past attempts
> > to do this sort of thing have always run afoul of open-coded BH
> > transitions.
> 
> Mostly rcutorture and loads such as kernel builds, on a debug kernel.  By
> "open-coded BH transition" do you mean directly manipulating the preempt
> count?  That would already be broken on RT.

OK, then maybe you guys have already done the needed cleanup work.  Cool!

But don't the additions of rcu_read_lock() and rcu_read_unlock() want
to be protected by "!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)" or similar?

							Thanx, Paul

