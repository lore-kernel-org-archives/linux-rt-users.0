Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FFEC433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B1B64E6F
	for <linux-rt-users@archiver.kernel.org>; Thu, 18 Feb 2021 15:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhBRP4f (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 10:56:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhBROo2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 18 Feb 2021 09:44:28 -0500
Date:   Thu, 18 Feb 2021 15:43:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613659415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/8ZS1aDVYMLh2tPz+fgtJVKA05kzSI68VKEktAExfQ=;
        b=NCOr+B3DUwAGXBoXm72P5lBovlVZxQxnybuXr15lSTHNDuwVCv+xIfJK36GOc3Cpw8Ka5b
        yAohuLjHkgNBMsPIhQKFxqiSNTZwULDWrO0AX3pkngIOd3S/b7aTN+xm4Sir/OqIX/Wg5H
        ZLcmqz/F795xvOmBjYG84UmpbqPWxVbanTz1BAJrxqgPJLRew20JMtLUosgmsdLwFWVoIH
        dNS1KMmNkQj3L/44eRm+Ywb+pdkqnWCkwj040G9ggxq1kuuLotCQSmwxiyDxzmJRZzgZym
        LCaWT5E4i56/kjDcbjjGkA6APd+lDMtRHgdfvu0iasJ8WuzhA926H0TYqmj1kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613659415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/8ZS1aDVYMLh2tPz+fgtJVKA05kzSI68VKEktAExfQ=;
        b=cBzks6y7qisTi8E4UvVsBZGfERhyu5IXsVx7csN4n1mxZFNihaAt2pYA2rWjCw7LjLDfV/
        QxiFf3L3j8cE19Dg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: rcu_preempt detected stalls [5.9.1-rt]
Message-ID: <20210218144334.fnohryfmztsywxly@linutronix.de>
References: <47623850-fb85-aac0-9d44-85d7914a321f@xs4all.nl>
 <20210218144104.rfpcpzp6rhvks5vj@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210218144104.rfpcpzp6rhvks5vj@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-18 15:41:06 [+0100], To Udo van den Heuvel wrote:
> so it appears that CPU0 is no longer blocked. I don't know what blocked
> the CPU for the time.

I just remembered that you had a box named vuurmuur running ntpsec.
There was something I didn't fully debug but I had some hints where to
look. Any chance that box has also ntpsec running?

> > Kind regards,
> > Udo

Sebastian
