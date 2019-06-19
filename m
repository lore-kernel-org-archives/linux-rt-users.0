Return-Path: <SRS0=vVbJ=US=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28355C31E5B
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CC8204FD
	for <linux-rt-users@archiver.kernel.org>; Wed, 19 Jun 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7N9Kxo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfFSPsn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 19 Jun 2019 11:48:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34058 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfFSPsn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 19 Jun 2019 11:48:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id k11so3975424wrl.1
        for <linux-rt-users@vger.kernel.org>; Wed, 19 Jun 2019 08:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aSEUIgUtUCM2YwUs77E1iNbfTBx0uo/Hg3NhgeYW6ao=;
        b=l7N9Kxo+SkuPNjvyuzAnxr9uVtKIl5K6ag/EqCl8IFZGcx5S6UJcFBjaWNH5441In9
         CqojUDC38CL4KMIEejT5FjMKuUqffzXj1c5QYqn1Gqzncy7YbyXUyBBxnuM3ArwCY/yK
         HG7Zo2kdK1RgWriiYx88lP1aiOiu2c3EBvfhDCLjqQcoQiiHo406P0LexV2HPaqq60xN
         HJ9NOSdT6+hUP05lqO8RpjQM8kPwjyzxXqLIdmjRCuWXnviy+CKLq8oDCeiP5MUjAiF7
         ad5IGBQDNpzxAIoCDeNrYkXqs3oi8Cy1v/8mmF+aDTT7G3NCQzBBMU5I9wvK9WwzyjpF
         Jrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=aSEUIgUtUCM2YwUs77E1iNbfTBx0uo/Hg3NhgeYW6ao=;
        b=XGZ5IN29G2Azt5gVMMiwHLjJSh1Ih5+VIsuvLvKSFoI1jarMbJjIOdgFZJERKs4MN7
         +ONSmAKU9I7hHd1b/Vglgdu5OWcf/V1S3KNqRFQEZzOyMh8RzsVwtWD9GsG2XpMEC98o
         8JG9p+8lzNcA1NOfgAIWqzT8d+uotdd+RdIILfsNtHLEpkOnq7K6C8Q7ZX/bBEXsIQAo
         sMZj2vlAbeiozpDshMDo1qlUaiUVGsA/VgJLwhYVLxlpApPwBeeoXwzbjmh1AEJH/kKX
         vpD2aIkGOXQKtOvAYf3m0AesUu8tpCYjvH7fgneWvi3Ma+ir8UVMHKGXBh3dCjRq0tae
         Y+PA==
X-Gm-Message-State: APjAAAXfX31+KE0DNxJWmOmwlRtRiy+FN717B1TsTn0+G9K+PAll5PcI
        hy1epKKwof08Va28gOS9CII03nbL/Dg=
X-Google-Smtp-Source: APXvYqxA1ivKPN1SydxzhXBSPh1MH/7EokrlVhju/cQztXMW1rN47O56cuI0mJHm/SQDVyPo6y16RA==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr70190476wrw.73.1560959321162;
        Wed, 19 Jun 2019 08:48:41 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id l12sm43449424wrb.81.2019.06.19.08.48.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 08:48:40 -0700 (PDT)
Date:   Wed, 19 Jun 2019 17:48:38 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Kurt Kanzenbach <kurt@linutronix.de>
cc:     Clark Williams <williams@redhat.com>,
        rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 4/6] rt-tests: cyclicdeadline: Add options to usage
In-Reply-To: <20190618103841.27249-5-kurt@linutronix.de>
Message-ID: <alpine.LFD.2.21.1906191748230.12022@planxty>
References: <20190618103841.27249-1-kurt@linutronix.de> <20190618103841.27249-5-kurt@linutronix.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 18 Jun 2019, Kurt Kanzenbach wrote:

> The current usage doesn't show the available options:
> 
>  $ sudo ./cyclicdeadline -h
>  usage: cyclicdeadline
> 
> So, add the options to the help text to see what can be configured.
> 
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---
>  src/sched_deadline/cyclicdeadline.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 17786db45612..7cffe826b944 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -631,8 +631,16 @@ static void usage(char **argv)
>  		p--;
>  	p++;
>  
> -	printf("usage: %s\n"
> -	       "\n",p);
> +	printf("usage: %s [options]\n"
> +	       " -h - Show this help menu\n"
> +	       " -a - Use all CPUs\n"
> +	       " -c cpulist - Comma/hyphen separated list of CPUs to run deadline tasks on\n"
> +	       " -i interval(us) - The shortest deadline for the tasks (default 1000us)\n"
> +	       " -s step(us) - The amount to increase the deadline for each task (default 500us)\n"
> +	       " -t threads - The number of threads to run as deadline (default 1)\n"
> +	       " -D time - Specify a length for the test run\n"
> +	       "           Append 'm', 'h', or 'd' to specify minutes, hours or days\n"
> +	       "\n", p);
>  	exit(-1);
>  }
>  
> -- 
> 2.11.0
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
