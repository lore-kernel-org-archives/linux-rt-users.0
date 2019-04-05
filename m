Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F446C4360F
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB0C21726
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 14:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWQi2MIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfDEOec (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:34:32 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39877 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEOeb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 10:34:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so7473065wmk.4
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wtl63FV4tzOLgZbSalnWZn4ofz8OeiDnXPzGd4orEVc=;
        b=IWQi2MICFLgNjIXGEv+oquZ/zTEag+9gZ6w9GAnjIBG/+VrLBE2ot4s6Vfq7DlV9hl
         1lGgzND90enmSGXGkAehM7LAiA04/CXUyhTzoqQFdMQaDxPnFPAms1NrQq4JMjNxwhro
         vRJXe7MXQ2Lwqarc/Fog7nPMCIh68j6igSALyQ2y/AMsxEM2F/hSP9MGNRNzM+Zz0ICG
         bLICnj0IK83bRlRDVZ96bap4MG8xWjCj2ewCpCj+mtEFKGssbLBszfKpfahGXH44h6li
         p+HssWBFh4yvrx+TS1cGQcTA3szGgKlAu60Opr+mYD7S0keAfB2N67JdN1quMoJahSaY
         1UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=wtl63FV4tzOLgZbSalnWZn4ofz8OeiDnXPzGd4orEVc=;
        b=S3vAjb6RObGl9EvhDBAlYnk0YOeqGFQM/uYpw0E7814y1UJ92ZMdGpHWzsFKfvFh6Z
         DDnanxYY7R+ZXYl3mFPdFQeGJkPDS/b7TMJmuvrvEHx50t/Uu4chgrbV93lexK4KRk/u
         JZH1P5DobXTX50QjzLKi2RZXRAJ9OqVHq9VVpiYSUH8RIf6SRsohMNGQyNaw9fsTmQm+
         cvrJ0mATQNTe7G8v3/Bap1xiOJiJG18fG7VSEs7wKi4jMvxNwM0q72t1dGQMEBib6h6C
         1KwDI2ZRrXSD3MN4x/rzJCyi19wOZKMmKXDP34uqndeah429Q9WPP42HxOCkbk4wzvFn
         baxg==
X-Gm-Message-State: APjAAAVy9A28vTahScCG6AwxnQDedfIBIZmoDaIUuBzqKVv/Qk2tdf12
        NTyNboWC80DMRSJDNFBBzt4=
X-Google-Smtp-Source: APXvYqxdo6AE2hTW/OJnpQsk/eNO9h1ZKehOQOxqh+qG7l1aWMta6JDKSFi6BCkHQrq5/OcCraYDYg==
X-Received: by 2002:a7b:c923:: with SMTP id h3mr8124819wml.34.1554474869815;
        Fri, 05 Apr 2019 07:34:29 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id w9sm7209363wmi.0.2019.04.05.07.34.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 07:34:29 -0700 (PDT)
Date:   Fri, 5 Apr 2019 16:34:18 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/4] rt-tests: cyclicdeadline: add missing free calls
In-Reply-To: <20190404134814.13376-3-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1904051633590.8480@planxty>
References: <20190404134814.13376-1-kurt@linutronix.de> <20190404134814.13376-3-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 4 Apr 2019, Kurt Kanzenbach wrote:

> The threads and thread data structures are allocated using calloc(). Free them
> as well.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 303b5e96647a..f4dd26a2dba2 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1261,6 +1261,8 @@ int main (int argc, char **argv)
>  		}
>  	}
>  
> +	free(thread);
> +	free(sched_data);
>  	free(setcpu_buf);
>  	return 0;
>  }
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
