Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30993C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 May 2022 11:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241060AbiEJLiQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 May 2022 07:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241114AbiEJLiM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 May 2022 07:38:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291B53B7F;
        Tue, 10 May 2022 04:34:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652182450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TC9/XshEOTpfSw/rNl+3rL4L7Eu/YKJZMaJhwEGZCIA=;
        b=1+BO+CV9mIpecQFKN1qq1b9aXH6xkTIXtonVxkct4HUBfahFp3qBTY6X98jyErGhSTb8zb
        Je8ggl97zDtnWszjuoiXIYpP02pk+YHGp+3l6oLrnmaHZy7w8rcSNuMAXeR4GroeczwH68
        EaNXCbsSNn9+S3n3liSnQmjIxtURB5owKn8NbWjgSq2OW7fhPTs/NK1oxSIKG27GahOF8p
        M1CKhTqokNsZVUtWvHHJRdFGiEoPt3erKAxHd5CtUUeBL6nJYv/jMRTkMLsroxV7Pk3ACl
        SS6ONEDp8qhnOSkcfNc8JmJxQ9u8FanjLdOReOPwYScmr99yc/PHzLJgSf6rrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652182450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TC9/XshEOTpfSw/rNl+3rL4L7Eu/YKJZMaJhwEGZCIA=;
        b=W9IZ6qpE6cR23ovgS7fHMwaerLRRSw7mVixYuAX4ZIFZkA6BEDJh2wsLmCsWK9LjXpNLzn
        gyIxUsR9FKM6InDQ==
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <e64aa9cb-a1ae-7534-8bf1-446d9d8c512@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <87mtg0m2jb.ffs@tglx> <e64aa9cb-a1ae-7534-8bf1-446d9d8c512@pcs.com>
Date:   Tue, 10 May 2022 13:34:10 +0200
Message-ID: <87pmklpqod.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, May 10 2022 at 10:43, Thomas Pfaff wrote:
> On Mon, 2 May 2022, Thomas Gleixner wrote:
>> On Mon, May 02 2022 at 13:28, Thomas Pfaff wrote:
>> This comment made me look deeper because I expected that free_irq()
>> would hang.
>> 
>> But free_irq() stopped issuing synchronize_irq() with commit
>> 519cc8652b3a ("genirq: Synchronize only with single thread on
>> free_irq()"). And that turns out to be the root cause of the problem.
>> I should have caught that back then, but in hindsight ....
>> 
>
> Sorry for coming back to this again late, but this makes me believe that 
> the real problem for the freeze in setserial is that uart_port_shutdown() 
> is calling synchronize_irq() after free_irq(), which is illegal in my 
> opinion.

Well, I'd say pointless.

But it's not the real problem, it's the messenger which unearthed the
underlying issue. Even if you remove that call, the underlying problem
persists because the interrupt descriptor is in inconsistent state.

> It can be done only before the interrupt thread is stopped, and free_irq() 
> itself is already taking care about synchronizing, no matter if its done by 
> __synchronize_hardirq() or by synchronize_irq(), like it was before commit 
> 519cc8652b3a.

No, it does not really take care about it. It can return with
irq_desc::threads_active > 0 due to the interrupt thread being stopped
before reaching the thread function. Think about shared interrupts.

> If it is called after free_irq(), the context is already lost.

That's correct.

> I am not sure about all the other drivers, but at least serial_core should 
> be fixed if you agree.

Yes, that call is pointless.

Thanks,

        tglx
