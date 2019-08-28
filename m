Return-Path: <SRS0=q9Sf=WY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3395C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 15:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FDF7208CB
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567007512;
	bh=G0VsCP8dbOtgyqj9srK7YmA1XEAwzErVOoPM9ccmKLY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lwGwTrbY46JKmGgU+i69O7ZX6+4KBbbe7sTMpaC7pZefdLbI82Y6Pun/g5Dgmu0Td
	 Zv+ZmpC7Dv+vf2qVuZwWdB2qnRZ3JRyZ0JMeKr/bNxeB0p3hwOOdCXuA3PiZ8g7klC
	 a+LG8tAPyGxw2T45u3mpyIwUODwlUNp0NtegQ2tM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfH1Pvs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:51:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9112 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbfH1Pvs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Aug 2019 11:51:48 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SFmU3G159123;
        Wed, 28 Aug 2019 11:51:41 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmw55vf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:51:41 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SFmWc9159537;
        Wed, 28 Aug 2019 11:51:31 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmw55ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:51:30 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SFolWA014163;
        Wed, 28 Aug 2019 15:51:19 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 2ujvv6pr56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 15:51:19 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SFpJ5t52298036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 15:51:19 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EC2FB2064;
        Wed, 28 Aug 2019 15:51:19 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E55D5B205F;
        Wed, 28 Aug 2019 15:51:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 15:51:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6281216C1700; Wed, 28 Aug 2019 08:51:20 -0700 (PDT)
Date:   Wed, 28 Aug 2019 08:51:20 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH RT v2 2/3] sched: migrate_enable: Use sleeping_lock to
 indicate involuntary sleep
Message-ID: <20190828155120.GQ26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
 <20190828092739.46mrffvzjv6v3de5@linutronix.de>
 <20190828125426.GO26530@linux.ibm.com>
 <20190828131433.3gi4debho5zc7hgc@linutronix.de>
 <20190828135938.GA230957@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828135938.GA230957@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280160
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 28, 2019 at 09:59:38AM -0400, Joel Fernandes wrote:
> On Wed, Aug 28, 2019 at 03:14:33PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2019-08-28 05:54:26 [-0700], Paul E. McKenney wrote:
> > > On Wed, Aug 28, 2019 at 11:27:39AM +0200, Sebastian Andrzej Siewior wrote:
> > > > On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > > > Am I understanding this correctly?
> > > > 
> > > > Everything perfect except that it is not lockdep complaining but the
> > > > WARN_ON_ONCE() in rcu_note_context_switch().
> > > 
> > > This one, right?
> > > 
> > > 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
> > > 
> > > Another approach would be to change that WARN_ON_ONCE().  This fix might
> > > be too extreme, as it would suppress other issues:
> > > 
> > > 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);
> > > 
> > > But maybe what is happening under the covers is that preempt is being
> > > set when sleeping on a spinlock.  Is that the case?
> > 
> > I would like to keep that check and that is why we have:
> > 
> > |   #if defined(CONFIG_PREEMPT_RT_FULL)
> > |         sleeping_l = t->sleeping_lock;
> > |   #endif
> > |         WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
> > 
> > in -RT and ->sleeping_lock is that counter that is incremented in
> > spin_lock(). And the only reason why sleeping_lock_inc() was used in the
> > patch was to disable _this_ warning.
> 
> Makes sense, Sebastian.
> 
> Paul, you meant "!" in front of the IS_ENABLED right in your code snippet right?
> 
> The other issue with:
> WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);
> 
> .. could be that, the warning will be disabled for -rt entirely, not just for
> sleeping locks. And we probably do want to keep this warning for the cases in
> -rt where we are blocking but it is not a sleeping lock. Right?

Yes, my code was missing a "!", but I prefer Sebastian's and Scott's
approach to mine anyway.  ;-)

							Thanx, Paul
