Return-Path: <SRS0=q9Sf=WY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BE2C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 12:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE00822CF5
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566996884;
	bh=/nqD0ViqaewNMKLDngfbrf5k41yE/1O2IaWRem8dmLw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gWFWSMaNkuXo3LU0K5KfUdy4jL6pHh3/jv6s/i1ck7J3//GbVTPuSRZh5WKjcKEUV
	 A3Men1rm3b1sgwsodr1cxS4VWxgW4N5xfXeoOjibji8y55zN1nE/mRViCNp9f4Sw9J
	 kqFGcpRLP+SZUDXC7uXoifW/MBSrKgYUEvJ9g5HU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1Myk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:54:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726368AbfH1Myk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Aug 2019 08:54:40 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SCqvWG084245;
        Wed, 28 Aug 2019 08:54:29 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unqr3wq1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 08:54:29 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SCrx01087890;
        Wed, 28 Aug 2019 08:54:28 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2unqr3wq0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 08:54:28 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SCnmOH004111;
        Wed, 28 Aug 2019 12:54:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma02dal.us.ibm.com with ESMTP id 2un65jybhe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 12:54:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SCsQRp15270712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 12:54:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E57CB2064;
        Wed, 28 Aug 2019 12:54:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C909B205F;
        Wed, 28 Aug 2019 12:54:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.209.133])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 12:54:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D011416C15A4; Wed, 28 Aug 2019 05:54:26 -0700 (PDT)
Date:   Wed, 28 Aug 2019 05:54:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190828125426.GO26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190821231906.4224-1-swood@redhat.com>
 <20190821231906.4224-3-swood@redhat.com>
 <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
 <20190828092739.46mrffvzjv6v3de5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828092739.46mrffvzjv6v3de5@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280138
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 28, 2019 at 11:27:39AM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > > On the other hand, within a PREEMPT=n kernel, the call to schedule()
> > > > would split even an rcu_read_lock() critical section.  Which is why I
> > > > asked earlier if sleeping_lock_inc() and sleeping_lock_dec() are no-ops
> > > > in !PREEMPT_RT_BASE kernels.  We would after all want the usual lockdep
> > > > complaints in that case.
> > > 
> > > sleeping_lock_inc() +dec() is only RT specific. It is part of RT's
> > > spin_lock() implementation and used by RCU (rcu_note_context_switch())
> > > to not complain if invoked within a critical section.
> > 
> > Then this is being called when we have something like this, correct?
> > 
> > 	DEFINE_SPINLOCK(mylock); // As opposed to DEFINE_RAW_SPINLOCK().
> > 
> > 	...
> > 
> > 	rcu_read_lock();
> > 	do_something();
> > 	spin_lock(&mylock); // Can block in -rt, thus needs sleeping_lock_inc()
> > 	...
> > 	rcu_read_unlock();
> > 
> > Without sleeping_lock_inc(), lockdep would complain about a voluntary
> > schedule within an RCU read-side critical section.  But in -rt, voluntary
> > schedules due to sleeping on a "spinlock" are OK.
> > 
> > Am I understanding this correctly?
> 
> Everything perfect except that it is not lockdep complaining but the
> WARN_ON_ONCE() in rcu_note_context_switch().

This one, right?

	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);

Another approach would be to change that WARN_ON_ONCE().  This fix might
be too extreme, as it would suppress other issues:

	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);

But maybe what is happening under the covers is that preempt is being
set when sleeping on a spinlock.  Is that the case?

							Thanx, Paul
