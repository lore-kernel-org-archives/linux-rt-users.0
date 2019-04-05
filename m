Return-Path: <SRS0=lqhu=SH=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B3C282CE
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A572621852
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Apr 2019 16:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkazXSjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731592AbfDEQbl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:31:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35458 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQbk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Apr 2019 12:31:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id w1so8775237wrp.2
        for <linux-rt-users@vger.kernel.org>; Fri, 05 Apr 2019 09:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=pa1M9fcO/RRrRyXGg+BpXGiMA68gNIY2mkqcCUMLjAo=;
        b=BkazXSjjTswl1NIXsm3FbL+ifp8J8hIPFK9TpnOk3ethY7nUaE03g0QEVKhSUkwjQq
         VgxRX9Lp865eYrI3arBJHlZAliocFlm65vCa2V2w+XqKviXzvYJ/Vb9Fr7hUX2ryE6kw
         yYLErEzkrx5lafm4D3q/DNCSu0yQ7uUYGNoqQZGK3GV6yOfAyCdAi8j+TJLVcZNbrKb7
         5fDXMVVP80CVK3FrEJpvd+21ip/ONUm3u9Yt3vtCyzj3oyEjGclLIJNS0j2IPB5x75mm
         yt9MFAaOACv4jEDI/VFeXJCNN6myoLKJch5lPS99BhAc5Tnin87k2koVOyYc8FKVjKG/
         MP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=pa1M9fcO/RRrRyXGg+BpXGiMA68gNIY2mkqcCUMLjAo=;
        b=oJO4Dw7Y8TssvCIl0Kp17wA8wX+89taDdi5XxLnw4HXR2AClPJhcJ3VYRagicQWeRO
         Bcq9RZM+xMtFFUjFBwNClYjTbU3Rd5RqqCB7uNUVi+BDsZYDj+8Dh9538Uv7Lk9ByxkK
         gnrR4Oqa7LgBjsgu8aeXUvhiWEyLfeNt7jgTaPa+UPZxKyLRresU0goPJglSR+fwhU2x
         hgcRY3MwbsQODz47DyPO44uiFXJhcj5TlQUZzbX3Al6Ayb+0+mewjNohhNmKXDDeN72Z
         0DOUnjK0o1uD9ViOhPLcNweH2jIlB2i9rEsCKqo2xyJO/wT8Sj2jtUkOT2YqqHZsBX66
         d4Dw==
X-Gm-Message-State: APjAAAWrqnF+iEuLTikIk4Yo7kLMQSnGJQhSASNK/UI52YgmcA3bcX1q
        F4NYDkFV+y2FedLZHJ11QNDM6qwC
X-Google-Smtp-Source: APXvYqxr71gVmQTjAa8F/c8nPJtCFpW2l3xgJ0ibVaLDNcXsuhekp/dyM1q1DeFSDInVY/H6Aebi2Q==
X-Received: by 2002:a5d:4646:: with SMTP id j6mr1031453wrs.56.1554481898616;
        Fri, 05 Apr 2019 09:31:38 -0700 (PDT)
Received: from planxty ([2a02:8108:1700:1960:91dd:e2f9:ed05:ee2b])
        by smtp.gmail.com with ESMTPSA id o4sm4953762wmo.20.2019.04.05.09.31.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Apr 2019 09:31:38 -0700 (PDT)
Date:   Fri, 5 Apr 2019 18:31:36 +0200 (CEST)
From:   John Kacur <jkacur@redhat.com>
X-X-Sender: jkacur@planxty
To:     Daniel Wagner <daniel.wagner@siemens.com>
cc:     linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 4/4] cyclicdeadline: Free allocated resources at exit
In-Reply-To: <20190312172436.18314-5-daniel.wagner@siemens.com>
Message-ID: <alpine.LFD.2.21.1904051831210.8480@planxty>
References: <20190312172436.18314-1-daniel.wagner@siemens.com> <20190312172436.18314-5-daniel.wagner@siemens.com>
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
>  src/sched_deadline/cyclicdeadline.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 095e6ccc166f..e3cc3c74ef68 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1271,6 +1271,10 @@ int main (int argc, char **argv)
>  		}
>  	}
>  
> -	free(setcpu_buf);
> +	if (setcpu_buf)
> +		free(setcpu_buf);
> +	free(thread);
> +	free(sched_data);
> +
>  	return 0;
>  }
> -- 
> 2.20.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>
