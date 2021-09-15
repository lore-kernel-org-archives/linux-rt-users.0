Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B3BC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 08:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D33FC611AF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 08:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhIOIqd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbhIOIqd (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 04:46:33 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05AC061574
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 01:45:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso4394661pji.4
        for <linux-rt-users@vger.kernel.org>; Wed, 15 Sep 2021 01:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SFSUUf+zraMDzRoczmpuGtX/kg57c3JOH2Jt1XztbY4=;
        b=lOGbY/NiSiioOSiC/ZsqFMqNVnsAfgkfjPwVplibbb4+SzRqL6+emIR9MbvZSCTZtm
         JvQSS6PHUX/VzeGiWvyQthYHJMPe1fxT18nqRTUaELU0f/ho/pYvmZ5uunHoMzArgLvy
         mvtWl0hu1cOwqsOoCk4epuIOR9S4w/YHz7fR9TSyFDUM1hqb+tEC2con7Wnmd+BjSvMn
         DFzIY8RgdGAuxRTBUD6FtAJyfwuNbEvvHODSvkdhAwyL5WNUzgaRnsBS13vOkI3YSeas
         NIqJLAh7vqLiNKtr1HL+16sF7nDEYoAdwVw7u8MOwQGou3fjt+hSYNFQvlXApGOloxDe
         NYfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=SFSUUf+zraMDzRoczmpuGtX/kg57c3JOH2Jt1XztbY4=;
        b=T5U25Y81HH+yeQWxrpOFipl1YVTn5AfNyF5Bu8jrEoCMqxTCTvN1xbQe2DkRAwCT4x
         PbI9Sv3M19c+nVdmpkFVRqoZnImFOAIzDKbLscgtfEjMsaJQv+dLlS7Ng1nHC0mPDmKC
         33PttLU6qNzX97aH85g3SY5Av1jVOO8fr0L5ZThe9nw0vFEv/hob1BfBmonzCYn0Ayav
         liJaigrkBPTTyPlEYvQ/Y0I/wnUTIACLHXWQh0iVgrbRj+HUvZKZ/t6/Q6ter250Bdca
         rIkad4aFjJif90dNg4xVjBwdKz0P6/YKbfVfERFIl6ZS7EsvoXx/9e38rm55Cxmv2Gia
         KVKQ==
X-Gm-Message-State: AOAM533jR4Uaj/7sv5soQHZoBWL1Y9ehAYsEmK5KWfuiSL50fcs+WM0x
        87g5p7pPgVjSnEiA/iSNse7ehUEXT5k=
X-Google-Smtp-Source: ABdhPJxKVMyHGNtrdXJokWBejgcP3yOFPAlyMTg5p+5Nakz0ii/7UwaUe4CXpdIsOxUEIcQGw0iL/g==
X-Received: by 2002:a17:903:41cd:b0:13c:87ab:d58d with SMTP id u13-20020a17090341cd00b0013c87abd58dmr5982165ple.55.1631695513807;
        Wed, 15 Sep 2021 01:45:13 -0700 (PDT)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id y13sm678522pjc.50.2021.09.15.01.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 01:45:12 -0700 (PDT)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     punit1.agrawal@toshiba.co.jp, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 3/5] rteval: kernel.py: Add support for kthreads running
 with deadline policy
References: <20210901080816.721731-1-punitagrawal@gmail.com>
        <20210901080816.721731-4-punitagrawal@gmail.com>
        <3ec9f755-404c-88b4-8efb-a29fb18f392@redhat.com>
Date:   Wed, 15 Sep 2021 17:45:10 +0900
In-Reply-To: <3ec9f755-404c-88b4-8efb-a29fb18f392@redhat.com> (John Kacur's
        message of "Thu, 9 Sep 2021 08:47:11 -0400 (EDT)")
Message-ID: <87v9326xd5.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

John Kacur <jkacur@redhat.com> writes:

> On Wed, 1 Sep 2021, Punit Agrawal wrote:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> 
>> When running rteval on a system with kthreads running with "deadline"
>> policy, an exception is encountered when parsing the output of "ps".
>> 
>>     [DEBUG] cmd: /usr/bin/ps -eocommand,pid,policy,rtprio,comm
>>     Traceback (most recent call last):
>>     ...
>>       File "...rteval/rteval/sysinfo/kernel.py", line 60, in kernel_get_kthreads
>> 	ret_kthreads[v[0]] = {'policy' : policies[bytes.decode(v[1])],
>>       KeyError: 'DLN'
>> 
>> The kernel uses deadline policy for "schedutil" cpufreq governor
>> threads. Fix the crash in rteval by adding support for "deadline" to
>> the list of policies.
>> 
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/sysinfo/kernel.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/rteval/sysinfo/kernel.py b/rteval/sysinfo/kernel.py
>> index 97ad9402b13e..f2e9d72ac2ef 100644
>> --- a/rteval/sysinfo/kernel.py
>> +++ b/rteval/sysinfo/kernel.py
>> @@ -44,7 +44,7 @@ class KernelInfo:
>>  
>>  
>>      def kernel_get_kthreads(self):
>> -        policies = {'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>> +        policies = {'DLN': 'deadline', 'FF':'fifo', 'RR':'rrobin', 'TS':'other', '?':'unknown'}
>>          ret_kthreads = {}
>>          self.__log(Log.DEBUG, "getting kthread status")
>>          cmd = '%s -eocommand,pid,policy,rtprio,comm' % getcmdpath('ps')
>> -- 
>> 2.32.0
>> 
>> 
>
> Signed-off-by: John Kacur <jkacur@redhat.com>

It looks like this patch and the other one converting hackbench memory
check to a warning was missed when applying the rest of the series -
John, could you please pick these as well.

Thanks,
Punit
