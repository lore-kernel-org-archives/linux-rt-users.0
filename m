Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DDCC5517A
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A2A221F1
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLflXGf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgKKCcU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731610AbgKKCcU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 21:32:20 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4B5C0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:32:20 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id x13so233253qvk.8
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MxK9tpLm0xZ2FwXdot5w/Ozxd4AT6TctKJagXsk7ysE=;
        b=DLflXGf31EIKlPshAKQPn943Sig351mHE1Uil4LBNdbcJX4j++bsg9mddL7yVlv+iC
         4iqWTQ7tIxzePBeJvJe7FbiDHXJdfcUrKp1alVXjcds13yEP+PuR2pbMXgpqtJSABVJK
         D5MqcgbINNx+AxmMhisXAuc4m3CMKRTAhDh/fnM/v4yn4i65DnSuAeDGBQGzvuxEY7fL
         mQf5D5deUk7Gvi13ZkWLjgiq9oOhw+PZ6v7YxC5pNCsZE56trDhf693QVXxfjJvk+UFL
         i6pxybI3mTPY/IXyTL0Q7fMZM9VotvHOAT71naK3nL/cytAk3+s0esAli4HoBdki4LLU
         Omdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=MxK9tpLm0xZ2FwXdot5w/Ozxd4AT6TctKJagXsk7ysE=;
        b=Zc5Slzy+tdfopKpt3H0HRkIQQyxxbpYnP6ww1xfQx+A8J5fQnOw73EQWqKC6/DDADq
         u54N99T6PZdCOYap1vjnIqZe/4xeQKrk3K1STmMR1bmg1d60qEsMWEolnnujPZTMFbrr
         ZR/mk0BTDi5vf5J5pz70Gmn58idADkmPTkvNC4GhtGd5HvmJ/7GMz6gRAcjpSMHgm9Vr
         dBzcOhUfDHFDB/qBmh6rd3hD09CcJhh1ZiMKC9PAyjB7S3eOqn8wmppahqdrVhXO+4rr
         /qpYte9BVnIabrFKkiPMkUtnEJflqNZN+BDqirEgUdVv5SH/lwbyM/62KKs6UI2bfmGO
         6HVw==
X-Gm-Message-State: AOAM533FOEOZS/ibI8fdeM/HFUlaZyhrkonzmqIIlcNOOWD3wsN6bFfx
        Mhh4NSWHVZusEcRalZysGLg=
X-Google-Smtp-Source: ABdhPJzMoZLM/w9dZbUhbZPEc1SwPSE6/IRaVw3rdnFkJoySzzhwdXYK6Vb1/3sY8UO3zgx5KHwiTA==
X-Received: by 2002:a05:6214:9c4:: with SMTP id dp4mr2396599qvb.44.1605061939537;
        Tue, 10 Nov 2020 18:32:19 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id r16sm800504qta.14.2020.11.10.18.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 18:32:19 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 21:32:18 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/4] rt-tests: cyclictest: Close correct trace fds
In-Reply-To: <20201107095843.11909-4-kurt@linutronix.de>
Message-ID: <81ca851f-26cc-f533-02a-a1a823fd7e3f@redhat.com>
References: <20201107095843.11909-1-kurt@linutronix.de> <20201107095843.11909-4-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 7 Nov 2020, Kurt Kanzenbach wrote:

> Remove the last lefotovers from migrating cyclictest to rt-utils.
> 
> The rt-utils module is reponsible for handling the tracing code.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/cyclictest/cyclictest.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 34aa9be583f8..0ec0b235dba3 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -283,9 +283,6 @@ enum {
>  	ERROR_NOTFOUND	= -2,
>  };
>  
> -static int trace_fd     = -1;
> -static int tracemark_fd = -1;
> -
>  /*
>   * Raise the soft priority limit up to prio, if that is less than or equal
>   * to the hard limit
> @@ -2272,10 +2269,7 @@ int main(int argc, char **argv)
>  	}
>   out:
>  	/* close any tracer file descriptors */
> -	if (tracemark_fd >= 0)
> -		close(tracemark_fd);
> -	if (trace_fd >= 0)
> -		close(trace_fd);
> +	disable_trace_mark();
>  
>  	/* unlock everything */
>  	if (lockall)
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
