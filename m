Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EDCC433F5
	for <linux-rt-users@archiver.kernel.org>; Sat, 16 Apr 2022 20:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiDPUXf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 16 Apr 2022 16:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbiDPUXe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 16 Apr 2022 16:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CD6E3CA58
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Apr 2022 13:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650140460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CyxydshJEcsTWnB+SSfy9/AjRCEUls6qGE26r0SBPkE=;
        b=dtkPi2y9W7xpFdNlGBE7XYndCqBmSWoT98oBKcU2Uj/c6/dyPeHJHngBu9p2BvsClpRVTz
        bsmIGwZdUxlQM+H4Jcjvty/pSCLQSGqdmjnbTxqbMmKZAGk046zSoEawQ6ndUfZI0wWi62
        lp0unMWVpElIQKIrkU7YVYc4EjglP1w=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-465-_2wn4LB2PWKI8qo2uccViw-1; Sat, 16 Apr 2022 16:20:58 -0400
X-MC-Unique: _2wn4LB2PWKI8qo2uccViw-1
Received: by mail-qv1-f69.google.com with SMTP id cs5-20020ad44c45000000b004463a27fb3fso3270151qvb.9
        for <linux-rt-users@vger.kernel.org>; Sat, 16 Apr 2022 13:20:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=CyxydshJEcsTWnB+SSfy9/AjRCEUls6qGE26r0SBPkE=;
        b=eEPIA06OggiClQ5ia+GPuuPZN4lHck/ylwL7LAV+0ZAPpE3NRHACb7URFvpZHaacSm
         Npb5F4WeAp30NwIYrrIggfN6017+fkHKwuZu0JV2XlGHkD+lVn+BweucxMH6DBbSSc8x
         LLsqan42Goa7H1SRXCDDlm7vjwItSejDrmw11TTNASvVbdHZt18UjIqEiRV5ZLm1hrob
         95J1pT1Bk1lcQvEjJhKPpdBL+GnnLx/H0xizcKIZcAFQ7XmSVMytBOLIjmo8oDHpsxGu
         ariu456X0im1K2pYGA2w3U5o7cdwJdx+aDBB9VUnC/zKaclwWjv7MKftWf2e+A1yfLpm
         AFEw==
X-Gm-Message-State: AOAM531Q5CXk1ipn584QU2sqR8+eu3FtVkjh3/GCCaq3LZqBqPCfPVT8
        susrobppoUpyTfO7TZAii314zwFu4ActyQxoU2SAaOv8x9Sq+74td5GEE6Y8kiwwFImZUpl+ecG
        PmXgeennOLAM8ZDmeH/0pdaB2we8=
X-Received: by 2002:a37:a50:0:b0:69c:7129:12da with SMTP id 77-20020a370a50000000b0069c712912damr2839287qkk.90.1650140457990;
        Sat, 16 Apr 2022 13:20:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoTEDbnMDx+sL/erXkZc3/b+zgzwLhdKCauUtEDvDho5Z9/Weoe5iImRctr5DZN6mpBaMy/Q==
X-Received: by 2002:a37:a50:0:b0:69c:7129:12da with SMTP id 77-20020a370a50000000b0069c712912damr2839277qkk.90.1650140457795;
        Sat, 16 Apr 2022 13:20:57 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-93.dsl.bell.ca. [184.147.143.93])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm5086798qtx.89.2022.04.16.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 13:20:57 -0700 (PDT)
Date:   Sat, 16 Apr 2022 16:20:55 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: hwlatdetect: Add option to specify cpumask
In-Reply-To: <TYCP286MB1913F333CCBD550E845C4CFDA1EA9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
Message-ID: <e7ca21e5-2a90-f954-2ac8-4629290b61b@redhat.com>
References: <TYCP286MB1913F333CCBD550E845C4CFDA1EA9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Apr 2022, Oscar Shiang wrote:

> The hwlat tracer can be configured to run on a set of cpus via
> tracing_cpumask [1].
> 
> Add a new option cpu-list to support the configuration of
> tracing_cpumask in the format of cpu list.
> 
> For example, if we want the thread to run on CPU 1,2,3 and 5,
> we can specify the cpu list to 1-3,5
> 
> The value to pass to hwlatdetect is:
> 
>     $ hwlatdetect --cpu-list=1-3,5
> 
> [1]: https://docs.kernel.org/trace/hwlat_detector.html
> 
> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  src/hwlatdetect/hwlatdetect.8  |  3 +++
>  src/hwlatdetect/hwlatdetect.py | 19 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.8 b/src/hwlatdetect/hwlatdetect.8
> index df33180..21d0fe4 100644
> --- a/src/hwlatdetect/hwlatdetect.8
> +++ b/src/hwlatdetect/hwlatdetect.8
> @@ -88,6 +88,9 @@ actually sampling. Must be less than the \-\-window value.
>  Specify the output filename of the detector report. Default
>  behavior is to print to standard output
>  .TP
> +.B \-\-cpu-list=CPU-LIST
> +Specify the CPUs for hwlat thread to move across.
> +.TP
>  .B \-\-debug
>  Turn on debug prints
>  .TP
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 27c2b8a..9ef50f8 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -232,6 +232,7 @@ class Tracer(Detector):
>          'window'    : "hwlat_detector/window",
>          'enable'    : "tracing_on",
>          'threshold' : "tracing_thresh",
> +        'cpumask'   : "tracing_cpumask",
>      }
>  
>      class Sample:
> @@ -410,6 +411,10 @@ if __name__ == '__main__':
>                          dest="report",
>                          help="filename for sample data")
>  
> +    parser.add_argument("--cpu-list", default=None,
> +                        dest="cpulist",
> +                        help="the CPUs for hwlat thread to move across")
> +
>      parser.add_argument("--debug", action="store_true", default=False,
>                          dest="debug",
>                          help="turn on debugging prints")
> @@ -476,9 +481,23 @@ if __name__ == '__main__':
>  
>      reportfile = args.report
>  
> +    if args.cpulist:
> +        cpumask = 0
> +        for c in args.cpulist.split(','):
> +            l, r = 0, 0
> +            if '-' in c:
> +                l, r = map(int, c.split('-'))
> +            else:
> +                l, r = map(int, [c, c])
> +            for i in range(l, r + 1):
> +                cpumask |= (1 << i)
> +        debug("set tracing_cpumask to %x" % cpumask)
> +        detect.set("cpumask", "%x" % cpumask)
> +
>      info("hwlatdetect:  test duration %d seconds" % detect.testduration)
>      info("   detector: %s" % detect.type)
>      info("   parameters:")
> +    info("        CPU list:          %s"   % args.cpulist)
>      info("        Latency threshold: %dus" % int(detect.get("threshold")))
>      info("        Sample window:     %dus" % int(detect.get("window")))
>      info("        Sample width:      %dus" % int(detect.get("width")))
> -- 
> 2.25.1
> 
> 

Nice patch, thanks
Signed-off-by: John Kacur <jkacur@redhat.com>

