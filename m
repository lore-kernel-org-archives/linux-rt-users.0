Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C0C7EE29
	for <linux-rt-users@archiver.kernel.org>; Fri,  2 Jun 2023 21:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjFBVG1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 2 Jun 2023 17:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjFBVG0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 2 Jun 2023 17:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7FAE74
        for <linux-rt-users@vger.kernel.org>; Fri,  2 Jun 2023 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685739930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YYvHvicuiJnDpTYP2tiCP38QQvuOnsXoIl7s38NiVeg=;
        b=DlBSu0vBs7yHOKe/mecjnkTHxGXNb/Ay1VN0DPK/7+9xK4xL2Qi2PhM+aks14zVG6tofBK
        q6Q9GatX287H/SuL2z/JxGonX1VE6AGZvfoLjOD/8lzbd8p8noBmpXU3/W15A8XwIK/7Oc
        IfdUAcB8TGpPhTV6HojNhDwKtHkAqgM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-_bFGP02OOaGLCXYuroCz0w-1; Fri, 02 Jun 2023 17:05:29 -0400
X-MC-Unique: _bFGP02OOaGLCXYuroCz0w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62609400a3bso35582236d6.2
        for <linux-rt-users@vger.kernel.org>; Fri, 02 Jun 2023 14:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685739929; x=1688331929;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYvHvicuiJnDpTYP2tiCP38QQvuOnsXoIl7s38NiVeg=;
        b=chooNyGgZCk7zpxEc61/P2m0meV0CU6yAEv2fxgbbq62fXD+EV6jqHUBpQixgTvBF3
         Zt+CBt+PE04A46qrAxXEK37kBSzXdB2pQJe4F5G1SlRSsquNz8qx7DVtoFpBsIguAiHq
         K82mj54gQ4K29MTkipLlnCtTv5N5MeVgwiva5cZE9QmNw2k/r1+CramPsGZNyz8LICQo
         m1n9CYxZvW9unHZuuDfBxdnjnbCTh61Q7FhyyP1+61lYRHiA2JLJ41ndu0wTH4J+ZoIT
         /YegbqObEp0YcJHGcKkHs3r6/Uqa5lcOm/Bo+/5CUf9vykAaAn29FwXCXhxwMuSnt0Vf
         Gyig==
X-Gm-Message-State: AC+VfDzawLyBG9uhBqpZKbLwxicazcvYoNOML0WVfLzFx2CH0Uzov4NE
        Gx/ESEaKssQmG6kiTYj/fGjaT3vvTJ+e15OHmgGEx/jfDGyVwX3x0jA8p0MrA21pAJjTl3T1khI
        9dE92PMOHZ2TnCwVK8R0w1oQEhYR7lCRKxOI=
X-Received: by 2002:a05:6214:19e6:b0:629:58a7:9a9d with SMTP id q6-20020a05621419e600b0062958a79a9dmr3436439qvc.10.1685739929090;
        Fri, 02 Jun 2023 14:05:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4aO95X+sZmwllpIpZLiIz7NBg/t92AYrb1JbmSbRxu/ai09B2atK6PpPtc6N5Up8OjtCi8Pw==
X-Received: by 2002:a05:6214:19e6:b0:629:58a7:9a9d with SMTP id q6-20020a05621419e600b0062958a79a9dmr3436420qvc.10.1685739928846;
        Fri, 02 Jun 2023 14:05:28 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-56.dsl.bell.ca. [184.147.141.56])
        by smtp.gmail.com with ESMTPSA id e11-20020ad450cb000000b00626234be222sm1288209qvq.57.2023.06.02.14.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:05:28 -0700 (PDT)
Date:   Fri, 2 Jun 2023 17:05:06 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] oslat: remove newline from tracemark message
In-Reply-To: <ZHj54pQWZ/RfAE/l@tpad>
Message-ID: <f0f98a79-be73-bbe9-ea2c-b99a8166691@redhat.com>
References: <ZHj54pQWZ/RfAE/l@tpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 1 Jun 2023, Marcelo Tosatti wrote:

> 
> Remove the newline from the trace mark message: it breaks 
> tools that expect the trace files to contain the standard 
> trace format on each new trace line.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index b680f1e..99f86b8 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -337,8 +337,7 @@ static void insert_bucket(struct thread *t, stamp_t value)
>  	lat = (value * g.unit_per_us + t->counter_mhz - 1) / t->counter_mhz;
>  	us = (double)lat / g.unit_per_us;
>  	if (!g.preheat && g.trace_threshold && us >= g.trace_threshold) {
> -		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n"
> -		    "Stopping the test.\n";
> +		char *line = "%s: Trace threshold (%d us) triggered on cpu %d with %.*f us!\n";
>  		tracemark(line, g.app_name, g.trace_threshold, t->core_i,
>  			  g.precision, us);
>  		err_quit(line, g.app_name, g.trace_threshold, t->core_i,
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

