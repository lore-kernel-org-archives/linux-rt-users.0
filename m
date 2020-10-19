Return-Path: <SRS0=qep6=D2=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8820AC433E7
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 10:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3647522263
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Oct 2020 10:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbgJSKxf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Oct 2020 06:53:35 -0400
Received: from mailout05.rmx.de ([94.199.90.90]:55943 "EHLO mailout05.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgJSKxf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Oct 2020 06:53:35 -0400
X-Greylist: delayed 1919 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2020 06:53:34 EDT
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout05.rmx.de (Postfix) with ESMTPS id 4CFCTm6QzMz9yVq;
        Mon, 19 Oct 2020 12:21:32 +0200 (CEST)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4CFCTQ21kpz2xqM;
        Mon, 19 Oct 2020 12:21:14 +0200 (CEST)
Received: from n95hx1g2.localnet (192.168.54.91) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 19 Oct
 2020 12:21:07 +0200
From:   Christian Eggers <ceggers@arri.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Peter Zijlstra <peterz@infradead.org>, <tglx@linutronix.de>,
        <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: sched: system doesn't boot since  "sched: Add new migrate_disable() implementation"
Date:   Mon, 19 Oct 2020 12:21:06 +0200
Message-ID: <1654655.1jrfHnk7pZ@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.91]
X-RMX-ID: 20201019-122118-4CFCTQ21kpz2xqM-0@kdin01
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I have problems with the latest 5.9-rt releases on i.MX6ULL (!CONFIG_SMP):

-rc8-rt13 works fine
-rc8-rt14 doesn't compile (due to CONFIG_FRACE, already fixed in -rt16)
-rt15 dito.
-rt16 compiles, but doesn't boot (no console output at all)

After reverting (on -rt16)

de1c0755e6f9 ("tracing: fix compile failure on RT with PREEMPT_RT off")
30763ce6c15d ("sched: Add new migrate_disable() implementation")

the system boots fine again.

Tracking the problem down showed that calls to wait_for_completion_timeout() 
(e.g. during imx_rngc_probe) will never return. The IRQ routine which should 
fire the completion is not executed, and the call doesn't return after the 
timeout. The IRQ flag on the ARM is not set before entering 
wait_for_completion_timeout(), so CPU interrupts seem to be on.

When building with CONFIG_SMP, the system boots fine.

Any hints?

Best regards
Christian



