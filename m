Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4266C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Feb 2022 19:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiBIT3D (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:29:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbiBIT2F (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Feb 2022 14:28:05 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43652E016D98
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Feb 2022 11:26:42 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id s18so4503922ioa.12
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Feb 2022 11:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uJdZ7oqw+QQlIzr17qqdwzwfregbqFYC9sj7YzP1HYY=;
        b=fYz8PGQMd29UOajQhZT2X83HUOpYoErPoGjRcNCM4yVnITAfRZgeDe7UMSvRLFe4oS
         1k0WRleLPHEuUfcf6Ia64xTw2nV6RRaWj+2NboS6Cc4j+5N0sOvshg1GvERuJ5jICtiI
         eslZtJUanhs7SqaFUnbPEbDHd79D+9p9fHxms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uJdZ7oqw+QQlIzr17qqdwzwfregbqFYC9sj7YzP1HYY=;
        b=WbEyeV20h0DTgVzSDBCyjxjD+90MuJG0F+iHSwtILeUeUu4Zc5XHdN+fb2PTKq73Da
         8PEiKb+odaFwPGWTbv+MAs067cwB9Ec8IricBg1gPOPTcb5ohwhX5GTGUc9WgzQRrFRB
         WTwtcYO63gnqHLIJxXvJJ2s2DUW7h5yuejVlzIJJyeWoYZAGzwk6GAvwFCKLob8Vn80x
         QQiamsKwhr50WT++MqW3SEICPEB0lOabzHtFLtLDI5f2GkREnOCRhhXRURFI3BfWU+fK
         mqeqGvnH3Oxwql40amexT614AdICalDSsVW6/ysCvgG3GeaIJmuNlAijV/41fLhyxGlY
         VLrw==
X-Gm-Message-State: AOAM531LpLSZiR3VTbYXfquvEl1oCjUJ8lNZEeqs+K3Z/qebZqAgMRHs
        55I9GmV7U0htD5t41T3CoqnSow==
X-Google-Smtp-Source: ABdhPJw5MU53uJwqzrLtiF140G+vIQQ1qVQ9YiU1UrUUC9dzqLmlqHS4jlfDiPOVYXjgDYKvgAj0iA==
X-Received: by 2002:a6b:6f09:: with SMTP id k9mr1864423ioc.61.1644434801604;
        Wed, 09 Feb 2022 11:26:41 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id o22sm9992022iow.37.2022.02.09.11.26.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 11:26:41 -0800 (PST)
Subject: Re: [PATCH] selftests/ftrace: Do not trace do_softirq because of
 PREEMPT_RT
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <aa0833ac-154e-9a66-c3f5-7c3b98f15f19@linuxfoundation.org>
Date:   Wed, 9 Feb 2022 12:26:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220209162430.286578-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2/9/22 9:24 AM, Krzysztof Kozlowski wrote:
> The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
> do_softirq fails for such kernel:
> 
>    echo do_softirq
>    ftracetest: 81: echo: echo: I/O error
> 
> Choose some other externally visible function for the test.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> I understand that the failure does not exist on mainline kernel (only
> with PREEMPT_RT patchset) but the change does not harm it.
> 
> If it is not suitable alone, please consider it for RT patchset.
> ---
>   .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> index e96e279e0533..1d0c7601865f 100644
> --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
> @@ -19,7 +19,7 @@ fail() { # mesg
>   
>   FILTER=set_ftrace_filter
>   FUNC1="schedule"
> -FUNC2="do_softirq"
> +FUNC2="_printk"
>   
>   ALL_FUNCS="#### all functions enabled ####"
>   
> 

Change looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

