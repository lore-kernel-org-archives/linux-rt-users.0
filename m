Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198FEC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 13:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJENbw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJENbv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 09:31:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD3D4DF1D
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 06:31:50 -0700 (PDT)
Date:   Wed, 5 Oct 2022 15:31:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664976709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdPHBO31Iuspv5hLXcjxm5ksWjU80Tp3xPF+3YO8jkY=;
        b=SXE2IaRB2ZE3J3gUGzT5oeqKJx4mcVpXfok/Ze7CMb3zx9e5Z+So0FYBqpLxWTP2IES+So
        XnCp4u4M1Ndc7h5CidORrCgyxRoNJFwyeXymYNi6m0BKArcPv1Mx9D12qQstrZG3XL3E84
        PNF2/f1lUXRuzP6rOLPH3VFIb7bX5XL96TcURvrjA9nYN2P17+CbU99T9Jj80u2IWyMqp7
        RQlDFE1j8FQIEPozZ6F8v87xWdUQKw0/nVqXH+PWrIIz3JlPoLISdlEAq0O6Ohmx1wk9zI
        y+VMyPXH46KPpEoc9hY+sUAnsAVFtiL1OqzizqdzGsQjKve6sW2ZoDt2H4IH2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664976709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SdPHBO31Iuspv5hLXcjxm5ksWjU80Tp3xPF+3YO8jkY=;
        b=qd6nwbm4zfy8XaeRnAj49qWu3bMUVXDbVR0lzyMOGB8ysmdqAU1BINF5dm9T/DbybGe99A
        LwqW69cnDHop0PCQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Florian Paul Schmidt <mista.tapas@gmx.net>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Message-ID: <Yz2HQlzZ491HtOm+@linutronix.de>
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-10-05 09:46:30 [+0200], Florian Paul Schmidt wrote:
> 5.19-rt10    has the problem
> 5.17.1-rt17  has the problem
> 5.16.2-rt19  does not have the problem

Could you check v5.17-rc1-rt1? Maybe it was introduced in v5.17 cycle. 

> I would possibly be willing to git bisect the issue. But I am a little
> bit confused about how to go about that. What repo/tree would I
> precisely bisect (I am using the the patch tarballs from
> https://cdn.kernel.org/pub/linux/kernel/projects/rt/)?

if it got introduced post v5.17-rc1-rt1 then we could try to bisect it.
Otherwise we would have to trace it. Since the latency spike is huge, it
should be easy to spot.

Sebastian
