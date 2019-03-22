Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A853C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 14:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1429320883
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbfCVOth (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:49:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35974 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728827AbfCVOth (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 10:49:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2MEctlW120605
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Mar 2019 10:49:35 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rd16c9w9q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rt-users@vger.kernel.org>; Fri, 22 Mar 2019 10:49:35 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Mar 2019 14:49:31 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Mar 2019 14:49:28 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2MEnUqO17956900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Mar 2019 14:49:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9044BB2065;
        Fri, 22 Mar 2019 14:49:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73258B205F;
        Fri, 22 Mar 2019 14:49:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Mar 2019 14:49:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B913E16C2A5D; Fri, 22 Mar 2019 07:50:22 -0700 (PDT)
Date:   Fri, 22 Mar 2019 07:50:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH RT 4.19] rcutorture: Fix oops when selecting non-default
 torture_type
Reply-To: paulmck@linux.ibm.com
References: <20190322032121.23948-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322032121.23948-1-swood@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032214-0068-0000-0000-000003A9A5CD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010795; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01178063; UDB=6.00616320; IPR=6.00958761;
 MB=3.00026111; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-22 14:49:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032214-0069-0000-0000-000047E71D5E
Message-Id: <20190322145022.GL4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-22_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=928 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903220108
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Mar 21, 2019 at 10:21:21PM -0500, Scott Wood wrote:
> rcu_bh is disabled on PREEMPT_RT via a stub ops that has no name.  Thus,
> if a torture_type other than "rcu" is used, rcu_torture_init() will
> pass NULL to strcmp() when iterating over torture_ops[], and oops.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>

This rcu_bh torture type is gone completely in mainline, however,
I just yesterday queued a patch to fix some problems when an invalid
torture_type was specified.

Mainline 4.19 does have the .name element of rcu_bh_ops specified,
though.  Not sure what happened here, but you are absolutely
correct that rcu_bh_ops does need a .name initializer.

							Thanx, Paul

> ---
> With this applied to 4.19.25-rt16 and specifying torture_type=sched,
> similar rcutorture failures are seen as with 5.0.3-rt1 (in which standard
> torture_cype=rcu no longer has .extendables=0 and thus stresses similar
> paths).
> 
>  kernel/rcu/rcutorture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
> index 7d2a615601e7..408d03048911 100644
> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -479,6 +479,7 @@ static struct rcu_torture_ops rcu_bh_ops = {
>  #else
>  static struct rcu_torture_ops rcu_bh_ops = {
>  	.ttype		= INVALID_RCU_FLAVOR,
> +	.name		= "rcu_bh"
>  };
>  #endif
> 
> -- 
> 2.18.1
> 

