Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43009C636CC
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Feb 2023 17:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjBPRiU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Feb 2023 12:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjBPRiT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2023 12:38:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B033B85B
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Feb 2023 09:38:16 -0800 (PST)
Date:   Thu, 16 Feb 2023 18:38:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676569095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4RhNx2PL0ZH3Sfqccq5PMtMoR9S3VEVcIuqSiR184E=;
        b=q+3BXC5b2yHsuWkktqkn+MXrAXLcd5A8Dbs0d5Nt33py1x4mDOR/HQPRXOa/1WctOMz/C/
        rgBYYGWUblJ3gUCL6jCrJQBeeH+oxM8F6/FrvJeQhkyjUArEiOTg0oJjEWBExnQUSZ2tZt
        dBhQXrYhgbiXYyfYPsnUJXzdauwwTAQehHc/4UtVRDi7rT3l65yYqAmWyoMhB7UnSLkkK3
        omQkQ55l5SkLMQQ2ix6W44b9FZKWsDraE4tcZkVL38kqYxsvKwNib3A/ZTvL0XjEj+gNou
        z3Z/ytF+70MS/vaiX4FeU6gFGtePcAoa/9QtD8FK/qPXVSyGL/l2MYuKbD1Vkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676569095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M4RhNx2PL0ZH3Sfqccq5PMtMoR9S3VEVcIuqSiR184E=;
        b=qVQfGTuukdZI/4Gc04Oi8pg1T2WDsuEmkLjbN6SqD7FDEWXj2X4H/u0+fgQbwDrQYVUZbc
        pbMgI57ylFt3fRDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michel Macena Oliveira <michel@austral-dynamics.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Out of Memory problem with kernel 5.16.2 and RT ptach
Message-ID: <Y+5qBGx0xkEUOKYX@linutronix.de>
References: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKkbJ-wOuKFZzmHL8wwap7160HdeoqQwkppGFwCc3Ah5GP94oA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-01-30 16:32:22 [-0300], Michel Macena Oliveira wrote:
> Hi,
Hi,

=E2=80=A6
> -Kernel Frequency: 1000 HZ

you could use 250 or less. It does not affect timer resolution (as in
sleep() for instance) but only kernel internal timeouts.
Having a smaller values ends up with less interrupts especially with
CONFIG_PERIODIC.

=E2=80=A6
> After I successfully installed the preempt RT kernel, I rebooted and
> tried to boot
> the RT Linux, but the system returned "Out of memory. Press any key to
> continue..."

This appears to come from grub. Later in the thread you stated the initrd
was 700MiB in size. I would have assumed that grub can handle < 1GiB but
maybe not. There is a difference in the boot protocol which means EFI
might be able to do more.

> Finally, how can I remove a preempt RT kernel installation?

if you did not package it and installed via "make install" it should be
safe to just rm the kernel + config + initrd from /boot, run update-grub
and then remove the modules from /lib/modules.

Sebastian
