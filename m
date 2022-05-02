Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD70C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon,  2 May 2022 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387012AbiEBTEI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 2 May 2022 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387014AbiEBTD6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 2 May 2022 15:03:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F7D1091;
        Mon,  2 May 2022 12:00:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651518026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFN2WdqzeQgS5RZmSYBBhPah4ZERNvMYVR3oemiypyA=;
        b=VVCXveVrglTJO+py77rxRcLewjhMSOAqz6KbQPP+jZ06befE0vVuYoMZQFO1Yp7sVfFbjV
        eowVD+Xzea+vvAoXaEOlQJrqqsMJRijOqOs54dH/7vOsVNdkTn/t5oP9XMBG/eRnF9jL/z
        AaA+nqYfSZmroz4q2Q1tpVygPuTLAaER+ewKvaVpkP/HIVMG+OUmrJ05g/9JRK7XPNXcvk
        LDKJttwxK1143D7Gahd4Ds7VqLP1Y0ntfTgaddiuqhvcE8WDeHQp7kUPqT23aNHNDtzo8z
        A94hMVpdLMBIJVcKwpwD3SQj4/BXSRLGxiRoSbo7QVyfJXGaAFM6YWEEjHpi9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651518026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oFN2WdqzeQgS5RZmSYBBhPah4ZERNvMYVR3oemiypyA=;
        b=JMGQYnCzotx+pHJfzEw3Da+0YcRKN3m4LSdwDdFRa+XG0LHzNKRqZn1zeZOCjEs/uilsSo
        2wATdimnD9bb8eAw==
To:     Thomas Pfaff <tpfaff@pcs.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <bbe3603c-df84-290-fb3c-10f450c21518@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <87mtg0m2jb.ffs@tglx> <bbe3603c-df84-290-fb3c-10f450c21518@pcs.com>
Date:   Mon, 02 May 2022 21:00:25 +0200
Message-ID: <87a6bzn4ja.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, May 02 2022 at 17:34, Thomas Pfaff wrote:
> On Mon, 2 May 2022, Thomas Gleixner wrote:
>
> I can confirm that your patch works.

But for the very wrong reasons. desc->threads_active is a counter and
not a mask. Where is that brown paperbag?

Let me merge your patch and add the information about the root cause to
the changelog.

Thanks,

        tglx
 
