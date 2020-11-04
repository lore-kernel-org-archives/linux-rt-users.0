Return-Path: <SRS0=gcb+=EK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56D1C388F9
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 16:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB8C20786
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Nov 2020 16:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgKDQGz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:06:55 -0500
Received: from mail.monom.org ([188.138.9.77]:36944 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727070AbgKDQGz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Nov 2020 11:06:55 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id C9F24500609;
        Wed,  4 Nov 2020 17:06:51 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 3F848500596;
        Wed,  4 Nov 2020 17:06:51 +0100 (CET)
Date:   Wed, 4 Nov 2020 17:06:50 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.10-rc2-rt4
Message-ID: <20201104160650.b63zqof74wohgpa2@beryllium.lan>
References: <20201103195731.erjkgyzxzzjylhui@linutronix.de>
 <20201104103809.bhl2iorbwv6xowtw@beryllium.lan>
 <20201104104617.ueefmpdou4t3t2ce@linutronix.de>
 <20201104111948.vpykh3ptmysqhmve@beryllium.lan>
 <20201104124746.74jdsig3dffomv3k@beryllium.lan>
 <20201104130930.llx56gtqt532h7c7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104130930.llx56gtqt532h7c7@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 04, 2020 at 02:09:30PM +0100, Sebastian Andrzej Siewior wrote:
> Could you figure out if the arm64 thingy started with -rt4 or was
> already in rt3?

I wrote a quick and dirty script to extract the data from my logs to see
if the regression might be older then I remembered. I filtered out the
obviously wrong configured runs (e.g !RT). It looks like the first
recorded outlier is around 5.9.0-rt16. Does this already help or do you
want me to bissect it down?

rpi3    signaltest      5.4.59-rt36
  382   0_signaltest         t0-max-latency      : fail     220.00
  382   0_signaltest         t0-avg-latency      : pass      47.00
  382   0_signaltest         t0-min-latency      : pass      20.00
rpi3    signaltest      5.6.19-rt12
  368   0_signaltest         t0-max-latency      : fail     221.00
  368   0_signaltest         t0-avg-latency      : pass      45.00
  368   0_signaltest         t0-min-latency      : pass      21.00
rpi3    signaltest      5.9.0-rc8-rt12
  813   0_signaltest         t0-max-latency      : fail     214.00
  813   0_signaltest         t0-avg-latency      : pass      45.00
  813   0_signaltest         t0-min-latency      : pass      20.00
rpi3    signaltest      5.9.0-rc8-rt12
  874   0_signaltest         t0-max-latency      : fail     217.00
  874   0_signaltest         t0-avg-latency      : pass      45.00
  874   0_signaltest         t0-min-latency      : pass      20.00
rpi3    signaltest      5.9.0-rt16
  963   0_signaltest         t0-max-latency      : fail     321.00
  963   0_signaltest         t0-avg-latency      : pass      47.00
  963   0_signaltest         t0-min-latency      : pass      21.00
rpi3    signaltest      5.9.1-rt19
  1038  0_signaltest         t0-max-latency      : fail     341.00
  1038  0_signaltest         t0-avg-latency      : pass      46.00
  1038  0_signaltest         t0-min-latency      : pass      20.00
rpi3    signaltest      5.9.1-rt20
  1079  0_signaltest         t0-max-latency      : fail     318.00
  1079  0_signaltest         t0-avg-latency      : pass      47.00
  1079  0_signaltest         t0-min-latency      : pass      21.00
rpi3    signaltest      5.10.0-rc1-rt1
  1118  0_signaltest         t0-max-latency      : fail     415.00
  1118  0_signaltest         t0-avg-latency      : pass      53.00
  1118  0_signaltest         t0-min-latency      : pass      23.00
rpi3    signaltest      5.10.0-rc2-rt4
  1163  0_signaltest         t0-max-latency      : fail     340.00
  1163  0_signaltest         t0-avg-latency      : pass      53.00
  1163  0_signaltest         t0-min-latency      : pass      24.00
