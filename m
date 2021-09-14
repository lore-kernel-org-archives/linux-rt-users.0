Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0D4C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD08610D1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 18:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhINSd6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 14:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229728AbhINSd6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 14:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631644360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcQb3oS79cQI0C+qfu1gfQPH403dpf2K5PH7iLk2pZU=;
        b=DR4RT+xXz2SKhsUMxRqYCw0dXUHDloioitF361dXE2HGWHSReHgxF/T9CGmS0JmyicY1St
        vEZIF0i4yqGEPAJWu0Kz8H6PW9pkE1UUTIn7fHVEKesAUYxWJO/g4AvrhCPUsYFeW2vLV3
        RcXeFP/s+cEdx2k9t4uBmL9+1NjNPf8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-mcFjj3bUMg2r3I9T_D1ipg-1; Tue, 14 Sep 2021 14:32:38 -0400
X-MC-Unique: mcFjj3bUMg2r3I9T_D1ipg-1
Received: by mail-qv1-f71.google.com with SMTP id cf6-20020a05621403e600b0037a70d2f960so565965qvb.13
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 11:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=BcQb3oS79cQI0C+qfu1gfQPH403dpf2K5PH7iLk2pZU=;
        b=Id/4rXgAcf0bi0TLw2kBfEmocKsQd30zMj2MMBuY2JE3RPhb2Hh6k4R0guILyLM45N
         +M8lwm7cH0qdiTQJ6RCnjcvetSrGxKJht31kXO94BpscRZT28iMQNx+6E2boWv3CCBkg
         JOWYlHdJBXZ7X9Di8IkoC0Hh1FzPhbrTDNlybzjxsHjTZMCFhn6I826Izt7TFetx8ga1
         lAw4WW9aXyrnqAVDEfjfTKzKWoM9NeWHUWyQZVIZuHIBja3z+gMtEIsLxMTfkTSwgpoy
         mel9v2W8dtDqhE4PTErCZACBFhapE/AQWgVxDoUc9Trd+JJ6qsNQ2028cgqXU01S7icg
         4OcQ==
X-Gm-Message-State: AOAM533Ww4qGoRyr0oPbCqc0M4VUU32/gyuyD0U5YBkq7fImimDJajnx
        zaOAnK990ZR4jWzABoGW5K+XO7e8dyrHJQHX5HlqlYqT0shg7SrEYVEWyevQptVJMgjQOCmht+t
        HQNzF7CLwZ8x55JTXhPiZYuTqJsY=
X-Received: by 2002:ac8:5f0b:: with SMTP id x11mr6160520qta.95.1631644358374;
        Tue, 14 Sep 2021 11:32:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6yXeqlrtYJ6w2/SLgaWdyvAjFWHd13FdlTkvt5pzwpPRmTPCfQ2imM+bsDS0tQ2+Jo9dXlw==
X-Received: by 2002:ac8:5f0b:: with SMTP id x11mr6160506qta.95.1631644358164;
        Tue, 14 Sep 2021 11:32:38 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id i18sm8197462qke.103.2021.09.14.11.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 11:32:37 -0700 (PDT)
Date:   Tue, 14 Sep 2021 14:32:36 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 4/5] rteval: hackbench.py: Enable running on a system
 with low memory
In-Reply-To: <20210901080816.721731-5-punitagrawal@gmail.com>
Message-ID: <64b0ee4c-41d4-9c76-98cf-b2459bdf214@redhat.com>
References: <20210901080816.721731-1-punitagrawal@gmail.com> <20210901080816.721731-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 1 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> The hackbench workload refues to run on RockPro64, a hexacore 64bit
> Arm board with 4GB memory, complaining about insufficient memory
> per-core.
> 
> On further investigation, it turns out that workload is using an
> arbitrary limit of 0.75 GB/core but will quite happily run on much
> lower lower memory systems.
> 
> Instead of preventing execution, convert the info message to a warning
> when the memory is lower than expected but continue execution. This
> should enable the workload to be used on a wider range of systems.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/loads/hackbench.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/rteval/modules/loads/hackbench.py b/rteval/modules/loads/hackbench.py
> index 3b692070e9d9..ab028c495d8b 100644
> --- a/rteval/modules/loads/hackbench.py
> +++ b/rteval/modules/loads/hackbench.py
> @@ -55,9 +55,8 @@ class Hackbench(CommandLineLoad):
>          if ratio >= 0.75:
>              mult = float(self._cfg.setdefault('jobspercore', 2))
>          else:
> -            self._log(Log.INFO, "Low memory system (%f GB/core)! Not running" % ratio)
> +            self._log(Log.WARN, "Low memory system (%f GB/core)!" % ratio)
>              mult = 0
> -            self._donotrun = True
>  
>          sysTop = SysTopology()
>          # get the number of nodes
> -- 
> 2.32.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

