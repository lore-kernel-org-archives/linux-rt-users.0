Return-Path: <SRS0=I6ff=4W=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6EDC3F2CE
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 00:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2C7214D8
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Mar 2020 00:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583368530;
	bh=A0B6q9mDysJC9CEiJqkKY3U8/e/cX5VhA8cYED9cPmo=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=jwJG5aY4fLPmwxiplNneXXmAopsAjKQ9BHwHm08+u8raONhkx+ncU7WgUrS2IGc46
	 kj5tFyMbCMKl3Tk/cqFaCppNpb4/47PMX2zM+VIiA3UujhCLZ353nFwldmQG5whYX8
	 mb1fY0uSw1J7nuTehEvlOjmlWI0MLlHiaHvN4gKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgCEAf1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:35:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388407AbgCEAf1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Mar 2020 19:35:27 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10DC32084E;
        Thu,  5 Mar 2020 00:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583368527;
        bh=A0B6q9mDysJC9CEiJqkKY3U8/e/cX5VhA8cYED9cPmo=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=h+taKVQbSBRSWDF0Q7aHQcp8F8fFOIlDl/Z3rg1xj7YbDd20n3SHfLCV69O/DdsqK
         dq29DR+6uLzamssXGopylboDp98CoKFzxmnzmxSBDK5cEtugT8L8Juycq/LdLB7Aeo
         7Gu0IS5d+B+0oau7p/h3NUMMuq++Sy3htnj+xfMo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D98743522731; Wed,  4 Mar 2020 16:35:26 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:35:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, bigeasy@linutronix.de, tglx@linutronix.de,
        swood@redhat.com, williams@redhat.com, juri.lelli@redhat.com,
        linux-rt-users@vger.kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org
Subject: RCU use of swait
Message-ID: <20200305003526.GA20601@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello!

RCU makes considerable use of swait and friends.  The motivation I recall
was around offloaded callbacks, where in the old days the grace-period
kthread might do a wakeup for up to N tasks, where N is the number of
CPUs, all with interrupts disabled.  This has since been reduced to
roughly sqrt(N) tasks, which might well still be too many wakeups to do
with interrupts disabled throughout.

However, the other use cases have at most one waiter to be awakened.

So I am guessing that I could usefully convert all but the rcu_node
structure's ->nocb_gp_wq field from swait to wait.  Particularly the
use cases in SRCU and Tiny RCU.

Or is there some other reason why {S,}RCU needs to use swait that I
am forgetting?

							Thanx, Paul
