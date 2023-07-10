Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D64EEB64D9
	for <linux-rt-users@archiver.kernel.org>; Mon, 10 Jul 2023 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjGJL52 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 07:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjGJL52 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 10 Jul 2023 07:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791EE1
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2023 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688990200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5nvWHxOS1jlxX2P24Kbt+E8BFVKb+2zALHkjYGPjbU=;
        b=HNQ1hywyKyOZk4wbqGxwgHlgbSvyjIKxdOmOC3HbZKwHrhg5QOQ/imYhfJulsjgYb+2P9A
        knLbG1PEcfHwJ3QPHf06gfMj7SQjHZnIcAEw4avT4+QxfEmlQbe9WGx1Df2IcBvhvdKkCV
        4o69kAQyJLx7L4FDIIQNbkjEV9WIm9g=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-F3LW7EANM_GRXtEqyCN3Mw-1; Mon, 10 Jul 2023 07:56:39 -0400
X-MC-Unique: F3LW7EANM_GRXtEqyCN3Mw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6fbef3087so38097691fa.0
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Jul 2023 04:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688990197; x=1691582197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5nvWHxOS1jlxX2P24Kbt+E8BFVKb+2zALHkjYGPjbU=;
        b=UzGWpNz6A4ocYeOhrRjusSEtDXiRlZddECKVkceQ51nSuBe9AU9u4fSvTai1fInrto
         aiWUjvZiDefrnwtvhwQomouHIGuH0nhzwGP78pZiTC3XkaemJFpoO1qClWeAOfN+FJe8
         QvoIgWGQ0t42HYpLicRFLyOwF4GYYUJCc4dUrn339U5uMnN6HWHAv9WU9TIKAZtCAB4Q
         iw4AgCzqyIVpJGIvxiX3g0FXDq+IkjRi9FVDxX0XybbMAGPNnXJGy1AA3Gps9A2R7ZAf
         atohV7zxpN2xzEOWtEIUQBCoplwoCXIKlgTGwgm3SuG3m2ol+GlMCe4P/cgzFheIBvGP
         s5UQ==
X-Gm-Message-State: ABy/qLbFN9sVr/HcvStJyqIigNlDN3ykSaW2E7lSuWgCuKrCK3V5YNPX
        xaGV0KAOeWbkKIOyANK6SmzOA0kveJJK//5G3xpuquQDA3MMJP2SZPIhkCG+7BipG0gXY44Gm6S
        n/c+FXDBb4ItzHF4rJljgUu2AtbIBvHcdopo=
X-Received: by 2002:a05:651c:205:b0:2b6:c394:91dd with SMTP id y5-20020a05651c020500b002b6c39491ddmr9535759ljn.10.1688990197749;
        Mon, 10 Jul 2023 04:56:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHHaINIY4IeEyczmZRw/E4sGNkyu+QGYkdJrKccjKWG8MejGXh5QlhRs3Cdy+GKrd5vo6ELuw==
X-Received: by 2002:a05:651c:205:b0:2b6:c394:91dd with SMTP id y5-20020a05651c020500b002b6c39491ddmr9535744ljn.10.1688990197329;
        Mon, 10 Jul 2023 04:56:37 -0700 (PDT)
Received: from localhost.localdomain ([151.29.137.73])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906594800b009930308425csm6046503ejr.31.2023.07.10.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 04:56:36 -0700 (PDT)
Date:   Mon, 10 Jul 2023 13:56:34 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] i915 sleeping function from atomic in gen6_reset_engines()
Message-ID: <ZKvx8hVLJ0OY3M5z@localhost.localdomain>
References: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
 <ZKuxdVJcsHdcbmYs@localhost.localdomain>
 <ae3f172d49bcf1af3c0e566bbc4f2967c9e65f2e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3f172d49bcf1af3c0e566bbc4f2967c9e65f2e.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/07/23 12:09, Mike Galbraith wrote:
> On Mon, 2023-07-10 at 09:21 +0200, Juri Lelli wrote:
> > Hi!
> >
> > On 23/01/23 17:04, Juri Lelli wrote:
> > > Hi,
> > >
> > > I've just noticed the following while testing v6.2-rc3-rt1.
> >
> > I'm still seeing the following on v6.4-rt6.
> >
> > I believe 20211006164628.s2mtsdd2jdbfyf7g@linutronix.de should cure it,
> > but I don't think it did go anywhere?
> 
> The raw lock cyclictest deltas don't look great.  I shut it up with the
> below.  For my i915 equipped lappy, a raw lock fix would be just fine,
> its cyclictest numbers already being well south of 'oh dear'.

Right, thanks for sharing!

Looks like Sebastian is on holiday, so I guess we'll need to wait till
he's back to see which solution he prefer.

Best,
Juri

