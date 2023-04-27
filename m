Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576D9C77B73
	for <linux-rt-users@archiver.kernel.org>; Thu, 27 Apr 2023 10:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbjD0KHF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 27 Apr 2023 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243429AbjD0KHE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 27 Apr 2023 06:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6D11FC0;
        Thu, 27 Apr 2023 03:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21610633E7;
        Thu, 27 Apr 2023 10:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF70C433EF;
        Thu, 27 Apr 2023 10:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682590022;
        bh=NpPUxdiGmbPhMzPhGolYoqA+iiu2qAbTIUmG3IlvkBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uopaMlnxAadrlJeOvUyXERVtGXrAzEIpeMldv/tk06iMcNE7F3/hWfRj+Ca/EUtXb
         YdUsi6lCe8viviR8eAZm5/Mnv2f3WZ1wmXnrniXiesePc/22nBQmZe6vdlGPiPjsH1
         jZssnpP9l4KgpFNHBQeeMoM6ebmwHpWYxqoDMsDOgYwByzaBkJALj6i+dGbH2Inby6
         pgWeOqazPR8GxI6JJUoI64n6zcMvKDj9OajMirX+Bb3VrtSvPa5zWdkv1PY/PKjulx
         7nNWEq7qTf2PJpukuqRlk21euEUCxN1l/ctfm6C/5c2AhQJqLMSS6gvez1G09U6EMk
         j8aceljwHzt7A==
Date:   Thu, 27 Apr 2023 11:06:57 +0100
From:   Will Deacon <will@kernel.org>
To:     "Bouska, Zdenek" <zdenek.bouska@siemens.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Kiszka, Jan" <jan.kiszka@siemens.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Puranjay Mohan <p-mohan@ti.com>
Subject: Re: Unfair qspinlocks on ARM64 without LSE atomics => 3ms delay in
 interrupt handling
Message-ID: <20230427100656.GA10855@willie-the-truck>
References: <AS1PR10MB567534190B05A4493674173BEB659@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
 <87pm7qxrg6.ffs@tglx>
 <AS1PR10MB5675F26ADC112F008B52F195EB6A9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR10MB5675F26ADC112F008B52F195EB6A9@AS1PR10MB5675.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Apr 27, 2023 at 09:38:59AM +0000, Bouska, Zdenek wrote:
> > Why is this interrupt handling specific? Just because it's the place
> > where you observed it?
> Yes.
> 
> > So if that helps, then this needs to be addressed globaly and not with
> > some crude hack in the interrupt handling code.
> I just wrote, what helps for me. I didn't mean it as a proposal for merge.
> Sorry for confusion.
> 
> I tried using Will's cpu_relax() implementation [1] everywhere but I was not 
> successful with that yet. ARM64's VDSO makes it complicating and even
> if I left original cpu_relax() just in VDSO, Linux did not boot for me.

It definitely seemed to work when I posted it all those years ago, but I'm
not surprised if it needs some TLC to revive it on more recent kernels.

Will
