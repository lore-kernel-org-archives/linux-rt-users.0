Return-Path: <SRS0=AM/X=2C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D83CC43603
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F008205C9
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Dec 2019 17:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbfLLRMe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:12:34 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbfLLRMc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Dec 2019 12:12:32 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ifS0t-0007Ie-1O; Thu, 12 Dec 2019 18:12:31 +0100
Date:   Thu, 12 Dec 2019 18:12:30 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Mathew <john.mathew@unikie.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: complete_all() with x waiters in swake_up_all_locked
Message-ID: <20191212171230.ygveclhr5xqurys7@linutronix.de>
References: <CAJz2qXnHnw7Z9ftb6Oha5_0-R4YfUL+FhVZPNX1KKHyUkP6KNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJz2qXnHnw7Z9ftb6Oha5_0-R4YfUL+FhVZPNX1KKHyUkP6KNA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-12-11 09:17:49 [+0200], John Mathew wrote:
> Hi,
Hi,

> We are seeing the waring still appearing in the v5.0.3-rt1 tag of the
> rt linux kernel.

I didn't managed to reproduce it at the time. Now you say it works with
5.0-RT. I will try to give it a spin with the latest RT sometime next
week.

> 
> Has there been any further investigation in to this warning following
> the previous discussion?

Thanks for report. I didn't manage to reproduce it so no. The actual
problem is that we are trying to figure out what a sane limit for
complete_all() might be. Most users of complete_all() have one two
waiters. Based on that report your max was 8 and that occurred a few
times.

> -John

Sebastian
