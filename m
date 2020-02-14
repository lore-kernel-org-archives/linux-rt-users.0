Return-Path: <SRS0=/68O=4C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC58C2BA83
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C821C2168B
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 Feb 2020 13:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgBNNnB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:43:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54616 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgBNNnB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 Feb 2020 08:43:01 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j2bFD-0006BL-5G; Fri, 14 Feb 2020 14:42:59 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Sebastien Fabre <sebastien.fabre@sigfox.com>,
        "linux-rt-users\@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Crash tool issue since printk re-implementation
References: <PR2PR08MB4681072153BF9E79416BD305951B0@PR2PR08MB4681.eurprd08.prod.outlook.com>
        <20200214123431.rsgw62fftclifs3l@linutronix.de>
Date:   Fri, 14 Feb 2020 14:42:57 +0100
In-Reply-To: <20200214123431.rsgw62fftclifs3l@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Fri, 14 Feb 2020 13:34:31 +0100")
Message-ID: <874kvtffoe.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-02-14, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2020-02-12 12:10:23 [+0000], Sebastien Fabre wrote:
>> Since kernel v5.0, PREEMPT_RT patches contain printk
>> re-implementation. This re-implementation removes some log symbols in
>> VMCOREINFO and crash tool cannot retrieve kernel logs (because
>> symbols no more exist).  Is this impact on crash expected? If so, how
>> can we retrieve a functional crash tool with kernel v5.0 (and
>> following) ?
>
> It is known, yes. I'm aware of crash and the gdb scritps should also
> suffer from this. 

Perhaps this should be listed under the "Known issues" of the PREEMPT_RT
release announcements.

John Ogness
