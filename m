Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ABCC77B60
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Apr 2023 21:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbjDZVaT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240147AbjDZVaC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Apr 2023 17:30:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECAEE76;
        Wed, 26 Apr 2023 14:29:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682544586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwiQaWIRHQyq7je3uiXIYH4HOfAwQIaSflkAEcF6eh8=;
        b=B9QDZ0qRvllVXbYmnanLl1ovYM3aOLpWhAF+F82mr/sHwScw4NB2YzXdlUBccBYRxOd9U4
        bvKiCt1ex+1KKGOFNXNBHRCU1RmAio5V++JhFLqath6WUBx9PKjA6sFtMPGfzw2SKGuO9F
        ssit9S+1Bx9s0QR5XCyOyQDfQghfryUJrJPQe+D5efffpWcLyDrmo11g7jPIfN3FCiRicH
        xKo1OX6bz7cqONbVIeixBvZreanatItV0kQxDGkLA1TtjoaWsQ9nZfsyEhlMLevoNc78YS
        Q0KC6EUH4hCDdJfvDQr/jj61AOQtCllRSbeqE8GGT+SLNm6wfvRQgPFONTrNbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682544586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fwiQaWIRHQyq7je3uiXIYH4HOfAwQIaSflkAEcF6eh8=;
        b=WJX2ivJ5pOIVjXh0XT2pQWl0AO1BXk5NMBCI+1TkxCZps2pFiYmBvL8jn/HqSVE36smstx
        BrCQwH0F6YLGPTAw==
To:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
In-Reply-To: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
Date:   Wed, 26 Apr 2023 23:29:45 +0200
Message-ID: <87pm7qxrg6.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Apr 26 2023 at 12:03, Zdenek Bouska wrote:
> following patch is my current approach for fixing this issue. I introduced
> big_cpu_relax(), which uses Will's implementation [1] on ARM64 without
> LSE atomics and original cpu_relax() on any other CPU.

Why is this interrupt handling specific? Just because it's the place
where you observed it?

That's a general issue for any code which uses atomics for forward
progress. LL/SC simply does not guarantee that.

So if that helps, then this needs to be addressed globaly and not with
some crude hack in the interrupt handling code.

> Anyone has a better idea how to solve this issue properly?

Use hardware with LSE atomics :)

Thanks,

        tglx
