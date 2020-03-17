Return-Path: <SRS0=iQLd=5C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B7C10F29
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 12:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD922073C
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 12:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgCQMIT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:08:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54351 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgCQMIT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Mar 2020 08:08:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jEB17-0000HH-5Q; Tue, 17 Mar 2020 13:08:17 +0100
Date:   Tue, 17 Mar 2020 13:08:17 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marouen Ghodhbane <marouen.ghodhbane@nxp.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: complete_all warning with 3 waiters
Message-ID: <20200317120817.zm3a2zr4bsvpcbsn@linutronix.de>
References: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-03-11 16:32:03 [+0000], Marouen Ghodhbane wrote:
> Hello everyone,
Hi,

> In fact, there is 3 sdma controller devices on the target pointing to
> the same firmware file and the imx-sdma driver is requesting the
> firmware asynchronously with request_firmware_nowait(). The
> request_firmware API in linux is making all waiters, requesting the
> same firmware file, wait on the same completion which triggers this
> warning.

This looks like something that happens at boot / hardware setup time and
not while the system is running "production". Thanks for the feedback.

> Any idea/suggestion is definitely appreciated

I've been interested in cases which can stack up beyond 2 and can be
triggered by users because these may influence the RT workload.
The pm-case has been filtered out because nobody should do RT a workload
while PM is going up and down. The report I got was in the init-phase of
crypto which does not trigger usually and shouldn't trigger at run-time
once everything is set up.
Feel free to raise the bar here to avoid the warning in your case here.
I'm currently thinking about removing the warning due to lack of new
cases.

> Best Regards,
> Marouen.

Sebastian
