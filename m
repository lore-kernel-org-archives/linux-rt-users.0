Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC58C4363D
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D91921D42
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ovFt5EX8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PkZoloDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgIYPJi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:09:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56886 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgIYPJi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 11:09:38 -0400
Date:   Fri, 25 Sep 2020 17:09:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601046576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XI34I1ZV8hlqDoDpbkDuanBdfjcnDcaJQLkh4XS3NGU=;
        b=ovFt5EX8Fq7vymXxe4jmHL12U35Rbq/VjkGrdIVd4ocW6amltGnES2DBaE2CYVQwIH0BFP
        KzuxJLU/nPln2mtP1WMdaJ9I0VqtexAd77T0VH+ESms4mjHUsgtqHx/ZiFbghcAu20IziZ
        e8kH6Wp2kQmnRD/r/Ln4S7uDSEArjaZgjNnyKNXdrj6G1TJpf0NU8/svuarKkRVNJt031S
        zP85yAW3ym8Ohk3+LgXAsqKWDJ9qfgkAB7FxTmH9wBduk7X3bP49TlivDP1frMdp3ZTewg
        sf8L8BbqTrcU+42B4WvKo7UhswHW64gGiKJfCY1RWMuHZSUvsr1AXcTtPh/81A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601046576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XI34I1ZV8hlqDoDpbkDuanBdfjcnDcaJQLkh4XS3NGU=;
        b=PkZoloDn6s59eMoUXQA+eSEk0DMOg0WL3klp1e6cnBslANPM8ZAPGOI0CMb1VV3tfCM0nQ
        /GolGxqWDc3odYBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marcos Tadeu <mtadeu.von@gmail.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Virtualbox - BUG: using smp_processor_id() in preemptible
 [00000000] code: modprobe/11395
Message-ID: <20200925150935.jo5ski6u3dewiewd@linutronix.de>
References: <CAL6cx4xXeVpA4zSmFzgUVp+i7TUsO=0bhhi9yEyXoS+4=wAnWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL6cx4xXeVpA4zSmFzgUVp+i7TUsO=0bhhi9yEyXoS+4=wAnWw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-23 12:19:39 [-0300], Marcos Tadeu wrote:
> HI!
Hi,

> [   47.871866] vboxdrv: version magic '5.4.66-rt38 SMP preempt
> mod_unload ' should be '5.4.66-rt38 SMP preempt_rt mod_unload '

So you merge RT and non-RT.

> [   88.091243] vboxdrv: loading out-of-tree module taints kernel.
> [   88.112349] vboxdrv: Found 4 processor cores
> [   88.128117] BUG: using smp_processor_id() in preemptible [00000000]
> code: modprobe/5538
> [   88.128119] caller is VBoxHost_RTThreadPreemptDisable+0x12/0x30 [vboxdrv]

This is not in tree and not related to RT. My guess is that you need to
properly compile your OOT modules.

Sebastian
