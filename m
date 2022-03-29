Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EF4C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 29 Mar 2022 06:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbiC2Gcd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 29 Mar 2022 02:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbiC2Gcd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 29 Mar 2022 02:32:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FE71959CC;
        Mon, 28 Mar 2022 23:30:49 -0700 (PDT)
Date:   Tue, 29 Mar 2022 08:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648535447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPMbslHvcWl9AuG65q7i4FLjo8NvVN67J002+wav/FY=;
        b=z5k01oUOKZTixIWULLUcr508q/nMMT4tEEjUge5ZQhzBEYr5bPRwiQs5vJj69dJ8aKWe0l
        jS8wDg+MxF5n3WIOpjYprknAz/fsRet90+HfSfbSpsXDmQz8PHqwVbo5tp/crRjl8EvIAx
        rZhQ9IxuO6UVMLbFCJsH6IWU7PFRCUUA0GjlXNDWXQFsbJeclC6zdaQLTIYNmz/2sxskDr
        aWELyVDtoySPAKA7Dzz4wvMzsDOzuChceYIe/QRlTD2wnf2ANI6RCFPgiZ8NdmZY1MwYXA
        IF6jphQxssXXlq5Idttg7mrH3MOnpCJjfSRUI3J/uL0fki1lgqnz04LPhr4X2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648535447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPMbslHvcWl9AuG65q7i4FLjo8NvVN67J002+wav/FY=;
        b=GQrvXCOItrac/je83cPCtN63EkGHkvcRnczk/iwqe7CV0yuSFNYWm+SEQQ7E05EByC9PsT
        itHjLIsLol12wLCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Tejun Heo <tj@kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Peter Hurley <peter@hurleysoftware.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Esben Haabendal <esben@geanix.com>,
        Steven Walter <stevenrwalter@gmail.com>,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?utf-8?B?QW5kcsOp?= Pribil <a.pribil@beck-ipc.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] RT scheduling policies for workqueues
Message-ID: <YkKnlUUsufZPiZxM@linutronix.de>
References: <20220323145600.2156689-1-linux@rasmusvillemoes.dk>
 <YkGIhYKJG+w4L7ge@linutronix.de>
 <20220328100927.5ax34nea7sp7jdsy@pengutronix.de>
 <YkHyzcfiyjLfIVOo@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkHyzcfiyjLfIVOo@slm.duckdns.org>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-03-28 07:39:25 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> I wonder whether it'd be useful to provide a set of wrappers which can make
> switching between workqueue and kworker easy. Semantics-wise, they're
> already mostly aligned and it shouldn't be too difficult to e.g. make an
> unbounded workqueue be backed by a dedicated kthread_worker instead of
> shared pool depending on a flag, or even allow switching dynamically.

This could work. For the tty layer it could use 'lowlatency' attribute
to decide which implementation makes sense.

> Thanks.
> 

Sebastian
