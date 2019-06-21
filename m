Return-Path: <SRS0=PqXR=UV=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932DBC43613
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 00:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F1720881
	for <linux-rt-users@archiver.kernel.org>; Sat, 22 Jun 2019 00:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfFVAAo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 21 Jun 2019 20:00:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726049AbfFVAAn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 21 Jun 2019 20:00:43 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5LNpj0s130185;
        Fri, 21 Jun 2019 19:59:55 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t946gtcbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 19:59:55 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5LNsvvm017308;
        Fri, 21 Jun 2019 23:59:54 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01dal.us.ibm.com with ESMTP id 2t8hrnyhfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jun 2019 23:59:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5LNxr1f45285772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:59:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C8782B2064;
        Fri, 21 Jun 2019 23:59:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB063B205F;
        Fri, 21 Jun 2019 23:59:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 21 Jun 2019 23:59:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 30ABF16C2F18; Fri, 21 Jun 2019 16:59:55 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:59:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Scott Wood <swood@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RT 4/4] rcutorture: Avoid problematic critical
 section nesting
Message-ID: <20190621235955.GK26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190619011908.25026-1-swood@redhat.com>
 <20190619011908.25026-5-swood@redhat.com>
 <20190620211826.GX26519@linux.ibm.com>
 <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621163821.rm2rhsnvfo5tnjul@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-21_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906210182
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jun 21, 2019 at 06:38:21PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-06-20 14:18:26 [-0700], Paul E. McKenney wrote:
> > > Example #1:
> > > 
> > > 1. preempt_disable()
> > > 2. local_bh_disable()
> > > 3. preempt_enable()
> > > 4. local_bh_enable()
> > > 
> > > Example #2:
> > > 
> > > 1. rcu_read_lock()
> > > 2. local_irq_disable()
> > > 3. rcu_read_unlock()
> > > 4. local_irq_enable()
> > > 
> > > Example #3:
> > > 
> > > 1. preempt_disable()
> > > 2. local_irq_disable()
> > > 3. preempt_enable()
> > > 4. local_irq_enable()
> > 
> > OK for -rt, but as long as people can code those sequences without getting
> > their wrists slapped, RCU needs to deal with it.  So I cannot accept
> > this in mainline at the current time.  Yes, I will know when it is safe
> > to accept it when rcutorture's virtual wrist gets slapped in mainline.
> 
> All three examples are not symmetrical so if people use this mainline
> then they should get their wrists slapped. Since RT trips over each one
> of those I try to get rid of them if I notice something like that.
> 
> In example #3 you would lose a scheduling event if TIF_NEED_RESCHED gets
> set between step 1 and 2 (as local schedule requirement) because the
> preempt_enable() would trigger schedule() which does not happen due to
> IRQ-off.

I have no objection to the outlawing of a number of these sequences in
mainline, but am rather pointing out that until they really are outlawed
and eliminated, rcutorture must continue to test them in mainline.
Of course, an rcutorture running in -rt should avoid testing things that
break -rt, including these sequences.

							Thanx, Paul
