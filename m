Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D76C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151076112F
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Nov 2021 20:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbhKKUjE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Nov 2021 15:39:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229785AbhKKUjE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Nov 2021 15:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636662974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qXLUoepDXQH3yWjQT5wpFggRgHMuoJyJNomLcQk14Gg=;
        b=cL7vJ8FqoEQMK5JFoD0gainNlfwxO6R6hAeVG0HLU6PUmAf+Hvlapu/B5r3KqG3PlH+WX7
        A1rv2pVSvVY4Qh9qmy6p0guH4A8iz7l8nJ28srs6uqeX/j+kLxpBenJv2ukKUhxlkR/z9F
        19ifsVRH9qQBVyLf0a+3eKdOIrK4fto=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-DYUQ4A9ENaeiBpvPp8E4nA-1; Thu, 11 Nov 2021 15:36:12 -0500
X-MC-Unique: DYUQ4A9ENaeiBpvPp8E4nA-1
Received: by mail-qt1-f197.google.com with SMTP id k1-20020ac80c01000000b002a79e319399so5630278qti.8
        for <linux-rt-users@vger.kernel.org>; Thu, 11 Nov 2021 12:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=qXLUoepDXQH3yWjQT5wpFggRgHMuoJyJNomLcQk14Gg=;
        b=0UzL4OQpGqVzIHLVMJQCXl55Hb2XCuhtmIz/pVfLdoQvWivY4wEALWyY+NHxcoyb++
         wBt+YUfDBL4rRzsiUOOBnfffLDlGoyVgwD8G/xenKDLUEbch+x0XTlA3+FFQCs3hDR+G
         hxb3nCh15gPaZ6ovdhazzDU3ZgE/VYOjtZbLFN0Qe2MRPABs/jlvXbpmj4bZmj8aQNxQ
         XqnjP2mtda8ONXPPj0g/9xUlZepnXwjxLHAAmBdDTwx3tTDD15+3prI/baPTYg2nKk4+
         Q6wpxq+IVRv9KM0fmiMdj4WSVCKN0YCraucbLS+T5wfv5TZzDiwTOBUVLzDAlG+Kjc7y
         njog==
X-Gm-Message-State: AOAM533rbyQw1LqVy3FUMMqK4mqhUnVubbO59HT4hhvYgmkKyCdiSqn6
        lnKDU+Smb+3JArjMzs4ppnT4LwltF6ZRC1t6P2dyBoE+8JlPoMr5zrdVLZBBetaw1H62rELDWsb
        q1NTCn0d0TV90bb9ipCdOlL5f+vs=
X-Received: by 2002:a05:622a:30a:: with SMTP id q10mr10628254qtw.267.1636662971406;
        Thu, 11 Nov 2021 12:36:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBxzyRuJ7w4+jYl7VLjDPk2BkEJCsIa/PqPrsm56a8bod4YuiyYqLHxBewVvEeTPjyHrM66A==
X-Received: by 2002:a05:622a:30a:: with SMTP id q10mr10628228qtw.267.1636662971199;
        Thu, 11 Nov 2021 12:36:11 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-154.dsl.bell.ca. [184.147.142.154])
        by smtp.gmail.com with ESMTPSA id y14sm2105480qta.86.2021.11.11.12.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 12:36:10 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:36:09 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Punit Agrawal <punitagrawal@gmail.com>
cc:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>, williams@redhat.com,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC 4/7] rt-tests: cyclictest: Drop unnecessary variable
 "bufsize"
In-Reply-To: <20211014071247.4165329-5-punitagrawal@gmail.com>
Message-ID: <6da2c9b8-f251-bef-45f7-5ad92b17f2@redhat.com>
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
Signed-off-by: John Kacur <jkacur@redhat.com>

