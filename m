Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC912C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 22:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A429161391
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 22:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243133AbhI1Wt5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1Wt5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 18:49:57 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62270C06161C
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 15:48:17 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x4so157631pln.5
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IMBEcKsN8CfmQRLkUXBlLd+1VFdM0QqWOjhzLT9dVxg=;
        b=GYyE1dzBwJ9RyjquidxOI3iMolEV+vPeuCPX1Mq2K/9T6NNcbU5MsbGOkXIPM2uNz2
         DdYphUXhMutk1E2O12Iv0XaLMGLoBZfEcJYdv1K/2ECYA500K8QOPaXUYXkVQLuMW6vg
         5U2T5bSlqVR3Fj4AKQTE0H5FnRwA84Vxj/ZYNjklKq6yMOeP11nfukoQCzH2ykOqwE+O
         3RJmdiDcd8qojHjrp+oEVV3q6u9pCsj9tRfLh/NgGcLq6Hg0Pk/3napRl3lNsyzUeJci
         DE1SpTMir1KowW53LLh/x8rFR4853zvlwMr0l2Fy+pz8q8J4PqUYOFcZGDR/EjjO+bUW
         N62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=IMBEcKsN8CfmQRLkUXBlLd+1VFdM0QqWOjhzLT9dVxg=;
        b=ILt2E8x2YH0kQ5We59xa/SSmQRY+R2MtjKbkTCkZW0/fqFpjb3fzVnk8a2TMUR1nOf
         DNBuR/PmwQyTPulwLJrSwSKeHA76n2+CUH3d6InN1L5EBdTGb6vY97poDUjmBW9gomD2
         S0IM/5Snz2Q6mAt9p4fyDvT1i6oA3WvUFSk37Lwe1g9ZOkSej66Pm2IhK1WcN9MwILYq
         GcWFYP3pTzm0gArbRRWuBhRq+QsKZE4Lot4Wsct8x0aDRy73A4vWrgopQTAtBRjgbAoj
         WPv8jKLeCd9G4x7JsGGSlD51XHuOfD1EAQh8LUX8ixymqsDGoavZLv2W2TrWiqkRHDAX
         Yydg==
X-Gm-Message-State: AOAM531ECIdsXAZKyd7O9VhwSYVgW4UnaYe0fskDBVX0BgKEauUZrrAD
        eoTet+/xiLuDMikKgqaOgo4=
X-Google-Smtp-Source: ABdhPJzXVuSAdJNE3FYdbMNoEb0uobIigZsH1Tj66CWfae7y2xR3yyz8xMmaE19KiujbX8jV4EWRig==
X-Received: by 2002:a17:90a:da06:: with SMTP id e6mr2613339pjv.63.1632869296811;
        Tue, 28 Sep 2021 15:48:16 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id b7sm172307pfb.20.2021.09.28.15.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 15:48:16 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
References: <20210928081716.3421463-1-punitagrawal@gmail.com>
        <20210928085900.3422085-1-punitagrawal@gmail.com>
        <748d14f-a32e-961-8581-f58be77ca419@redhat.com>
Date:   Wed, 29 Sep 2021 07:48:13 +0900
In-Reply-To: <748d14f-a32e-961-8581-f58be77ca419@redhat.com> (John Kacur's
        message of "Tue, 28 Sep 2021 10:34:45 -0400 (EDT)")
Message-ID: <87fsto5nbm.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

Thanks for having a look.

John Kacur <jkacur@redhat.com> writes:

> On Tue, 28 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> On systems where cpu idle is disabled to reduce latencies,
>> "/dev/cpu_dma_latency" does not exist and leads to the following
>> exception report from python when using hwlatdetect.py -
>> 
>>     FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency
>> 
>> Update hwlatdetect to check whether the file exists before attemping
>> to write values to it.
>> 
>> Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>> v1 -> v2:
>> * Correct Suresh's email
>> 
>>  src/hwlatdetect/hwlatdetect.py | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
>> index 12228f45f852..89537a6e371f 100755
>> --- a/src/hwlatdetect/hwlatdetect.py
>> +++ b/src/hwlatdetect/hwlatdetect.py
>> @@ -216,8 +216,11 @@ class Detector(object):
>>      # use c_states_on() to close the file descriptor and re-enable c-states
>>      #
>>      def c_states_off(self):
>> -        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
>> -        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
>> +        if os.path.exists("/dev/cpu_dma_latency"):
>> +            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
>> +            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
>> +        else:
>> +            self.dma_latency_handle = None
>>          debug("c-states disabled")
>>  
>>      def c_states_on(self):
>> -- 
>> 2.32.0
>> 
>> 
>
> Thanks! I have a couple of nit-picky suggestions.
>
> If you initialize self.dma_latency_handle = None in the init method of 
> class Detector, then you can drop the else part of your check to see if 
> the file exists.

I can do that - but then I wonder if there is any harm in initialising
the file handle in the init method itself too. That way
c_states_[off|on]() can focus on doing their thing after checking the
handle is not null.

I'll send a patch in sometime addressing this and below comments.

>
> Also, in the situation you describe, the debug messages should probably be 
> hoisted up under the "if" part, and that goes for method c_states_on() 
> too, as they are not relevant.
>
> You might as well fix the comments above the code too,
> openinging -> opening
> writeing -> writing
> And edit that one line not to over flow 80 chars.
>
> Thanks!
>
> John
