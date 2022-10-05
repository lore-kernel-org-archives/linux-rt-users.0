Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14AFC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Oct 2022 16:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiJEQXJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 12:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJEQXH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Oct 2022 12:23:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55746DAE3
        for <linux-rt-users@vger.kernel.org>; Wed,  5 Oct 2022 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664986985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U5fCIEPw1aPUARhX0jj6r5TlOkSXtlor22k7XPUIU3k=;
        b=S868gzVur9mKniCsl/9bbvJesPcPFGg0KbaGps8O91qAl4t6IRkAWSFEyudZFqjCPVFCbz
        ORLKP8cfDQgP3rbEzIflgxB847VhP0iHvq5RQMLAfoq2Jf6JlZh+2vUJ26In1U4fc8Ebba
        jn/PCOvak1fi5YVUaOjJR62DiPpfwGw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-391-y4NY_OEtN5eGiRFifrlUJg-1; Wed, 05 Oct 2022 12:23:04 -0400
X-MC-Unique: y4NY_OEtN5eGiRFifrlUJg-1
Received: by mail-ed1-f70.google.com with SMTP id w2-20020a056402268200b00458ef2a5a4eso7579855edd.9
        for <linux-rt-users@vger.kernel.org>; Wed, 05 Oct 2022 09:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=U5fCIEPw1aPUARhX0jj6r5TlOkSXtlor22k7XPUIU3k=;
        b=EtRfxH1sCc87quPpx6XgfIloiZMZu8Adz2IE7xni1NdAMpAE7VK9fTh53CWp1toXqF
         LGJDPT3FfT1BMLESE6qPWCt6iWwE/jeWH/7z/Gf7/IGVHqiEj8OkePHbyJjYZex9mdNm
         8iyFP9PmIS/cyESLdnrv8gJW935tJVwle1ttMXJNShfYTqVUfwE5BwS39I1mIp7s6oGX
         3VVXW5M+jt6IAeTdt56fn+xTrn+8V2HiRU+4UFmdDJilLbvGzC4zKlhZAEBTslAObQfI
         wfMHKI5c07+pcqwbvmTzko0chiP9exLr580Y2WmuSuoNomynLwNSkfuyS7VSQvmCIy2j
         A+fQ==
X-Gm-Message-State: ACrzQf1rpD/GVGL+Fv9VEB5DrU6lTkfvbCygyQYi8zTesnyuBT+n6nal
        2UVW1hneElfA6bt0Z/TYZkZodw1VPwzZrTaNfEcbAaBfo9mdB7QRM4fDOSKQtC6a65l8PNLUK/x
        s1a7z5+rJwfvkGX0cIOH0YtuudSQ=
X-Received: by 2002:a17:907:628a:b0:781:bbff:1d42 with SMTP id nd10-20020a170907628a00b00781bbff1d42mr291996ejc.375.1664986983256;
        Wed, 05 Oct 2022 09:23:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4NkPHReT/IB19B7fIOqVIaCHCfvlLaDjcDYyTNVfanyGv3RR+V0wHd12EQ1ySu+lJtmQRr9g==
X-Received: by 2002:a17:907:628a:b0:781:bbff:1d42 with SMTP id nd10-20020a170907628a00b00781bbff1d42mr291984ejc.375.1664986983079;
        Wed, 05 Oct 2022 09:23:03 -0700 (PDT)
Received: from [192.168.0.198] (host-79-50-96-115.retail.telecomitalia.it. [79.50.96.115])
        by smtp.gmail.com with ESMTPSA id la3-20020a170907780300b00781dbdb292asm8834364ejc.155.2022.10.05.09.23.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 09:23:02 -0700 (PDT)
Message-ID: <6b79b2f3-7ec9-88e9-48e4-71c6ec85b7db@redhat.com>
Date:   Wed, 5 Oct 2022 18:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
Content-Language: en-US
To:     Florian Paul Schmidt <mista.tapas@gmx.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
 <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 10/5/22 18:17, Florian Paul Schmidt wrote:
>> try:
>> # timerlat -a 100
>>
>> wait for it to stop and save the trace. Then see what the trace points out at the
>> end of the trace.
> 
> What package contains the timerlat command? I gathered from searching
> online for timerlat that it is part of the tracing machinery but I
> didn't find the executable itself..

on fedora it is part of rtla, but you can compile it from the kernel source:

$ cd tools/tracing/rtla/
$ make 
$ sudo make install

-- Daniel

