Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A282C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Dec 2021 12:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLIMOt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 07:14:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhLIMOs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 9 Dec 2021 07:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639051874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i2Zw1FhutayMl/PUqOBAkyZL/QtmzZtPZQAPcyxunvk=;
        b=INTwYU9XNLiegh5od+uGAJkhJa+MzIAlLj+KVHoTOqTS68Y3Zk/mK2G+a2+isPDBb2ok79
        adI/b1Hz3MD2yExpKgk4xk76uiJeAFb8lE2EEXpRJmDS5CHH5ORDCRJMcERSEnOsQgmyDr
        Ru537pqk+x7kUt+H99fWKCXeWksAZG8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-Os1vVyDdMMCXy2CXno42Eg-1; Thu, 09 Dec 2021 07:11:13 -0500
X-MC-Unique: Os1vVyDdMMCXy2CXno42Eg-1
Received: by mail-lj1-f197.google.com with SMTP id h17-20020a05651c125100b0021ba28cf54dso1759436ljh.22
        for <linux-rt-users@vger.kernel.org>; Thu, 09 Dec 2021 04:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i2Zw1FhutayMl/PUqOBAkyZL/QtmzZtPZQAPcyxunvk=;
        b=tEQjU1aOOKg0qY3JXPlnxYk28jViMh32cjOXdlXtId1L9fSWfg2xRLDvHtoC0lkbZV
         ORUTHViH0xLPb0l/FL72J3N9jR0z5EdZ6plwYzzpjoXSVMzcTRJbRI+uNbdXRDwQSD1H
         tPDT2l5vxwK//k/trWZkr5izvpuiz+KX35gbKqsdjFMzGxFVo1M99/lIdA1btiS8kBSu
         dFnUw8Pq11XxXvfs4Pbi/0bDl+da8xaFnT9wlzS5+VTeeb0b2cMKsvIjRLLn9+Ou+z2O
         Nkeo5oFUhziaxX1dG8JeyCgczWaNCBOkuUi+HOOeqjkV0m2ljS9R5Y45ZA4qEYLA0lwq
         VPkQ==
X-Gm-Message-State: AOAM532tuGvGuuOyVt4/5j6/9t+0T/WbripEWg1sZm85hrr02fm57Swu
        SKJkPdtpvzz0NWaxpG74FAQ//CaPSmOyMJPy1ducDZj2diJx5Jud79inXchRqXy1vWH5g2BvY1N
        N+Max0PdBpr2Bnl3U/dZ3AbGl5oRDF4ZHjxff3efzmng=
X-Received: by 2002:a2e:730b:: with SMTP id o11mr5849660ljc.14.1639051871740;
        Thu, 09 Dec 2021 04:11:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTPfOUOaNypP+QNTzg5R+jU2YwGhOTgLVB/gbq2d9K9oOlQC8VLEuSu4LdrWoh8oInZzYJIcEMDbeibB3/6AA=
X-Received: by 2002:a2e:730b:: with SMTP id o11mr5849634ljc.14.1639051871410;
 Thu, 09 Dec 2021 04:11:11 -0800 (PST)
MIME-Version: 1.0
References: <D966A34A-70D9-4CFA-9644-B9DC35841AB3@sap.com>
In-Reply-To: <D966A34A-70D9-4CFA-9644-B9DC35841AB3@sap.com>
From:   Luis Goncalves <lgoncalv@redhat.com>
Date:   Thu, 9 Dec 2021 09:11:00 -0300
Message-ID: <CAD8J--_aDCF1fjtoqiC2vqOS65LPc0tos+gcveMkQnEskrjfqQ@mail.gmail.com>
Subject: Re: Q: verify signature of 5.10.83-rt Patchset
To:     "Riesop, Vincent" <v.riesop@sap.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Dec 9, 2021 at 6:19 AM Riesop, Vincent <v.riesop@sap.com> wrote:
>
> Hi,
>
> I want to build a 5.10.83 kernel with RT patches downloaded from mirrors.=
kernel.org.
>
> But I am not able to find the public key for F394A423F8E67C26
> which seems to be the public key used to create the signature of patches-=
5.10.83-rt58.tar.sign
> (I think the pub key used here is from Luis Claudio R. Gon=C3=A7alves, bu=
t I cannot find it on ubuntu or  openpgp keyservers)
>
> Question 1: Where can I get an =E2=80=9Cofficial=E2=80=9D list of public =
keys used to create the signatures for the RT patches?

Hi Vincent!

As Sebastian mentioned in another thread [1]:

    All keys used for the uploads are located in a repository at
       git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git
kernel
> Question 2: What is the preferred keyserver to retrieve the public keys?

That git repository above is the preferred method to retrieve the
keys. You can find a few notes about the choice here:

   https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/about/

I hope this helps!
Luis

[1] https://lore.kernel.org/linux-rt-users/20211208194756.GA4909@duo.ucw.cz=
/T/#mdf7624e5524e9c550f5443f1ee084ff18cf5559d

