Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE611C282CE
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8AD2146F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tppK8yo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfDEQ3R (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:29:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36040 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730554AbfDEQ3R (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 12:29:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id h18so7864707wml.1
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 09:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=VoJe8BPbaY26gcBAO50w+hZ6oHgHfEG78c5rLQPstUo=;
        b=tppK8yo1lDiHR2HytcNfeMlm4gbdr1bnMspzH+BCahXJVXYTtwWl+lFNNbzBflN/W4
         vI49hFdCSZPKKYQ+Iorp3gOssd/IM06hlwN62JdppsAG1/ECEW7p8AGRkEOquVBsg1oM
         Zn0D6KsDfasuVf12G8W7xJu+87jBWoOcrgv5mgvdOBgViAWgchZUnBSUOVSN2KIbuzd7
         6CaWH406i0EJC1IORwtmBacrUTn86qhYRIjqf5yjtvylCeIvnhjL1LCaudwbiqE6z5te
         xh4rtGrX01q9jvpi7o1bSyJokW0p83XCVLJ8MoRxwr+xhNF5Du53QGOFxmgULQcVWUcn
         xrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=VoJe8BPbaY26gcBAO50w+hZ6oHgHfEG78c5rLQPstUo=;
        b=GrudWN+0LuQiXNG5CXz7YavsQHo8qxHF3HAviZJRAEMhI4YCzEpv1Is8HJySs+AYvr
         u4skYYGKQeiDZYgewbFDqJmJe2wxFzgS6+WgET6TU6yZOdpVL3BVd65+ta4wC69r+PSY
         YgUXD4nbK6LnHqwSypckWW2vj5LzD17AwJWAwvFJzc8qSJXvTuD0qwOC7DhI/TjUKoaf
         DDdRP/DY5nhR+pfqWG/PwILnOsQx5CubGafj4Pe2rWgPDRMCTvr/yXxii0ocxigwB5pS
         quCMG9owVggsdQ1hGF7u2IP2Rtv8LhOsGWBFPRHLxpa4DFHg5qSpU1C6OqpynnhIYK0u
         ++dQ==
X-Gm-Message-State: APjAAAV2ogfMQ11ybndmNzKPRdKI6ktu8EzPIRvi7FWc8rRyJVG8uYeB
        u8UoniRjrMjXgF1EHTeioLA=
X-Google-Smtp-Source: APXvYqyuhRGjHoCMAMzm15nuNtUWzjGcojxiXDX8uvKYxIFTzOmYw74WDTTsJWs5jBGVSumTGgbFqA==
X-Received: by 2002:a1c:3507:: with SMTP id c7mr8499270wma.20.1554481755383;
        Fri, 05 Apr 2019 09:29:15 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id b10sm33513076wrt.86.2019.04.05.09.29.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 09:29:14 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:29:13 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <daniel.wagner@siemens.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 3/4] deadline_test: Free allocated resources at exit
In-Reply-To: <20190312172436.18314-4-daniel.wagner@siemens.com>
Message-ID: <alpine.LFD.2.21.1904051828530.8480@planxty>
References: <20190312172436.18314-1-daniel.wagner@siemens.com> <20190312172436.18314-4-daniel.wagner@siemens.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 12 Mar 2019, Daniel Wagner wrote:

> Signed-off-by: Daniel Wagner <daniel.wagner@siemens.com>
> ---
>  src/sched_deadline/deadline_test.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index 1b72c6097a87..04984d997f58 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -2092,8 +2092,12 @@ int main (int argc, char **argv)
>  		printf("\n");
>  	}
>  
> -	if (!setcpu_buf)
> +	if (setcpu_buf)
>  		free(setcpu_buf);
> +	free(thread);
> +	free(sched_data);
> +
> +	CPU_FREE(cpusetp);
>  
>  	return 0;
>  }
> -- 
> 2.20.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
