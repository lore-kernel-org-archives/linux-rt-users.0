Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E40AC433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 11 Nov 2022 19:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiKKTri (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 11 Nov 2022 14:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiKKTrh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 11 Nov 2022 14:47:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262CB7F57D
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668196001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nr2NTdE0pQBZs+Lg2G/2YNoSkAPTFt1mfikLysU+A8M=;
        b=CWkDbahhQa77jlIi6rMBwrc14bnCuCZJ9dW9RFwaBXcYVG6dMuGc6eVFAWUIu37YxDMYum
        08eY/hnr8BV3irOJVEqF3z4Ia/g7gRysLtDLYfmBBuqX+uERS2zou3dFXUOV3Wo0H7WC/f
        kIuJ7TUCbkWDRHz3NZsV2I92++xkQUk=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-320-bIST34-vMOmspRlVmGS6qA-1; Fri, 11 Nov 2022 14:46:40 -0500
X-MC-Unique: bIST34-vMOmspRlVmGS6qA-1
Received: by mail-qk1-f199.google.com with SMTP id x2-20020a05620a448200b006fa7dad5c1cso5484196qkp.10
        for <linux-rt-users@vger.kernel.org>; Fri, 11 Nov 2022 11:46:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nr2NTdE0pQBZs+Lg2G/2YNoSkAPTFt1mfikLysU+A8M=;
        b=bKKLS1jpsM/vsj7YaRogwNGKF52/xo3jphsGc6zIP4bfsEf5Ty9GiFoNXscTRJgjMw
         Q+/3PVfxClv+ybN1UtB0+3jteuQPjjGN0z4wxtJAgLu1OFkTIzvjQMFQqkaDXkv/TPH3
         WVcuYdGbgi+06jcqlyCNoNfGxpFBgAG/xe6ryU4Dt2Niw5TadTyW7IqIli4fnvuPKn4x
         oUGN/7u0l5lLRFS92Em6zyHchonGvezuKn2O16SLv29mrmDMsqFFit0BL3/cb5LPDbjs
         N5ryiCPwrp2XUIFSZN48FYsZ26geyXG5xSVIuz4LsMsiOEsQGK1rH3w/IlNaYhRkY+0v
         JrVA==
X-Gm-Message-State: ANoB5pkK309QMvGYJzuX0A0N04AjG9lVbTncFiKNFrIayfuiCMBM/j7j
        rAlItGEoqBPvCqRDtSuoGm6Wsn6yLq6lOsBVu7HhSOkpNBcsrPNeeuuMd8SiC/DqlhuRtbGxup2
        A+FvO6F2gGPgguBQh3PHNywkLKNc=
X-Received: by 2002:a0c:abc8:0:b0:4bb:6837:9f8a with SMTP id k8-20020a0cabc8000000b004bb68379f8amr3313162qvb.66.1668195999338;
        Fri, 11 Nov 2022 11:46:39 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5Kajtk3UzcMkcVtYjRZ09bNvn7xRpLeOAYVDSqjlQzapOH3lJ0C9bs6yJfy1m0X9E1dv2nWA==
X-Received: by 2002:a0c:abc8:0:b0:4bb:6837:9f8a with SMTP id k8-20020a0cabc8000000b004bb68379f8amr3313149qvb.66.1668195999149;
        Fri, 11 Nov 2022 11:46:39 -0800 (PST)
Received: from fionn (bras-base-rdwyon0600w-grc-08-184-147-142-10.dsl.bell.ca. [184.147.142.10])
        by smtp.gmail.com with ESMTPSA id y22-20020a37f616000000b006cf19068261sm1843178qkj.116.2022.11.11.11.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 11:46:38 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:46:37 -0500 (EST)
From:   John Kacur <jkacur@redhat.com>
To:     Leah Leshchinsky <lleshchi@redhat.com>
cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] rt-tests: hwlatdetect: Update to integer division
In-Reply-To: <20221110153527.553524-1-lleshchi@redhat.com>
Message-ID: <53f64e12-ed12-455a-4838-d140786d22dc@redhat.com>
References: <20221110153527.553524-1-lleshchi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Thu, 10 Nov 2022, Leah Leshchinsky wrote:

> In Python 3, "/" is a float division operator, as opposed to Python 2,
> which defaults to integer division. This results in an error when
> calculating width, which assumes an integer.

What kind of error? Is there a traceback, or merely an incorrect value?

> 
> Update width division to integer division with the "//" operator.
> 
> Signed-off-by: Leah Leshchinsky <lleshchi@redhat.com>
> 
> diff --git a/src/hwlatdetect/hwlatdetect.py b/src/hwlatdetect/hwlatdetect.py
> index 7b1ae646577a..929107f9c252 100755
> --- a/src/hwlatdetect/hwlatdetect.py
> +++ b/src/hwlatdetect/hwlatdetect.py
> @@ -454,9 +454,10 @@ if __name__ == '__main__':
>  
>      if args.window:
>          w = microseconds(args.window)
> +        width = w//2
>          if w < int(detect.get("width")):
> -            debug(f"shrinking width to {w//2} for new window of {w}")
> -            detect.set("width", w/2)
> +            debug(f"shrinking width to {width} for new window of {w}")
> +            detect.set("width", width)
>          debug(f"window parameter = {w}")
>          detect.set("window", w)
>          debug(f"window for sampling set to {w}us")
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>

