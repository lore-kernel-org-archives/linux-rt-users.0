Return-Path: <SRS0=4xIy=WT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3574C3A5A2
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C826421848
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Aug 2019 15:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDgSJt3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404965AbfHWPUl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:20:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44423 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390470AbfHWPUl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Aug 2019 11:20:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id p17so8964791wrf.11
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Aug 2019 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6AAqfL3Llgau2678RvoVkM3Ho35tUfXwmZL5+zrpiIs=;
        b=oDgSJt3AePpN/0tHnAEL3hsapq/LSUYEDRHHU3bb2XUURSX/MZg1m6KxHNjCfvAy+Z
         EzVG9ReJ89iBFFPuf+rjrqzz8tCUmiHqL4as8sz+McfL09kXZ0ZzsniHC4IS/SrsEPcX
         dMX8Lx9GCaXMYlWnGF4rdPolHweR/monNsLPPw/uu30a/HUgg9wFGPGA0B3hVfEAZXQd
         h8rQJwp00Ks6Fl4asswVzZ++ygwbkQpWmxnkMF3v6F+vwy1RlD/NSC6aj3yfDHfW43iy
         83ttaA0G0BBTjFiQrICdUT+dl5DUspysE1U6Uf1Ay7/xjUSdTIojKkzMlFPF9uwwI77v
         wAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=6AAqfL3Llgau2678RvoVkM3Ho35tUfXwmZL5+zrpiIs=;
        b=Dw0APMtJjuctWCTk9lcOSHS1xcpTMGVeOmR/ZuxbEmF6ax1yctN27X0wrtX/XDg1dY
         9x7SRk5+zlbNBv/uSd0/Oc6Km2bwLIKl4zjQVLTxTefUNruz6MA+JaIrw6Vx17oWA7o4
         1KKEl0D7TUvkKChXwD2tkc+anNXinPnvxjKMVSVpKYXNyNg3UT3D7G24xVZsNGEwAebH
         ZMtKxzP6GVpJL+Kixede2/xWkef8zRMBYAM7+bdnlJsq6N2ZrTWPiM5q7t/dDKVXozye
         Fit9UIqHQswM0nAWrJ+nJWAVUSnFFIfM/mOWDBjkPXFmqXqWByWT0hfRSSfofWNkrMpo
         R05w==
X-Gm-Message-State: APjAAAVvz4fHRWo3WFqzorU/CRRNhXEotL2E+njjvQyAw/fuDrSqNCVS
        Q8EM2dAjpBvILl3OtuYg1TA=
X-Google-Smtp-Source: APXvYqxvLMcx2htDzWT8Edxy059s80Lf6u8Wu3xqnesdfAA7YfGPv3xVMP1Ixh14sCtVpOndkIMoTA==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr6005233wrx.241.1566573639009;
        Fri, 23 Aug 2019 08:20:39 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:19dc:b567:5617:6bc1:51bb])
        by smtp.gmail.com with ESMTPSA id x26sm2184098wmj.42.2019.08.23.08.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:20:38 -0700 (PDT)
Date:   Fri, 23 Aug 2019 17:20:36 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <wagi@monom.org>
cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v1 v1 4/4] deadline_test: Increase buffer to
 avoid overflow
In-Reply-To: <20190819064304.4676-5-wagi@monom.org>
Message-ID: <alpine.LFD.2.21.1908231720220.7154@planxty>
References: <20190819064304.4676-1-wagi@monom.org> <20190819064304.4676-5-wagi@monom.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463804494-1257084403-1566573638=:7154"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1257084403-1566573638=:7154
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 Aug 2019, Daniel Wagner wrote:

> Increase the size of the char buffer. gcc 9.1.1 reports:
> 
> src/sched_deadline/deadline_test.c:1803:24: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
>  1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
>       |                        ^~
> src/sched_deadline/deadline_test.c:1803:23: note: directive argument in the range [-2147483648, 2147483646]
>  1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
>       |                       ^~~~
> src/sched_deadline/deadline_test.c:1803:3: note: ‘sprintf’ output between 2 and 12 bytes into a destination of size 10
>  1803 |   sprintf(setcpu_buf, "%d", cpu_count - 1);
>       |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Daniel Wagner <wagi@monom.org>
> ---
>  src/sched_deadline/deadline_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/deadline_test.c b/src/sched_deadline/deadline_test.c
> index e2898de328bb..5b5f40dbb74d 100644
> --- a/src/sched_deadline/deadline_test.c
> +++ b/src/sched_deadline/deadline_test.c
> @@ -1795,7 +1795,7 @@ int main (int argc, char **argv)
>  
>  	/* -b has us bind to the last CPU. */
>  	if (!all_cpus && !setcpu) {
> -		setcpu_buf = malloc(10);
> +		setcpu_buf = malloc(12);
>  		if (!setcpu_buf) {
>  			perror("malloc");
>  			exit(-1);
> -- 
> 2.21.0
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
---1463804494-1257084403-1566573638=:7154--
