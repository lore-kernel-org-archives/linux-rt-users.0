Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7A7C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 10:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 632B061130
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Oct 2021 10:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbhJ2K2h (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Oct 2021 06:28:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54148 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhJ2K2f (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Oct 2021 06:28:35 -0400
Date:   Fri, 29 Oct 2021 12:26:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635503165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HMIqRwJVjGzc3V4xThCxjmLf3jVkpfRcTm2nWNW3fYg=;
        b=lUZkbq7WHkgwwp6NzaDEFFFEXUS0v2aA1pnA4NpSj2gkg3WapZuIFQ4VCuJBSCO4B+hwfz
        Dvrx182nXINglYVsK3U2EMuVKnWv2VSbx/ShlMgYdvPtYAe/89fOPp3kSc2GrIQbBxtAaU
        YuQU+asRaSTHyw3iS9L+XE7Sbik8FERLobN6fm8OlH5Z0ktGOI44xuxGFpQeKwvUNxbhOM
        t6eLW4r5IsA88t54wLxvDomzRZQajSZP5hjI6xwqgrhVPRaoYXXtav5sYwwLnhChjl+tO9
        xaKWiubOMU+fZ1EHGOgBfdeA0w76Vdu+yMW6lMna+046zR7njpHQKPlCah5Ihw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635503165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=HMIqRwJVjGzc3V4xThCxjmLf3jVkpfRcTm2nWNW3fYg=;
        b=GZLuhDonLjyP90dX1CLe6nb0JTWkaKZUUR083ojrvnwNJUMQ2NYuz9AELev0Ph2DPuBpj7
        zAG6Hykhkh6P4YBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC] printk's sync mode for ftrace_dump()
Message-ID: <20211029102603.4qp4g5bzuydrbkrx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

ftrace_dump() is used for instance by alt-sysrq-z / sysrq_ftrace_dump().
The function itself dumps the whole trace buffer in an irq-off section so
no need to talk about max latencies unless this is going to change.

The output on the serial is more or less brief and starts with
    "** 397774 printk messages dropped **"
and so I do see only the end of it. Might be okay.
Any reason not to use the sync mode + atomic console while ftrace_dump()
is in progress?

Sebastian
