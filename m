Return-Path: <SRS0=q9Sf=WY=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC66C3A5A1
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 15:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630DD217F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Aug 2019 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567007473;
	bh=Mll0WVt6jM+M6zS23ifxtclyC0dFeBkrDlP645wA0/M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Mi8lH/HfU7M/X62cIvLsR/B45dY8eMsGJwrtTDvet7CxfAQ27r51mB/k/tvq18mGM
	 8mloWn4vg2LC1kIjCqdBlyujbipaT3CfubAdd7Ir8Gbv+EcTm7adXpNrOoaB8/BWow
	 3Gcp88dqIngtSZpN5VbMVaKPYuYUcwcdZc4BIM1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfH1PvI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:51:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53508 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726428AbfH1PvI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Aug 2019 11:51:08 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SFmRT8159062;
        Wed, 28 Aug 2019 11:50:59 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmw551x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:50:57 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7SFmtNR160669;
        Wed, 28 Aug 2019 11:50:43 -0400
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2umnmw54un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:50:42 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7SFjLa7003562;
        Wed, 28 Aug 2019 15:50:27 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03wdc.us.ibm.com with ESMTP id 2ujvv6psb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 15:50:27 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SFoRKx53543348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 15:50:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D6F0B2064;
        Wed, 28 Aug 2019 15:50:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A4DCB2066;
        Wed, 28 Aug 2019 15:50:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 15:50:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7BD2B16C65E3; Wed, 28 Aug 2019 08:50:28 -0700 (PDT)
Date:   Wed, 28 Aug 2019 08:50:28 -0700
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
Message-ID: <20190828155028.GP26530@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190823162024.47t7br6ecfclzgkw@linutronix.de>
 <433936e4c720e6b81f9b297fefaa592fd8a961ad.camel@redhat.com>
 <20190824031014.GB2731@google.com>
 <20190826152523.dcjbsgyyir4zjdol@linutronix.de>
 <20190826162945.GE28441@linux.ibm.com>
 <20190827092333.jp3darw7teyyw67g@linutronix.de>
 <20190827155306.GF26530@linux.ibm.com>
 <20190828092739.46mrffvzjv6v3de5@linutronix.de>
 <20190828125426.GO26530@linux.ibm.com>
 <20190828131433.3gi4debho5zc7hgc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828131433.3gi4debho5zc7hgc@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=764 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280160
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 28, 2019 at 03:14:33PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-08-28 05:54:26 [-0700], Paul E. McKenney wrote:
> > On Wed, Aug 28, 2019 at 11:27:39AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2019-08-27 08:53:06 [-0700], Paul E. McKenney wrote:
> > > > Am I understanding this correctly?
> > > 
> > > Everything perfect except that it is not lockdep complaining but the
> > > WARN_ON_ONCE() in rcu_note_context_switch().
> > 
> > This one, right?
> > 
> > 	WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0);
> > 
> > Another approach would be to change that WARN_ON_ONCE().  This fix might
> > be too extreme, as it would suppress other issues:
> > 
> > 	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_RT_BASE) && !preempt && t->rcu_read_lock_nesting > 0);
> > 
> > But maybe what is happening under the covers is that preempt is being
> > set when sleeping on a spinlock.  Is that the case?
> 
> I would like to keep that check and that is why we have:
> 
> |   #if defined(CONFIG_PREEMPT_RT_FULL)
> |         sleeping_l = t->sleeping_lock;
> |   #endif
> |         WARN_ON_ONCE(!preempt && t->rcu_read_lock_nesting > 0 && !sleeping_l);
> 
> in -RT and ->sleeping_lock is that counter that is incremented in
> spin_lock(). And the only reason why sleeping_lock_inc() was used in the
> patch was to disable _this_ warning.

Very good!  I would prefer an (one-line) access function to keep the
number of #if uses down to dull roar, but other than that, looks good!

(Yeah, I know, this is tree_preempt.h, but still...)

							Thanx, Paul
