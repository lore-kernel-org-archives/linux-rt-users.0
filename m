Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98AF3C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 680446145D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbhEGQoQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhEGQoQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:44:16 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AFAC061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:43:15 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id h21so3274584qtu.5
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=GbW+EPyv2GDaYNWqRhUxxa6UNqkhGLSXF5Mp64imGO8=;
        b=tcysudDfYhtlKx3LGnk4T8QbjVEawH1JjIxziwuuy7cPC++V9OSbIehwHGYOg4U+04
         ejbnkuKaE9eIk2ufzFy+ZXPpVkg/BeoketsOj48JCeIdo4w0MDL/qHYSVCUnmG6I1ouJ
         3aT/KYshnIVmtyG29bcqhL0AeJ0nHD7UXt31qqQPNZOd+hwapp92B3px1LAqMi5vg22F
         SzCqQg74lur/SrdqgEuIZQnRRf2bWB5N9rjKt9+NQ5eYjoNXaKDjyAX1Gw2jw3Bdki9V
         0OD7C/vjuQ6Vik5vsxTSHOsaNjy6zZDT2d92+50kcwzPOijQIciOctSimgRdqKLerq83
         YPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=GbW+EPyv2GDaYNWqRhUxxa6UNqkhGLSXF5Mp64imGO8=;
        b=fEcUzBkENlj/XL1+DSUPcIEiyU+VpEPYbkEJFmeToyhSRxk/QGhqDwlMjq6/r3jOe3
         E5pPY4CvT3Ks+5LCOoRtrOgU0D/CJZKq60LkbXb808aKoSI/5cg7rCTAMpHES99SnDR4
         erX85KsqnHooaJnUpGku15PdZHXTDZso0DiulTlZ4fzM/TQDavXyseVZWN9Tc7HdX988
         iQDo3pYKIks54lZA/PLY+FRsFxyMVNNG1dDXUZ6HoP62B4JMhT2P0ov4V8g6Gz0Ciksk
         Nj65T2Sn7KRL5FGQwkYcmFlHrL3AJVbr2vx5URT+ymK2eJ9/pwJYCLsVZgSYP23BisYI
         60Ew==
X-Gm-Message-State: AOAM530RB591ibJUxwY9waUz/IZnxEZEF9XkzJeVEKABm0PilpGd+vQ9
        UznI4PH0SqNkeUbYNkavUx8=
X-Google-Smtp-Source: ABdhPJwT9DGtM0ICpw0AmCh607WXCuGIKbhqGzzlDc5WpwQuinwPATcT+dzknFePoGsWMUlsJYV1TA==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr10626939qta.362.1620405794437;
        Fri, 07 May 2021 09:43:14 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id t18sm5249686qkj.75.2021.05.07.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:43:14 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:43:13 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 18/33] pmqtest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-19-dwagner@suse.de>
Message-ID: <8b810c7-58eb-d025-d853-d461c095665@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-19-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 20 Mar 2021, Daniel Wagner wrote:

> Use rt_test_start() to record a timestamp when the test starts.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pmqtest/pmqtest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index f96b3d0bf400..adf72c10ce83 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -583,6 +583,7 @@ int main(int argc, char *argv[])
>  	sigemptyset(&sigset);
>  	pthread_sigmask(SIG_SETMASK, &sigset, NULL);
>  
> +	rt_test_start();
>  	do {
>  		int newsamples = 0, newtimeoutcount = 0;
>  		int minsamples = INT_MAX;
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
