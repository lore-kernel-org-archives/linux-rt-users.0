Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0341C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F86204FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMRxxSdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfFSPtO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:49:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39276 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPtO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:49:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id z23so3357wma.4
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kOC9dFGFcgxRF42dUk1Toc8FG9V1zbrc4a9WdsowWiI=;
        b=JMRxxSdby7St/Zt3QWJ5P4NmTIyfn7SECO91vYvgyv1PsnY3Hyo1F7AymSXb6+n6br
         pnm5NFg3WFMAXb0orR6YMg+gVVSKYun6QGuPIapbZqnKSrRasfJ4G7tmQwMyY+k2RCUV
         pwYJDiicYMAEvbb9+2foVzz9h0A/DuBvf4fa0uyM/t0e5zCvh45VT3vKxPH7f8Em1OCu
         AsZZf/sUYk3lMG5cK8FrAbn57ftlyVA1f9vfVtIPhcFXj9VGvUw9z92x7/0vlXvl0un7
         OtIw+D3cvOrRNyDJo8JLGwOfvbf6FxGmujDfAdpVcNlMPVoojZ3hH+XLW+SjlwwAgy2j
         +s0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=kOC9dFGFcgxRF42dUk1Toc8FG9V1zbrc4a9WdsowWiI=;
        b=jeCKfXHewIWCV3+zyEAUhiGp4NOxcrUpA25fDV6DLYfaxi/Xu63KcyR6lJUkBL0UQH
         BxX3E7IkaBGubkuxOhln5B/MLWhj6G1VGgs1+zI3GSd2ktJtnArOonMWcs+ih71l6l6d
         +qz1t6CpRAlNrprVCxjMYvjj19gTiV7NtbiLoocRTkyFLwvR0t8CeWdMSX8k+dM//PL/
         gzeeD/5tezVI0Z7+lGJqakXa7NCSZ7EFyLYZy1z47TrQr+l1iaomTWElG9r2YCi3Y+Pj
         SmrE0u2CgQkV9Bf5Ueqe3HDaFJfm8vtPMVoLZJ0aGoTI1ydasF6Yr+G5MYFBu1f1XIjz
         4lRw==
X-Gm-Message-State: APjAAAVvet3aNrQc3O98ajanlibjar8HIn0lJf+kWkgrNTcZfya9XhaR
        seDM1kq4uYbljtME4sXg0qlkWpUJ6Vs=
X-Google-Smtp-Source: APXvYqxJ/g7Ao1kEl3AiLK1B3sDJrkX86jb4jlYIefEREzJbnRB/6gc2wT/C/zm92F/Bai/W9+DUyw==
X-Received: by 2002:a1c:ab06:: with SMTP id u6mr8840904wme.125.1560959351827;
        Wed, 19 Jun 2019 08:49:11 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id f2sm1054218wmc.34.2019.06.19.08.49.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:49:11 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:49:09 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 5/6] rt-tests: cyclicdeadline: Print fail only if something
 failed
In-Reply-To: <20190618103841.27249-6-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191748540.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-6-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> It is interesting to see what went wrong in case something did. However, the
> fail statement is printed always. That is confusing.
> 
> Furthermore, the fail value is always 1 when a failure happened. There is no
> need to print it.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 7cffe826b944..16d986a02244 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1204,10 +1204,11 @@ int main (int argc, char **argv)
>  	printf("main thread %d\n", gettid());
>  
>  	pthread_barrier_wait(&barrier);
> -	printf("fail 2 %d\n", fail);
>  
> -	if (fail)
> +	if (fail) {
> +		printf("fail 2\n");
>  		exit(-1);
> +	}
>  
>  	pthread_barrier_wait(&barrier);
>  
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
