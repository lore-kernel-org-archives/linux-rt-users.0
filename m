Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA5C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 May 2022 10:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiECKac (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 May 2022 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbiECKa3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 May 2022 06:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D736C270A
        for <linux-rt-users@vger.kernel.org>; Tue,  3 May 2022 03:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651573616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ACXzqzZIpagn9Gc4X6IO21huUPSi5KC6syV3IW3U6k=;
        b=dxQZNXsWhsB1/uH1azgTl2HOmDAiu9Wom+8RzW7HNEiP2yghDNOJzVVpUtrLhvnGiG5k33
        AmFjjMVLypjkmERkhpzFFfqRvMeNUBS9Jr4J4S2fuq4bFrXF3K/s1aSlM8app3R0ktW2ko
        eL3TZjxJhzT3rEcKY8MscJfdkesTwvI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-TaWaMUUwPrm6oQhGL1WapA-1; Tue, 03 May 2022 06:26:55 -0400
X-MC-Unique: TaWaMUUwPrm6oQhGL1WapA-1
Received: by mail-wm1-f71.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso589235wmq.3
        for <linux-rt-users@vger.kernel.org>; Tue, 03 May 2022 03:26:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ACXzqzZIpagn9Gc4X6IO21huUPSi5KC6syV3IW3U6k=;
        b=AkJfKBmDn7rQa8uZLiSLvJQHSm/zSNdKcxBIqDfhrumBzZCKK9UzTEmRUXrg7veSo1
         j4oc1rT8vo5GoCqqJnZjLmyaYFKZcEYKjp4atjgAzU3zpAwW9fkfOVAdmV71NIl0hUGv
         Yz7EQA+NBk4xQEqfHZP9K/ITZqT5uq+NgfliXmYxPSnKmoAv5+1+MrHFhlApl3B4WImv
         ETQe+UiuyjKGT3HE8t8V3Eqdls375WT5FETw/PWG9XNI/K8p5STrSEV8emppjJjvQXc8
         DTX2/xGjjqu7KVrXttmdYcSSNk/VAmTWHXUhtv8ZYkawo4UPWn/Utaz8ftPrRfNEKURg
         E/tA==
X-Gm-Message-State: AOAM533uR1Pc4qLFk00sQzP2byPoaT3sZ0RztXRs195DQzxOgvSxQEzB
        xkygNbCPuEFDIMFNW1N7NyBNhHb39IOnwwGQx/yRryo2T6foeicNzfbzgUTnIC2NOSnjAh0a+xQ
        NMY1SEp4EV4qBqaEifdTV4fTHFaI=
X-Received: by 2002:a5d:4e05:0:b0:20a:d4a6:32b1 with SMTP id p5-20020a5d4e05000000b0020ad4a632b1mr11920091wrt.174.1651573614524;
        Tue, 03 May 2022 03:26:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+nD0G+MT4Dzix/l32a9KD2YKXOtUvJq4aR0onm7+GAkCd+5oZPkMat1cpSgrOFbyEiw9UBQ==
X-Received: by 2002:a5d:4e05:0:b0:20a:d4a6:32b1 with SMTP id p5-20020a5d4e05000000b0020ad4a632b1mr11920081wrt.174.1651573614307;
        Tue, 03 May 2022 03:26:54 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id d14-20020adfa40e000000b0020c5253d8casm9058400wra.22.2022.05.03.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 03:26:53 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/3] rteval: systopology: Slight
 CpuList.__expand_cpulist() cleanup
In-Reply-To: <f03dc22b-75e8-982b-5766-e0ccfbe3cd7c@redhat.com>
References: <20220419161443.89674-1-vschneid@redhat.com>
 <20220419161443.89674-4-vschneid@redhat.com>
 <f03dc22b-75e8-982b-5766-e0ccfbe3cd7c@redhat.com>
Date:   Tue, 03 May 2022 11:26:52 +0100
Message-ID: <xhsmho80evrmb.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 29/04/22 16:53, John Kacur wrote:
> On Tue, 19 Apr 2022, Valentin Schneider wrote:
>
>> This method currently aggregates CPUs into a list, then converts this to
>> set and then back to list. The aggregation can instead be done directly
>> into a set.
>>
>> (as an offside, it would make more sense for CpuList to have its storage be
>> a set in the first place as duplicate CPU ids don't make sense for it, but
>> that's a separate discussion :-))
>>
>> The integer conversion of the "a-b" pattern can also be condensed into a
>> single map() expression.
>>
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> ---
>>  rteval/systopology.py | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/rteval/systopology.py b/rteval/systopology.py
>> index b2da7bb..2a28f9c 100644
>> --- a/rteval/systopology.py
>> +++ b/rteval/systopology.py
>> @@ -102,20 +102,19 @@ class CpuList:
>>          """ expand a range string into an array of cpu numbers
>>          don't error check against online cpus
>>          """
>> -        result = []
>> -
>>          if not cpulist:
>> -            return result
>> +            return []
>> +
>> +        result = set()
>>
>>          for part in cpulist.split(','):
>>              if '-' in part:
>> -                a, b = part.split('-')
>> -                a, b = int(a), int(b)
>> -                result.extend(list(range(a, b + 1)))
>> +                a, b = map(int, part.split('-'))
>> +                result |= set(range(a, b + 1))
>>              else:
>>                  a = int(part)
>> -                result.append(a)
>> -        return [int(i) for i in list(set(result))]
>> +                result |= {a}
>> +        return list(result)
>>
>>      def getcpulist(self):
>>          """ return the list of cpus tracked """
>> --
>> 2.27.0
>>
>>
>
> I'm guessing that the reason for the "set" was to remove any potential
> duplicates. Duplicates are not normally a problem in rteval, but if you
> want to ensure you handle any user input correctly, it makes sense to do
> that. I think your code is correct, but I'm not sure if it buys us
> anything.
>

It doesn't really, it should be functionaly identical to the existing code
- it's just "drive-by cleanup" really :)

> John

