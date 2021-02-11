Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D66C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E036C64DCD
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhBKNrN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhBKNnp (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Feb 2021 08:43:45 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF50C061574
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Feb 2021 05:42:55 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so2536603qvp.2
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Feb 2021 05:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=fGAJNf9cAv4/sCYPTM1iLzzzcSWk1eT7HBi8GEUShOM=;
        b=o1n3tS4+MxUgUJa/x7JAjd+IPuZ/jWTWnfAspUkBra6X3nQ+JoL9VoGO7V5Sj2fqwa
         qZJy62HUQ7g9nXEqLaUONs2b/lSJ/11UhOo3RjviEsbfOvlcRTA049wvi/oqO/x2Uj1R
         yvmBYf/mCirX493s/Pg9s0dpzA2Wn1HK8SAWu4KJqH0C9eKBivipBjAikH69r3xAAtyv
         5KeHrF2btoTCFBK8kDQTcei18MOKQANKpnRJo433eVkdEevcJmzqttLq4fO4FrF+IEm9
         III15K19Skokxj3xaHttIioe0ZhMVk+rIuh0rJyj8wBUZ8vFnudUH4HwFG8T5d/RdQhV
         /c6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=fGAJNf9cAv4/sCYPTM1iLzzzcSWk1eT7HBi8GEUShOM=;
        b=n+gppLPT5jg1vJX/lZlsLREON7kkSYshXp6OJABEteIwTwDnYohi1RnrDA8t1nC1WL
         UxVQmCaZtdNY5QU3wseiXHOypwo5d1PiFGDL+iy1C9cszKUPaCdVFlZ/pP/8CGpRLYse
         q8CQgchwtqHUTj2PyL+JKJEUjOW7MNRWqluOnRqHfP9JUEjbZyTIC9k0p4BGhWsAK9Vn
         Tj/s6z7YPdz8c0yCeO77HDZmW277eWl5/vTwrYZ/AKdkUvAc6D3FPu66faZ7/Iu9+pRO
         XvYqAMnnhjMb1Jz8IT7kvV+QHrk8qtPRKdf3LKjU0neC3r9ghfVRJUbrXUacKF0yj0mV
         mV6Q==
X-Gm-Message-State: AOAM532z67dicHCaKJd/2ETVGuU0tbMMEBJeT3/Rl+Rnx5vKQHwstBsr
        0rGcAXVc/aZemBxqEt96kMQ=
X-Google-Smtp-Source: ABdhPJzlgLCyPe/rboFvDFMztqHQvsnPXRlWW9ZhRMRMd/CmM2aXKfInXaoLi2svvEy9OLABEPtSBw==
X-Received: by 2002:ad4:5288:: with SMTP id v8mr1611947qvr.52.1613050975027;
        Thu, 11 Feb 2021 05:42:55 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id m5sm2103669qtu.41.2021.02.11.05.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 05:42:54 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Thu, 11 Feb 2021 08:42:41 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        "Reported-by : Peter Xu" <peterx@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: print version string
In-Reply-To: <20210211074529.wxm66aeszzfs5gek@beryllium.lan>
Message-ID: <ec91e6ef-11f7-5cb7-445-dd5bf2d467@redhat.com>
References: <20210211044221.27851-1-jkacur@redhat.com> <20210211074529.wxm66aeszzfs5gek@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 11 Feb 2021, Daniel Wagner wrote:

> > --- a/src/oslat/oslat.c
> > +++ b/src/oslat/oslat.c
> > @@ -512,7 +512,6 @@ static void handle_alarm(int code)
> >  
> >  static void usage(int error)
> >  {
> > -	printf("oslat V %1.2f\n", VERSION);
> >  	printf("Usage:\n"
> 
> Why do you remove the version string in the usage output. Every other
> tool prints it?
> 
> 

Because the version is printed out before the call to parse the options.
If you don't remove it here, it gets printed out twice.

John
