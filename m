Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB28AC4332F
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 16:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKKQrn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 11:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiKKQrl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 11:47:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2B836B1
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 08:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668185211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l6W2WHV77UqqsinBy3QuEMjzlmMOmXYiiFHac4B0qc8=;
        b=Tq4sYCqwpCMcaTQLIsPSlT2B2R0OT1hp+CLepeiCsSMaJNHONFKN10N00+6BarvT62ml68
        O8c+a/yaPIH/mZIJcPKqOXTUY5xS7bqIrAY+iOguUTivuKm9H+0QyUq0FpNtc9x+fTeiAk
        G01KQ6U84APinFKvXdOwB9vRHrGJPC8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-Ba1p56BfNA-IAi9BEuPIuA-1; Fri, 11 Nov 2022 11:46:50 -0500
X-MC-Unique: Ba1p56BfNA-IAi9BEuPIuA-1
Received: by mail-qt1-f197.google.com with SMTP id bb32-20020a05622a1b2000b003a56991a048so3936309qtb.6
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 08:46:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6W2WHV77UqqsinBy3QuEMjzlmMOmXYiiFHac4B0qc8=;
        b=MWV9S9A/Ku8PicsIW7qvQSW9aUjBtzq8aS+vKtT629Lx/FyEH9ZmM3LfcXCJS8nJpy
         O8214fEgdmE4GGzlJniz08rwE+L9n3zAEqQ/jEmRlHUT3z4TbMvQM5i0Tv21uKhPiy3N
         Nh3/1wRxi/hrqCTaj9bW5apB3Kp+KsAKgRZ7WW3QJvghKCKoOibGYYg1+b58JC6EBnw3
         ynfCtxxBMhpvpYBjZR9CXLrvrIAJDgxoXISMQcePosmz/8RL8ckzUcNLfZu2hd4rgYzF
         utMfRVPY91rubyWl6MkR36JNASmXMZd+kMtxcekSvttl2F0eDUUqqL+YBl6IhSTBbv/A
         EIqg==
X-Gm-Message-State: ANoB5pmwF+yzP0Egjm0B4Pf1FM5ezmEE87snXFdJvijSMtoQmth2EHej
        WeznqLKXggZrOWjp4Pey546PrnhCi3R1x6UL2OgBCKJILHaNbRiqciT1M43uCsOkxyhNdu9FupG
        nHS4r9W6UC/vtyJcfNetb2ZA7A2o=
X-Received: by 2002:a05:620a:c14:b0:6fa:ca:ba0f with SMTP id l20-20020a05620a0c1400b006fa00caba0fmr1772486qki.266.1668185209485;
        Fri, 11 Nov 2022 08:46:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7ADQKIA87Gf5LSX0hOhCEa11Q8HOppdvHmljvmcovDQgB5lhxdXLHxdMNw7SJixt2WJRmdhg==
X-Received: by 2002:a05:620a:c14:b0:6fa:ca:ba0f with SMTP id l20-20020a05620a0c1400b006fa00caba0fmr1772461qki.266.1668185209182;
        Fri, 11 Nov 2022 08:46:49 -0800 (PST)
Received: from fionn ([184.147.142.10])
        by smtp.gmail.com with ESMTPSA id y12-20020ac8128c000000b00399b73d06f0sm1475676qti.38.2022.11.11.08.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:46:48 -0800 (PST)
Date:   Fri, 11 Nov 2022 11:46:21 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v2] rt-tests: hwlatdetect.py Covert to f-strings
In-Reply-To: <20221109201241.415024-1-lleshchi@redhat.com>
Message-ID: <b2b7924a-3ba7-b0e5-b0bb-3a405b59a0c6@redhat.com>
References: <20221109201241.415024-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 9 Nov 2022, Leah Leshchinsky wrote:

