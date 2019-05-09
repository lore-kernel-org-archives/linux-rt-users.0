Return-Path: <SRS0=OpkQ=TJ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE61BC04AB1
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 14:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A12085A
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 May 2019 14:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Savv3j6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfEIOOn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 May 2019 10:14:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40248 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfEIOOn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 May 2019 10:14:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id h11so3389624wmb.5
        for <linux-rt-users@vger.kernel.org>; Thu, 09 May 2019 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yJNtysPh8F58RU2XBDT2WZRAJIll7PK/odDSMPSbDcA=;
        b=Savv3j6CfJDxCrRoAsUiMywJuJW9QD3CBa1cg8cl3wQ9S+HTneUShXGuf0Y/1yPaWM
         pzp1KGqkYRr+iDy+e/BfLBiNN1X3m+Cd2oYVGAulzQHYmxGoxor1ibeNeflrtp5a3LvI
         PORU10/2oTx7IAryajappNzVxpaFw02n2knLfQIxC/ipQodIHmTr56rYPhs/yt3Hth/J
         +m8PfYvQ1J6U50HIPtjLci4ZX7/NlXTUq7O2lqr4i3puFRp+q9XKm5L/Jcksm1Pt33nA
         PLQbPfcOyYfBPLiege2DtoW5SkgJyFmt9zKUSQ1dQvX5C5AyFzTke+8SAEOvWgT4ygal
         bsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=yJNtysPh8F58RU2XBDT2WZRAJIll7PK/odDSMPSbDcA=;
        b=lTybXfFuCVsL3V5nGdmfgjQQ8hFV6MrYiSsvzF+OrsL9T7YHuSHueglNbb9Ts8Od8R
         wVgQ9Xle4tAFJFARUpkg3f6wetOUULKdQHsKbZK+5DOodik5stpwAwmrI2y+p9SFiZ6H
         0f6q0iiuXbCNWdAtNloAmYAvprzYiR7enghec8WEAV1Z+6pFL4C8oDdzlIyVmMYNUEZO
         AlDEnFEdnRk9qS/ad6eSSYFREnk+IgWCo5YjmwC5+fY/GHV3aGffaTRqmCcDdcNKWiP6
         uRHbDJsxmOWBKWV3QeWQ19A0i3p6EWF12fIZfZDvE+xpyc+zH1e1kD72ZTRG3dHlBS4s
         ShWA==
X-Gm-Message-State: APjAAAVnCvIshOmF7P0fU3EgiG0pVryk68a2HjHK8xPyz9iZrVy+UKdg
        bZ4x6+v2VQe318txgZgx/V0=
X-Google-Smtp-Source: APXvYqwVrhNAWSGdw+HcP3q+JQfRzdHM/rm8aaLPIZsKEQhzek6UM9VUwSqot3EiiH6BO5hkiJEzeg==
X-Received: by 2002:a7b:cb85:: with SMTP id m5mr3236236wmi.75.1557411281695;
        Thu, 09 May 2019 07:14:41 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id t18sm4341324wrg.19.2019.05.09.07.14.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 09 May 2019 07:14:40 -0700 (PDT)
Date:   Thu, 9 May 2019 16:14:29 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Clark Williams <williams@redhat.com>
cc:     rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] hwlatdetect: disable/enable c-state transitions during
 detection
In-Reply-To: <20190506194046.13144-1-williams@redhat.com>
Message-ID: <alpine.LFD.2.21.1905091612180.13440@planxty>
References: <20190506194046.13144-1-williams@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 6 May 2019, Clark Williams wrote:

> Recent performance tuning problems led me to realize that just running
> at fifo:99 and turning off interrupts isn't enough while looking for
> BIOS induced latencies. Power savings logic is built into most modern
> cpus and so must be disabled while looking for BIOS induced (SMI/NMI)
> latencies.
> 
> Use the /dev/cpu_dma_latency mechanism to disable c-state transitions
> while running the hardware latency detector. Open the file
> /dev/cpu_dma_latency and write a 32-bit zero to it, which will prevent
> c-state transitions while the file is open.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/hwlatdetect/hwlatdetect.py | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 2c8f9f160419..368079a158b1 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -1,6 +1,6 @@
>  #!/usr/bin/python3
>  
> -# (C) 2018 Clark Williams <williams@redhat.com>
> +# (C) 2018,2019 Clark Williams <williams@redhat.com>
>  # (C) 2015,2016 Clark Williams <williams@redhat.com>
>  # (C) 2009 Clark Williams <williams@redhat.com>
>  #
> @@ -213,6 +213,22 @@ watch = False
>              counts = [ int(x.strip()) for x in p.stdout.readlines()]
>          return counts
>  
> +    # methods for preventing/enabling c-state transitions
> +    # openinging /dev/cpu_dma_latency and writeing a 32-bit zero to that file will prevent
> +    # c-state transitions while the file descriptor is open.
> +    # use c_states_off() to disable c-state transitions
> +    # use c_states_on() to close the file descriptor and re-enable c-states
> +    #
> +    def c_states_off(self):
> +        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> +        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> +        debug("c-states disabled")
> +
> +    def c_states_on(self):
> +        if self.dma_latency_handle:
> +            os.close(self.dma_latency_handle)
> +        debug("c-states enabled")
> +
>      def cleanup(self):
>          raise RuntimeError("must override base method 'cleanup'!")
>  
> @@ -235,6 +251,7 @@ watch = False
>      def start(self):
>          count = 0
>          threshold = int(self.get("threshold"))
> +        self.c_states_off()
>          debug("enabling detector module (threshold: %d)" % threshold)
>          self.set("enable", 1)
>          while self.get("enable") == 0:
> @@ -258,6 +275,7 @@ watch = False
>              time.sleep(0.1)
>              debug("retrying disable of detector module(%d)" % count)
>              self.set("enable", 0)
> +        self.c_states_on()
>          debug("detector module disabled")
>  
>      def detect(self):
> -- 
> 2.21.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>
