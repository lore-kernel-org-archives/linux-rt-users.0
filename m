Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A4AC00140
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Aug 2022 14:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240952AbiHEOXW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240947AbiHEOXP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Aug 2022 10:23:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8C75C35B
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Aug 2022 07:23:14 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659709392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAVw9SbEXm+bOkOczmi7NjcSkNOmxVzuXzQbxpjebHo=;
        b=n4Bk9Kfv21Qtf6P7l1WkVAXjRg8z7SJMkswKnb5E5/IlBoahNo0fyVNS7wFE5Yq+9N5HZR
        rhNqKrdSI+/22u0Cgb0bqLJ6/YRgpjShGCVHn8woqSSSDVYi5ZnhNViUY/KiXuhnrU6OGg
        ll5dgoD4v21dVGoWalp82h0WuEMTNo5y/hgD0gYDSxaDFuHNFCbCy6dnTQiz5kSnErXCZ6
        fMS0qPcJ+aOsiCXGBhFnyXb3lB5siGSoopbnJWb5vUfIRETb/IKpZuw1DYlaBkqZbIJduS
        NIAudN7+hesY4/78SkqDSZBLROx75AUNtl6xJ/f0S3jOtvnKR9AP/UxpMDmbsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659709392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GAVw9SbEXm+bOkOczmi7NjcSkNOmxVzuXzQbxpjebHo=;
        b=9/piGa6Lt4YgMPPgEZEEW9QZSe6BA4qAf54jNogDZQ0n2TWT4/DJE1ajAPgm/3bqIkM/Hw
        W3WwNvMf6o4EShBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
In-Reply-To: <YuqeB6Z0ZYNb2TxC@alley>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
 <87tu8a16bm.fsf@jogness.linutronix.de>
 <daf9b4678af9a121ba85f30b04f1335b44639433.camel@gmx.de>
 <Yt5RDajSVTPqahV4@linutronix.de> <87h735ikdh.fsf@jogness.linutronix.de>
 <YuqeB6Z0ZYNb2TxC@alley>
Date:   Fri, 05 Aug 2022 16:29:11 +0206
Message-ID: <87tu6qrcq8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-08-03, Petr Mladek <pmladek@suse.com> wrote:
>> I am preparing a new series that addresses this by completely removing
>> interrupt disabling from the printk() path. This required changes to the
>> printk_enter() macro, recursion handling, and the printk-ringbuffer
>> itself.
>
> I am not going to accept any removal of disabled interrupts in
> the first round. It opens another can of worms.

To be clear, my new series only removes interrupt disabling for RT. It
uses spin_lock_irqsave() and lock_lock_irqsave() to accomplish this so
that interrupts are still disabled for all !RT preemption models.

John
