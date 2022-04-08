Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CB1C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Apr 2022 13:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiDHNOI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236543AbiDHNNr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Apr 2022 09:13:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3457120B8
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Apr 2022 06:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649423406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F6zQPUV2PlrHGRSviwyJlofSDRUyDcipHnyWs+t/Z1c=;
        b=bPMGwiyTmEfo8C8vQRRJfRym39Zfbhgf4+FhnAiCogPHHpDTmj2jHCxmekyOQPJzTkaLbc
        rj9fb+AqsOc8pbvFM7+5BKYJDD2XWXFdBT9xWJy4OX492Jp/rPFAFuq47OzMkz86i0TAgH
        GtVihh0D/xuPmVjHjCJpqxav6rrSfkY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-524-RvBslbkaMdmdm8eSPzObOQ-1; Fri, 08 Apr 2022 09:10:05 -0400
X-MC-Unique: RvBslbkaMdmdm8eSPzObOQ-1
Received: by mail-ed1-f72.google.com with SMTP id cx4-20020a05640222a400b0041cf617aefdso4337341edb.14
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2022 06:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F6zQPUV2PlrHGRSviwyJlofSDRUyDcipHnyWs+t/Z1c=;
        b=msCfnCVwXFiJOlYS/1NBBGjDn8KhvsSMCmGLFLlVNgCmnPso+p7vctaHU+YGIvAm4B
         LfHHPHQ2ooBD9vLXqwCZVOAHsqfS3g+i4vw95yhigNWXAMZfbg/e9M1uJNrHPbUl+FIY
         Mxo7RYMFVnnyDWS52oGCZpp7nr+RQNh68cue2pIXoG9TCC86WMmM2KPbTZuRQQc+lhHx
         oSH2juMCvm00V42XZnDuryMB40Nm8rowmUBehqo1V+6fxFNKEQcVKPaRU9X8JlDkomu0
         6MQQw4Qe8RSjhTH0KByY/Bd76/Emk54WDuRrs26Lt1aYGp7ocs97+r6xIjRYmcNl+KGb
         C2Rg==
X-Gm-Message-State: AOAM5335a+CzIDqvp8pMNDKBW5Yp8nWlmmirwHDkBtZ1mw3T3SS9+hp+
        bWULR5B2oX9bItpmIMf6csJaNZCbXwmNjRjuiwDJBExhVBSpLNz9BKXLxv0ekLFwzOC5M9KhjMI
        /lQLfAZcA7Q5Js77dNo4E87+qkdE=
X-Received: by 2002:a05:6402:1811:b0:41c:d21a:4096 with SMTP id g17-20020a056402181100b0041cd21a4096mr19328843edy.389.1649423404236;
        Fri, 08 Apr 2022 06:10:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxn7MP9IA7yyDw5LXL1ocCfgDAs6gLE3DYeEm4wur52ay4RHHoQP9A+hUSUwLYwXmMU7zcaow==
X-Received: by 2002:a05:6402:1811:b0:41c:d21a:4096 with SMTP id g17-20020a056402181100b0041cd21a4096mr19328820edy.389.1649423403995;
        Fri, 08 Apr 2022 06:10:03 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id gv55-20020a1709072bf700b006e82ef9b910sm1880289ejc.70.2022.04.08.06.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 06:10:03 -0700 (PDT)
Message-ID: <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
Date:   Fri, 8 Apr 2022 15:10:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] rtla: Minor fix to grammar in README.txt
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220402043939.6962-1-jkacur@redhat.com>
 <20220402043939.6962-2-jkacur@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220402043939.6962-2-jkacur@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 4/2/22 06:39, John Kacur wrote:
> "The rtla" doesn't make sense, change it to "The rtla tool"
> This is better than removing the word "The" since some packaging tools
> need the description to start with a capital letter.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  tools/tracing/rtla/README.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/tracing/rtla/README.txt b/tools/tracing/rtla/README.txt
> index 6c88446f7e74..3b809eeff5f9 100644
> --- a/tools/tracing/rtla/README.txt
> +++ b/tools/tracing/rtla/README.txt
> @@ -1,6 +1,6 @@
>  RTLA: Real-Time Linux Analysis tools
>  
> -The rtla is a meta-tool that includes a set of commands that
> +The rtla tool is a meta-tool that includes a set of commands that

I do not like bike-shedding but 'the rtla tool is a meta-tool" sounds repetitive.

Does:

The rtla meta-tool includes a set of commands...

sound good for you?

-- Daniel

