Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3A2C433EF
	for <linux-rt-users@archiver.kernel.org>; Mon, 24 Jan 2022 16:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241118AbiAXQ0a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 24 Jan 2022 11:26:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbiAXQ02 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Jan 2022 11:26:28 -0500
Date:   Mon, 24 Jan 2022 17:26:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XWbxFDue4/MoHXW0EIsthq5jsRxY7sF3kqRTMjklXY=;
        b=ngwPpKIW+xo+M/HRIEe9scukPchKfXIZ6FNXC4cp7KF48J4+H7zJ6+NJxCOT/BhLKp3xb1
        RysRv0whhlBPEF0s22bn/bAGIvK/G6QmpJcJrO6Hfx2z3i/aMXpksX7/SyJ9AYzgnKOZ+A
        QAMacasTN93UswZXmsr5UDey8FKExnxhxSuKJy0fF1cIswLZrf6fh0vrcxjVbkY22F3YXI
        giuG7m7HvNpOCnqEphxAUgoTNG7MX06sni1kh3gGHznUom0vSfvZXfzwH6asKib4HYjNEn
        qYQjPijXPj2X3cSlvC4ZchASl7wQNSw68B3f5Bm2kYDFkxAjU64RdLr0raKWgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643041587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+XWbxFDue4/MoHXW0EIsthq5jsRxY7sF3kqRTMjklXY=;
        b=bqEZC0JiPbMg6qX4rkj+OsYG46IJb1rF1MTpVVku/xvgwteGsnoWMKctNfRxH/AJx6Z9Ez
        TJpYmO1My0ydOQDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] rt-numa: optionally ignore runtime cpumask
Message-ID: <Ye7TMlx3mJkTxCsI@linutronix.de>
References: <YerAW90QwEg9yXAb@fuller.cnet>
 <Yer4kB0fmR41u19Y@linutronix.de>
 <Ye6id4lSKMcqAZ65@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ye6id4lSKMcqAZ65@fuller.cnet>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-01-24 09:58:31 [-0300], Marcelo Tosatti wrote:
> You mean "using all CPUs which are part of the current affinity mask by
> default" ? (where current affinity mask would mean user specified CPU
> mask).
> 
> > And then either specify the
> > requested CPU mask or use explicitly all CPUs.
> 
> Do you mean to drop 
> 
>         /*
>          * Clear bits that are not set in both the cpuset from the
>          * environment, and in the user specified affinity.
> 
> And just attempt to use the user specified mask? (which will then return
> failure to the user in which case he can correct it).
> 
After reading it again, I don't get it.
  cyclictest -a

Uses all CPUs in the system. 

  cyclictest -a $CPU

Uses the $CPU (mask) specified. If $CPU is not part of the current CPU
mask, why shouldn't it work?

Sebastian
