Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C98C4332F
	for <linux-rt-users@archiver.kernel.org>; Fri,  8 Apr 2022 14:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiDHONN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 8 Apr 2022 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236718AbiDHONL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 8 Apr 2022 10:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 117CB34B938
        for <linux-rt-users@vger.kernel.org>; Fri,  8 Apr 2022 07:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649427067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqy0/ETekPLWIA7UmgVZ0eT5yPuRDnDxC9XVs/Ymk8c=;
        b=SFJXRJbZKwWdFsgifIPtH4UgtlWg6AIxbwaoU89f1YCPlpSsrKJHedT/ZbHGnbL/glUYnH
        vwZQPWFWLC9ZjHmF7TC0Z/K1bmiUipmppvoGoE+3wdaF/sBjVGll+SyBTo2olaXaUuH98Q
        WkpNdX+HszANLNr9bcMTqmIryjDlXRE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-tzq0UXBmP72QJHvBypkgww-1; Fri, 08 Apr 2022 10:11:06 -0400
X-MC-Unique: tzq0UXBmP72QJHvBypkgww-1
Received: by mail-ej1-f72.google.com with SMTP id hs16-20020a1709073e9000b006e853a25acfso937291ejc.3
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Apr 2022 07:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zqy0/ETekPLWIA7UmgVZ0eT5yPuRDnDxC9XVs/Ymk8c=;
        b=2QfuEPU9VuoCIs85S4bxEI+SGYOUifzHgerxQ9NMuqSD5Jdc1n06Jluh3wUYb3hDav
         GtwObQO9+elOPWJx3j2YpKGOKZPlk1yXFRPzi13pLXap6AKX8/PSMvVNtnDPKuG5DAO/
         oGGsOsxUf3ZkKilPOEZSsDk9bKuBukMUaqleLLETgke/HYJwrtf/lt2LAo1UOA2edUb6
         Gc4sVhdvG24IC8stuoZmTf/uO0XVE8RwrxM+Mk7uxKr19eziFqw610GIbxgDum6TmNam
         PE6RYFgWsSquJBcu81dtddItf6AnrrRVJ8B5yP9+gPzOieee7lkGietx19oqI2pwybCB
         ORLg==
X-Gm-Message-State: AOAM530rJ0uuJ3TkaniCt5DgLwGDvbN+Ccxhj5lSdx2GibsBldtlemJa
        jRaZDn51QNWmiTJzu4J6XZxBZ8D86Xy4wlT7bNxj3+7QR65zu7wBIFK2x8bKt6bbbSwWT0oU6ZG
        +etr4klSYzFvd5f13cNzK9CkiqKI=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id i23-20020a05640200d700b004130673ba2fmr19804698edu.29.1649427064779;
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz2QYbOAS6gQvm5hSttLC55Jx/uzKl8NPt10gwYa8XKd5lkS0jIF6mruPngPWmHh2Ot4kDoA==
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id i23-20020a05640200d700b004130673ba2fmr19804684edu.29.1649427064609;
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id gg7-20020a170906e28700b006e73ac96f99sm6694825ejb.224.2022.04.08.07.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
Message-ID: <36540bb7-ada0-451b-f935-a3a1f9c83d41@redhat.com>
Date:   Fri, 8 Apr 2022 16:11:03 +0200
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
 <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
 <6b8d24c-d793-866c-30a7-f015c7babd2d@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <6b8d24c-d793-866c-30a7-f015c7babd2d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


>>> -The rtla is a meta-tool that includes a set of commands that
>>> +The rtla tool is a meta-tool that includes a set of commands that
>> I do not like bike-shedding but 'the rtla tool is a meta-tool" sounds repetitive.
>>
>> Does:
>>
>> The rtla meta-tool includes a set of commands...
>>
>> sound good for you?
>>
>> -- Daniel
>>
>>
> Perfect
> 

Would you mind re-sending this patch?

You will also need to adjust the paragraph alignment as the first line is
shorter now ...
-- Daniel

