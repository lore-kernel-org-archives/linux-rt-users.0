From: John Kacur <jkacur@redhat.com>
Subject: Re: hwlatdetect:  Add --hardlimit to define the real test failing
 criteria
Date: Wed, 17 Aug 2016 19:00:37 +0100 (IST)
Message-ID: <alpine.LFD.2.20.1608171848410.12882@riemann>
References: <20160815152857.054f67e3@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36587 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406AbcHQSPb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Aug 2016 14:15:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so26671609wmf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Aug 2016 11:15:30 -0700 (PDT)
In-Reply-To: <20160815152857.054f67e3@sluggy.hsv.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 15 Aug 2016, Clark Williams wrote:

> John,
> 
> Luis and I were working on our tests and decided it is more interesting, in our 
> automated tests, to have a higher tolerance for SMIs, as most of the test boxes are 
> not optimized for RT. On the other hand, we would like to know how big the firmware-induced
> latencies on these boxes.
> 
> This commit adds the --hardlimit parameter, which defines the real
> PASS/FAIL latency criteria. Latencies above --threshold will be
> annotated, but the test may PASS if the observed latencies are smaller
> than --hardlimit.
> 
> When --hardlimit is not informed, the value used for --threshold is also
> used as the hard limit.
> 
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Signed-off-by: Clark Williams <williams@redhat.com>

Note, to apply your patch you have to cd to src/hwlatdetect instead
of being in rt-tests

Since this would go in unstable, we don't have to maintain backwards 
compatibility. So, you could remove the --threshold parameter and create
--hardlimit, and --softlimit parameters that consistently do the same 
thing. (instead of having --threshold mean two different things depending 
on whether or not --hardlimit exists)

That might even be better because you could annotate a --softlimit without 
even requiring there to be a hard one.

I'm going to impose a new requirement on people submitting patches to also 
submit patches to update documentation. So once, we are agreed on what 
this change should look like you have to also change the hwlatdetect.8
page as well as the output to hwlatdetect --help

Thanks

John 
 > 
> diff --git a/hwlatdetect.py b/hwlatdetect.py
> index d9ef027..51bb401 100755
> --- a/hwlatdetect.py
> +++ b/hwlatdetect.py
> @@ -474,6 +474,10 @@ if __name__ == '__main__':
>                        dest="threshold",
>                        help="value above which is considered an hardware latency")
>  
> +    parser.add_option("--hardlimit", default=None, type="string",
> +                      dest="hardlimit",
> +                      help="value above which the test is considered to fail")
> +
>      parser.add_option("--window", default=None, type="string",
>                        dest="window",
>                        help="time between samples")
> @@ -526,6 +530,12 @@ if __name__ == '__main__':
>          detect.set("threshold", t)
>          debug("threshold set to %dus" % t)
>  
> +    if o.hardlimit:
> +        hardlimit = microseconds(o.hardlimit)
> +    else:
> +        hardlimit = detect.get("threshold")
> +    debug("hardlimit set to %dus" % hardlimit)
> +
>      if o.window:
>          w = microseconds(o.window)
>          if w < detect.get("width"):
> @@ -595,5 +605,6 @@ if __name__ == '__main__':
>          for s in detect.samples:
>              print("%s" % s)
>  
> +    maxlatency = int(detect.get("max"))
>      detect.cleanup()
> -    sys.exit(exceeding)
> +    sys.exit(maxlatency > hardlimit)
> 
> -- 
> The United States Coast Guard:
> Ruining natural selection since 1790
> 
