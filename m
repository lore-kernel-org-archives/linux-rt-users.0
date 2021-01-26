Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425EDC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB0F22B3F
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 06:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbhAZGlq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732736AbhAZGku (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:40:50 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E78C061573
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:40:10 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id u20so6404710qku.7
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=npxR5nV58n/SLgjZiy5DOWkJqz6X8Ruh8sY8+ohHCCg=;
        b=e4N+QoYKeP4/Mwd3tssZj0hXkD6sLPCyjKlYhpWuWuOWyRg+GPJkvrpgB9/b5a6Q+c
         Z9lNGVxpnS60X0iDM7BeRKrIo+6dRni24hVXrlkKD6ssnxEMp3xFs/zpSCoU+RsyL4mE
         1NbznFaRumeX5YWKjjpt7heK2iXbcIyMIcq1WBy7cRdWhYu9R2658FYad+9ELnRvAn1x
         z/pqBANEWHumla4z4B9omS6DfcIluC/4bbprGtMsSfJaMV56laTIGbVvuq2jIa0XCtDk
         CxLBH34X8OvwhhqKctWlURlINz0HNTQfIB3++1JWBcuO/k2/raQjx4Cd9SmxX+wgFxS6
         gtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=npxR5nV58n/SLgjZiy5DOWkJqz6X8Ruh8sY8+ohHCCg=;
        b=I2kPeDSpmVDc9UcsjmGYFJe+L7/C2sadJqA8CwH3sVhq/DJn9eWT5I2Dj6xFT7SBFz
         injbZbYi3gDeWcIh86DdlFKjpZsWoGhLNbHjMSVCrGO/0Zsz07ggY58yVIXHRul2LQSI
         DcwE9xmD/BrOHt4mEaDxxJ3ZE6pmtoNuBzKWiEvwiwkWIEFojMCcA3bffpndwK17LVN2
         9obP6cxi/MCOono83Y7AB+Tpjf2w2uygGDdEFT6WPOLJ784QMw+cIJk1sozbQii/MyOt
         RsLH0bs2/7L6qiMVA2msE8fNcPeuNljH/JT57CnkWp9ahLdkEW2eROcYy4rIPJRWe5dS
         NPxA==
X-Gm-Message-State: AOAM532886sV1gy1ByzGYCzDh6oBJNFajiXnkeTe9W+PwkT+MG3sqodT
        Jue4KzndgpXTO32gTRwAy38=
X-Google-Smtp-Source: ABdhPJztAB7SEe9cx/utVQPwcm4b/ciVrGuO70jYJzPYaXFXymHVSmdfoXYRhTmzWfk5jjM2E8HaQg==
X-Received: by 2002:a37:617:: with SMTP id 23mr4434175qkg.219.1611643209693;
        Mon, 25 Jan 2021 22:40:09 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id i18sm13630145qkg.66.2021.01.25.22.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:40:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:40:08 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 14/20] rt-numa: Use error message helpers
In-Reply-To: <20201218161843.1764-15-dwagner@suse.de>
Message-ID: <b077fc9-8e4b-caba-82ce-567cae14cf1e@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20201218161843.1764-15-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 18 Dec 2020, Daniel Wagner wrote:

> As we have our small error message helpers use them.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/lib/rt-numa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/lib/rt-numa.c b/src/lib/rt-numa.c
> index fc7adb4d467a..3a8441d5151c 100644
> --- a/src/lib/rt-numa.c
> +++ b/src/lib/rt-numa.c
> @@ -40,7 +40,7 @@ static int cpu_for_thread_sp(int thread_num, int max_cpus, struct bitmask *cpuma
>  			cpu++;
>  		}
>  	}
> -	fprintf(stderr, "Bug in cpu mask handling code.\n");
> +	warn("Bug in cpu mask handling code.\n");
>  	return 0;
>  }
>  
> @@ -68,7 +68,7 @@ static int cpu_for_thread_ua(int thread_num, int max_cpus)
>  		}
>  	}
>  
> -	fprintf(stderr, "Bug in cpu mask handling code.\n");
> +	warn("Bug in cpu mask handling code.\n");
>  	return 0;
>  }
>  
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
