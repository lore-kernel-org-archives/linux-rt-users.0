Return-Path: <SRS0=aYAi=XS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C3BC4CECF
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378B820882
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 18:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfIWSgJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:36:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfIWSgJ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Sep 2019 14:36:09 -0400
Received: from pd9ef19d4.dip0.t-ipconnect.de ([217.239.25.212] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iCTBt-0003Wu-Jh; Mon, 23 Sep 2019 20:36:05 +0200
Date:   Mon, 23 Sep 2019 20:36:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] posix-timers: Unlock expiry lock in the early
 return
In-Reply-To: <20190923160141.oqsv7vwhw5pof6f2@linutronix.de>
Message-ID: <alpine.DEB.2.21.1909232035530.1934@nanos.tec.linutronix.de>
References: <20190923160141.oqsv7vwhw5pof6f2@linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 23 Sep 2019, Sebastian Andrzej Siewior wrote:

> Patch ("posix-timers: Add expiry lock") acquired a lock in
> run_posix_cpu_timers() but didn't drop the lock in the early return.
> 
> Unlock the lock in the early return path.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
