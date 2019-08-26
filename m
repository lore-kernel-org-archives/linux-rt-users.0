Return-Path: <SRS0=Uj5H=WW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8159CC3A59F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 18:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B26B20850
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Aug 2019 18:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732303AbfHZSNE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:13:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731907AbfHZSND (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Aug 2019 14:13:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7QI1k5R064158;
        Mon, 26 Aug 2019 14:12:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umjn6479y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 14:12:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7QI29ig068067;
        Mon, 26 Aug 2019 14:12:46 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umjn64794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 14:12:46 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7QHxcBI003127;
        Mon, 26 Aug 2019 18:12:45 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 2ujvv6ebcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Aug 2019 18:12:45 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7QICjDc44171598
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Aug 2019 18:12:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19764B2067;
        Mon, 26 Aug 2019 18:12:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF5C4B205F;
        Mon, 26 Aug 2019 18:12:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 26 Aug 2019 18:12:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9308416C65B8; Mon, 26 Aug 2019 11:12:47 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:12:47 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190826181247.GG28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <72c2da8695f622b8962ac43e3571107382969555.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c2da8695f622b8962ac43e3571107382969555.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908260176
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Aug 26, 2019 at 12:49:22PM -0500, Scott Wood wrote:
> On Mon, 2019-08-26 at 09:29 -0700, Paul E. McKenney wrote:
> > On Mon, Aug 26, 2019 at 05:25:23PM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-08-23 23:10:14 [-0400], Joel Fernandes wrote:
> > > > On Fri, Aug 23, 2019 at 02:28:46PM -0500, Scott Wood wrote:
> > > > > On Fri, 2019-08-23 at 18:20 +0200, Sebastian Andrzej Siewior wrote:
> > > > > > this looks like an ugly hack. This sleeping_lock_inc() is used
> > > > > > where we
> > > > > > actually hold a sleeping lock and schedule() which is okay. But
> > > > > > this
> > > > > > would mean we hold a RCU lock and schedule() anyway. Is that okay?
> > > > > 
> > > > > Perhaps the name should be changed, but the concept is the same --
> > > > > RT-
> > > > > specific sleeping which should be considered involuntary for the
> > > > > purpose of
> > > > > debug checks.  Voluntary sleeping is not allowed in an RCU critical
> > > > > section
> > > > > because it will break the critical section on certain flavors of
> > > > > RCU, but
> > > > > that doesn't apply to the flavor used on RT.  Sleeping for a long
> > > > > time in an
> > > > > RCU critical section would also be a bad thing, but that also
> > > > > doesn't apply
> > > > > here.
> > > > 
> > > > I think the name should definitely be changed. At best, it is super
> > > > confusing to
> > > > call it "sleeping_lock" for this scenario. In fact here, you are not
> > > > even
> > > > blocking on a lock.
> > > > 
> > > > Maybe "sleeping_allowed" or some such.
> > > 
> > > The mechanism that is used here may change in future. I just wanted to
> > > make sure that from RCU's side it is okay to schedule here.
> > 
> > Good point.
> > 
> > The effect from RCU's viewpoint will be to split any non-rcu_read_lock()
> > RCU read-side critical section at this point.  This alrady happens in a
> > few places, for example, rcu_note_context_switch() constitutes an RCU
> > quiescent state despite being invoked with interrupts disabled (as is
> > required!).  The __schedule() function just needs to understand (and does
> > understand) that the RCU read-side critical section that would otherwise
> > span that call to rcu_node_context_switch() is split in two by that call.
> > 
> > However, if this was instead an rcu_read_lock() critical section within
> > a PREEMPT=y kernel, then if a schedule() occured within stop_one_task(),
> > RCU would consider that critical section to be preempted.  This means
> > that any RCU grace period that is blocked by this RCU read-side critical
> > section would remain blocked until stop_one_cpu() resumed, returned,
> > and so on until the matching rcu_read_unlock() was reached.  In other
> > words, RCU would consider that RCU read-side critical section to span
> > the call to stop_one_cpu() even if stop_one_cpu() invoked schedule().
> > 
> > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > would split even an rcu_read_lock() critical section.  Which is why I
> > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > complaints in that case.
> 
> migrate_enable() is PREEMPT_RT_BASE-specific -- this code won't execute at
> all with PREEMPT=n.

Understood!  And yes, that was your answer to my question.  Me, I was
just answering Sebastian's question.  ;-)

							Thanx, Paul
