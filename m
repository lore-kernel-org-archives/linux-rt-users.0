Return-Path: <SRS0=LljW=DT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C84CC43457
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 09:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACA520776
	for <linux-rt-users@archiver.kernel.org>; Mon, 12 Oct 2020 09:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgJLJhY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 12 Oct 2020 05:37:24 -0400
Received: from mail.monom.org ([188.138.9.77]:46608 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729414AbgJLJhY (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Oct 2020 05:37:24 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 48DD05005E8;
        Mon, 12 Oct 2020 11:37:22 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id DD935500103;
        Mon, 12 Oct 2020 11:37:21 +0200 (CEST)
Date:   Mon, 12 Oct 2020 11:37:21 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.9-rc8-rt14
Message-ID: <20201012093721.xdgqk5sq5jqslmoh@beryllium.lan>
References: <20201009220146.tubrqcdbzg3opqtc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009220146.tubrqcdbzg3opqtc@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Sebastian,

On Sat, Oct 10, 2020 at 12:01:46AM +0200, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v5.9-rc8-rt14 patch set. 
> 
> Changes since v5.9-rc8-rt13:

FWIW, all my tests passed.

Thanks,
Daniel

ps: this time I didn't do the same mistake...
