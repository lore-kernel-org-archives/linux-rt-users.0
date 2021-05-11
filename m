Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171EFC433ED
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 07:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D060761004
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 07:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhEKHr7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 03:47:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42348 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhEKHr6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 03:47:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620719211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dtVEhCLda8HUeKzIqG51m4PkcfarQ4Ebl7TLDitKBI=;
        b=3LourMSF7DsaPAHqr0aaZ6BlkdlbV6LqKjrjyfvqoMLqY1XJGOJUPBcuusaM1rMe9Sut1y
        zOT9Eue0HmJZpL5QrOZ35cMHp0WfFlkVJ8jLp52OnY8B7OYTbbOBmT+ZQ7BoFvBgVUTE2L
        Ke+arWRAAVz+z+Lv+9VQFisOOBs3IOuEx3WK9Cx+FvbhqFUJfGoHUqQjkqlfg98JzEOqlU
        P6EMrY6Yfvw9ldiXeWfvLdKjlrhbKlhcqKtdlCATUvSpUFZ/Qi+tgb1bK2bEhx7w9jgmIT
        Tu+IBEssamCP/1Xz0Y25r9wMyi2i3kra4FPKERzDVn5Ho0IgwqwkkICi58hyrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620719211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4dtVEhCLda8HUeKzIqG51m4PkcfarQ4Ebl7TLDitKBI=;
        b=x+fuvGCbSAp/hR3iIE9JNfwIzdafP9EW9cZnnVgnaAxVLdmLmtEdUT0DxHqi1z9/3XijY8
        fBCXmu4ZweIM55AA==
To:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sassmann@redhat.com
Subject: Re: [RT] Question about i40e threaded irq
In-Reply-To: <YJofplWBz8dT7xiw@localhost.localdomain>
References: <YJofplWBz8dT7xiw@localhost.localdomain>
Date:   Tue, 11 May 2021 09:46:51 +0200
Message-ID: <875yzphfv8.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 11 2021 at 08:09, Juri Lelli wrote:
> My understanding is that rps_trigger_softirq() sneaked in while
> i40e_msix_clean_rings() threaded irq was running and, since the latter is
> using napi_schedule_irqoff(), the softnet_data poll_list got eventually
> corrupted.
>
> Now, doing s/napi_schedule_irqoff/napi_schedule/ in the i40e driver seem
> to cure the problem. I'm not sure that there isn't a more general
> solution, though. Is it expected that napi_schedule_irqoff users in RT
> know what they are doing or do we want/need to fix this in a more
> general way?

The straight forward fix it to map napi_schedule_irqoff() to
napi_schedule() on RT. Fixing this at the driver level is a whack-a-mole
game.

Thanks,

        tglx
