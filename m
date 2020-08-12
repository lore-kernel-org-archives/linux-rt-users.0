Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E27CC433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 14:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 481AE206DA
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 14:34:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNw6OlCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgHLOef (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgHLOee (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 10:34:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21357C061383;
        Wed, 12 Aug 2020 07:34:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id g19so2499334ejc.9;
        Wed, 12 Aug 2020 07:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ejiFCkdhVdyCKbo2t7RPl1vTBlePfrxJWk3shyF3YhI=;
        b=hNw6OlCi8g+P8di5CwbOo8vo/c0XgtZFCHgHTRTkA5qJIU99egb45BeZUoNdRGaL8u
         gyFX1Ri455JbLeNhGKjub53kG3hgOeyY/iPgFFSDuB0HGI1bnsyvFnk1bwK/tvTWL6zg
         jZlmB1ZIGznraRBASVuRSZG9RUatybstceQ5L5qohlZi0esLzzkfIjq+itmMoNytCKSH
         aPKxpTsANDesovrKlAGSUTweVyIXZL+ZPfntkzpMNfkWkHTvAjCUatespNsRmb/trTiY
         4QYQgREJy/tdxZZvWGGGV35t7X0ASo0Xe3v5WUW4eA6lSwxlnVsGykB8m0Q3K4191Dri
         UyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ejiFCkdhVdyCKbo2t7RPl1vTBlePfrxJWk3shyF3YhI=;
        b=aqNF9AliLqY7ksJOWAz4NeKW/11wcTmkVV4/hKGef1WwwTRl0CEXtFfRfy971XcWCo
         7qsE94t7KxFsSVaYIPMHldC/VcsPySI9vF+qGgF8E31eNIrfXDU5ZgJL5vl0tOlUEEC8
         GNC4Z8Hal+gJj0moRlQQk6yE/kdJwL7/cDwMzf4I02IArEqs2BmF0lTVD8FwYi7+q3Ce
         xti7iCVeJ5brjPsC/tlFMLoSavAZkO86G3LLxFmLc22nrbocckx+FDvQP1enD9cafD1Z
         FLy04s0aaOFwTGaY3dC52ly8a/kccD0d59/qeJjGP+ALSMIDtv0oqVmWIbrTsNoFNehm
         3LFg==
X-Gm-Message-State: AOAM5337NVHLYrU1DcGJPBc8B8rVle6nx2JWI83BZhDzo5iAlS/nerXE
        v8tAOwtpFKKTV2M/dSzLFE8=
X-Google-Smtp-Source: ABdhPJwoixtSUaRECdtNhbZS4r9qPHAzAZ8VZH9rSHhwEsMrsXBoKdp0dA/X2v62biITf2fT9SPs/g==
X-Received: by 2002:a17:906:7e0b:: with SMTP id e11mr77329ejr.540.1597242872873;
        Wed, 12 Aug 2020 07:34:32 -0700 (PDT)
Received: from skbuf ([86.126.22.216])
        by smtp.gmail.com with ESMTPSA id x10sm1550055eds.21.2020.08.12.07.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:34:32 -0700 (PDT)
Date:   Wed, 12 Aug 2020 17:34:30 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Miller <davem@davemloft.net>, Jiafei.Pan@nxp.com,
        kuba@kernel.org, netdev@vger.kernel.org, claudiu.manoil@nxp.com,
        ioana.ciornei@nxp.com, yangbo.lu@nxp.com,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] enetc: use napi_schedule to be compatible
 with PREEMPT_RT
Message-ID: <20200812143430.xuzg2ddsl7ouhn5m@skbuf>
References: <20200803201009.613147-1-olteanv@gmail.com>
 <20200803201009.613147-2-olteanv@gmail.com>
 <20200803.182145.2300252460016431673.davem@davemloft.net>
 <20200812135144.hpsfgxusojdrsewl@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812135144.hpsfgxusojdrsewl@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 12, 2020 at 03:51:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-08-03 18:21:45 [-0700], David Miller wrote:
> > From: Vladimir Oltean <olteanv@gmail.com>
> > > The driver calls napi_schedule_irqoff() from a context where, in RT,
> > > hardirqs are not disabled, since the IRQ handler is force-threaded.
> …
> > > 
> > > Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> > > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > 
> > Applied.
> 
> Could these two patches be forwarded -stable, please? The changelog
> describes this as a problem on PREEMPT_RT but this also happens on !RT
> with the `threadirqs' commandline switch.
> 
> Sebastian

I expect the driver maintainers to have something to say about this. I
didn't test on stable kernels, and at least for dpaa2-eth, the change
would need to go pretty deep down the stable line.

Also, not really sure who is using the threadirqs option except for
testing purposes.

Thanks,
-Vladimir
