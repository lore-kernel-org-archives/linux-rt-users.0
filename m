Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79049C001B0
	for <linux-rt-users@archiver.kernel.org>; Wed,  9 Aug 2023 18:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjHISz2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjHISz1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 9 Aug 2023 14:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC79E51
        for <linux-rt-users@vger.kernel.org>; Wed,  9 Aug 2023 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691607282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJQ5AejF+uOMP0CqB8cdfgb4TV1nPoV1kkRYl+nwK6Q=;
        b=XjC529aDE3tDUtOlV3iQ8MEg2dA1di63YPtVwY7TqLwHpBVt9rW3+gGTtgtL1sivu0RjOO
        aEcPIwDZrWnlO/tVybM/SfOwFOiqhOZ+1Qou+4Kz2zbGzceL3VeY7oXKAZ+nNsXfr1qAVn
        HHGXj4rtFiLpOhSdt11DsnSPaZKV+2w=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-HGDd8vAAPFCUihGiP8eE2A-1; Wed, 09 Aug 2023 14:54:39 -0400
X-MC-Unique: HGDd8vAAPFCUihGiP8eE2A-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-583a89cccf6so2695267b3.1
        for <linux-rt-users@vger.kernel.org>; Wed, 09 Aug 2023 11:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691607279; x=1692212079;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJQ5AejF+uOMP0CqB8cdfgb4TV1nPoV1kkRYl+nwK6Q=;
        b=cudk+4seozX8yXk6HNVVCort0w536sRsjYj7QcORtSkVc7T7unPgYdeUqO4CW5pk8l
         jDT6ot+PCEGFTjiAugrx8e8y0pSu0TApFJEyiKSV59/hoCfoSFf6w8yMK0i1jzDiaAcj
         ABUPvfc5FELQnf+PpTJM6OPhcrE7HEYSJgk3IXoYt/XdGCV06F0AhLfRaAhagaNKSBh7
         zTvzwEUCGpH+3AzBUaDhU2ELWT/nPH/2CH7nikW+A6a/7IpQ3nthNmmR45MhmuCtqAbk
         CI0qIojTsBV113QWq4i6AVKShLHFHHw8KTSwQ3nlaLDTsHjENp5rhHhcfiYA3wmnZJ7q
         Qixg==
X-Gm-Message-State: AOJu0YzdZX693PskCgW215+NAWu0qbQpphJUevfXnP+vZqyLi0dtIiM8
        xW6aFMnY7v4hEbwr/iFRnMbILinpoy1SpJk05q/q4rp7eWaaJusszh7vaog8qyQQnYait0LqeyK
        IOqAfFJ3F/NTLyKR5sr11689ME3i6erjxtdQ=
X-Received: by 2002:a81:92d7:0:b0:56d:34:893c with SMTP id j206-20020a8192d7000000b0056d0034893cmr186922ywg.4.1691607278916;
        Wed, 09 Aug 2023 11:54:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEygP5Q187AccAxMT1C8G5Y1P0hvmQ/zGovFpSaHWj7NVW6i+SpbCy7DUMhUzztiVvjARe6wA==
X-Received: by 2002:a81:92d7:0:b0:56d:34:893c with SMTP id j206-20020a8192d7000000b0056d0034893cmr186906ywg.4.1691607278522;
        Wed, 09 Aug 2023 11:54:38 -0700 (PDT)
Received: from fionn ([184.147.140.157])
        by smtp.gmail.com with ESMTPSA id d26-20020a0cb2da000000b0062ffec0a18esm3441656qvf.84.2023.08.09.11.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:54:37 -0700 (PDT)
Date:   Wed, 9 Aug 2023 14:54:28 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Eder Zulian <ezulian@redhat.com>
cc:     linux-rt-users@vger.kernel.org, williams@redhat.com
Subject: Re: [PATCH] rt-tests: Add __pycache__/ to .gitignore
In-Reply-To: <20230808211615.281193-1-ezulian@redhat.com>
Message-ID: <46d4f510-6984-d3c9-829e-84aa84d0ff65@redhat.com>
References: <20230808211615.281193-1-ezulian@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Tue, 8 Aug 2023, Eder Zulian wrote:

> Add __pycache__/ to .gitignore so that it will be ignored by git.
> 
> Signed-off-by: Eder Zulian <ezulian@redhat.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 61fb49c..7fef7de 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -47,3 +47,4 @@ tags
>  TAGS
>  cscope.*
>  src/cyclictest/__pycache__/
> +__pycache__/
> -- 
> 2.39.3
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

