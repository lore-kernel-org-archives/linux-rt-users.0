Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D58C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F1021726
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 02:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbfHWCy3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 22 Aug 2019 22:54:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731416AbfHWCy3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Aug 2019 22:54:29 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7N2qKGZ110341;
        Thu, 22 Aug 2019 22:54:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uj3jqyg43-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 22:54:20 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7N2sKLE114247;
        Thu, 22 Aug 2019 22:54:20 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uj3jqyg3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 22:54:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7N2otnr025174;
        Fri, 23 Aug 2019 02:54:18 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 2ue976es6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Aug 2019 02:54:18 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7N2sIhF47841552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Aug 2019 02:54:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA9EB2064;
        Fri, 23 Aug 2019 02:54:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DC50B205F;
        Fri, 23 Aug 2019 02:54:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.73])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 23 Aug 2019 02:54:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 09EF616C3FC8; Thu, 22 Aug 2019 19:54:18 -0700 (PDT)
Date:   Thu, 22 Aug 2019 19:54:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 1/3] rcu: Acquire RCU lock when disabling BHs
Message-ID: <20190823025417.GO28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-2-swood@redhat.com>
 <20190821233358.GU28441@linux.ibm.com>
 <2981acb99554a80211118350975577ab8faa3a2d.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2981acb99554a80211118350975577ab8faa3a2d.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908230030
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Aug 22, 2019 at 09:36:21PM -0500, Scott Wood wrote:
> On Wed, 2019-08-21 at 16:33 -0700, Paul E. McKenney wrote:
> > On Wed, Aug 21, 2019 at 06:19:04PM -0500, Scott Wood wrote:
> > > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > > index 388ace315f32..d6e357378732 100644
> > > --- a/include/linux/rcupdate.h
> > > +++ b/include/linux/rcupdate.h
> > > @@ -615,10 +615,12 @@ static inline void rcu_read_unlock(void)
> > >  static inline void rcu_read_lock_bh(void)
> > >  {
> > >  	local_bh_disable();
> > > +#ifndef CONFIG_PREEMPT_RT_FULL
> > >  	__acquire(RCU_BH);
> > >  	rcu_lock_acquire(&rcu_bh_lock_map);
> > >  	RCU_LOCKDEP_WARN(!rcu_is_watching(),
> > >  			 "rcu_read_lock_bh() used illegally while idle");
> > > +#endif
> > 
> > Any chance of this using "if (!IS_ENABLED(CONFIG_PREEMPT_RT_FULL))"?
> > We should be OK providing a do-nothing __maybe_unused rcu_bh_lock_map
> > for lockdep-enabled -rt kernels, right?
> 
> OK.
> 
> > > @@ -185,8 +189,10 @@ void __local_bh_enable_ip(unsigned long ip,
> > > > > unsigned int cnt)
> > >  	WARN_ON_ONCE(count < 0);
> > >  	local_irq_enable();
> > >  
> > > -	if (!in_atomic())
> > > +	if (!in_atomic()) {
> > > +		rcu_read_unlock();
> > >  		local_unlock(bh_lock);
> > > +	}
> > 
> > The return from in_atomic() is guaranteed to be the same at
> > local_bh_enable() time as was at the call to the corresponding
> > local_bh_disable()?
> 
> That's an existing requirement on RT (which rcutorture currently violates)
> due to bh_lock.
> 
> > I could have sworn that I ran afoul of this last year.  Might these
> > added rcu_read_lock() and rcu_read_unlock() calls need to check for
> > CONFIG_PREEMPT_RT_FULL?
> 
> This code is already under a PREEMPT_RT_FULL ifdef.

Good enough, then!

							Thanx, Paul
