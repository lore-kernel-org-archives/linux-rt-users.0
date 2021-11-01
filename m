Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581EC433EF
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Nov 2021 07:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9AE60EFF
	for <linux-rt-users@archiver.kernel.org>; Mon,  1 Nov 2021 07:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhKAHnJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 1 Nov 2021 03:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbhKAHnE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 1 Nov 2021 03:43:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C46C061714
        for <linux-rt-users@vger.kernel.org>; Mon,  1 Nov 2021 00:40:31 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n8so351358plf.4
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Nov 2021 00:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PLa5X6f12m0jUSnT9vRx2eoavvX+vkar/SNQ9GysNV0=;
        b=HTpYOEKxGVcH04DssN8abrrtcMd8kx65mGjVDRRU7lzHD+I7ipXxPcFyPjb8GsGq1e
         0L5Z75OMcbnARyVLBUhtYjFeDClX9omNHvJi0DpSHkq2in4IIWsxsEiFgSCRKSxB1cYh
         xERBLg+ALuJ9PR/vfMTz0TGUsMpZzcy2dqd2Qm7qcTgVjmcSFgb2Ed4B5wPgdQGYRc4G
         uAw7z2UDtfsi7LhICHWKqe7eYx8pL62TCMH/xu+fNJFBxwUzMAvZZSRaQ178jivbkeLX
         FFIDU39io1HUm0ogyWf3bVoPF/+7HSGdoL/GNejPqCmNDtT/HZ7xbw8SvmCdiKO50Cs7
         wzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=PLa5X6f12m0jUSnT9vRx2eoavvX+vkar/SNQ9GysNV0=;
        b=TFBPWRdGoDOMDsHwzlAapOPqsOoirybmJodpAiLGVnF2ISgONTb8Qzps7AC+LdPhPe
         FLnXCTRg55eWm7MUHKii4MDurpVwK3jHvVRt9zOERV+g3Rc4jrXjINjjsm3MpyVvCM89
         4SkiAHHIsAgSNOI9M1xZKZC5/zTDovuw3qhbs5y4sKQztmPAtl3aoTuQ4vJhtga51nns
         Qhu/3igapPO6Fuo9AcHT13lS+MyknFxgup9/p5Cwn+79IxgxGSreET3gID93w6b7D9tl
         vkXmkDNoAE+HXrZeIozzOdVH8O2ZOXxFkaJEa7sRMIyZgkwYqhWPDLr3Hzp/0/j54BDf
         yTng==
X-Gm-Message-State: AOAM531xnhA6vDX/KeFhYM3eJFcOHku9AgRzAB8gom+JHWD+bf9l9okv
        znUj9NV5IuYLxFC093xdNH0qUAWaV7Y=
X-Google-Smtp-Source: ABdhPJxd/+0+UdL0XTYaWSoNYVdwSBmhdnAo8bCH018pgmAuJ7s9cQevt58Ch89HLYV4t2n3ZhYEfA==
X-Received: by 2002:a17:90a:917:: with SMTP id n23mr29400147pjn.131.1635752431433;
        Mon, 01 Nov 2021 00:40:31 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id h13sm11991140pgf.14.2021.11.01.00.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 00:40:30 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH v3 4/4] rteval: cyclictest.py: Skip statistics reporting
 in case of an overflow
References: <20211018055736.412576-1-punitagrawal@gmail.com>
        <20211018055736.412576-5-punitagrawal@gmail.com>
        <616c492a-c710-a8b-ff20-832a2816f14e@redhat.com>
Date:   Mon, 01 Nov 2021 16:40:28 +0900
In-Reply-To: <616c492a-c710-a8b-ff20-832a2816f14e@redhat.com> (John Kacur's
        message of "Wed, 27 Oct 2021 19:29:18 -0400 (EDT)")
Message-ID: <87fssg9vdf.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

> On Mon, 18 Oct 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> The cyclictest.py module recently gained the capability to parse max
>> latency values as reported by cyclictest.
>> 
>> When the max latency exceeds the range of the latency histogram (or in
>> other words, the number of configured buckets), statistics such as
>> mean and standard deviation can not be calculated correctly due to
>> lost samples during measurement.
>> 
>> In the case of lost samples, skip statistics generation and report the
>> max latency warning the user to rerun the measurement.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/modules/measurement/cyclictest.py | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>> 
>> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
>> index 50a734c75047..7a619dd1c852 100644
>> --- a/rteval/modules/measurement/cyclictest.py
>> +++ b/rteval/modules/measurement/cyclictest.py
>> @@ -67,6 +67,9 @@ class RunData:
>>          retval += "mean:       %f\n" % self.__mean
>>          return retval
>>  
>> +    def get_max(self):
>> +        return self.__max
>> +
>>      def update_max(self, value):
>>          if value > self.__max:
>>              self.__max = value
>> @@ -423,6 +426,13 @@ class Cyclictest(rtevalModulePrototype):
>>          if abrt:
>>              rep_n.addChild(abrt_n)
>>  
>> +        # Let the user know if max latency overshot the number of buckets
>> +        if self.__cyclicdata["system"].get_max() > self.__buckets:
>> +            self._log(Log.ERR, "Max latency(%dus) exceeded histogram range(%dus). Skipping statistics" %
>> +                      (self.__cyclicdata["system"].get_max(), self.__buckets))
>> +            self._log(Log.ERR, "Increase number of buckets to avoid lost samples")
>> +            return rep_n
>> +
>>          rep_n.addChild(self.__cyclicdata["system"].MakeReport())
>>          for thr in self.__cpus:
>>              if str(thr) not in self.__cyclicdata:
>> -- 
>> 2.33.0
>> 
>> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thank you for picking this and other patches in the set.

Let me know if you had any comments on the first patch.

Thanks,
Punit
