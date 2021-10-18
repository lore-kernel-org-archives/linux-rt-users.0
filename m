Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4BC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 09:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF9A9610C7
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Oct 2021 09:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhJRJOq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Oct 2021 05:14:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhJRJOi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Oct 2021 05:14:38 -0400
Date:   Mon, 18 Oct 2021 11:12:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634548344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbE2YnSCccswsXIPoCg/L05MYpt6dNjDb2WgkmZmaog=;
        b=PkXD3/huRPXbp3fIDBPiGW9kGJcCQIzvNr5ppiBDHnSCy92MfeSsE4UrIVg2uE/F81JnHo
        gfv66N/QExAGqQBF/V1JHfiSR1huXmBhi9ZiFFHltLapJIrTarO9APTmb1ZD8ZmPdJVF54
        5geKyclx0Z7BBou9MMkX5qzUPtkhmlYZAxVODULEPh64nu8xbloKJXC7g+eYbqHl42PLmn
        vEy3LSKhLXTlIZB2+7SgL5yXZgJuYE5D0jBgE4K4zy/uYqhWpvHSJTWfSEphRo9dAftuyc
        QdHIhQ209ye/wTHZltXfCFCk5HIU+eCEIoN7Z1L5bIqNGJCs6R1leJpMchkjyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634548344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fbE2YnSCccswsXIPoCg/L05MYpt6dNjDb2WgkmZmaog=;
        b=Qlt4wAfuQYI9buMiXofs9nG4xH7gdfoGAF5MluSRLCn2NXF3MthMMYN91xeZMDj6OTUg7W
        YmGo246SZW9XjrDQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre FICHEUX <pierre.ficheux@smile.fr>
Cc:     Punit Agrawal <punitagrawal@gmail.com>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Strange problem with PREEMPT_RT
Message-ID: <20211018091222.xxqyobs3ovseaf7z@linutronix.de>
References: <CAFc1U0sgMtKvcpTWkyjwXsq3Md_Huew7mSye_AratkM63D6K-Q@mail.gmail.com>
 <87y27e53a2.fsf@stealth>
 <20210930132319.eixnv6rb66ui6x6j@linutronix.de>
 <CAFc1U0uMuj1PPmxPQTTVqscYsnKfOE+sjtasK9KqadkgaUgLSg@mail.gmail.com>
 <20210930135145.mdlzzwp64yykixhx@linutronix.de>
 <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFc1U0sYdJQWkeLgPjiR1Y1CnafV22zgS4AW0Yf6+h7CO03u+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-30 16:31:25 [+0200], Pierre FICHEUX wrote:
> # cpupower -c all idle-info
> CPUidle driver: none
> CPUidle governor: menu
> analyzing CPU 0:
> 
> CPU 0: No idle states
> ...
> same for all cpus.

Are you still stuck with this or did go somewhere in the meantime?

Sebastian
