Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16C1C56201
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 20:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D811246AA
	for <linux-rt-users@archiver.kernel.org>; Wed, 18 Nov 2020 20:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huB7XrU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKRU7M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 18 Nov 2020 15:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgKRU7M (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 18 Nov 2020 15:59:12 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A94C0613D4
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 12:59:11 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id b16so2759364qtb.6
        for <linux-rt-users@vger.kernel.org>; Wed, 18 Nov 2020 12:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=UDHZm8Ddad+DvuQIzD0sKurLkiInICwju2HsjMjGe2E=;
        b=huB7XrU7GiGoxf3ZlaefM5NFFhcR4uFeXxLJM3qYc2aA8A+vnnqdfrjaKXzi/FZG47
         cY0o3R/c0hRG3CU/8cYedz5cUCohmRUDMvHz6p8gykGHpDGl8sDRG6lBcM01bkTU0YYb
         8kYVriwm539dYSgLJliJtD6r/GsWGUgQyLEAgPWEe/426XScf6KQRjy0quS+yx9Cql9u
         YE5ipJzvAC5cRcfQjXsc8SbgzX9otKLXyLf+YL/9r40IchvbjP2JVHySmZpaawTpVdGm
         FXIWGROIszhUMV7nKdlRToXkCKWfHEIMYa7r7Y4hcck77ttljF9mEB4u+XEzuqsX4GCM
         W/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:mime-version;
        bh=UDHZm8Ddad+DvuQIzD0sKurLkiInICwju2HsjMjGe2E=;
        b=E7+3nfozOGCqaw/IFFzaewgSknnbddtaPfrFOS33vuMjL6rSBRWO0oC77Skkm61oxa
         rndHPd0S+DvxrW6gWRGx2Fk4aybuXSrr22XVvuqm0RoyQed9M5EPUYVPnJP4oGmvjo2z
         rquaCEvDrCTgujb6Ag1E6tMOZvsz1MOeYXZPeI0YhZzLWrEnLsV5zIrkkFZbBWBfYfQO
         dQVdsuTbWyzj1YjyHq/1GWw7chJU/I2+WenHNUaWPvaY+2dD3shAdrV9OUm3QEz1Ek5I
         5Cg3igwCi1ZO7nUmiptN0mfmqWxy3FA1KPOpyyGuMFvnCy7THp5HcZ00zjAskpUXRe0s
         7Ejw==
X-Gm-Message-State: AOAM53107FNKeCJKxmEvMOdVIjmYEzrqwDpqrtQS2jmzzVOIN6Hml0uh
        rYL7mr8zrmbRYXsqeyVueUZtfvml+2wrQg==
X-Google-Smtp-Source: ABdhPJwhCJcsg4PjMuKvT1TxGbKYYQkP2gSh0Oepins/ag131INO8/ye9JjhVmM1IokGMwLn0RBW3Q==
X-Received: by 2002:aed:3968:: with SMTP id l95mr6888214qte.302.1605733151143;
        Wed, 18 Nov 2020 12:59:11 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-11-174-88-121-241.dsl.bell.ca. [174.88.121.241])
        by smtp.gmail.com with ESMTPSA id k15sm17233674qke.75.2020.11.18.12.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 12:59:10 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
Date:   Wed, 18 Nov 2020 15:59:02 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 1/6] rt-utils: Introduce parse_mem_string()
In-Reply-To: <20201113210910.21807-2-dwagner@suse.de>
Message-ID: <32f855be-6eab-f560-ad5b-6a4041e5f845@redhat.com>
References: <20201113210910.21807-1-dwagner@suse.de> <20201113210910.21807-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Fri, 13 Nov 2020, Daniel Wagner wrote:

> Add helper to parse common memory prefixes on strings.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  src/include/rt-utils.h |  1 +
>  src/lib/rt-utils.c     | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/src/include/rt-utils.h b/src/include/rt-utils.h
> index c6fb220cdb0a..39ddbd9eae29 100644
> --- a/src/include/rt-utils.h
> +++ b/src/include/rt-utils.h
> @@ -28,6 +28,7 @@ uint32_t string_to_policy(const char *str);
>  pid_t gettid(void);
>  
>  int parse_time_string(char *val);
> +int parse_mem_string(char *str, uint64_t *val);
>  
>  void enable_trace_mark(void);
>  void tracemark(char *fmt, ...) __attribute__((format(printf, 1, 2)));
> diff --git a/src/lib/rt-utils.c b/src/lib/rt-utils.c
> index a30e1e4ce436..2d68d62cd875 100644
> --- a/src/lib/rt-utils.c
> +++ b/src/lib/rt-utils.c
> @@ -362,6 +362,36 @@ int parse_time_string(char *val)
>  	return t;
>  }
>  
> +int parse_mem_string(char *str, uint64_t *val)
> +{
> +	char *endptr;
> +	int v = strtol(str, &endptr, 10);
> +
> +	if (!*endptr)
> +		return v;
> +
> +	switch (*endptr) {
> +	case 'g':
> +	case 'G':
> +		v *= 1024;
> +	case 'm':
> +	case 'M':
> +		v *= 1024;
> +	case 'k':
> +	case 'K':
> +		v *= 1024;
> +	case 'b':
> +	case 'B':
> +		break;
> +	default:
> +		return -1;
> +	}
> +
> +	*val = v;
> +
> +	return 0;
> +}
> +
>  static void open_tracemark_fd(void)
>  {
>  	char path[MAX_PATH];
> -- 
> 2.29.2
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
