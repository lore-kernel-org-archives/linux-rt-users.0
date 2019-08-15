Return-Path: <SRS0=hjoW=WL=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EEAC3A589
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 12:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04D07208C2
	for <linux-rt-users@archiver.kernel.org>; Thu, 15 Aug 2019 12:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfHOMdp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 15 Aug 2019 08:33:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39707 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730919AbfHOMdp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 15 Aug 2019 08:33:45 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1hyEwp-00044b-3u; Thu, 15 Aug 2019 14:33:43 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Paul Thomas <pthomas8589@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        dunc.mcphie@gmail.com, Anders Roxell <anders.roxell@linaro.org>
Subject: Re: poor cyclictest results with 5.0 series rt for arm64
References: <CAD56B7eswTRxbeA8foXyVVZ7Bd+_y40dtOLkHxuAf4kVge7VDg@mail.gmail.com>
        <alpine.DEB.2.21.1907171001150.1767@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1907171009280.1767@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1907171101150.1767@nanos.tec.linutronix.de>
        <alpine.DEB.2.21.1907171220400.1767@nanos.tec.linutronix.de>
        <CAD56B7eomeb5Lr2juFWtZmtqSx3SkPijW03QZz8xv39He26PrA@mail.gmail.com>
        <20190813095306.xqgq3uusdpj7dhy7@linutronix.de>
        <CAD56B7fqosJAhiCLikhcxv_3wY7ETOv++kmQcr-=9NKEGq7Agw@mail.gmail.com>
        <20190814112656.z3de2rgbqzpaquz5@linutronix.de>
        <CAD56B7ezpaONhXCddu6RTE33-iXG7+J=xf417xu_uT-YKPV6RQ@mail.gmail.com>
        <20190815082955.olo3phbqj6disk3q@linutronix.de>
Date:   Thu, 15 Aug 2019 14:33:41 +0200
In-Reply-To: <20190815082955.olo3phbqj6disk3q@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Thu, 15 Aug 2019 10:29:55 +0200")
Message-ID: <87a7ca4nh6.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-15, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>> The attachment is here:
>> https://bugzilla.kernel.org/attachment.cgi?id=284391
>
> both traces have `printk' in it. Could you please explain what it is
> doing?  It should print something to the console. The printk code in
> v4.19 vs later changed and now (by default) ERR levels are printed
> immediately and will cause latency spikes.
>
> This would explain the spike but I don't understand how lazy preempt
> is related here.

Where in this trace is there a latency spike? I could not see one.

Emergency messages are not involved here. You can see at 84239098us that
systemd is writing to /dev/kmsg, but this is completed (haven only
written to the ring buffer) by 84239118us (20us).

printk schedules an irq_work to wake the printk thread. The irq_work
begins at 84241028us. All it does is call wake_up_interruptible_all() on
the queue.

John Ogness
