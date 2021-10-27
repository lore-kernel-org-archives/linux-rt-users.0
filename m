Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1286FC433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E569A60FC0
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhJ0Xay (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:30:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhJ0Xax (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 19:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635377305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jVASxyq+LWl8ZsKvkk2gmDex4U/xnrLQA22pOjAxLJA=;
        b=AWP3k9j7qBanWq+FJB48Ht50b9QKbOhHOvR/T+YpYt6tDaoYJyq00OXDbRmSlNVuPB5EDa
        UO7BSgTJDd6hYwkZdYoz4G7+UtXAKwAHNlj5lovVOOaYUH9m/OEtiHRosg/od16EHHYuLD
        FqB1tFxOQ3Kumy42obPfBqeihv5ySgI=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-oQbim-LfOruzfFon_G-w5g-1; Wed, 27 Oct 2021 19:28:24 -0400
X-MC-Unique: oQbim-LfOruzfFon_G-w5g-1
Received: by mail-il1-f198.google.com with SMTP id h7-20020a92c267000000b0025aac3b112aso2863400ild.11
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Oct 2021 16:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=jVASxyq+LWl8ZsKvkk2gmDex4U/xnrLQA22pOjAxLJA=;
        b=ugFlHNmUNXVILmdVTXi0TrmjgVqwcja+uWLe7jlJSEYoEC50eCXlBeRqksQSAmiGdy
         1gWQoUySU4ZS13Wt4Bu3vRNiRY46/mo6sOIdrrP55Rbv7EupG9xAFwZDQFmVi7aNutEb
         dLMMQt2bXDotFMYQuGGTiMeq/UXHNbPhRdcpJJabOE6K+owdvUP+jSzspy1qAzvT4+zx
         IMrll3XCYRGKj2129t/V+yAI45IZbBEnpUcjq1sxCMiYK19TppWl3ZB0xNI0QUfLpaea
         BWhcq7EAhk5MUk4uEYSwvjlRnP6WPUa0AHY0kNJCOOtJpKjy9/39Ul8H4I10GfBWPPQ8
         MPeg==
X-Gm-Message-State: AOAM5322nwF87CKZzdoCySzpXwlwbNdLz07OJcSiHZz1Xar5F+SBerCd
        MtuykrgU+xpoLJVxl19wSvcMP1tq/oWSVGceamWMOnCdxbNeiYipUL9PqRGnqdyUrBAFNUq0LkV
        d7t2ijWDjgG0qvtlHBCASPoSyJ40=
X-Received: by 2002:a92:c54d:: with SMTP id a13mr573286ilj.111.1635377303392;
        Wed, 27 Oct 2021 16:28:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ39ZcFIdKhO3vhzTraJhCvafBPjq/5eIPpTowFxETlnGExTjsuzFV4ivnhlW9bsX175Irpw==
X-Received: by 2002:a92:c54d:: with SMTP id a13mr573276ilj.111.1635377303200;
        Wed, 27 Oct 2021 16:28:23 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id r12sm825166ilb.28.2021.10.27.16.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:28:22 -0700 (PDT)
Date:   Wed, 27 Oct 2021 19:28:21 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH v3 2/4] rteval: cyclictest.py Parse max latencies from
 cyclictest output
In-Reply-To: <20211018055736.412576-3-punitagrawal@gmail.com>
Message-ID: <71b340f6-7678-56a9-6d23-687081c4c95a@redhat.com>
References: <20211018055736.412576-1-punitagrawal@gmail.com> <20211018055736.412576-3-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 18 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> When collecting a histogram of latencies, "cyclictest" reports the
> maximum latency encountered on each core even if they fall outside the
> configured no. of buckets. This can be useful to understand the worst
> case latencies for the run as well as right sizing the number of
> buckets for the histogram.
> 
> While processing the output of cyclictest, rteval skips the reported
> max latencies and calculates them by capping to the no. of buckets.
> 
> Fix rteval by parsing the maximum latencies reported by cyclictest.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 31 +++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 6 deletions(-)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index ee1de883d844..d3a0b045b9dd 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -67,20 +67,25 @@ class RunData:
>          retval += "mean:       %f\n" % self.__mean
>          return retval
>  
> -    def sample(self, value):
> -        self.__samples[value] += self.__samples.setdefault(value, 0) + 1
> +    def update_max(self, value):
>          if value > self.__max:
>              self.__max = value
> +
> +    def update_min(self, value):
>          if value < self.__min:
>              self.__min = value
> +
> +    def sample(self, value):
> +        self.__samples[value] += self.__samples.setdefault(value, 0) + 1
> +        self.update_max(value)
> +        self.update_min(value)
>          self.__numsamples += 1
>  
>      def bucket(self, index, value):
>          self.__samples[index] = self.__samples.setdefault(index, 0) + value
> -        if value and index > self.__max:
> -            self.__max = index
> -        if value and index < self.__min:
> -            self.__min = index
> +        if value:
> +            self.update_max(index)
> +            self.update_min(index)
>          self.__numsamples += value
>  
>      def reduce(self):
> @@ -332,6 +337,18 @@ class Cyclictest(rtevalModulePrototype):
>          return False
>  
>  
> +    def _parse_max_latencies(self, line):
> +        if not line.startswith('# Max Latencies: '):
> +            return
> +
> +        line = line.split(':')[1]
> +        vals = [int(x) for x in line.split()]
> +
> +        for i, core in enumerate(self.__cpus):
> +            self.__cyclicdata[core].update_max(vals[i])
> +            self.__cyclicdata['system'].update_max(vals[i])
> +
> +
>      def _WorkloadCleanup(self):
>          if not self.__started:
>              return
> @@ -348,6 +365,8 @@ class Cyclictest(rtevalModulePrototype):
>                  # Catch if cyclictest stopped due to a breaktrace
>                  if line.startswith('# Break value: '):
>                      self.__breaktraceval = int(line.split(':')[1])
> +                elif line.startswith('# Max Latencies: '):
> +                    self._parse_max_latencies(line)
>                  continue
>  
>              # Skipping blank lines
> -- 
> 2.33.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks!

