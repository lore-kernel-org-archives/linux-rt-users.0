Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F139FC4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF76921852
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSNs5Dcw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfDEOfh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:35:37 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53691 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOfh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 10:35:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so6954706wmj.3
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 07:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=oaghjbRPgTStOVIiQnkD8CjtdrBk20L7b35hvWAolnw=;
        b=GSNs5DcwFCt9mS+nEH3N637H7UYNy2qtUX+UAOPSZy3eaqSCmeR0+z1MzfjsSlAENR
         vuOc8VChmvG2Pqlh5bHyRk7Lyn35aTZizjDh9Z/7oy1t5Jv6Kc3XJG+mcjKL9mT9fw9K
         hQgGYbou63Fjey4ywmId9ic40yWweK43QE3/+fwaRzp7oGfhq/zgxZvpYqbvaiZdO2hl
         /aBaYI3h+LUnMA1BiEcWc6FYNqPGxpHfE31EwcB3GTmhfI/HtkxVrp0087F5QlJxHaHV
         wuf013I/MI48oBbzvNwkKnMmkhpD2PCp0zV3BXSZimT4l17XQuXv/SPQ14e8D377gc2z
         c2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=oaghjbRPgTStOVIiQnkD8CjtdrBk20L7b35hvWAolnw=;
        b=OCbBc4p419rl28riYyYiv83YPLZrqpw/4oT/gRD9sbXtVMox1BlQqJmYqftADOrdSz
         Qy9KcYKMl5SNyFyo4yGAwYm9pbSdibEnxQ/qqQIAAywzfXSyqmJ7DI9PRUY4GOwOfvaC
         dyK9rRIBwNTLVwu4ALh+f+cT1O3dnJ7h5IxawVGAdYp9pTcveb8+/vuNqSj5GNQC41xO
         /QQH45uKK6eZLHQos/+ZzGmUU0cBWzKONmIobhrY/RbrmK3fWt3HqE9g2AjFfXsOMeD8
         jwqbs2cEY/51iT+t0vk7gCP4tEm0dMTGm4tBftl+CQj5TlmjJMNzBTotMV1QIwmvOxAx
         WStg==
X-Gm-Message-State: APjAAAUt++jz25bcwUE0FaubHqKZlh/Zzt8gZtcVZp6xSlgZHrRSQHs5
        pQldqcoi6Si1iLqI3YB1gf8=
X-Google-Smtp-Source: APXvYqwMxOOwuvjrs7Rgm4UkYCCPoIRWDXjKaAOJ9RRxCzE2gwqYvAjwExumTrJfZVtwn3JBZMxfwg==
X-Received: by 2002:a1c:4cf:: with SMTP id 198mr8090417wme.125.1554474935034;
        Fri, 05 Apr 2019 07:35:35 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id c10sm24961620wrt.65.2019.04.05.07.35.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 07:35:34 -0700 (PDT)
Date:   Fri, 5 Apr 2019 16:35:28 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 3/4] rt-tests: deadline_tests: fix stack buffer flow
In-Reply-To: <20190404134814.13376-4-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904051635140.8480@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-4-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> The appended string is actually longer than 14 characters. Use strlen() to
> compute the correct length like the other functions do.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/deadline_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index b213c206559c..4826557d0624 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -435,7 +435,7 @@ static void setup_ftrace_marker(void)
>  {
>  	struct stat st;
>  	const char *debugfs = find_debugfs();
> -	char files[strlen(debugfs) + 14];
> +	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
>  	int ret;
>  
>  	if (strlen(debugfs) == 0)
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
