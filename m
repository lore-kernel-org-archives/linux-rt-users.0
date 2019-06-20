Return-Path: <SRS0=3DPx=UT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9308EC43613
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 22:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D7D72070B
	for <linux-rt-users@archiver.kernel.org>; Thu, 20 Jun 2019 22:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfFTWQM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 20 Jun 2019 18:16:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725906AbfFTWQL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 20 Jun 2019 18:16:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KM2vhp128720
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 18:16:10 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8hte1yfd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Thu, 20 Jun 2019 18:16:10 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 20 Jun 2019 23:16:09 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Jun 2019 23:16:06 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5KMG5Wo31326664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jun 2019 22:16:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52333B20B7;
        Thu, 20 Jun 2019 22:16:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35176B20B4;
        Thu, 20 Jun 2019 22:16:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Jun 2019 22:16:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 450B216C6AC7; Thu, 20 Jun 2019 15:16:07 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:16:07 -0700
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
 <20190620212035.GY26519@linux.ibm.com>
 <8bcc818b1b08850e109d1cde529ab98c4ed788df.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcc818b1b08850e109d1cde529ab98c4ed788df.camel@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19062022-2213-0000-0000-000003A23447
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011299; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220888; UDB=6.00642287; IPR=6.01002027;
 MB=3.00027398; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 22:16:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062022-2214-0000-0000-00005EEEB679
Message-Id: <20190620221607.GA26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906200158
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Jun 20, 2019 at 04:38:47PM -0500, Scott Wood wrote:
> On Thu, 2019-06-20 at 14:20 -0700, Paul E. McKenney wrote:
> > On Thu, Jun 20, 2019 at 04:06:02PM -0500, Scott Wood wrote:
> > > On Thu, 2019-06-20 at 13:53 -0700, Paul E. McKenney wrote:
> > > > And I have to ask...
> > > > 
> > > > What did you do to test this change to kernel/softirq.c?  My past
> > > > attempts
> > > > to do this sort of thing have always run afoul of open-coded BH
> > > > transitions.
> > > 
> > > Mostly rcutorture and loads such as kernel builds, on a debug
> > > kernel.  By
> > > "open-coded BH transition" do you mean directly manipulating the preempt
> > > count?  That would already be broken on RT.
> > 
> > OK, then maybe you guys have already done the needed cleanup work.  Cool!
> 
> Do you remember what code was doing such things?  Grepping for the obvious
> things doesn't turn up anything outside the softirq code, even in the
> earlier non-RT kernels I checked.

It was many years ago, and it is quite possible that I am conflating
irqs with bh or some such.  If it now works, it now works.

> > But don't the additions of rcu_read_lock() and rcu_read_unlock() want
> > to be protected by "!IS_ENABLED(CONFIG_PREEMPT_RT_FULL)" or similar?
> 
> This is already a separate PREEMPT_RT_FULL-specific implementation.

Ah, sorry for the noise, then!

							Thanx, Paul

