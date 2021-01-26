Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6F7C43333
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84B0022286
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbhAZRTB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbhAZGH3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:07:29 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21894C061574
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:06:47 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id k193so14965678qke.6
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=zJ1ZNoSXjld4MYEOeeyAMYFm1mao4v//6l26JzcIQrA=;
        b=Jz2b3rU1g959tdc3tlBEHdHghfxgb6L8eEmpnx8txPO5qp7i74I1O5J+z+8p7d1l5Z
         iMZVwAavdCShmiUNnk72q4RTFlmKw0367iKYg4AeKLLy4Z5MwANEZvGA+vtLBfc108fn
         ZwKnwvlRgV7KQ8YWgmjUOas5ClYh1G90tb56MF+jHVL4NqV2q87bOlHJGbWINN8YLIgm
         DK45uf6Wsfq8M5tcD3EGedien2axO31mvpcfaLc7SfW/Z9eXsvJ/3nAyMLQkcsRR13+A
         Ne+DsR/nOhxtuqO1vMolHbJNjTXGTtiKq4Ywn6Hq1a/dzxnEbjg2zaCMkoJMW+L7gipA
         wE6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=zJ1ZNoSXjld4MYEOeeyAMYFm1mao4v//6l26JzcIQrA=;
        b=EXsl4SgqCsKmdEeY1rBWEKSQTKysa1+nnwXn3Z7PraM48WN7cJEsAiAOXY0Nt/Hrgx
         dgkp3CYNDiaMYG2/8EzlvWfnpI9/aYHESfddHHc08r31/K3+KANnf85QgraJAqc1QIlN
         lMtm76rYPXBGzN16GoW3j1PHok7q5cs+E5ffhzIlMvixxWpysk2oB0FKNG80UXwfLoWw
         P8I4Qg4sgrFriCdjbic1rCP2UWisqIAO0ycXY0Uek0mSr2WMzz60LTiDzjGF9KzVuOpC
         dhozY2DNVj8S/tnGQzLUHVnVoxL7rVi2FuQ0UxCQ9j1LfVkPlGaxkM1uMq3KO7E98hR4
         sRtg==
X-Gm-Message-State: AOAM531AAIhOJO3py60dby0bBuNtC53JUVyDcWaxWsTQxX259ihCHaGZ
        Z8vHlbsYcmrL+4T4ELSmhxeuXwjuGOpISQ==
X-Google-Smtp-Source: ABdhPJxgTrkb8cIfP2SzZDLNDOBO2owxYjm2cpiDNBog90Vgs8tK6+RgR/85Uy0467XPDH+z69KAbw==
X-Received: by 2002:a37:9b8b:: with SMTP id d133mr4070646qke.71.1611641206459;
        Mon, 25 Jan 2021 22:06:46 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id a21sm13682739qkb.124.2021.01.25.22.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:06:46 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:06:45 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 01/19] pip_stress: De-constify prio_min
In-Reply-To: <20210115190936.26148-2-dwagner@suse.de>
Message-ID: <e8f8b6ea-e0b6-62f3-33c-fa1205ee588@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> This variables is updated by the result of
> sched_get_priority_min(). Hence, it can't be const.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/pi_tests/pip_stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 4583aa40a6b8..8b91578f9ab8 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -65,7 +65,7 @@ struct State {
>  struct State *statep;
>  
>  const int policy = SCHED_FIFO;
> -const int prio_min;	/* Initialized for the minimum priority of policy */
> +static int prio_min;	/* Initialized for the minimum priority of policy */
>  
>  static void usage(int error)
>  {
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
