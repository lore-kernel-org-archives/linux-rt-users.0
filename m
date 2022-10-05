Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F325C433FE
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 14:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiJEOpx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 10:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJEOpv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 10:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81337822A
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664981150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4JUlwk38blEa+JCtv47qprbyQFCtfix/C2beiQRfC8=;
        b=d1+fMoT2afLfcG0AujNmfZXMknCMGaJ0Q1vAOv6PoIE/8n8ZmKxKZyVlXngFn31HjODcSJ
        Xmpe3nQOmFilvdxxpg1G9+ZXsoDU4LQm0Rsl9fFPBwj19qND8GpeEILYfvWNLmjSd+jYez
        I20/HIJpwJ5OfusCuWnArZ6vx8P96WU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-533-y8xhGYK_NjO_i88xU-hUyg-1; Wed, 05 Oct 2022 10:45:46 -0400
X-MC-Unique: y8xhGYK_NjO_i88xU-hUyg-1
Received: by mail-ed1-f72.google.com with SMTP id s17-20020a056402521100b004511c8d59e3so13802113edd.11
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2022 07:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d4JUlwk38blEa+JCtv47qprbyQFCtfix/C2beiQRfC8=;
        b=eopHf5qTaOaHhprf65r115SoofI9gJlVa9X7dycqnIAIS+4KrNHHzmJmtfd2pQYg2w
         i9HfAnQy0sdrD0M/fDzc51w4NLJOqo/tVKLIHHEd5bS+f17lCXDFkWAD+vTZ+WCjK0K/
         bHyiRO/uWVjXfRyOLKKftFuHkVWPdWUumkMSzf7e6CQrXY+3BiJLbAQhFxqgSlmDzloP
         FITB67k3ecTAQBmzT6c4sUfdljw85eukF56L1q9/JnbkvF9Dagk6ASat41CcShBIeqFB
         XS9knTLv00AGZgkgGwEcCOb7XicvJ+UcMGrCDOEFJyMkwqfRRAVesqYPUUIV4OTNG6XJ
         5Ojw==
X-Gm-Message-State: ACrzQf1SUs//NpyVngZkJSmlVaN8KZIz0d4TofLTviDV2GO6ded4fLmd
        /RK8lnBVnSokSswpC2fApm1Npiowr2oBcpmg6LTNcLsoF/IMzjlaSCS29Ptr/zbfyibrVHgZv6h
        dvywW0j562OwNP+Dtbg6XePKGRIc=
X-Received: by 2002:a05:6402:348b:b0:450:28be:d6b0 with SMTP id v11-20020a056402348b00b0045028bed6b0mr104915edc.386.1664981145693;
        Wed, 05 Oct 2022 07:45:45 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5+5SBI8fUpXMuN6nxyaVj4Q8moCVwg66Mh6WYPShW39jh/pVr9DMv7TiN5ZfbnZJ7PQAIB6A==
X-Received: by 2002:a05:6402:348b:b0:450:28be:d6b0 with SMTP id v11-20020a056402348b00b0045028bed6b0mr104898edc.386.1664981145469;
        Wed, 05 Oct 2022 07:45:45 -0700 (PDT)
Received: from [192.168.0.198] (host-79-50-96-115.retail.telecomitalia.it. [79.50.96.115])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090607c200b00780b1979adesm8694752ejc.218.2022.10.05.07.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 07:45:44 -0700 (PDT)
Message-ID: <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
Date:   Wed, 5 Oct 2022 16:45:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Florian Paul Schmidt <mista.tapas@gmx.net>
Cc:     linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <Yz2HQlzZ491HtOm+@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/5/22 15:31, Sebastian Andrzej Siewior wrote:
> On 2022-10-05 09:46:30 [+0200], Florian Paul Schmidt wrote:
>> 5.19-rt10    has the problem
>> 5.17.1-rt17  has the problem
>> 5.16.2-rt19  does not have the problem
> Could you check v5.17-rc1-rt1? Maybe it was introduced in v5.17 cycle. 
> 
>> I would possibly be willing to git bisect the issue. But I am a little
>> bit confused about how to go about that. What repo/tree would I
>> precisely bisect (I am using the the patch tarballs from
>> https://cdn.kernel.org/pub/linux/kernel/projects/rt/)?
> if it got introduced post v5.17-rc1-rt1 then we could try to bisect it.
> Otherwise we would have to trace it. Since the latency spike is huge, it
> should be easy to spot.

try:
# timerlat -a 100

wait for it to stop and save the trace. Then see what the trace points out at the
end of the trace.

-- Daniel

