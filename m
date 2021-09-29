Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB1FC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE8161407
	for <linux-rt-users@archiver.kernel.org>; Wed, 29 Sep 2021 15:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbhI2PLq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 11:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344834AbhI2PLm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Sep 2021 11:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632928201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oNncbowCgMsQ3avPKLfjiYCgSFMzKGSMntIUuN5rAE8=;
        b=QVjb/y874HpBFBM9ZrxrWUx3yMLCrK+sqXdxbPh9GAwIG3qRS2e9DqL0cmslKiL5+UWRE2
        rhAmXb8u6RPlXVLy6D3D9Z3fk+82lxuFpLofrqJDo0reDEsXe4z3QBd8fVuMQ7Oy/n/X34
        0uWa7XsqXEKqUDJT4/OlhQu+J5qLeTI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-gX29fatcP6asTyZRs4yoFw-1; Wed, 29 Sep 2021 11:10:00 -0400
X-MC-Unique: gX29fatcP6asTyZRs4yoFw-1
Received: by mail-io1-f69.google.com with SMTP id p71-20020a6b8d4a000000b005d323186f7cso3222419iod.17
        for <linux-rt-users@vger.kernel.org>; Wed, 29 Sep 2021 08:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=oNncbowCgMsQ3avPKLfjiYCgSFMzKGSMntIUuN5rAE8=;
        b=HRHrKO+qkCj6+XVYosYX5ZW5095Y7tSMwh8g4qfCoSm3wPyARkXYql7rubaC+FpEpe
         ffCMOkmnCyfGFW9bHTyOPv4bgj+92FEIlEbal9NDLn5OvG8THKrSjDW9zPVEMSi5JrpL
         JCODWnyHAIQQebvhgxi4dZfrELKZGACnZn2vMaUdALfSL/Yu/1UAofSY0skZAYVNb0KD
         X0zIgMswx43Sbd5eZci/7zT66Acaga5w0Oy/FRl1GNshLCytzT80KvZX81Bia5on5549
         yAhNaa+ves+7MhwcWgcmQEfoPTI8eWN99A7/o81gORfZmLR88y2TpzaCH3fUOBTGzyl5
         eV9w==
X-Gm-Message-State: AOAM531GyKew4rHZ5W5m9L6V112lde4xRAaTlxzixvzanqQzj8x4nnlf
        sIOyx3ilVETttdq91cqvm7z/YFPgT+BOooES60V244LCe2drcaJzcySPE4OuM74HMSZjQm6qAxH
        M74k9hjRbtwovvgd4K5NojNb3ugc=
X-Received: by 2002:a05:6e02:1c4d:: with SMTP id d13mr121045ilg.49.1632928199436;
        Wed, 29 Sep 2021 08:09:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyECfILAtUxrJEI1+2jV3pNkQLeMlEE3BQYWgqbLko6tgDcKR9pJAWAZgSQpgJrn37zBJRlig==
X-Received: by 2002:a05:6e02:1c4d:: with SMTP id d13mr121033ilg.49.1632928199267;
        Wed, 29 Sep 2021 08:09:59 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id m10sm93011ila.13.2021.09.29.08.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 08:09:58 -0700 (PDT)
Date:   Wed, 29 Sep 2021 11:09:57 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v3] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
In-Reply-To: <20210929003709.3423639-1-punitagrawal@gmail.com>
Message-ID: <8ec5eca-1152-20ab-c25-2625f563773@redhat.com>
References: <20210929003709.3423639-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 29 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> On systems where cpu idle is disabled to reduce latencies,
> "/dev/cpu_dma_latency" does not exist and leads to the following
> exception report from python when using hwlatdetect.py -
> 
>     FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency
> 
> Update hwlatdetect to check whether the file exists before attemping
> to write values to it. Also, make the related debug output conditional
> to c-states support being enabled in the kernel.
> 
> While we are touching this part of the code, also address a couple of
> minor issues in the code such as -
> * correct typos
> * reflow comment to fit 80-char column limit
> 
> Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
> v2 -> v3:
> * Address issues in comment
> * Initialise self.dma_latency_handle in init()
> * Make debug() statements conditional to /dev/cpu_dma_latency
> ---
>  src/hwlatdetect/hwlatdetect.py | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 12228f45f852..56fd2af8641d 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -200,6 +200,7 @@ class Detector(object):
>          if os.path.exists('/usr/sbin/rdmsr'):
>              self.have_msr = True
>              self.initsmi = self.getsmicounts()
> +        self.dma_latency_handle = None
>  
>      def getsmicounts(self):
>          counts = []
> @@ -210,20 +211,23 @@ class Detector(object):
>          return counts
>  
>      # methods for preventing/enabling c-state transitions
> -    # openinging /dev/cpu_dma_latency and writeing a 32-bit zero to that file will prevent
> -    # c-state transitions while the file descriptor is open.
> +    #
> +    # opening /dev/cpu_dma_latency and writing a 32-bit zero to that file will
> +    # prevent c-state transitions while the file descriptor is open.
> +    #
>      # use c_states_off() to disable c-state transitions
>      # use c_states_on() to close the file descriptor and re-enable c-states
>      #
>      def c_states_off(self):
> -        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> -        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> -        debug("c-states disabled")
> +        if os.path.exists("/dev/cpu_dma_latency"):
> +            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> +            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> +            debug("c-states disabled")
>  
>      def c_states_on(self):
>          if self.dma_latency_handle:
>              os.close(self.dma_latency_handle)
> -        debug("c-states enabled")
> +            debug("c-states enabled")
>  
>      def cleanup(self):
>          raise RuntimeError("must override base method 'cleanup'!")
> -- 
> 2.32.0
> 
> 

Signed-off-by: John Kacur <jkacur@redhat.com>

