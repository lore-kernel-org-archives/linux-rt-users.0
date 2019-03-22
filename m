Return-Path: <SRS0=2PTS=RZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4857AC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 09:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202E3206B7
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Mar 2019 09:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfCVJWt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:22:49 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40488 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVJWt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Mar 2019 05:22:49 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h7GNx-00077P-1Y; Fri, 22 Mar 2019 10:22:45 +0100
Date:   Fri, 22 Mar 2019 10:22:44 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Scott Wood <swood@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Juri Lelli <juri.lelli@redhat.com>, anna-maria@linutronix.de,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 4.19] rcutorture: Fix oops when selecting non-default
 torture_type
Message-ID: <20190322092244.4nthhso5onp426zy@linutronix.de>
References: <20190322032121.23948-1-swood@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190322032121.23948-1-swood@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-21 22:21:21 [-0500], Scott Wood wrote:
> rcu_bh is disabled on PREEMPT_RT via a stub ops that has no name.  Thus,
> if a torture_type other than "rcu" is used, rcu_torture_init() will
> pass NULL to strcmp() when iterating over torture_ops[], and oops.
> 
> Signed-off-by: Scott Wood <swood@redhat.com>
> ---
> With this applied to 4.19.25-rt16 and specifying torture_type=sched,
> similar rcutorture failures are seen as with 5.0.3-rt1 (in which standard
> torture_cype=rcu no longer has .extendables=0 and thus stresses similar
> paths).

Anna-Maria was talking about this to me a long time ago, I though we
fixed that. But since your patch targets v4.19 it is not the case.
As far v4.19 goes, I think it can go in but this is up to Steven now.

Does this still apply to 5.0-RT? The RCU was greatly reworked so it may
no longer apply and just work. However the "random context" in
rcutorture gives me a headache right now…

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

Sebastian
