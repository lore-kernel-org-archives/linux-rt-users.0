Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C9C433FE
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 14:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiJFOQl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiJFOQR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 10:16:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD202B276E;
        Thu,  6 Oct 2022 07:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A270B8202F;
        Thu,  6 Oct 2022 14:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D99C433C1;
        Thu,  6 Oct 2022 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665065583;
        bh=yHLPL1u37DocLvg+SfEes2hYtXAS6S7NA+hLKCbZxnc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=arCS1NSYECPWRntFuOe4lgbJGUUks3IngLbdjxANn4kc23aTmaFXd+6ZJbn+6DR45
         4New9u9QcQT/nQeHhiR5W+kZYfuApUoOXdnYBNsCJdIqaEnTj/DQwbJyFCyWkUwnN8
         Ufz9/UmgBo3eJauXu7G6+Qrc2OLdAHEIn5Gr+rYb6S6g4Eedx2hteEJu3BtEIRv6Qp
         uIscMTvs6MbVI9Be3SBs5ukJzUzR9A5tiYdIblgZ7r/w7vFB5+hnrc1ooqlhqB79gR
         ZS4AbjKyZl4IqKZITT4JVoPdEHQjXf6o3Us8TiC3tOwn6llf/IFLWmtuz2KZA5vSo+
         klBH1KVhDZDpw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 96F3D5C0A04; Thu,  6 Oct 2022 07:13:02 -0700 (PDT)
Date:   Thu, 6 Oct 2022 07:13:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        rcu@vger.kernel.org, frederic@kernel.org,
        Florent Carli <fcarli@gmail.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: RCU stall warnings even with rcu_nocbs and rcu_nocb_poll
Message-ID: <20221006141302.GW4196@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <e86930e4-4b9c-cf18-5119-50c6910b76dd@redhat.com>
 <Yz7Yv6d3v3oETZYI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz7Yv6d3v3oETZYI@google.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Oct 06, 2022 at 01:31:43PM +0000, Joel Fernandes wrote:
> On Wed, Oct 05, 2022 at 06:03:39PM +0200, Daniel Bristot de Oliveira wrote:
> > On 10/5/22 18:01, Florent Carli wrote:
> > > Hello,
> > > 
> > > I'm trying to isolate some cores to run a CPU-bound real-time task and
> > > even though I'm using rcu_nocbs and rcu_nocb_poll, I can see the rcuc
> > > threads wake up, and I get RCU stall warnings on the isolated core.
> 
> Isolating a CPU does not mean that RCU activity is forbidden on it, even with
> nohz_full, if the CPU enters the kernel (say syscall or interrupt), then it
> may enter a read-side critical section so RCU will be watching it, and such
> CPU will have to report quiescent state.

What Joel said!

Plus, if you keep that CPU out of the kernel (including avoiding it ever
taking any interrupts), you won't see rcuc activity on that CPU.

> > > As per the documentation, if I use rcutree.kthread_prio with a
> > > priority > my RT task, then the rcu stall does not happen.
> 
> Yes, it sounds like the main RCU GP thread (mostly called rcu_preempt thread)
> in your system is competing with your RT task. Increase kthread_prio is
> standard procedure to resolve this issue, as you did.

Or affinity the rcu_preempt kthread elsewhere so that it is not competing
with your real-time workload.

> > > However I find it confusing: why are the rcuc threads woken up on the
> > > isolated cores despite using rcu_nocbs and rcu_nocb_poll? In my (very
> > > likely erroneous) understanding, I shouldn't have to fiddle with rcu
> > > priority... In other words, how come I get rcu stalls on cores that
> > > have no rcu callbacks?
> 
> It is not possible to provide further help without more info, in particular
> are you using nohz_full and isolcpus options? Can you provide kernel
> and #CPU configuration?
> 
> Happy to look further! Also adding some more folks who know a lot about this
> stuff and +rcu list for archives.

The rcuc kthreads communicate between the corresponding CPU and the
rcu_preempt kthread (AKA RCU GP kthread).  They wake up only when there
is something for them to do, and letting your nohz_full/rcu_nocbs CPUs
execute in the kernel is an excellent way to give them something to do.

In particular, if that CPU runs in the kernel, it might have executed
an RCU read-side critical section.  Because RCU grace periods are not
permitted to complete until all pre-existing RCU read-side critical
sections finish, communication is required.

So, yes, that rcuc kthread will need to execute if its CPU queues an
RCU callback.  But it might also need to execute if some other CPU queues
an RCU callback -and- its CPU spends significant time in the kernel.

							Thanx, Paul

> thanks,
> 
>  - Joel
> 
> > 
> > Adding Joel because we had a chat about it during lpc...
> > 
> > > Thanks.
> > > 
> > -- Daniel
> > 
