Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729B6C19F2B
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Aug 2022 20:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiHCUvj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Aug 2022 16:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238798AbiHCUv3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Aug 2022 16:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B818CCE25
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Aug 2022 13:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659559883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WcgdRhDiEw/HcxZt96Dot+lNjJnRjMfTfDMfYK22WM=;
        b=Xj43z0eTymyYWr1Sd1ueB+7pnjZehO9GF3k9X/Fl4EIcBB5RdLzzG5jCkksOj9Ht949NAg
        IEYoRhqJKMTznE09Im2noJ2iRDaJ6vJuFUGlG5zh52wyUzYRQRasZzksv7znoj9f7A1tqx
        N+bs4PwVcp3G42itIehJ5mBTJ+jVEbo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-Um0bvAuJPC2Z0vkVhTPZQA-1; Wed, 03 Aug 2022 16:51:23 -0400
X-MC-Unique: Um0bvAuJPC2Z0vkVhTPZQA-1
Received: by mail-qt1-f197.google.com with SMTP id f1-20020ac84641000000b0031ecb35e4d1so11675306qto.2
        for <linux-rt-users@vger.kernel.org>; Wed, 03 Aug 2022 13:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=8WcgdRhDiEw/HcxZt96Dot+lNjJnRjMfTfDMfYK22WM=;
        b=hirtQyYjd0X0QkIixakwPMRjID/Dwce8cyuK/VOcpaBztC/EoDirng/7KR/KvQ8ZOm
         MhOsAKyftc4wN+3mxqoRrYDg9D9hqD76V0/QZenrZjnqliwTkZwP0ET86eOSQbFciIgK
         8tflGyvxswzcOyqtQFDc5FIx+0Rj8KKR24FLCH2zp6/I9KDWveHglGrJ4qUusEhy5/Me
         ZcmMufSZV4rjaFisLznC9k7CDzrjZoIsFgns1fMvLVtB1W47BYijgVFru+ikB7pzwzjp
         SWfWiWvZi+suQa6z0kvf4tjFHo4cmwpJwKQdX5rImZqrcuy48CyCTaxyXVL9SzbTrKgq
         06TQ==
X-Gm-Message-State: AJIora/M4EJEtzC4owQjSR3dm48DMys8jkZURRLaCWaWfivxqdWyXGQZ
        TeNx71CRZNceWfaunOpLVVnxX9lWAc+/qNaQMuWhQ6ohWN+ZglTYH//IJKMPogQURwvMY5b48up
        aukdnkkB5eIgJRjZ0ncOt/oSJPAk=
X-Received: by 2002:a37:8a47:0:b0:6b5:561c:b90b with SMTP id m68-20020a378a47000000b006b5561cb90bmr19334631qkd.427.1659559882316;
        Wed, 03 Aug 2022 13:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sbQma1ELJOrxFbKPeMUUhPsULZPIqudF+7PYDQDE+2V41/0upADbGewJY1DB++nrIoZ/ribw==
X-Received: by 2002:a37:8a47:0:b0:6b5:561c:b90b with SMTP id m68-20020a378a47000000b006b5561cb90bmr19334620qkd.427.1659559882119;
        Wed, 03 Aug 2022 13:51:22 -0700 (PDT)
Received: from fionn ([142.189.102.90])
        by smtp.gmail.com with ESMTPSA id p22-20020ac84616000000b0031ea864d3b2sm11565344qtn.30.2022.08.03.13.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 13:51:21 -0700 (PDT)
Date:   Wed, 3 Aug 2022 16:51:20 -0400 (EDT)
From:   John Kacur <jkacur@redhat.com>
To:     Manasi Godse <magodse@redhat.com>
cc:     linux-rt-users@vger.kernel.org, lleshchi@redhat.com,
        kcarcia@redhat.com
Subject: Re: [PATCH] rteval: restrict kernel source download with invalid
 file extensions
In-Reply-To: <20220803204122.1091137-1-magodse@redhat.com>
Message-ID: <9b5189c8-9d5b-138b-90c7-b0e2a1070f3@redhat.com>
References: <20220803204122.1091137-1-magodse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Wed, 3 Aug 2022, Manasi Godse wrote:

> If the user inputs an extension other than tar.xz or tar.gz to the -S or --source-download option, the
> program should exit.
> 
> Signed-off-by: Manasi Godse <magodse@redhat.com>
> ---
>  rteval-cmd | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/rteval-cmd b/rteval-cmd
> index c1a68bd5133b..e4a6bcb223da 100755
> --- a/rteval-cmd
> +++ b/rteval-cmd
> @@ -275,6 +275,10 @@ if __name__ == '__main__':
>                  major_version = re.search(r"\d{1,2}", kernel_prefix).group(0)
>                  url = "https://kernel.org/pub/linux/kernel/v" + major_version + ".x/"
>  
> +            file_ext = rtevcfg.srcdownload.split(kernel_prefix)[-1]
> +
> +            if file_ext and file_ext not in ('.tar.xz', '.tar.gz'):
> +                sys.exit("Invalid file extension for the kernel source. Exiting")
>  
>              if rtevcfg.srcdownload.endswith(".gz") or 'rc' in rtevcfg.srcdownload:
>                  rtevcfg.srcdownload = "linux-" + kernel_prefix + ".tar.gz"
> -- 
> 2.31.1
> 
> 
Signed-off-by: John Kacur <jkacur@redhat.com>

