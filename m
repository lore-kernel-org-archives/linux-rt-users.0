Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FA8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Sep 2021 09:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21C1660F56
	for <linux-rt-users@archiver.kernel.org>; Mon, 20 Sep 2021 09:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbhITJTw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 20 Sep 2021 05:19:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40942 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbhITJTo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 20 Sep 2021 05:19:44 -0400
Date:   Mon, 20 Sep 2021 11:18:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632129487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkxwER75kXZZpuDwFvfbVzQapA+NV8ir7y2e7aZZKN8=;
        b=coRFMzbKm9xJ5hFtX9n5QEqSTSLJaUaPcF9IPSwFoh3A+UGDgGGARJbZB0YybsT/T0VUyJ
        nMuOIvoE+1fxpHyA/u23pXm65T5UpGe3qE3V167Fp90ER+mBkk6guRZ4r1mzVS1vWaixkB
        6UE9mUsIID2vquzFmU856/T7A3ZRnXTsYNGRwJR3atjzZaoP1QljhapDj1SZxtFXit4Jgm
        qaLRIUmbrRUoTzXvEe97o3X9hfeKRvgq8sxnmAgCQitAK2zdnxqOiw5lWdOPKt6PYmlJbs
        zaQr8NaY+cap5+9L0YwLA7mtusT5ejktIIAIGY2pzs2zdsDEnPPvPCM4Wbmq5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632129487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkxwER75kXZZpuDwFvfbVzQapA+NV8ir7y2e7aZZKN8=;
        b=OcEFF/ye7O1+L1BbbOW1isEG6pjYWjEe37LEQlYV014nzQ0TMKDrm533qnmayH51iata6C
        kfRIleBzu9mb8xAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Gratian Crisan <gratian.crisan@ni.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: irq thread latency caused by softirq_ctrl.lock contention
Message-ID: <20210920091806.lgmznb5mkqoyyfkb@linutronix.de>
References: <87a6kd78n7.fsf@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87a6kd78n7.fsf@ni.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-15 17:59:50 [-0500], Gratian Crisan wrote:
> Hi guys,
Hi,

=E2=80=A6
> The 'irq/102-atomicc-248' irq thread is our high priority data
> acquisition thread. The additional pi boost and context switch seems to
> account for the main differences I'm seeing versus 4.14-rt. This race +
> pi boost happens with other lower priority irq threads too but the
> ksoftirq case is the most common one.
>=20
> I would appreciate any thoughts on how/if we could improve this?

It appears to be a consequence of the new softirq design/ handling.
Earlier we could have multiple softirqs running in parallel on a single
CPU (as in NET_RX and NET_TX).
With the new design only one softirq can be handled at a time resulting
in a full synchronisation at local_bh_diable() time by the lock you
mention in subject.
In your case it appears that irq/102-atomicc is force-threaded and
therefore requires to disable BH before its execution. This is just to
mimic what upstream does in terms of locking and to ensure that BH
invocation happens after the threaded interrupt ended.
If there is nothing special about this interrupt handler (in terms of BH
handling) you could request a threaded handler for the IRQ. The manually
threaded handler do not disable BH before their invocation.

> Thanks,
>     Gratian

Sebastian
