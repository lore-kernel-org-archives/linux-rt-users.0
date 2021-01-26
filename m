Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FE6C43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 905EE22228
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbhAZRTU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbhAZGUb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 01:20:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B4FC061574
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:19:50 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id n14so2622262qvg.5
        for <linux-rt-users@vger.kernel.org>; Mon, 25 Jan 2021 22:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=r5mZnbKYE/oDix8PANlc3H371kSq1roJKs0RuC/g+kU=;
        b=bkTo97Q1o2PPLjEaxb7KCo/0Alte2aITwtzachkoHNpWjvoG1SBqw9yMFh31VvCkqj
         fGtNqa7GCYbAzZ1MeWXuDLWjvZC7/S0uY/6o2chEXWrEuuGcOHOsJ9FYkkDTnjgIX3vo
         3AQq6Lg/G9HAa4lGrkleGi2McOGz4n1F3BEofKoNslOAIYPmUoGuAP1mERzleVP51zZJ
         KGIsnqUhztDCqutT8Yfuz+Nx69bvJ8rrQbgv/v1byGLKGxbKqz77IFMs0DsMlFDFs3Oz
         Tkxy30kqdFw7gLzyc989CVn0Q5jutRGvtj/KAz+09yZ68u/MD77dsKxrss5BU81jd6iq
         9N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=r5mZnbKYE/oDix8PANlc3H371kSq1roJKs0RuC/g+kU=;
        b=lep9KhSkXIK82frH/T7sD9aDvR/W2khEE3m/mat8z/tvgYgvYlwgjONJe3IgOL6Wl7
         0nuR+d3hWM70sfunizmSQeBDzgK+w8koVP+vnRB91yzJan7MPV44c37msCUKg8b1hNz1
         XeJrh+GKEP5aY2TFqnLheiSZmYg5Yw0pVl0nWk88xh5VVdjwbVLF7aF7EfjAO8XsC6kM
         SzeFxZmvJ9qYxWbS70bfMhuNmfo6J6MAFAgky694WJCc0AFEDJd3OJeNmXaVJ69CT6yL
         VB2Witj82f0AIfDE8v6LMOb+eO7aRcSHnymWoxqV2AEkdLQDhqz4mfUX/STqkZbjcY0L
         N7Mw==
X-Gm-Message-State: AOAM533hsCids2uxhJNRqGYjtOI2WtMPkyh0TfnPvKPH4KyhOGVBNBZf
        XM+XJNdmErhPFQvDMPMstksJFe5Sa/GMgw==
X-Google-Smtp-Source: ABdhPJzD81LIJRyESaWb/YzPE2OLAG4SQhIreQp/Lz7V4ODD9OAsrSjj8GYJP0HBaKdKSWRfSm+Pqw==
X-Received: by 2002:a0c:a98c:: with SMTP id a12mr4132920qvb.43.1611641990004;
        Mon, 25 Jan 2021 22:19:50 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-06-184-147-140-29.dsl.bell.ca. [184.147.140.29])
        by smtp.gmail.com with ESMTPSA id k14sm8449805qtj.40.2021.01.25.22.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 22:19:49 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Tue, 26 Jan 2021 01:19:48 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v3 07/19] cyclicdeadline: Add missing step command line
 argument
In-Reply-To: <20210115190936.26148-8-dwagner@suse.de>
Message-ID: <75aa6c1-967d-687d-4bac-bcbc55ba1ef0@redhat.com>
References: <20210115190936.26148-1-dwagner@suse.de> <20210115190936.26148-8-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 15 Jan 2021, Daniel Wagner wrote:

> When adding long command line options support the --step
> argument was missed out. Add it back.
> 
> Fixes: 9723329835b3 ("cyclicdeadline: Add long command line options")
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 19a7fcb6c488..cd12c7f313c2 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1013,11 +1013,12 @@ int main(int argc, char **argv)
>  			{ "duration",	required_argument,	NULL,	'D' },
>  			{ "help",	no_argument,		NULL,	'h' },
>  			{ "interval",	required_argument,	NULL,	'i' },
> +			{ "step",	required_argument,	NULL,	's' },
>  			{ "threads",	required_argument,	NULL,	't' },
>  			{ "quiet",	no_argument,		NULL,	'q' },
>  			{ NULL,		0,			NULL,	0   },
>  		};
> -		c = getopt_long(argc, argv, "a::c:D:hi:t:q", options, NULL);
> +		c = getopt_long(argc, argv, "a::c:D:hi:s:t:q", options, NULL);
>  		if (c == -1)
>  			break;
>  		switch (c) {
> -- 
> 2.29.2
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
