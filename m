Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CEEC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Apr 2022 19:54:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380426AbiD2T6M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Apr 2022 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiD2T6L (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Apr 2022 15:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 066D5C44C6
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 12:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651262092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HUrW48NeYN/3mVeb6h5HVy0f0onOYY3L4YYkfG9YfKY=;
        b=FWhuN2516W9wnIVOwQIKXwy95wrznKjDyNWE8wE2Fes8xsX2EH7jN7ueclmLe+NPhoeKHL
        g7l8ReuuO8rKaSjswkLK5X9xDUHuHlYq99EvQonqgXS/nG4HbIiHk2npLOiB3c7IkjXFrC
        ORo5W+Ov8iDmXgUIEA3D+9vhQaKx7io=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-er0TmwgyNZGgadK1OUAImg-1; Fri, 29 Apr 2022 15:54:50 -0400
X-MC-Unique: er0TmwgyNZGgadK1OUAImg-1
Received: by mail-qv1-f70.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso6701661qva.18
        for <linux-rt-users@vger.kernel.org>; Fri, 29 Apr 2022 12:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HUrW48NeYN/3mVeb6h5HVy0f0onOYY3L4YYkfG9YfKY=;
        b=sxQRmTVpwNczHQSMV+B4WeO/XLqQFlUqaoFD1rtMNDRKTY9hnEVdeb85Id4sjhN1sl
         zZ4CnF479M0kdFvMRK6fRmKjM2gGWsWVAUH+ZIRzI7TFyFFi9eDieLp9F+hAhrSZoGqk
         VaJlLdvrGx4HzoYzJirB9ZPd75tLO7mv0PJREWAoInvVru5mEAth3Zg+qJwSf/jsQjxa
         Y7Bg3+AMQBbOEsJQ6Vthaj5RnlzKbBlS4UtuKPclivnCXTV5KbxkylBALVileAR8vXGt
         MLoIJmk9YMrBR0GAhsLt7ubk6EFFQyJgrIoxPoV8OyhyeVLd2Nc9CCt09zGdE9eybNfE
         lcyw==
X-Gm-Message-State: AOAM532rdbUZ/NrhOCYqKBtLs0rpC8kzl5V1m+tfJq9XriomEz8/aYOG
        G0gZnv4XmFUi4ToYKNbU+ozj8VO4BZspPysgsqSs2KMIZyUlZrKPtiRDF0MHASdjQXqcjvc0z1t
        oq+G13R4bycOQIUJ02g8t17mA274=
X-Received: by 2002:a05:622a:198f:b0:2f3:9b9b:e3be with SMTP id u15-20020a05622a198f00b002f39b9be3bemr569003qtc.656.1651262090136;
        Fri, 29 Apr 2022 12:54:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+/I16jawbOw4akH0fhQJh4wYmzGVzyVPanlh/QNWejwVs8n+0tf2L9WvZpogvP0fN93y7EQ==
X-Received: by 2002:a05:622a:198f:b0:2f3:9b9b:e3be with SMTP id u15-20020a05622a198f00b002f39b9be3bemr568999qtc.656.1651262089955;
        Fri, 29 Apr 2022 12:54:49 -0700 (PDT)
Received: from fionn ([184.147.143.93])
        by smtp.gmail.com with ESMTPSA id l63-20020a37bb42000000b0069fc13ce1fdsm64017qkf.46.2022.04.29.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 12:54:49 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:54:12 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Valentin Schneider <vschneid@redhat.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rteval: systopology: Fix offline NUMA node parsing
In-Reply-To: <20220419161443.89674-2-vschneid@redhat.com>
Message-ID: <16e1df7-d472-dabf-798f-e8e49d74b29@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com> <20220419161443.89674-2-vschneid@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 19 Apr 2022, Valentin Schneider wrote:

> An offline NUMA node will report in its cpulist an empty
> string. Unfortunately, "".split(sep=x) with x != None returns a list
> containing an empty string rather than an empty list, which causes
> CpuList._expand_cpulist() to try to run int(''), which ends up in the
> following exception:
> 
>   ValueError: invalid literal for int() with base 10: ''
> 
> Prevent this by adding an early empty-string check.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> ---
>  rteval/systopology.py | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/rteval/systopology.py b/rteval/systopology.py
> index bf794ce..b2da7bb 100644
> --- a/rteval/systopology.py
> +++ b/rteval/systopology.py
> @@ -103,6 +103,10 @@ class CpuList:
>          don't error check against online cpus
>          """
>          result = []
> +
> +        if not cpulist:
> +            return result
> +
>          for part in cpulist.split(','):
>              if '-' in part:
>                  a, b = part.split('-')
> -- 
> 2.27.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

