Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402D2C4332F
	for <linux-rt-users@archiver.kernel.org>; Wed,  2 Nov 2022 20:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiKBUb1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 2 Nov 2022 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiKBUb0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 2 Nov 2022 16:31:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F6B88
        for <linux-rt-users@vger.kernel.org>; Wed,  2 Nov 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667421023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XQyQZbBaa7C1Rq3N7Z9zsZCeOoS0vR0UfP0yySU/eBg=;
        b=DyBDVwugBgJG2/WkI7Egt371o6VQzmVVJUZWNvZr5aLv3zqniecV/wYl9UuhFzc4a5cOUc
        CPgysbuiBw51XRcIzL/ePcTiWlHUrbnGPcG8wgPWrCTFoVJVHGdmzMtnd142lu0pN/Lr/m
        G2tcM7GKNaUq7X7MNAAOfxl6pArmLUk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-655-CZcmNb5YPT-GGv0RsMPonQ-1; Wed, 02 Nov 2022 16:30:21 -0400
X-MC-Unique: CZcmNb5YPT-GGv0RsMPonQ-1
Received: by mail-qt1-f200.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so76141qtb.9
        for <linux-rt-users@vger.kernel.org>; Wed, 02 Nov 2022 13:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQyQZbBaa7C1Rq3N7Z9zsZCeOoS0vR0UfP0yySU/eBg=;
        b=IQ07EXhmCGHBaiutmkcQ0ZHnucAXn91ULhkH/G9P37xyjg0D2zjhTSscSbsOJ7Z74W
         IR4yFZjuEtlbFyr0ZFbDzxgIY2SGgGuwOAhZ88J3qotkpbmP08vK4C8ZqJW7yrlchtkV
         0ohIzEnOiEYXSTDHmUkK6RMrXOLzu3uLpiWCrzERLIk9vuXc8wQZcte5fUJDOOEhbaVV
         fgKwLuev1xKLBltjHohUNjy7jNKi1DwLh4+0GUL+Ihr6WlRvuO2/Yhtapx+pzhglZwny
         5rAGnAMVUIws9mTa13zL0CXJG1tg21IVLSf/UZqqjqH4Y/G/tKq02qZuwHR8iHeyOQIp
         xK9g==
X-Gm-Message-State: ACrzQf0J7GvRn+nK1afQPgc4FsPNS2OGHfy2Ce4wtvHV2CQMQUaEglNy
        N4iGSAqQdFLsaqRq5K11LO5k/HsdxOj0jjm64+QW/tDssgKTW+p7W4jFG9A4vultbavN892J3qw
        ovP6ThF/eeY9zESBLLWV+CquYK0Y=
X-Received: by 2002:a05:620a:1002:b0:6fa:f78:32c8 with SMTP id z2-20020a05620a100200b006fa0f7832c8mr19052996qkj.89.1667421020396;
        Wed, 02 Nov 2022 13:30:20 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6FVHBWvnTgOct7EnXaIEv0Ou+7tQg69e0KLy5P4JOEDD54hQoZq9PbvDa0rnTiQzBIPy4Hhw==
X-Received: by 2002:a05:620a:1002:b0:6fa:f78:32c8 with SMTP id z2-20020a05620a100200b006fa0f7832c8mr19052977qkj.89.1667421020149;
        Wed, 02 Nov 2022 13:30:20 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id dm21-20020a05620a1d5500b006b95b0a714esm9233542qkb.17.2022.11.02.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:30:19 -0700 (PDT)
Date:   Wed, 2 Nov 2022 16:30:18 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: hwlatdetect.py Covert to f-strings
In-Reply-To: <20221102143554.214241-1-lleshchi@redhat.com>
Message-ID: <f624d8c-3865-2cb-d030-a8c20f46d9a@redhat.com>
References: <20221102143554.214241-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 2 Nov 2022, Leah Leshchinsky wrote:

> Add f-strings where applicable for readability.
> 
> Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 9ef50f862127..3b20f664a536 100755
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
> @@ -192,13 +192,13 @@ class Detector:
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
> @@ -518,7 +518,7 @@ if __name__ == '__main__':
>      info("Samples recorded: %d" % len(detect.samples))
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

This looks fine, but there are others that could be converted too.

Signed-off-by: John Kacur <jkacur@redhat.com>

