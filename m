From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Interrupt Bottom Half Scheduling
Date: Mon, 14 Feb 2011 14:31:43 -0800
Message-ID: <AANLkTimGobdGMgnc8bVJTvYtH4Tjn2ZVmroeFA2s06WD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37058 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1BNWbo (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 14 Feb 2011 17:31:44 -0500
Received: by yxt3 with SMTP id 3so2284898yxt.19
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2011 14:31:43 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

How is the scheduling of the hrtimers softirq thread handled?

When querying the RT priority of the hrtimer softirq, I get a priority
of 50.  But when running a priority 99 thread, we still seem to be
getting interrupted.  Shouldn't the hrtimer softirq be put off until
the CPU is idle or a lower priority task is running?

Thanks,
Pete
