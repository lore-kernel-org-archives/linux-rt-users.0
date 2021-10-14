Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E2FC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49A26105A
	for <linux-rt-users@archiver.kernel.org>; Thu, 14 Oct 2021 18:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhJNScB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:32:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48143 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhJNScA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 14 Oct 2021 14:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OvzK5OI3gFvWcN3aNc902xgyiVEI301miYW7OX+RCcc=;
        b=E1HrRWZ2a3Yedqf2oE6lqw2HPBV8ppygpMEfi2V2PKg3XHxL0puDLt5CuUaZ3ApVuEmQS4
        dDvBvdrLKj+y9YBJU4vpD9fFlgN437u2VN4E42XLFOHOMMwXtZU7/bx7PFeGr5F0qeBSAu
        nsxmxBlVbkYbd7deLj5wYORRPibuNvE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-fl4R2g-EPA2Bp5UccVlEMw-1; Thu, 14 Oct 2021 14:29:53 -0400
X-MC-Unique: fl4R2g-EPA2Bp5UccVlEMw-1
Received: by mail-qv1-f69.google.com with SMTP id q9-20020ad45749000000b00382b7c83aa1so6306617qvx.11
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Oct 2021 11:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=OvzK5OI3gFvWcN3aNc902xgyiVEI301miYW7OX+RCcc=;
        b=iuV5kCjTHMXcpZsuX3Q3E/PVtrCevCrOhmjwWMGmhe6cvb8RD18V1czDTy6RHs2x51
         Ln2ZULKYVO5mfZD7WmJnjoEmahlBU1VlUy6XzkpWlWgmoTL/nHIdLoVhnBiHoiJkdOrN
         C9lxYl4wAru5rTVZt80AKoxGmeK9n1u/1INs7jSzPVvUotc8eS+9dt7T2WHG+N6EoubP
         LogwqnFL2jcvIdr0/HSI2yEKYYiMIa+wuaktO7ujJGikFswowmdNPwPmArMxITcyKxWX
         60QDmINDiPGrBu3FeVKtP2CadlfifYTq2G5xdSd6qwXpLN+Yq4Vg8I2Avw6rRomXZctw
         HdlA==
X-Gm-Message-State: AOAM530PSkRjtH4X8cl+3Agv4OlO2p2KNomJgPALWpWZGd1+f5+mUHKP
        teYv6do7dV5sSxhwbBvkyJBTET9LnKNsAivYRqP29s/LV2yZHUmylaKre0v0l1Jo3PpB1tMXYnX
        qdZ24mbBm0jSpRPzQTixRHd4Gkh8=
X-Received: by 2002:a37:ec5:: with SMTP id 188mr6340569qko.440.1634236193510;
        Thu, 14 Oct 2021 11:29:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXsIoyrnBNyuGPp6PBjs/tNcFMUro7BpZUBa9xlXk3GF3ocqB+ivWP371RLYVz6vhKgcErww==
X-Received: by 2002:a37:ec5:: with SMTP id 188mr6340558qko.440.1634236193368;
        Thu, 14 Oct 2021 11:29:53 -0700 (PDT)
Received: from fionn (bras-base-rdwyon0600w-grc-09-184-147-143-99.dsl.bell.ca. [184.147.143.99])
        by smtp.gmail.com with ESMTPSA id u3sm1585034qkj.53.2021.10.14.11.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 11:29:53 -0700 (PDT)
Date:   Thu, 14 Oct 2021 14:29:51 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 4/7] rt-tests: cyclictest: Drop unnecessary variable
 "bufsize"
In-Reply-To: <20211014071247.4165329-5-punitagrawal@gmail.com>
Message-ID: <d6cff5d3-1a9b-2b92-6a10-65b3b3af7d89@redhat.com>
References: <20211014071247.4165329-1-punitagrawal@gmail.com> <20211014071247.4165329-5-punitagrawal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 14 Oct 2021, Punit Agrawal wrote:

> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> 
> Two copies of "bufsize", initialised with the same value are declared
> in enclosed blocks. Remove the redundant declaration.
> 
> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> ---
>  src/cyclictest/cyclictest.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 721d242a1da0..9c67a3ce3034 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2054,7 +2054,6 @@ int main(int argc, char **argv)
>  			memset(stat->values, 0, bufsize);
>  			par->bufmsk = VALBUF_SIZE - 1;
>  			if (smi) {
> -				int bufsize = VALBUF_SIZE * sizeof(long);
>  				stat->smis = threadalloc(bufsize, node);
>  				if (!stat->smis)
>  					goto outall;
> -- 
> 2.32.0
> 
> 
NACK: two different scopes, two different variables.

