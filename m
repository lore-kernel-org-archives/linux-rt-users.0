Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A2DFC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188B26145D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 16:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbhEGQr5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 12:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhEGQr4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 12:47:56 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41A0C061574
        for <linux-rt-users@vger.kernel.org>; Fri,  7 May 2021 09:46:55 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id i17so9084710qki.3
        for <linux-rt-users@vger.kernel.org>; Fri, 07 May 2021 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=plY+aTHMsEYkOSzOLlPHXqAJw9gh7OHc11emLczQ7C0=;
        b=hzSQQE2d4uNcNBaNyPiQplgEw5MTDVkcNWdtMu0xy7mDEm0nGroKfTSdzmONYpU/rH
         ZOaVeXSyE68RYw4cebIqTkmciCxsQg6IbyIlUmMSj1GikvoLKLjmEhoRiHWq9fuscitE
         38M2qAti+7Gm4e888YzUomgLDVOExES9JJbnpIzspbZy39EX2gsUQksF8/fmPebL43hh
         G5deuQqw7E9NhTuyTR681RITDkfeNUKtdCx/Bhi78RJMBfG5kP2YrK73becfvaRu69bn
         ET+qKxLBCuifb9ay0rNBo1gt9JZYUmib+WnLdHKMZUMU/4F7p8ags8qShWkB4IyEvq9e
         0AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=plY+aTHMsEYkOSzOLlPHXqAJw9gh7OHc11emLczQ7C0=;
        b=ainWDQDaB5J7zg+DZt4O9mxJ5zdJMkbDQMCgEt+L/nFHeaWKPl64f6hvIV++FyQeVt
         2uA4q3F58zo8QM4lJvJiKYQEBSLyXkGE3WQrGKQuke7M+SoVc9a5MqLJ0WVsuWiQP2qo
         Kex78t2c8jjDA3KQ5IxhY1Di6oxXSLv4375KeaMPXVLkUm09ut4KBVxxr2Y7zIK5cY1V
         CoSM9U0Lui7obOXVNwNzI4zEGe0IOMOdYhRg2Ye3W12Tt7QYAucs4rTPSdW1n39zS8yS
         IyFGCofOSozu1aLr+45bNmiAFoZQfzvVB4iz5t1JA/jJrCQE96gpAPhMhbk0TtHm8437
         LTIw==
X-Gm-Message-State: AOAM530BViTLKonjgQmtkb0/fbZokNoUpfjHQexmm1QnXxrl9mkZJTNV
        DEVmKC724ipu7qbJGYHBY7k=
X-Google-Smtp-Source: ABdhPJxuZtgf9OwKFwch1U31398c3jhFtlKYrE9xxTPJt3nf46sfKHm/2g7klh+0BDgoVlixhrIT1g==
X-Received: by 2002:a37:a90e:: with SMTP id s14mr10618678qke.262.1620406015159;
        Fri, 07 May 2021 09:46:55 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-133.dsl.bell.ca. [174.88.120.133])
        by smtp.gmail.com with ESMTPSA id x18sm28699qtq.40.2021.05.07.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 09:46:54 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
Date:   Fri, 7 May 2021 12:46:54 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 24/33] svsematest: Record start of test
 execution
In-Reply-To: <20210320183829.1318-25-dwagner@suse.de>
Message-ID: <546d353a-536d-2331-951c-72832faedd5@redhat.com>
References: <20210320183829.1318-1-dwagner@suse.de> <20210320183829.1318-25-dwagner@suse.de>
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
>  src/svsematest/svsematest.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 7c9d21edbab2..7533b1b569cc 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -724,6 +724,7 @@ int main(int argc, char *argv[])
>  			    &sender[i]);
>  	}
>  
> +	rt_test_start();
>  	while (!mustshutdown) {
>  		for (i = 0; i < num_threads; i++)
>  			mustshutdown |= receiver[i].shutdown |
> -- 
> 2.30.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
