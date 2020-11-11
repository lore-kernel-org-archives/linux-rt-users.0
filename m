Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46EC388F7
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05710221F1
	for <linux-rt-users@archiver.kernel.org>; Wed, 11 Nov 2020 02:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCFci7mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgKKCeM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Nov 2020 21:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKCeM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Nov 2020 21:34:12 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8779BC0613D1
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:34:10 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id d28so405244qka.11
        for <linux-rt-users@vger.kernel.org>; Tue, 10 Nov 2020 18:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=WjSU7Ym4Jjw/y5PB8GaAD/acsOISftn1JjCw2ZOWnxU=;
        b=QCFci7mDrstrI385CF02ytnIX08RhtvAkSzHmJA+WbPkkhfLqLNo2SqlinHH85Fzu8
         JSJ+qHYFBF2m1xec+lIfL4qJoNP0/GP3u33ZiD3zg3R8FwXKfQyrhqq8gPmUXfRm3u5A
         kQma27uc3df1cvppi/jMhD82mSXebd9jm7e02fX2yh4pep4obF7cJ05w51ZpIZZNbFUL
         Vrq5vEXzOUjm87d29iK1kBT+XFILYoZf2K/69Hl4i5eA3SC3LnaTjpoPlwU5SC4f3fSG
         jPi+/jPm9KUA8cQbw3D4Q4P5xHHJ3l4lk5CExA2MVYkcOezPO1JvhCcGpHi9nNZGF+wq
         4HHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=WjSU7Ym4Jjw/y5PB8GaAD/acsOISftn1JjCw2ZOWnxU=;
        b=r9l/8789H5uQXf3jjrNLZwvzGK5ra/vjRHwRCbjmSe6HToT0wVzqECYs+x6oGbcLx3
         FDmXWp2NS7zczesN1yw/nFk5qOKisLomjFudXhBFbEPOTiQtqKkM8zYWq1s0iG3dGTCb
         Ax+6cHvycGK5Bkcd5AZJ+1tH9PErdurVqZ1ihtrrV7DYnmeGyuzJaO8Zra/MB/qHTbaf
         v2/6MbpqNFs7ivQ0q5QlHlr+VZGzvkpaU7mAK7xd+rawJRvDMoOCVtTFr4gcGAQllmdg
         pEi9ldyz+aiRMKXHa8ABIiz1yzUldo9BpjoMqxEvXsH4lL481oF5gq71mOpZF4IXa+0h
         +21Q==
X-Gm-Message-State: AOAM530JC64R2s/CKJZLq1snWcjwoCFr5yawPqhRAqsqoUb09SufoOM/
        vBWy7V/7MFeCf21CHYi8Q44=
X-Google-Smtp-Source: ABdhPJxEEsvHZdkFoADxI0L9DqYZyG4Whi53Qnpet5BkS9E57gs1BhYqXgX67cnWaAxlyzcr9FZ+jQ==
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr23381011qkf.250.1605062049735;
        Tue, 10 Nov 2020 18:34:09 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-10-174-88-120-216.dsl.bell.ca. [174.88.120.216])
        by smtp.gmail.com with ESMTPSA id m5sm778341qtp.51.2020.11.10.18.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 18:34:09 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 10 Nov 2020 21:34:08 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/4] rt-tests: oslat: Close trace fds
In-Reply-To: <20201107095843.11909-5-kurt@linutronix.de>
Message-ID: <70441dce-b973-fc2e-f5c6-b314ec7f91f@redhat.com>
References: <20201107095843.11909-1-kurt@linutronix.de> <20201107095843.11909-5-kurt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Sat, 7 Nov 2020, Kurt Kanzenbach wrote:

> oslat is also using enable_trace_mark() and never closes the fds. Add it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/oslat/oslat.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/oslat/oslat.c b/src/oslat/oslat.c
> index 918e6733c066..0018c472e0c1 100644
> --- a/src/oslat/oslat.c
> +++ b/src/oslat/oslat.c
> @@ -871,5 +871,7 @@ int main(int argc, char *argv[])
>  		g.cpu_list = NULL;
>  	}
>  
> +	disable_trace_mark();
> +
>  	return 0;
>  }
> -- 
> 2.26.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
