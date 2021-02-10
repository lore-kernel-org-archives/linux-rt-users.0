Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C280C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DF464EDC
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhBJSDW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhBJSAd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 13:00:33 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7ACC06178A
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:59:35 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id p12so1270926qvv.5
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Feb 2021 09:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=MYsAIg98qjYUjGx3mULMUm6XwUe1tV8XO+qNTdRF3ZI=;
        b=dIevtviTFv2BMLkB0W7n/fqHKfkYEzZfYTSI/rbOfAvGnNljVi6eA7G079gLX+jS9Z
         pXuae/HEUXFptM9rPnwBVhnVfuLR2z5lA4lC+rEeKwz2VcJRlQr8bulFbGd30q9EO16z
         FZAb6RBR3GMnTxKUOjvvCcYzBZSm815C7XTXuhJAEXPLtqO1cR9auEgKWL3UthAbMira
         zNv38fxIm2+iTuuArxlEfbTZeX4On0a2TOUU8rs0ZNY/pyM7scPgBqxNAtLssVBzPHP4
         BmThdLTH0gyMEq+tcJTcsfO3lI0QKvKptfaR+XAgVk5wsMGYU980u7xaesi2HMveAauK
         avpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=MYsAIg98qjYUjGx3mULMUm6XwUe1tV8XO+qNTdRF3ZI=;
        b=Mz5Defzz9m8ogwKVZhBTA/PgqbCOL0RvrbiFOz3tn4A5WTGLRWEg5Iwf7LwDgtZUgk
         1rfQkFNHPWJoihH59ZBqOhFDseep9cqWGAambqalohRLqCMngs2hnhWRLOlX2w26x2Qk
         bJSefiVApcELRh6YxtviqzpDXSGKxN3sXY9xitgSOydwdkofYBH3ju/mW88mtM0YDIg6
         Sa/p3nc5nC9sss5ZJRSTwnte18ouxQupmKf5pQqQTBiT+b/jf+njN3fKIlw0tGsdhYrs
         5msktKCn4ag12BR2deCpSxddefvgS3p3o8AMRU4CVzHEZP8Zwfpf/AWRg7wgwIjWGo5I
         1Wow==
X-Gm-Message-State: AOAM530CaApYj6eFZH476B87OKfqVqbswBkPVJBFbWKOuLOuQae6r8Ax
        j5qATxQaHTZ7cKFQM0lVhSQ=
X-Google-Smtp-Source: ABdhPJyG0CQg3fdSFNrP9XHFmzo116Z6RliTiY28uIKOmB0p4lba4eDROa1GZfsUTMXJL2eFC5zQdg==
X-Received: by 2002:a0c:e302:: with SMTP id s2mr3861865qvl.45.1612979974390;
        Wed, 10 Feb 2021 09:59:34 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id b206sm1943127qkg.97.2021.02.10.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 09:59:34 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 10 Feb 2021 12:59:29 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
In-Reply-To: <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
Message-ID: <7a61c0fd-90fe-69a4-5d26-4b688e2147b5@redhat.com>
References: <20210210165407.9770-1-dwagner@suse.de> <20210210165407.9770-2-dwagner@suse.de> <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com> <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 10 Feb 2021, Daniel Wagner wrote:

> On Wed, Feb 10, 2021 at 12:28:09PM -0500, John Kacur wrote:
> > It shouldn't be a fall through, we don't want to print the usage.
> 
> Ok. In this case I suggest we introduce for all tolls the long option
> '--version' and print only the version string.
> 
> As I have already added the long parsing option in my series 'Generate
> machine-readable output'. This was a lot of tedious work, so I would
> like to avoid to do it split out for the '--version' option. Thus, could
> you review the series and I could easily fix this problem.
> 

Are you really telling me you won't fix a problem you introduced unless
I first take all the other code you would like to get in rt-tests?

:)


John
