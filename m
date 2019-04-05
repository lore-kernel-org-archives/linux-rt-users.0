Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3C6C4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9707C206DD
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XawXQLC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfDEOdu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:33:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfDEOdu (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 10:33:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id g3so8274380wrx.9
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=tay2HgwzrulyG4rw5zVXJVBK5f04A1peT50eDrQWCc8=;
        b=XawXQLC6Ha2FOBplNUG0kDpxs+iWk4y9YHATdAFtp0e4AxJz25rgRkhvIQb06wBlDK
         NBpB5ozd6ThTD8828cbJeZHIo/tGjTJX8usWg26121a3GrAvJh9kVsB/OvgwVP632MNw
         clo1DP2MOMuGR+Oz2Z1Z4W8eBRgk2awnoRw9CNgsbr+zZ6QQio7OrTPaP8yvMKsK1usz
         dQ9JDpO8AJppjfLOYf+h7yKggmzO6E5m4S8PjEY2S5vEy/JulbKgbiLD9QsBancAHlol
         hUd2QXWXIx2DoSbh6woy2WkV+6ErmIBAnOLsReFqNGDVa3dQQPDjcqI4cESVc+LaN9E2
         jcWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=tay2HgwzrulyG4rw5zVXJVBK5f04A1peT50eDrQWCc8=;
        b=lMO5JPjA3hwe7Z2kIY0WTSNoOGT4TP6ch/GClgFT64u4QpcETdHrlXSYCrC6GgG3g+
         9p1Wbi23n5SIMADXxVvO8ZOr4KUeED0py00navx1NghBLlAuuE/OUjSd+CcoZGs85R9M
         rTnnMEIdqmF8u1epROMnou9FUKKmKFyvaLt6sTk//4t6d0RUarRC3bHFLxX2aT/Eys52
         gttDw6h1oDzxQa1JXLaAq5W9XxQqD5XCrjRNHWSmqpxULrMBIkEaG1hdu9gzvYNkKbQq
         qeIA+V9mvNBMdjIpbzm0HK24lktuRW2EY6clgKjFv2oyDs+tWhKnLr/SS1Y6CsHbkD/b
         JYQg==
X-Gm-Message-State: APjAAAVuAnEObiQAwKgr4L1EYb/WN08QAjficJbELOfIiCxFoenGKZbA
        5DbRSvTPxrPCj7KkES/mK8k=
X-Google-Smtp-Source: APXvYqy29P8Bhon2Vid32WQkr3mvr80RGKvzJJTnNkjK31KidOj9c0ZCv56Gr4w40bj2DM+biCtzfw==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr9348500wrs.252.1554474828371;
        Fri, 05 Apr 2019 07:33:48 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id j3sm47255965wre.51.2019.04.05.07.33.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 07:33:47 -0700 (PDT)
Date:   Fri, 5 Apr 2019 16:33:33 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 1/4] rt-tests: cyclicdeadline: fix segmentation fault on
 close
In-Reply-To: <20190404134814.13376-2-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904051633140.8480@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-2-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> The current code generates a segmentation fault in the last free() call.
> 
>   $ sudo ./cyclicdeadline
>   Using all CPUS
>   /sys/kernel/debug/sched_features: Success
>   interval: 600:1000
>     Tested at 5us of 600us
>   deadline thread 2963
>   thread[2963] runtime=600us deadline=1000us
>   main thread 2962
>   fail 2 0
>   T: 0 ( 2963) I:1000 C:   1268 Min:      7 Act:   55 Avg:   56 Max:     256
>   [1]    2961 segmentation fault  sudo ./cyclicdeadline
> 
> This is caused by a buffer overflow in setup_ftrace_marker(). The appended
> string is 21 not 14 characters wide. Fix it by using strlen() like the other
> function do.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 08460107c464..303b5e96647a 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -283,7 +283,7 @@ static void setup_ftrace_marker(void)
>  {
>  	struct stat st;
>  	const char *debugfs = find_debugfs();
> -	char files[strlen(debugfs) + 14];
> +	char files[strlen(debugfs) + strlen("/tracing/trace_marker") + 1];
>  	int ret;
>  
>  	if (strlen(debugfs) == 0)
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
