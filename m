Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB628C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BF361215
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Sep 2021 14:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbhI1Ogc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 10:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60039 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241080AbhI1Ogc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Sep 2021 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632839691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8Dr7nkpAYqUPMG+84rCR21AHCdeI/15+1Icix4YhWY=;
        b=iKNVN3kswJljkLTTjqsAWPRGLZNixuxWQhcNLKStN+lW1wbJQDXtIIyTrdY/UvrqRgc5GG
        kf9ZIoMiFihbVXgNU9paG4E+vNRiGaRZs200Iq/VmP/N5MBEKUSLGYFxOJrDS8EEKpG6T6
        AA+gt68Rp5cR9cbBZ88BPDxDJulbJe0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-gbzIm6j-Ofij-VLBgukbEw-1; Tue, 28 Sep 2021 10:34:48 -0400
X-MC-Unique: gbzIm6j-Ofij-VLBgukbEw-1
Received: by mail-qt1-f200.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso100216056qtj.7
        for <linux-rt-users@vger.kernel.org>; Tue, 28 Sep 2021 07:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=k8Dr7nkpAYqUPMG+84rCR21AHCdeI/15+1Icix4YhWY=;
        b=RUqieQWONufvyPrWBFdPPJEW7J1ciHB9069vjEj4zPIPCIWpKsUmWq3kgKxjofZnks
         gO6S6+afaJT6WdHxyLb722+os8TZkSXA4KjRDB0C7TuUCQJRKAVLIdwySkQo3bQmPQQT
         Xvs08gOPOphr9IxboRHxIBSZPLueBmVzytlQySAN8F5M5frDim4sT08qUGUaFH9ZtssA
         hu2pHFOarjxPBRlT4rRibcJRbLux4Lu+ZtbEd+dV/IGRyAo+2OtyXEzKf8FDFVEjRWym
         XHrpH+Kefs5mQM04GEugMMsJMCwiqmwKjFwlMzElQ3xYC3TtQEGA6p+0T2Fiu16H3qcs
         B/3w==
X-Gm-Message-State: AOAM5318HfhrzaRVbGqMCJjF0EQi2GWwlmScGx5qWsp/bBMD+/TIK9B4
        4MEAMWj/L2TK1dahFqNG4vaLB4y6+ndzwFW4GYh+bEf2Tac3KzJ2woj4vQS3Z+HXxg0SLAl6ujI
        xdk5DCTyyJbDf0OjVQMkh4G299oM=
X-Received: by 2002:a37:9bd5:: with SMTP id d204mr256391qke.451.1632839687286;
        Tue, 28 Sep 2021 07:34:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzv/lRa+1tqeOopRyxhQkZOXIhp7uWpm3xtAmVZF4cjoepfCNMHHrDhl3CqNZtpwfzyREC9g==
X-Received: by 2002:a37:9bd5:: with SMTP id d204mr256370qke.451.1632839687092;
        Tue, 28 Sep 2021 07:34:47 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id q137sm15435696qke.103.2021.09.28.07.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 07:34:46 -0700 (PDT)
Date:   Tue, 28 Sep 2021 10:34:45 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     linux-rt-users@vger.kernel.org, daniel.sangorrin@toshiba.co.jp,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Suresh Hegde <suresh.c11@toshiba-tsip.com>
Subject: Re: [PATCH v2] rt-tests: hwlatdetect: Gracefully handle lack of
 /dev/cpu_dma_latency
In-Reply-To: <20210928085900.3422085-1-punitagrawal@gmail.com>
Message-ID: <748d14f-a32e-961-8581-f58be77ca419@redhat.com>
References: <20210928081716.3421463-1-punitagrawal@gmail.com> <20210928085900.3422085-1-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 28 Sep 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> On systems where cpu idle is disabled to reduce latencies,
> "/dev/cpu_dma_latency" does not exist and leads to the following
> exception report from python when using hwlatdetect.py -
> 
>     FileNotFoundError: [Errno 2] No such file or directory: '/dev/cpu_dma_latency
> 
> Update hwlatdetect to check whether the file exists before attemping
> to write values to it.
> 
> Reported-by: Suresh Hegde <suresh.c11@toshiba-tsip.com>
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
> v1 -> v2:
> * Correct Suresh's email
> 
>  src/hwlatdetect/hwlatdetect.py | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 12228f45f852..89537a6e371f 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -216,8 +216,11 @@ class Detector(object):
>      # use c_states_on() to close the file descriptor and re-enable c-states
>      #
>      def c_states_off(self):
> -        self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> -        os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> +        if os.path.exists("/dev/cpu_dma_latency"):
> +            self.dma_latency_handle = os.open("/dev/cpu_dma_latency", os.O_WRONLY)
> +            os.write(self.dma_latency_handle, b'\x00\x00\x00\x00')
> +        else:
> +            self.dma_latency_handle = None
>          debug("c-states disabled")
>  
>      def c_states_on(self):
> -- 
> 2.32.0
> 
> 

Thanks! I have a couple of nit-picky suggestions.

If you initialize self.dma_latency_handle = None in the init method of 
class Detector, then you can drop the else part of your check to see if 
the file exists.

Also, in the situation you describe, the debug messages should probably be 
hoisted up under the "if" part, and that goes for method c_states_on() 
too, as they are not relevant.

You might as well fix the comments above the code too,
openinging -> opening
writeing -> writing
And edit that one line not to over flow 80 chars.

Thanks!

John

