Return-Path: <SRS0=eU8X=WU=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DATE_IN_PAST_24_48,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86959C3A59E
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Aug 2019 18:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62AD1206DD
	for <linux-rt-users@archiver.kernel.org>; Sat, 24 Aug 2019 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfHXSJM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 24 Aug 2019 14:09:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55214 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726464AbfHXSJM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 24 Aug 2019 14:09:12 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7OI6mcf109799;
        Sat, 24 Aug 2019 14:08:39 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujycnpjww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 14:08:39 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7OI866r111633;
        Sat, 24 Aug 2019 14:08:38 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ujycnpjwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 14:08:38 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7OI581E030781;
        Sat, 24 Aug 2019 18:08:37 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 2ujvv63wuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 18:08:37 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7OI8b9f26739032
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 24 Aug 2019 18:08:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E04AFB2065;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27A9B206C;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.187.121])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 24 Aug 2019 18:08:36 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 124E316C3882; Fri, 23 Aug 2019 05:30:38 -0700 (PDT)
Date:   Fri, 23 Aug 2019 05:30:38 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823123038.GR28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <20190822133955.GA29841@google.com>
 <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d65032399f66ec85731fdcf4f8c6c7af74687fb2.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-24_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908240201
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 10:23:23PM -0500, Scott Wood wrote:
> On Thu, 2019-08-22 at 09:39 -0400, Joel Fernandes wrote:
> > On Wed, Aug 21, 2019 at 04:33:58PM -0700, Paul E. McKenney wrote:
> > > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:

[ . . . ]

> > > >  include/linux/rcupdate.h |  4 ++++
> > > >  kernel/rcu/update.c      |  4 ++++
> > > >  kernel/softirq.c         | 12 +++++++++---
> > > >  3 files changed, 17 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > > index 388ace315f32..d6e357378732 100644
> > > > --- a/include/linux/rcupdate.h
> > > > +++ b/include/linux/rcupdate.h
> > > > @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
> > > >  static inline void rcu_read_lock_bh(void)
> > > >  {
> > > >  	local_bh_disable();
> > > > +#ifndef CONFIG_PREEMPT_RT_FULL
> > > >  	__acquire(RCU_BH);
> > > >  	rcu_lock_acquire(&rcu_bh_lock_map);
> > > >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > > >  			 "rcu_read_lock_bh() used illegally while idle");
> > > > +#endif
> > > 
> > > Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
> > > We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
> > > for lockdep-enabled -rt kernels, right?
> > 
> > Since this function is small, I prefer if -rt defines their own
> > rcu_read_lock_bh() which just does the local_bh_disable(). That would be
> > way
> > cleaner IMO. IIRC, -rt does similar things for spinlocks, but it has been
> > sometime since I look at the -rt patchset.
> 
> I'll do it whichever way you all decide, though I'm not sure I agree about
> it being cleaner (especially while RT is still out-of-tree and a change to
> the non-RT version that fails to trigger a merge conflict is a concern).
> 
> What about moving everything but the local_bh_disable into a separate
> function called from rcu_read_lock_bh, and making that a no-op on RT?

That makes a lot of sense to me!

							Thanx, Paul
