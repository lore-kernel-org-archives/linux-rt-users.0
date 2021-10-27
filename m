Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D125C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C261039
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Oct 2021 23:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhJ0Xbt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 19:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhJ0Xbs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Oct 2021 19:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635377362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HmdBlz+hCAYR8nrU8aYpXT3uzda8UZKTZV1Dk+HW3YY=;
        b=KwCMts4o7WRVlA9KeLtllIkh3CgrByk0CXXjqj5ZgEGiUUCfv12na7jpYg5FTIgDXKO56g
        0CGC7GQtsNYyDPt3z2XIfasRkfa3m3/TaxMHgueVvsNuH6zjdkaBmiN78kpVxWMq7baoj8
        cG7Ecx7/hbE4xJszzE9RAFnOavmu5HM=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-gN5ayjbcP4auGnvwLx_lPg-1; Wed, 27 Oct 2021 19:29:21 -0400
X-MC-Unique: gN5ayjbcP4auGnvwLx_lPg-1
Received: by mail-il1-f200.google.com with SMTP id r13-20020a92440d000000b002498d6b85c1so2869179ila.5
        for <linux-rt-users@vger.kernel.org>; Wed, 27 Oct 2021 16:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=HmdBlz+hCAYR8nrU8aYpXT3uzda8UZKTZV1Dk+HW3YY=;
        b=DDUq5g6V5I/Wv705QKdMTs86kh/0YtV9Wy7Vel8XCTDY/xJ05faNpl063/Rh7Ohl9p
         HscaLZzApC34Dk5AE1kMh5lc7NUiYWGgBt5IsVRNS4yQJ7TlLdugx0it6tmC7d5smgqq
         mT0IP2zAhoRKsTbjxdgWTHDeMDqQzMzuGnd5ub2yHNcla0VfGk60MLbNz8ccKz2mT0qJ
         NpdlUGOmA0uVwFWZBOt2OHK5hxFPe1LhCC876Od/D4nPJbfi94dNzHicU7yqSvwJamFX
         XJSTIghaATO1BucFiQ5X1ZfMnlq2OzgyyN4olyy+7Qn+6xWOGozw/ba4RSknvcw4vEFc
         kPsw==
X-Gm-Message-State: AOAM532XRbYQlm7y+XKK81tEnaxPw6H4pZUv9wr+Z2IKp/la2ULbBhF1
        bFWqlk/cR6dPEEpIHUp4DUp+sjdb42HLpbxtl87MEc3KSEoC/Sgldk6v5EC8t2OE/gBdPaJ8Md+
        I9IfZ8hoc+oEgl24Ri6um5tK7MF8=
X-Received: by 2002:a92:c983:: with SMTP id y3mr230714iln.24.1635377360491;
        Wed, 27 Oct 2021 16:29:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGRToja/ZDqz6/zr3aDcMtLmdtLOVF/kDfcgc5+Lghu2UosYPvWYeROJOfVJzB0kFyvzygPw==
X-Received: by 2002:a92:c983:: with SMTP id y3mr230704iln.24.1635377360351;
        Wed, 27 Oct 2021 16:29:20 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id k12sm744621ilu.23.2021.10.27.16.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 16:29:20 -0700 (PDT)
Date:   Wed, 27 Oct 2021 19:29:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Subject: Re: [PATCH v3 4/4] rteval: cyclictest.py: Skip statistics reporting
 in case of an overflow
In-Reply-To: <20211018055736.412576-5-punitagrawal@gmail.com>
Message-ID: <616c492a-c710-a8b-ff20-832a2816f14e@redhat.com>
References: <20211018055736.412576-1-punitagrawal@gmail.com> <20211018055736.412576-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 18 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> The cyclictest.py module recently gained the capability to parse max
> latency values as reported by cyclictest.
> 
> When the max latency exceeds the range of the latency histogram (or in
> other words, the number of configured buckets), statistics such as
> mean and standard deviation can not be calculated correctly due to
> lost samples during measurement.
> 
> In the case of lost samples, skip statistics generation and report the
> max latency warning the user to rerun the measurement.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  rteval/modules/measurement/cyclictest.py | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
> index 50a734c75047..7a619dd1c852 100644
> --- a/rteval/modules/measurement/cyclictest.py
> +++ b/rteval/modules/measurement/cyclictest.py
> @@ -67,6 +67,9 @@ class RunData:
>          retval += "mean:       %f\n" % self.__mean
>          return retval
>  
> +    def get_max(self):
> +        return self.__max
> +
>      def update_max(self, value):
>          if value > self.__max:
>              self.__max = value
> @@ -423,6 +426,13 @@ class Cyclictest(rtevalModulePrototype):
>          if abrt:
>              rep_n.addChild(abrt_n)
>  
> +        # Let the user know if max latency overshot the number of buckets
> +        if self.__cyclicdata["system"].get_max() > self.__buckets:
> +            self._log(Log.ERR, "Max latency(%dus) exceeded histogram range(%dus). Skipping statistics" %
> +                      (self.__cyclicdata["system"].get_max(), self.__buckets))
> +            self._log(Log.ERR, "Increase number of buckets to avoid lost samples")
> +            return rep_n
> +
>          rep_n.addChild(self.__cyclicdata["system"].MakeReport())
>          for thr in self.__cpus:
>              if str(thr) not in self.__cyclicdata:
> -- 
> 2.33.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

