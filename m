Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E160C6FD19
	for <linux-rt-users@archiver.kernel.org>; Mon, 13 Mar 2023 09:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCMJp4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMJpy (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Mar 2023 05:45:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F13B20572
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Mar 2023 02:45:39 -0700 (PDT)
Date:   Mon, 13 Mar 2023 10:45:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678700737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swMYz/g8QHg+dmqceYw4tAOo5Hiimxhihx7pD9k4hwc=;
        b=N6Ua7nz9MoJkKwbFWV4LM9QJVPmD+FxiFrMhwDf0EORvV9nGk+kvNzKPqJaae0qO2MUFvA
        kDeQkeFdxQkBXtUj4bN14vGn4wZsy4YZMhr2a3EEVSQ/1AjRiEnBiSGjbedWNiQrf5Mo7s
        QBA/VmNzUNYtVgA+I+tBG1fDDxLQyGIreCNXiNc3GQZGu7/CslhCKBfjpyi6f0hg9gAef0
        1cb5qpe9FwNwConpdzorfCoTGJb+2QfloZ4iroHkWcJHagSfpqgpKA5hS0OcSJMUPC71U7
        Sfa1LrQG2PE9nUwL+HPhfWxPh9kcdNV6KZSNolZ31YGoF1pA5SshhSxYQ6NnvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678700737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=swMYz/g8QHg+dmqceYw4tAOo5Hiimxhihx7pD9k4hwc=;
        b=Ja1pl1Tt+6jj4NPnHlWaB6rinCyim7BnYf4wC1u85XzXAleMfX9qLS8sJSj0YAIYSB8J+R
        wzm8xMUwjzlZ7PAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     yosi yarchi <yosi.yarchi@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: hard irq + threaded irq
Message-ID: <20230313094536.xsTij_2F@linutronix.de>
References: <c2b42dfa-8d41-d981-18e1-539d70e1d54d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b42dfa-8d41-d981-18e1-539d70e1d54d@gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-03-12 10:02:48 [+0200], yosi yarchi wrote:
> Hi
Hi,

> If using 'request_irq' API with IRQF_NO_THREAD, then the provided handler is
> invoked as hard irq, and no threaded irq is launched.
> 
> If using 'request_threaded_irq' API with 2 handlers, then two threaded irq
> are launched.

This is done because quite some of the driver were using sleeping locks
in the primary handler.

> Is there a way to configure irq so that one handler is invoked as hard irq,
> and the second handler is launched as threaded irq?

Isn't
	request_threaded_irq(,, IRQF_NO_THREAD, , );

doing this?

> With best regards
> 
> Yosi Yarchi

Sebastian
