Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2870C433E0
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CFEA2083E
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390542AbhAZRTM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728568AbhAZGK2 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:10:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745CC06178C
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:09:09 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 19so15002426qkh.3
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4LfEUjE3wq0de8wiOdmHoknwON9JqQEacrKOy0WZd54=;
        b=apP99ChJsgRL8C09bFDJh9R2m8n7LaqZK5pR7kXFJXRBhxrFL3k0FlW4S5xm1/E0am
         0zkJQ/rlIfTZVsoZwj79IX5rsTcqN9r8sLEZDWdEIfV++KRJsgxsLG5We7r8PonNq1I1
         iRWGqzdgO5VysJmidn4CeABKEw/ywYH0t8itrx4AGquhhNblA0xxK2SojLDeRlAE56RL
         ECWFLjIVYJULAJMl1ZF4hrMLvpSedk+UH6me1a7WNFYgWn5xkXzSiWKHKT1PclblD7gm
         alGokW2+SnZ/2j9UljHC9Ccx7BWHSMddDEa1bOSX0MpLdz5DQW3BpBiKpej9Oju2TMJB
         1I1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=4LfEUjE3wq0de8wiOdmHoknwON9JqQEacrKOy0WZd54=;
        b=RgYE/nxuhQ9dmWoXMl4QJvyj+TZBvAFgLcd0yanM9GMwrrKfANOl9Lx4YbtSQ6ibRu
         Nb+7NT1wNKUgfgqT3jMLaLYCXPGeckgdZ0N3eGPUPgU+5XDMnaH85znf3HaiPVIqFc98
         1OT22kGb/nNn8UhMQC9mFhm/8ahdFibOcFlcfcEqkBQvLiNYRePGFmM+QXdN67xDmkmo
         6G/8MfZVE7L119+u/ItSeGQykntjrvHPSim70/fy98mlHhlsv2ji/qS92V13aNtO6OWK
         6pzaJKe6zxxOmHutCoRuKP1d+BojdJGh+7j9XlF24twrdLTTVsQJxvgh5g4MOVFtwVHp
         bMHw==
X-Gm-Message-State: AOAM530X6AbW1XObEjLJmgDqlibg6+XbWQgHoWZeOM44k+VsvjVnwuK0
        KZfhERpni4eVcMdZX0c6bEI=
X-Google-Smtp-Source: ABdhPJw510rG8dafZZbZ3k6vwmxCWTxRpNg7YHz5nMYOqaEipcKNPAJPtYyUii1aNV2wV4rOEyKbGw==
X-Received: by 2002:a37:5b05:: with SMTP id p5mr4308167qkb.277.1611641348630;
        Mon, 25 Jan 2021 22:09:08 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id y66sm2126775qka.17.2021.01.25.22.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:09:08 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:09:07 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 02/19] ptsematest: Return correct exit code when showing
 help
In-Reply-To: <20210115190936.26148-3-dwagner@suse.de>
Message-ID: <5ec8a5ae-1f9b-33b-832c-c26dc78cf0@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> Instead always return success, use the provided exist code.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/ptsematest/ptsematest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index 2e392299fdc4..f8f075591f4b 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -164,7 +164,7 @@ static void display_help(int error)
>  	       "                           without NUM, threads = max_cpus\n"
>  	       "                           without -t default = 1\n"
>  	       );
> -	exit(0);
> +	exit(error);
>  }
>  
>  
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
