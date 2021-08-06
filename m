Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF69C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC54061179
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhHFOCP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 10:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234249AbhHFOCP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 10:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628258518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xLvR+nVwmSCXRcuZnAHt58ex8+k6LCpGNT3kP9WtLpY=;
        b=DCE9FTw+EWjBGfXYmnkK8P7Kp3hcZ5OjuuW38lSRIi9ITcBl2VlumnzzzxKFg+IuUDkVlt
        r5u6DAWz90tg4S3yxMyUWu4RnTTaICK3L/Gq5mkWQrcpWGaeKTsN99hkmueXVrj71Va6Z7
        CSAl/aGFSQPXOugUEs4QMSnv5DKRirE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-MydLD_FxPsS32r0Ao62Vdw-1; Fri, 06 Aug 2021 10:01:57 -0400
X-MC-Unique: MydLD_FxPsS32r0Ao62Vdw-1
Received: by mail-lf1-f72.google.com with SMTP id j6-20020ac253a60000b02903b68cc7d130so3976944lfh.16
        for <linux-rt-users@vger.kernel.org>; Fri, 06 Aug 2021 07:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xLvR+nVwmSCXRcuZnAHt58ex8+k6LCpGNT3kP9WtLpY=;
        b=iwbNjhQm1cqasKpCLkjYudtHiiHrdaez2/SFhSe7DfKiMQyZELbDHSQAGGcYOGuxBZ
         whlV7KGY47htJQO8i6zzQoYXtuYigKvvhRIAhjwxRao5pICEqvy5PI+9NgT+BnPhTAGt
         hU5GVGOXX+XAS/VC92i782M9Ym4CrRUhiYNOpslOjA0aDB+fQtMKR2kSD98qYNZFqvlx
         tktC7k2YI2Ep6UaND2Of1mFfM/DY9p2Dfkfe8sm1jr1q46bf90ef34AR7kRqjVOB52Ph
         LOOBk6fIl5wwo39I9+QvBRioI3oqZtRnhN32A0I1ai9xo91x2UryQMHtb0f5BzmOeyMP
         7H4A==
X-Gm-Message-State: AOAM533XztzZ8Gmy73jizLVGVxWrCHrhbkMZLfC3cjqFoogj8QKUnWjy
        D9snl3EjrrNayHYHLiTfx0Ytsv+fYa6oIxZWhWs05vJFGxqX6LAaadSQqvO9XgearLf2z2R0LuP
        m52efYjbTVOv1H+LdR8IRpSBQ0J4=
X-Received: by 2002:a2e:22c6:: with SMTP id i189mr6805656lji.378.1628258515482;
        Fri, 06 Aug 2021 07:01:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytBxeIxtXFM3hSrN1X1Ki4+qr+wnxSpl0SdogB0m+LQ9/A3byYqC90iUwEV9FFmARDggm1xw==
X-Received: by 2002:a2e:22c6:: with SMTP id i189mr6805545lji.378.1628258513809;
        Fri, 06 Aug 2021 07:01:53 -0700 (PDT)
Received: from localhost.localdomain (cgn-b129.netstone.cz. [213.211.43.129])
        by smtp.gmail.com with ESMTPSA id m5sm677499ljq.22.2021.08.06.07.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 07:01:53 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:01:51 +0200
From:   Jan =?utf-8?B?SHV0YcWZ?= <jhutar@redhat.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     Pradeep Surisetty <psuriset@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: possibility to gracefuly stop hwlatdetect when it is runinng in
 a background
Message-ID: <20210806140151.7r436e7eexxw3nfk@localhost.localdomain>
References: <20210806140103.3qpw5ldryml5tluw@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210806140103.3qpw5ldryml5tluw@localhost.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sorry, forgot to CC linux-rt-users@vger.kernel.org

On 2021-08-06 16:01 +0200, Jan Hutař wrote:
>Hello.
>
>I wanted to use hwlatdetect in this way:
>
>    nohup ./hwlatdetect --duration <long time> ... &
>    pid=$!
>    <run my workload>
>    kill -s 2 $pid
>
>but as I'm running these in different shells (in individual ansible
>tasks), sending SIGINT does not work as Python is not registering it
>properly:
>
>    https://stackoverflow.com/questions/974189/how-to-send-a-sigint-to-python-from-a-bash-script
>
>I found it works for me with this patch (as advised on SO link above):
>
>
># diff -u /usr/bin/hwlatdetect{.ORIG,}
>--- /usr/bin/hwlatdetect.ORIG	2021-08-06 13:46:18.781000725 +0000
>+++ /usr/bin/hwlatdetect	2021-08-06 13:48:47.153994491 +0000
>@@ -12,6 +12,7 @@
> import subprocess
> import errno
> import os.path
>+import signal
> version = "0.8"
> debugging = False
>@@ -494,6 +495,11 @@
>     else:
>         raise RuntimeError("invalid input for microseconds: '%s'" % str)
>+
>+def signal_handler(signum, frame):
>+    raise KeyboardInterrupt("Signal handler")
>+
>+
> #
> # main starts here
> #
>@@ -501,6 +507,9 @@
> if __name__ == '__main__':
>     from argparse import ArgumentParser
>+    # Properly register SIGINT signal (i.e. Ctrl+C)
>+    signal.signal(signal.SIGINT, signal_handler)
>+
>     parser = ArgumentParser()
>     parser.add_argument("--duration", default=None,
>                         dest="duration",
>
>
>Please does this tiny patch make sense to you? It works for me.
>
>Thank you in advance,
>Jan
>
>
>
>-- 
>Jan Hutar   Performance Engineering
>jhutar@redhat.com     Red Hat, Inc.

-- 
Jan Hutar   Performance Engineering
jhutar@redhat.com     Red Hat, Inc.

