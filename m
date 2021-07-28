Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689D1C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 21:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FB06069E
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhG1VeJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 17:34:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39988 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231665AbhG1VeI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 17:34:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627508045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0aNHj/VtMYHvqcrLgvZzZfzepUG6niMbaJev58elHQ=;
        b=SHAasKtehPm5P7Ac714Qde2gsOrUgveM3ytXHGL2DPg4tzH9liOkEO1EGDVWAOQMNQMPQ3
        SMBgJFAiBbuTb+hSWhXw/prkdrDKV/3NWowsKNutklt8/8wZGpoXeHQOCtQaPp4p0ixHqy
        84tOI6NpFPo2EIAgW6FDtdaQO3pjB0g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-n3qPBphsMoqo5ZVGWhpdzA-1; Wed, 28 Jul 2021 17:34:04 -0400
X-MC-Unique: n3qPBphsMoqo5ZVGWhpdzA-1
Received: by mail-qk1-f197.google.com with SMTP id b4-20020a3799040000b02903b899a4309cso2442030qke.14
        for <linux-rt-users@vger.kernel.org>; Wed, 28 Jul 2021 14:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=T0aNHj/VtMYHvqcrLgvZzZfzepUG6niMbaJev58elHQ=;
        b=FhuGWYX73A6O0W509YsWRO7fobJi97OOWlJxYG6jWuZqnA+jdOSUtbHUJTHr2idTWW
         oka8PpaHZv2y7OImd84V6S0fjcEavUiFy/lg9dUNOiv5Np5vh5EbIB0l7SEoQvKB7V+M
         ZI26+aH7IZa1QII62AXkpqjwBMRvQJEP/rP0Fp0r7QLiHpDLwMp1fWyQOh+pfHsDuvsq
         AKUNlQO7kN++UOxhxsYrNkk1FHYN407XeBjT5ULIDMiYfRcnikI16i0cRo8f8ODlH9ia
         crlAEUkyluLeaJyKfLUduvl3XvVeEvE9eEGlC6/8fgRV1ZYNibE6m9oDFcjMAhLCbnXq
         lULw==
X-Gm-Message-State: AOAM532DgEvRF4N9p2M8OMBKP+DXHzX99ksRtAzGAdYc5nnqZ0673Qy2
        twyjd0wUDlmHswoQ6U7E2C3q75Tl6gs4bJFo36Cgl10bk7Xm+Ek8XwsqZf4gFegfJqhv6kFMsjg
        1QzFJXTtChZ3m3ksM8Ulg/rtrJIg=
X-Received: by 2002:a37:8407:: with SMTP id g7mr1856754qkd.123.1627508042327;
        Wed, 28 Jul 2021 14:34:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzbNfzVK6BLD/7V8gtIwQXNHRWjq3bDVSTOcEAXTafyFE0UPrBg7BKqMr41nJOyg1CNIPYgXA==
X-Received: by 2002:a37:8407:: with SMTP id g7mr1856739qkd.123.1627508042174;
        Wed, 28 Jul 2021 14:34:02 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-07-184-147-141-243.dsl.bell.ca. [184.147.141.243])
        by smtp.gmail.com with ESMTPSA id f10sm466187qto.31.2021.07.28.14.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 14:34:01 -0700 (PDT)
Date:   Wed, 28 Jul 2021 17:33:58 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: cyclictest.py: Do not pass obsolete
 --notrace option
In-Reply-To: <20210728.202015.848207132223180831.atsushi.nemoto@sord.co.jp>
Message-ID: <bc76e1a-a288-206b-cf81-523a8a40edc@redhat.com>
References: <20210728.202015.848207132223180831.atsushi.nemoto@sord.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 28 Jul 2021, Atsushi Nemoto wrote:

> The notrace option was removed from cyclictest on rt-tests v1.4 in 2019.
> 
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index ae91dbb..b1755d4 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -286,7 +286,6 @@ class Cyclictest(rtevalModulePrototype):
>          if 'breaktrace' in self.__cfg and self.__cfg.breaktrace:
>              self.__cmd.append("-b%d" % int(self.__cfg.breaktrace))
>              self.__cmd.append("--tracemark")
> -            self.__cmd.append("--notrace")
>  
>          # Buffer for cyclictest data written to stdout
>          self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks

