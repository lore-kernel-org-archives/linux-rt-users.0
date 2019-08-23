Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EB4C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864AD20870
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is+h1dUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfHWPD5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:03:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53573 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfHWPD5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:03:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id 10so9182917wmp.3
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BovqvL9t+Sfb65f2Cvro+tEpAfqnwe7IxIbLhCPAVf4=;
        b=Is+h1dUigc3uMFBW1Oe2qVjyh9EMl+rzZRRndfFcI5uIHsPaHWijKvHftnmlBX/CmF
         zK7d9SZuYkXc8MKdldSmVJcoSbfrRrLpyxmWEt9uCy32WxZTkYspc0ySBD5YSChfAxv2
         35jfW1oJlElSkqRvN3Y27j4QLyS0dXEalQ2NJ13SFHldez4IMwBy1bdXs3T2c+2+0M0Q
         e4tOBKbdnlCezN00aXZIhWy13dDFOSITCQZSWu2ght5a2DlAW8PWusn23H63x8gOeMPP
         9Khj4IhLU/fpQ9g0zTaVKqkcpHvBkHnBFXTg+XeBZKfGOohMQFQtYR41U3GMS6W0tbKP
         GCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=BovqvL9t+Sfb65f2Cvro+tEpAfqnwe7IxIbLhCPAVf4=;
        b=XAUY4jQXVAPWJDQQWbn73VLBBD8zRON1TRpnfXXYmuZrebnmdDeyDrD3htRrAEt+O6
         /smMEDKdpA7GRoUgD6M3/lJL9cgb6O7mpkc/94fz8dvK13o/AUMTbBYKJfTMwyPWNMSc
         6I3BPQQTTw/K/q7GG+npbyAp6NpK/95bsSpktLyriQWnzj2SQowzXyjPia+YPrts7jKA
         LjzSYgPdx/+BpuD9beCi1H0fWSVTT96Ou1O4jLh1HIeDwzpCi7ghH6nqtozVywf7xcwY
         DORWah/lB3zIWUQeoe+iyynOFshW24sqsfPWXjDq5xyZUusBuz0iWLR4gCQQxp9VhWNy
         jvWQ==
X-Gm-Message-State: APjAAAX2negSw98H2gkZAtg7qKWukPA8/luGOmePnCFGjhFCZCGU7f91
        28mDnHBZ2c14491+3XwT7PM=
X-Google-Smtp-Source: APXvYqzUAg3vrH7SIkX4dXknnER8f2cf1AZ3ZW0XiCXD+b4sZydLBwUHQCl9pw5UBswBiEGCu5JpzQ==
X-Received: by 2002:a1c:7a10:: with SMTP id v16mr5673437wmc.2.1566572634790;
        Fri, 23 Aug 2019 08:03:54 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id g65sm5018281wma.21.2019.08.23.08.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:03:54 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:03:46 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Afzal Mohammed <afzal.mohd.ma@gmail.com>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/2] rt-tests: Allow cross compilation
In-Reply-To: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com>
Message-ID: <alpine.LFD.2.21.1908231703240.7154@planxty>
References: <eb3b222b7741d16bf45735f59015c40fcbb31ba2.1566455869.git.afzal.mohd.ma@gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 22 Aug 2019, Afzal Mohammed wrote:

> $ make CROSS_COMPILE=<my-toolchain-prefix>
> 
> currently does not cause source to be built using the intended
> toolchain, instead will use the host toolchain.
> 
> CC & AR are not updated with CROSS_COMPILE value since they are
> predefined make variables (with default cc & ar respectively) combined
> with the fact that CC & AR variables are updated in the makefile only if
> not already defined due to the usage of '?='.
> 
> Signed-off-by: Afzal Mohammed <afzal.mohd.ma@gmail.com>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 51b8dea..b573408 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1,6 +1,6 @@
>  VERSION = 1.5
> -CC?=$(CROSS_COMPILE)gcc
> -AR?=$(CROSS_COMPILE)ar
> +CC = $(CROSS_COMPILE)gcc
> +AR = $(CROSS_COMPILE)ar
>  
>  OBJDIR = bld
>  
> -- 
> 2.23.0

Signed-off-by: John Kacur <jkacur@redhat.com>
