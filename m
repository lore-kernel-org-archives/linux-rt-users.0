Return-Path: <SRS0=Ir0P=V4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D4C32751
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52284208E3
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Jul 2019 15:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUt8lZxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfGaPTT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Jul 2019 11:19:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52260 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728543AbfGaPSs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Jul 2019 11:18:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so61214823wms.2
        for <linux-rt-users@vger.kernel.org>; Wed, 31 Jul 2019 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3vbmTZp7vw8h/pflQkcoTH8pYw4g3uDpC1Cao0ypU+M=;
        b=NUt8lZxKh2RCrdUP3QdfvyDOD/zpx6+eceI59v9UJI9+TWMmgBXJnZczRPvDgaMjaZ
         1DTO2My6rOUZKhgIJV9kOWI0y10m/L2ooLoknqbWFC4oCKDj2OTFrSB71fWOGC+P2nJy
         kGjshwPZOJ6qkQjHc/vLVuNIXStDL2F7Pu7ImUDWceRtlsP+kvIXNsf27uiEnlb4SXmy
         bnPXL9+VN4HfDp2s4iyIMYmYMahMsUXzx/TdRTdfGCn0O5xys7qjKbVOUVTux20iLkNd
         lOrPGfZyjSAraA3z2AJ8DO+jBA0/PUSFNV5WkqWx24FC63jhlXwq7xhmk4qmHdAT0MV+
         u/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=3vbmTZp7vw8h/pflQkcoTH8pYw4g3uDpC1Cao0ypU+M=;
        b=c4Jwo6sgUMQXJaiDyLyCruWLU8qXuvNpwDFES7zt4ILcf4tOH2Ym0+ehaeelV40SdV
         pgy8iuHSrTkhLOXmSMWrSqSO4yVmu6Q2xbByD0ONB9BEy9jWY0lQQpdd/GZ42VhbdQvX
         OPT6AjB1FZPX2DDqzeRp3+jTli0yDhXSBkcUDL9CW9vOxZsSTbHY2hTekzrxw9RyZakm
         yKBlcBPBFORNYpzs27Ss5z40yqkvOMSgUxinzSI6VV67Q589/iNO9sN/sidd7HPcgoZQ
         mi8kmieucmLHKbWo+pesSNdF0NQlcaJP3O2KA0GiNENyezZyhBxvTsMMBKD6JoBPD8bB
         cY3A==
X-Gm-Message-State: APjAAAW2qAQOjoxhAAs1lCszRL207XPDQt2ofwdaGhuH/QFRxn9ofF8B
        0St59cBePpl6ZlImKCJ5uFE=
X-Google-Smtp-Source: APXvYqyAKndpxC9MJszcAYYFpO9DEbuc8cCFFCrUnDzlYNvRzqbG2SabLGo5JzGq+av6RIDo0AKg9w==
X-Received: by 2002:a1c:7414:: with SMTP id p20mr108145483wmc.145.1564586002802;
        Wed, 31 Jul 2019 08:13:22 -0700 (PDT)
Received: from planxty (ip1f122014.dynamic.kabel-deutschland.de. [31.18.32.20])
        by smtp.gmail.com with ESMTPSA id 2sm97000961wrn.29.2019.07.31.08.13.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 08:13:22 -0700 (PDT)
Date:   Wed, 31 Jul 2019 17:13:14 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Qiao Zhao <qzhao@redhat.com>
cc:     linux-rt-users@vger.kernel.org, jkacur@gmail.com,
        williams@redhat.com
Subject: Re: [PATCH] ptsematest, sigwaittest, pmqtest, svsematest reprot
 error "Could not access /sys/kernel/debug/tracing/tracing_enabled"
In-Reply-To: <20190725024915.11497-1-qzhao@redhat.com>
Message-ID: <alpine.LFD.2.21.1907311712010.21757@planxty>
References: <20190725024915.11497-1-qzhao@redhat.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 25 Jul 2019, Qiao Zhao wrote:

> For current RHEL7 and RHEL8 kernel (3.10.0 and 4.18.0), we use "tracing_on"
> to control tracing disable/enable. The "tracing_enabled" is not the
> current value.
> 
> For RHEL bug: https://bugzilla.redhat.com/show_bug.cgi?id=1731336
> E.g: # # svsematest -a -b 20us -f -i 100 -l 100 -S
> ...
> Could not access /sys/kernel/debug/tracing/tracing_enabled
> 
> Sanity test passed. No this error msg when patched.
> 
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> ---
>  src/pmqtest/pmqtest.c         | 2 +-
>  src/ptsematest/ptsematest.c   | 2 +-
>  src/sigwaittest/sigwaittest.c | 2 +-
>  src/svsematest/svsematest.c   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 2191710..a04fc49 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -204,7 +204,7 @@ void *pmqthread(void *param)
>  				char tracing_enabled_file[MAX_PATH];
>  
>  				strcpy(tracing_enabled_file, get_debugfileprefix());
> -				strcat(tracing_enabled_file, "tracing_enabled");
> +				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index e8a3177..5537592 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -131,7 +131,7 @@ void *semathread(void *param)
>  				char tracing_enabled_file[MAX_PATH];
>  
>  				strcpy(tracing_enabled_file, get_debugfileprefix());
> -				strcat(tracing_enabled_file, "tracing_enabled");
> +				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 4579f90..59f28a5 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -179,7 +179,7 @@ void *semathread(void *param)
>  				char tracing_enabled_file[MAX_PATH];
>  
>  				strcpy(tracing_enabled_file, get_debugfileprefix());
> -				strcat(tracing_enabled_file, "tracing_enabled");
> +				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 01083d1..8f88078 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -185,7 +185,7 @@ void *semathread(void *param)
>  				char tracing_enabled_file[MAX_PATH];
>  
>  				strcpy(tracing_enabled_file, get_debugfileprefix());
> -				strcat(tracing_enabled_file, "tracing_enabled");
> +				strcat(tracing_enabled_file, "tracing_on");
>  				int tracing_enabled =
>  				    open(tracing_enabled_file, O_WRONLY);
>  				if (tracing_enabled >= 0) {
> -- 


Thanks for the patch

I did edit the comments to remove references to rhel
Signed-off-by: John Kacur <jkacur@redhat.com>
