Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D378BC433B4
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 May 2021 08:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B906613FC
	for <linux-rt-users@archiver.kernel.org>; Sat, 15 May 2021 08:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhEOIiW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 15 May 2021 04:38:22 -0400
Received: from mout.gmx.net ([212.227.17.21]:50595 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhEOIiV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 15 May 2021 04:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621067782;
        bh=63KxS4mqnuOPyJ6F4sl+aqr2F0EgHsdc7QMN4zX55+I=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=PlSh/BN/ZtoETMjeCjp65B6XG85XDxgtFEIk3R2XIsTtIO2BkeI0BoSZ1w/4rRAau
         kCAgkM8Urx7DHlQ5TvB5vMv3In7OQ+hawa5XrdRb4FWaYxVfiDW0HYOgFCpNZMVwuv
         e9B0ZkNGS6bUGSag435cRupSrzNmlXNg/g1yuMB8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.221]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1lZ08z3ZUe-00zpLp; Sat, 15
 May 2021 10:36:21 +0200
Message-ID: <752d89013a703a2a4bd32b4be196e84a9065b060.camel@gmx.de>
Subject: Re: [PATCH v2 3/3] sched/fair: break out of newidle balancing if an
 RT task appears
From:   Mike Galbraith <efault@gmx.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 15 May 2021 10:36:19 +0200
In-Reply-To: <284735cfa1b23484cb0aaeb896067cbf888ac6af.camel@gmx.de>
References: <20210428232821.2506201-1-swood@redhat.com>
         <20210428232821.2506201-4-swood@redhat.com>
         <YJUecEMZNDfD1Z4K@hirez.programming.kicks-ass.net>
         <284735cfa1b23484cb0aaeb896067cbf888ac6af.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n/WeMyrUVHimaca42rioNVkS6DTf6uaK+5xkEwJRspkEC/Z9vGt
 RWK7BjqJZW4K3IAfsxtj4H/BtqKS0eM7PYHYsYknE+Z2TgwHVqhcPAmIue25GbRjBK8vgNW
 rLF4ss3ofvSD1SVfrkltOQz0tCAIn7XM1YiMtDcLSCohboFOrFbzd/9K6RBaLkIZMUmxGGu
 vtCHYAchzDb89SQoLKBow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+LoyvyClCZE=:wykXHgLFUyOl2MkUv4naq5
 vKr9SKFIdmKZIUdr2s5FbpdT3A7ZeefPN+nCrPldk8q7NwCSHBpwW0LT/VdhRGba3GR8WYxY+
 6Q4sgJVBYd3Dzcm2NhMhp/7W3S/l94fz1IVJGJfZUIlKzI6TBekyCSikCube5lLsaIVbohqhh
 bw5R0g7bLYwrYyUilJq1LX3Ux3/nqpI23+X2lBcLu72m4luYkng6+5EBHwQ0LE74y1+Kl15lI
 +0uIJbxN9ZSPH4a8A8NNxzYc9mSALvfmgucPJM09uMtf5v8fWTMS80jaDaZGbT7VOGg/p9P/1
 0ADiji5tn8VghskC9q513VMm8UCFMnUq6OPb1Q9LmWIPdZr1lzonn3jdorj1bFmvLIBF0Cn0F
 V9ssT/+KGNOM/FUTb1Qh0I5ZNpiPBkMjSpEfcMsqT5dBcEbAaJV7o2fydnZmaszko0UKtI7aM
 duFHWIEj5Zc6StcjQkdeu/HuRvW/afgr0fwWuhJoBf5TMfmhX22VqaLSxYbHN1bTouahLjA8c
 54I1f163eY1H+6xgB/+bC4C9Ur27btJRoIBFY+h7csnQ9PjampRcF8EHwbyBGujLegeZok899
 m30SOzN2OHwL5iZWyIyPLCKXko+nT3zLGJQqYYx1ja0A3hzr0QDTCkkffWtvAvF0q3osSlAAg
 NH/bkbOkIYmKFanlSncUA7l5sYSFbq4oaI5bHb0DCByitMQInNzc5v/xFUqJDPXXup45nS75u
 NgCYUX69RMiewrjN4QkSNmgXqc/XKH9lL6IeWxZZm1tSSV5Xt6Gjtv/WuCmvvhN1oQgorLbLc
 9KseCJSxtsNLP1mNMOFLtwjZalCXgXdf8u82mF6EMMn4Mix8MhoDrqRWz/r/yWH8tY9sYBhdL
 oMstucWcWUWL6cNG2Mqye1kNq4L8UTMgwDRquSip52xvhyc4UU7BB2CdOr7yQEguw+/JlDitN
 LtCTEmD4QDaKH2+sPK0TDepNtn98CGDcg32Ka+xJMka9FEEx8pqi+yt0Bs8eAgDcPduzekwYX
 9vDJGyqFZBFZQkUOJTdDSm6ibvHYrIVh+biPYzdVZFMyBDifTpz3IWrU3//WTp8pcuIpgWGZh
 dPBt3S4lp8wdlQqtfWsqSFfD8l60FJxvGGx/pVAO6/f2DXLOt6vnpLDBwfUwM8ognHGaHTJPg
 njYKfd9phRbHWCO63fBbTnu38/oZ2ZdeEpk9KGfdUzLnCe9DevD6eWfpLHPBKLB4ivREU=
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

P.S. The largest I spotted before boredom won:

     kworker/3:1-22161   [003] d...2.. 11559.111261: load_balance: NEWIDLE rq:4 lock acquired
     kworker/0:0-21137   [000] d...1.. 11559.111262: load_balance: NEWIDLE rq:4 locked - aborting
     kworker/7:1-20870   [007] d...1.. 11559.111262: load_balance: NEWIDLE rq:4 locked - aborting
           <...>-22133   [002] d...1.. 11559.111263: load_balance: NEWIDLE rq:4 locked - aborting
     kworker/6:1-22213   [006] d...1.. 11559.111263: load_balance: NEWIDLE rq:4 locked - aborting

5/8 of a 128 rq box meeting like that is.. hopefully impossible :)

	-Mike

