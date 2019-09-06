Return-Path: <SRS0=NMSW=XB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0011C43331
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 22:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E0C2081B
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Sep 2019 22:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNgG4lbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbfIFWGW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Sep 2019 18:06:22 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:45933 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392106AbfIFWGW (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Sep 2019 18:06:22 -0400
Received: by mail-ed1-f42.google.com with SMTP id f19so7799286eds.12
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Sep 2019 15:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Ctf2fCGCOyzuiCld+Wec4lg3Dv6DzWXv1MMXQpgIfE=;
        b=lNgG4lbAERn9xYOVosyYKY9R17VFg5Hw9a1IORhKLTCw/W4N+aLnHG2624Sivj+VL9
         Kiu27MA8uqwkFTMuIZSrh5zSm2riJoPl4oFHDyBHqqDckuO14kE4sL86iXydIQZOknnK
         pDtRljNF/jN7ZM5zmg5INEj8lRBlDukXJcKS2Wztq0zbT77VQwIMv0ptUOJ8LfRD+DmF
         iQVwpPhkNYOeRe71WXff/30LfrYEQ1+d2O/39ZbptLH8pi933XhgK/C6+FG84sdQzTYk
         ebFgZEtZIgIeVibGQDFciYRVkVWUojyoq4jr0Phy+4HH6vY9ZpFMjMo+YJ/WOz66RLbC
         HqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Ctf2fCGCOyzuiCld+Wec4lg3Dv6DzWXv1MMXQpgIfE=;
        b=MUfQhwhhYMN3Iuijb86qo1FODi4ItAibCoGQTG7iNtp/Oen0p/qTptGaaelR2D+06V
         6nLFkYKLPQTUj6N8DOSg7tKCrAEG6AEjdMN1kVQCY+ZTRKy4L+q9TWxQGZg5xKgNxGI1
         SvwOYvJn4c/9MFJffnk+FX/6NuRL3FwGejvaS3cac/dbERPuNxfYUGeJysEa218ftm76
         Q9xlJU42YbpJY5W+kQle1VCceodVRCvCf9OnWFKRpgusUPYLmHGp35DUiN3lUjH7te6B
         poI6jrFjJ8tjw140pSOnniVZhGZ9AAeNGJ90/knDj398SK2M7EZ22bmGPdtgn9e8OnSN
         Hd1A==
X-Gm-Message-State: APjAAAV1ftrXUH/yjtZDcPVFL/rPZ6xUfV0IuV1RktYmbo9sCfJ2fz9P
        knX/sJc3BQQd6PlzbKuo4QHK5v7nE/IEMJ3+eus=
X-Google-Smtp-Source: APXvYqw7378fSsZWAhyBZJyEz4vr/0uojIK/wo4v3MsbXH4nQixYOJzHd96CeAUf/jHjw+MacwiTSh4EU3n0EpVHYzw=
X-Received: by 2002:a50:d903:: with SMTP id t3mr11827107edj.117.1567807580306;
 Fri, 06 Sep 2019 15:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de> <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
From:   Austin Schuh <austin.linux@gmail.com>
Date:   Fri, 6 Sep 2019 15:06:07 -0700
Message-ID: <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
Subject: Re: Long latencies during disk-io
To:     Martin.Wirth@dlr.de
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Sep 6, 2019 at 11:48 AM <Martin.Wirth@dlr.de> wrote:
> For the tracing, I at the moment have no idea how to set it up. I only did some
> tracing which was triggered by cyclictest. But that won't help here...

Modify your code to open up /sys/kernel/debug/tracing/tracing_on and
write 0 to it when you detect a high latency event.  I'd suggest
opening up the file when the code starts and writing when the event
happens, but opening and writing all at once would be fine.  I've very
successfully used that to catch events in the past.

Austin
