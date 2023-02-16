Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A81C61DA4
	for <linux-rt-users@archiver.kernel.org>; Thu, 16 Feb 2023 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjBPSEy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjBPSEw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 16 Feb 2023 13:04:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFFC38662
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Feb 2023 10:04:50 -0800 (PST)
Date:   Thu, 16 Feb 2023 19:04:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676570688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DayJwlNUs+70qmX8hWyyyHE/nMhf1bwiKaFvPsUUXiY=;
        b=oHMI/51X/gv4IiYtbOEvv9j9COX8Z/BZT6wwqKjxT293I5td6lv+PwGs7W199xUrveHSZE
        g7EAk2njaj32lf/2nKP8kxbXtbyPxQgU2Rud6+vTzCGexLmHOQ8zmAt09rXaDyXTCVKsAo
        jbp+tXxpxLo/+Xip3SlM87GOUYmKS9HLj8DUrhtig/fdcGSu4kA9sRwlY28Ky3F43mcsjA
        6LAbtnBE4J0L6XxSKcEe7SEqti8F/g4eVTm+/1Br/rs32GhaP48WukVgnDuCu4ZHTUGCpu
        2ak+su2Tg7z5DeQg6LAeLLgDn/x8XDdsbfzq7/J0qlupqDR6SHr/gVpK84R0JA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676570688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DayJwlNUs+70qmX8hWyyyHE/nMhf1bwiKaFvPsUUXiY=;
        b=OLerT2/3wijPBPNkoeqeKomLIHhddiJKNUcuxYRNnmKsrak2arsdxtLubiz5qRBCUYG1GM
        cy15LtrFnEBfeyDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: Scheduling while atomic due to i915 intel_uncore->lock
Message-ID: <Y+5wPzWeMHnEmf4D@linutronix.de>
References: <CAFLxGvw0WMxaMqYqJ5WgvVSbKHq2D2xcXTOgMCpgq9nDC-MWTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFLxGvw0WMxaMqYqJ5WgvVSbKHq2D2xcXTOgMCpgq9nDC-MWTQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-01-31 14:16:48 [+0100], Richard Weinberger wrote:
> Hi,
Hi!,

> A reliable trigger for the problem is using the Chromium browser when
> it utilizes OpenGL.

need to try that. OpenGL as in watching a video with HW acceleration
enabled or is there something else?

> The root of the problem seems to be that struct intel_uncore->lock is
> a regular spinlock but
> taken in atomic context.
> AFAICT the atomic context is a result of kmap_atomic() and
> io_mapping_map_atomic_wc()

kmap_atomic() should be fine as it does not disable preemption.
io_mapping_map_atomic_wc() on the other hand does disable preemption.

Now looking at this, it seems to happen eb_relocate_vma(). From staring
at it, you might be lucky to get away with

diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
index 09d4f17c8d3b6..5ddc70a4e7e3e 100644
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -162,7 +162,7 @@ static inline void __iomem *
 io_mapping_map_atomic_wc(struct io_mapping *mapping,
 			 unsigned long offset)
 {
-	preempt_disable();
+	migrate_disable();
 	pagefault_disable();
 	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
 }
@@ -172,7 +172,7 @@ io_mapping_unmap_atomic(void __iomem *vaddr)
 {
 	io_mapping_unmap(vaddr);
 	pagefault_enable();
-	preempt_enable();
+	migrate_enable();
 }
 
 static inline void __iomem *

which is based on 6.2 but you get the idea.

> usage in i915.
> Converting the said lock to a raw spinlock cures the problem but the
> overall latency almost doubles.

yeah. I tried that once, too.

> I'm pretty sure the problem exists also on v6.2-rc3-rt1 because there
> the affected lock is also
> still a spinlock and used below kmap_atomic() and io_mapping_map_atomic_wc().

Could you please try the hack above and check if it appears to work?

Sebastian
