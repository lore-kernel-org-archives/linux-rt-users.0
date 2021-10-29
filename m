Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3067C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 11:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08186115B
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 11:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhJ2LPE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:15:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54386 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhJ2LPD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 07:15:03 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635505954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRQonRnJ4JIIOkFNIVqiRhv4kbr2xVNea/DEIga/8C8=;
        b=dVj+rDlYEB7FssceKcPAVu1jX8lyLP+iyjFNzjO/0nj3DPpIvrRYWFCmBdADejcPRHP6UZ
        f2Rjl4hWv2Fe3BZN9bDF7BeRq4XYAO0OPgx9oKQ4aUAu+Ymo83gFmDBuXxAVRXApfnZf8x
        ils/A33dxdTVwmpk/anwSzBb9fybSsdl+deaa5bi1FVX1buwFoIplAF47A7XwcvsTKvuMz
        tCNFpWFQqTx/ozIWLzX1OlBeUGfHysrrzfNsZFMEdgl9rYc2xG4IOtzrbiExfERodg9qGW
        Dw5V5Jaj4rsLvT2WhNyAxwSTepUBb5T0kOld68WY9EWgcQ5jLwRwr95PhRDjrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635505954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HRQonRnJ4JIIOkFNIVqiRhv4kbr2xVNea/DEIga/8C8=;
        b=Ab4t4SHK28adMBRmlFoo9Wj+Kuh+dZycJvPhwowxFGeKRkK7laZdnE1mtIgZB72XWoo+a3
        i/rVpSJgCkmVtaCg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] printk's sync mode for ftrace_dump()
In-Reply-To: <20211029102603.4qp4g5bzuydrbkrx@linutronix.de>
References: <20211029102603.4qp4g5bzuydrbkrx@linutronix.de>
Date:   Fri, 29 Oct 2021 13:18:33 +0206
Message-ID: <87y26c9ja6.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-29, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> ftrace_dump() is used for instance by alt-sysrq-z / sysrq_ftrace_dump().
> The function itself dumps the whole trace buffer in an irq-off section so
> no need to talk about max latencies unless this is going to change.
>
> The output on the serial is more or less brief and starts with
>     "** 397774 printk messages dropped **"
> and so I do see only the end of it. Might be okay.
> Any reason not to use the sync mode + atomic console while ftrace_dump()
> is in progress?

Since latencies are not a concern, I see no reason not to use
sync+atomic.

However, it does put us into the situation of beginning to define
non-emergency scenarios where sync+atomic is used. That rabbit hole
might go quite deep. I wonder if it might be better to introduce a new
sysrq to toggle sync mode.

John