> Add f-strings where applicable for readability.
> 
> Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 9ef50f862127..7b1ae646577a 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -59,7 +59,7 @@ class DebugFS:
>          if self.premounted or self.mounted:
>              debug("not mounting debugfs")
>              return True
> -        debug("mounting debugfs at %s" % path)
> +        debug(f"mounting debugfs at {path}")
>          self.mountpoint = path
>          cmd = ['/bin/mount', '-t', 'debugfs', 'none', path]
>          self.mounted = (subprocess.call(cmd) == 0)
> @@ -90,7 +90,7 @@ class DebugFS:
>              try:
>                  val = f.readline()
>              except OSError as e:
> -                print("errno: %s" % e)
> +                print(f"errno: {e}")
>                  if e.errno == errno.EAGAIN:
>                      val = None
>                  else:
> @@ -192,18 +192,18 @@ class Detector:
>          count = 0
>          threshold = int(self.get("threshold"))
>          self.c_states_off()
> -        debug("enabling detector module (threshold: %d)" % threshold)
> +        debug(f"enabling detector module (threshold: {threshold})")
>          self.set("enable", 1)
>          while self.get("enable") == 0:
>              debug("still disabled, retrying in a bit")
>              count += 1
>              time.sleep(0.1)
> -            debug("retrying enable of detector module (%d)" % count)
> +            debug(f"retrying enable of detector module ({count})")
>              self.set("enable", 1)
>          if self.get("threshold") != threshold:
>              debug("start: threshold reset by start, fixing")
>              self.set("threshold", threshold)
> -        debug("detector module enabled (threshold: %d)" % int(self.get("threshold")))
> +        debug(f"detector module enabled (threshold: {int(self.get('threshold'))})")
>  
>      def stop(self):
>          """ disable the detector """
> @@ -214,7 +214,7 @@ class Detector:
>              debug("still enabled, retrying in a bit")
>              count += 1
>              time.sleep(0.1)
> -            debug("retrying disable of detector module(%d)" % count)
> +            debug(f"retrying disable of detector module({count})")
>              self.set("enable", 0)
>          self.c_states_on()
>          debug("detector module disabled")
> @@ -248,7 +248,7 @@ class Tracer(Detector):
>              self.outer = int(o)
>  
>          def __str__(self):
> -            return "ts: %s, inner:%d, outer:%d" % (self.timestamp, self.inner, self.outer)
> +            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}"
>  
>          def display(self):
>              """ convert object to string and print """
> @@ -322,8 +322,8 @@ class Tracer(Detector):
>          if output:
>              with open(output, "w") as f:
>                  for s in self.samples:
> -                    f.write("%s\n" % str(s))
> -                print("report saved to %s (%d samples)" % (output, len(self.samples)))
> +                    f.write(f"{s}\n")
> +                print(f"report saved to {output} ({len(self.samples)} samples)")
>  
>      def display(self):
>          for s in self.samples:
> @@ -341,7 +341,7 @@ def seconds(sval):
>      if sval.isdigit():
>          return int(sval)
>      if sval[-2].isalpha():
> -        raise RuntimeError("illegal suffix for seconds: '%s'" % sval[-2:-1])
> +        raise RuntimeError(f"illegal suffix for seconds: '{sval[-2:-1]}'")
>      if sval[-1:] == 's':
>          return int(sval[0:-1])
>      if sval[-1:] == 'm':
> @@ -352,7 +352,7 @@ def seconds(sval):
>          return int(sval[0:-1]) * 86400
>      if sval[-1:] == 'w':
>          return int(sval[0:-1]) * 86400 * 7
> -    raise RuntimeError("invalid input for seconds: '%s'" % sval)
> +    raise RuntimeError(f"invalid input for seconds: '{sval}'")
>  
>  
>  def milliseconds(sval):
> @@ -367,7 +367,7 @@ def milliseconds(sval):
>          return int(sval[0:-1]) * 1000 * 60
>      if sval[-1] == 'h':
>          return int(sval[0:-1]) * 1000 * 60 * 60
> -    raise RuntimeError("invalid input for milliseconds: %s" % sval)
> +    raise RuntimeError(f"invalid input for milliseconds: {sval}")
>  
>  
>  def microseconds(sval):
> @@ -380,7 +380,7 @@ def microseconds(sval):
>          return int(sval[0:-2])
>      if sval[-1:] == 's':
>          return int(sval[0:-1]) * 1000 * 1000
> -    raise RuntimeError("invalid input for microseconds: '%s'" % sval)
> +    raise RuntimeError(f"invalid input for microseconds: '{sval}'")
>  
>  
>  if __name__ == '__main__':
> @@ -444,37 +444,37 @@ if __name__ == '__main__':
>      if args.threshold:
>          t = microseconds(args.threshold)
>          detect.set("threshold", t)
> -        debug("threshold set to %dus" % t)
> +        debug(f"threshold set to {t}us")
>  
>      if args.hardlimit:
>          hardlimit = microseconds(args.hardlimit)
>      else:
>          hardlimit = int(detect.get("threshold"))
> -    debug("hardlimit set to %dus" % hardlimit)
> +    debug(f"hardlimit set to {hardlimit}us")
>  
>      if args.window:
>          w = microseconds(args.window)
>          if w < int(detect.get("width")):
> -            debug("shrinking width to %d for new window of %d" % (w/2, w))
> +            debug(f"shrinking width to {w//2} for new window of {w}")
>              detect.set("width", w/2)
> -        debug("window parameter = %d" % w)
> +        debug(f"window parameter = {w}")
>          detect.set("window", w)
> -        debug("window for sampling set to %dus" % w)
> +        debug(f"window for sampling set to {w}us")
>  
>      if args.width:
>          w = microseconds(args.width)
>          if w > int(detect.get("window")):
> -            debug("widening window to %d for new width of %d" % (w*2, w))
> +            debug(f"widening window to {w*2} for new width of {w}")
>              detect.set("window", w*2)
> -        debug("width parameter = %d" % w)
> +        debug(f"width parameter = {w}")
>          detect.set("width", w)
> -        debug("sample width set to %dus" % w)
> +        debug(f"sample width set to {w}us")
>  
>      if args.duration:
>          detect.testduration = seconds(args.duration)
>      else:
>          detect.testduration = 120  # 2 minutes
> -    debug("test duration is %ds" % detect.testduration)
> +    debug(f"test duration is {detect.testduration}s")
>  
>      if args.watch:
>          watch = True
> @@ -491,18 +491,18 @@ if __name__ == '__main__':
>                  l, r = map(int, [c, c])
>              for i in range(l, r + 1):
>                  cpumask |= (1 << i)
> -        debug("set tracing_cpumask to %x" % cpumask)
> -        detect.set("cpumask", "%x" % cpumask)
> +        debug(f"set tracing_cpumask to {cpumask:x}")
> +        detect.set("cpumask", f"{cpumask:x}")
>  
> -    info("hwlatdetect:  test duration %d seconds" % detect.testduration)
> -    info("   detector: %s" % detect.type)
> +    info(f"hwlatdetect:  test duration {detect.testduration} seconds")
> +    info(f"   detector: {detect.type}")
>      info("   parameters:")
> -    info("        CPU list:          %s"   % args.cpulist)
> +    info(f"        CPU list:          {args.cpulist}")
>      info("        Latency threshold: %dus" % int(detect.get("threshold")))
>      info("        Sample window:     %dus" % int(detect.get("window")))
>      info("        Sample width:      %dus" % int(detect.get("width")))
>      info("     Non-sampling period:  %dus" % (int(detect.get("window")) - int(detect.get("width"))))

