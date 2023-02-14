Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFAC636CC
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Feb 2023 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBNB7w (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 13 Feb 2023 20:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBNB7u (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 13 Feb 2023 20:59:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6813198
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2023 17:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676339943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P+ffTu3y8Zy6aIL5NSbj0x/oUp2hzc1RZkyDpNmeuhs=;
        b=DHcPAEU7VpFkoQ44reNOzZdUU7++6FXiiV2ukB6hiB3JdpiZzNS9W/2JIEoi9Qr+5cpflD
        xGfuBKS4d2FE61n7lbgqJ21kOwubWi/HFgbBS8uh0lcgghmR6PzX4DEwVVTqgvCDV2AJ9H
        VDsNbwmMDrqr5/Rje5LVjrCrhS0pn6Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-19-kvtgofxEMemGiaAHvAQQwQ-1; Mon, 13 Feb 2023 20:59:01 -0500
X-MC-Unique: kvtgofxEMemGiaAHvAQQwQ-1
Received: by mail-qt1-f199.google.com with SMTP id a24-20020ac84d98000000b003b9a4958f0cso8502650qtw.3
        for <linux-rt-users@vger.kernel.org>; Mon, 13 Feb 2023 17:59:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P+ffTu3y8Zy6aIL5NSbj0x/oUp2hzc1RZkyDpNmeuhs=;
        b=4JKXNsw2TMXsqDP88MgcnhWpaiC8CLU8sVm8yZORxGHKo0BFu5MoYY9l3gLmczHBB+
         xdob4j3B9b/ivPJPHW5Ouf8+WDTNXO2ltj2EyWc3VwM9BhwKSXkTe0bCbTA4Huv4vWs0
         fA99WlK1Cegmm/+4R5gjrKmwbKlWBXyFZcAcyIJP5z0JNODKvFEUT3a60JvqEa1Llw3v
         AKIkfj25Abj9zb4/cvwdWDhtEzETPae7FVTmwKmJE6CFEYJUwApVliq3yiDv3LNB/7iO
         WaiMk1B5IZ1elVe328BptjczzmvmI/A4ZUqzyTGCLDdz+jy/ZfPu3sHFKCoDRNFXfS1y
         QuWQ==
X-Gm-Message-State: AO0yUKV/wtSzaKLCHMNH24R24ErbXuB4rvcM9MdPz1F9jnCFc70oLcK+
        wRyNMFJmliFeE+dyJaLli7Xo30kpy85FmWDphx0OEQ1wYCj6bPaJNSWFmqBms9ulq8lBbU2N5Qa
        W5zu1O1B43wjlrHnqEVNQMcl/26w=
X-Received: by 2002:ac8:5e0a:0:b0:3b8:61df:e298 with SMTP id h10-20020ac85e0a000000b003b861dfe298mr1157671qtx.3.1676339941146;
        Mon, 13 Feb 2023 17:59:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9vW2LGCSyO3zfEgdN9F6bHWOLn0bSn+Vj32FCdParHusKiw3t75Ycc15Y3eapg16oKHjalJw==
X-Received: by 2002:ac8:5e0a:0:b0:3b8:61df:e298 with SMTP id h10-20020ac85e0a000000b003b861dfe298mr1157652qtx.3.1676339940926;
        Mon, 13 Feb 2023 17:59:00 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-14-76-71-123-7.dsl.bell.ca. [76.71.123.7])
        by smtp.gmail.com with ESMTPSA id d19-20020ae9ef13000000b0071ddbe8fe23sm10849361qkg.24.2023.02.13.17.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 17:59:00 -0800 (PST)
Date:   Mon, 13 Feb 2023 20:58:55 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Costa Shulyupin <costa.shul@redhat.com>
cc:     Clark Williams <williams@redhat.com>, bwensley@redhat.com,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: hwlatdetect: Add field cpu to samples output
In-Reply-To: <20230213171136.226532-1-costa.shul@redhat.com>
Message-ID: <4f6bcb15-f0ef-76dd-fa89-b81bc3556c80@redhat.com>
References: <20230213171136.226532-1-costa.shul@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 13 Feb 2023, Costa Shulyupin wrote:

> Information about CPU index is valuable for debugging
> latency issues
> ---
>  src/hwlatdetect/hwlatdetect.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 68df58f..dc28f38 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -237,10 +237,11 @@ class Tracer(Detector):
>  
>      class Sample:
>          'private class for tracer sample data'
> -        __slots__ = 'timestamp', 'inner', 'outer'
> +        __slots__ = 'cpu', 'timestamp', 'inner', 'outer'
>  
>          def __init__(self, line):
>              fields = line.split()
> +            self.cpu = int(fields[1][1:-1])
>              i, o = fields[6].split('/')
>              ts = fields[7][3:]
>              self.timestamp = str(ts)
> @@ -248,7 +249,7 @@ class Tracer(Detector):
>              self.outer = int(o)
>  
>          def __str__(self):
> -            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}"
> +            return f"ts: {self.timestamp}, inner:{self.inner}, outer:{self.outer}, cpu:{self.cpu}"
>  
>          def display(self):
>              """ convert object to string and print """
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com