The above 4 lines could use f-strings too

> -    info("        Output File:       %s" % reportfile)
> +    info(f"        Output File:       {reportfile}")
>      info("\nStarting test")
>  
>      detect.detect()
> @@ -513,12 +513,12 @@ if __name__ == '__main__':
>      if max_latency == 0:
>          info("Max Latency: Below threshold")
>      else:
> -        info("Max Latency: %dus" % max_latency)
> +        info(f"Max Latency: {int(max_latency)}us")

Why is int needed?

>  
> -    info("Samples recorded: %d" % len(detect.samples))
> +    info(f"Samples recorded: {int(len(detect.samples))}")

Why is int needed? 

>  
>      exceeding = detect.get("count")
> -    info("Samples exceeding threshold: %d" % exceeding)
> +    info(f"Samples exceeding threshold: {exceeding}")
>  
>      if detect.have_msr:
>          finishsmi = detect.getsmicounts()
> @@ -527,8 +527,8 @@ if __name__ == '__main__':
>              if count > detect.initsmi[i]:
>                  smis = count - detect.initsmi[i]
>                  total_smis += smis
> -                print("%d SMIs occured on cpu %d" % (smis, i))
> -        info("SMIs during run: %d" % total_smis)
> +                print(f"{smis} SMIs occured on cpu {i}")
> +        info(f"SMIs during run: {total_smis}")
>  
>      maxlatency = int(detect.get("max"))
>  
> -- 
> 2.31.1
> 
> 
The patch looks good on the whole, just remove the unnecessary int(var)
and add the 4 missing lines that could be changed to f-strings.

Thanks!

John

