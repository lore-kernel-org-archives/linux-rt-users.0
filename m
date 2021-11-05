Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38003C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 01:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB1A61157
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Nov 2021 01:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbhKEBoh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 21:44:37 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:18580 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhKEBog (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 21:44:36 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211105014156epoutp044cfbb4c740372d7053e5ebbfc638dcec~0guxqa5NT3200832008epoutp04U
        for <linux-rt-users@vger.kernel.org>; Fri,  5 Nov 2021 01:41:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211105014156epoutp044cfbb4c740372d7053e5ebbfc638dcec~0guxqa5NT3200832008epoutp04U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1636076516;
        bh=cwnvp7g68i8jxP6TxiXIMbaX7SzTNKGT3PgP13skHVw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=WItOHlpvX23naeRXNDDejaII949kuUQDNIAZrkKf1BC8W2W9To478bDhevYXB8qGh
         cNuB/7EkMWINHSJ6FiTRzmcWFVZxVA7vjMXzJWWAVc0RgwUcxI44buRHelrFQOWtL9
         ZMabqDVAYYQknzZTvlCjGukMZyT5JGYcAjY6SroM=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20211105014156epcas2p4e0e6c9e5097ed9edb623fde1024a6040~0guxfNQMp1619016190epcas2p4m;
        Fri,  5 Nov 2021 01:41:56 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Hljsp22fyz4x9Q7; Fri,  5 Nov
        2021 01:41:50 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        88.24.12141.5DB84816; Fri,  5 Nov 2021 10:41:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20211105014141epcas2p349469117cfcab09995e99fd93166a439~0gujxC_K21363413634epcas2p3u;
        Fri,  5 Nov 2021 01:41:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211105014141epsmtrp18b328bf9f831108b82fa8a468f8cbce0~0gujxDIjI1086110861epsmtrp1w;
        Fri,  5 Nov 2021 01:41:41 +0000 (GMT)
X-AuditID: b6c32a48-d5dff70000002f6d-b1-61848bd5a29c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.85.29871.5DB84816; Fri,  5 Nov 2021 10:41:41 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211105014141epsmtip2f009a64d219d937dfbe6ebe593f8e511~0gujmoGbr0569305693epsmtip26;
        Fri,  5 Nov 2021 01:41:41 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>
Cc:     <linux-rt-users@vger.kernel.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>
In-Reply-To: <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
Subject: RE: hackbench score comparison between 5.10.75-rt47 and
 5.14.14-rt21
Date:   Fri, 5 Nov 2021 10:41:40 +0900
Message-ID: <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF6b1C5A31qlqi3pgFWq9aeFpIZMgLEO9yXAZZyEH+sjAVNIA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmue7V7pZEg/PfrCymXZzEbHF6Yg+z
        xeZNU5kdmD3enTvH7vF5k1wAU1S2TUZqYkpqkUJqXnJ+SmZeuq2Sd3C8c7ypmYGhrqGlhbmS
        Ql5ibqqtkotPgK5bZg7QDiWFssScUqBQQGJxsZK+nU1RfmlJqkJGfnGJrVJqQUpOgXmBXnFi
        bnFpXrpeXmqJlaGBgZEpUGFCdkbrs3UsBT9EKo4u6WRqYPws0MXIySEhYCLRPGMaE4gtJLCD
        UaK3x7uLkQvI/sQoMfniPTYI5xujRMftHnaYjg2fulkgEnsZJfZ8esgI4bxglLh06xczSBWb
        gL7Ey45trCC2iIClRPe6fWwgNrNAgMSe22/AJnEK2Ehc6Z4KtltYwF9i7erFYDaLgIrEgR9/
        wXp5gXq3ndrMDGELSpyc+YQFYo62xLKFr5khLlKQ+Pl0GdQuJ4njMx+yQtSISMzubGMGOU5C
        4Bq7xI8D/1khGlwkvq+8xgZhC0u8Or4F6jUpiZf9bewQDd2MEq2P/kMlVjNKdDb6QNj2Er+m
        bwEaxAG0QVNi/S59EFNCQFniyC2o2/gkOg7/ZYcI80p0tAlBNKpLHNg+nQXClpXonvOZdQKj
        0iwkn81C8tksJB/MQti1gJFlFaNYakFxbnpqsVGBCTyyk/NzNzGCk5+Wxw7G2W8/6B1iZOJg
        PMQowcGsJML7fENTohBvSmJlVWpRfnxRaU5q8SFGU2BYT2SWEk3OB6bfvJJ4QxNLAxMzM0Nz
        I1MDcyVxXkvR7EQhgfTEktTs1NSC1CKYPiYOTqkGJu/f389EOL+1Kov75hlY6r5Ep1Tm/gZ1
        zhdvXWKVVnhcsWS5+fWU8+EdBxRa2H2jTA/X/+U9df/zmcXf+Jb/3Sp4RM3Odd4saeeqrlUB
        XJz9QVJvRJoKrT7e+LBf8thfb70V9mc85hWsnh7IUcYf/HrerDvnGS+Kfn7g+zlw2bdP87MS
        rlXMsTqV5rHq1Z3IuL0cey2dvb2WPD5+aL6397On8Xp8MeszN/f8eiTtNfmq3NbdcvazH1zy
        XOywr1O3e4/x7MV13XM1QzdOfJp88W9u7D7XH3/u3Fv5ZIvwQ2PpVYV57RoMkX4vvs5sZtva
        siDAWuywjVvwoRXfrUV3zTr3bFsBs7zUpJdT+NQWbZivxFKckWioxVxUnAgAZNGDiAcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSvO7V7pZEg77HAhbTLk5itjg9sYfZ
        YvOmqcwOzB7vzp1j9/i8SS6AKYrLJiU1J7MstUjfLoEr4+75Y8wFd0Uq9q+ZwtzAeEqgi5GT
        Q0LARGLDp24WEFtIYDejxPX7eRBxWYln73awQ9jCEvdbjrB2MXIB1TxjlDh2/DBYgk1AX+Jl
        xzZWEFtEwFKie90+NhCbWSBA4vmaHjaIBqChixbfBCviFLCRuNI9lQnEFhbwlVj+8yTYIBYB
        FYkDP/6C1fACDdp2ajMzhC0ocXLmExaIodoST28+hbOXLXzNDHGdgsTPp8ugjnCSOD7zIStE
        jYjE7M425gmMwrOQjJqFZNQsJKNmIWlZwMiyilEytaA4Nz232LDAMC+1XK84Mbe4NC9dLzk/
        dxMjOBK0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHe5xuaEoV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Xug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg2hne8sD1o48tJyvPBhe5h5u3GFT1aFw38ba13/ya
        kTvyxv+YX7ZcN4+3bvN8+mfdvdddhhIdW/hf3hCNufouKyZlQ7Jn2x7Wr68Tkhod32bNfLNi
        5ieWi34/3svwLw6M7VZPnZPHLp7BP69o+p2sZaa/ynqmv3zMI1na8E3wpH6ej3CLwt39Jryb
        1ie9nnTjpP3M2mUPs/KmPDz/4dabCU0MZ1ZaFUiGXlGYtIkvYUFjwIKnN46KZ5TPd9j6+UrX
        Mu7tPxZ+fnG11G7f/sznXVuFe/XUPvXvCs94oTJVa4nEy0WTuaX52U49MXbUlj/mctoqMLJ9
        e0TH8eMsnm22ES81Q0RuanfWLWeZxbdaXImlOCPRUIu5qDgRAC8lxQ/zAgAA
X-CMS-MailID: 20211105014141epcas2p349469117cfcab09995e99fd93166a439
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
        <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
        <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

> -----Original Message-----
> From: Sebastian Andrzej Siewior <bigeasy=40linutronix.de>
> Sent: Wednesday, November 3, 2021 6:14 PM
> To: Chanho Park <chanho61.park=40samsung.com>
> Cc: linux-rt-users=40vger.kernel.org; 'Thomas Gleixner' <tglx=40linutroni=
x.de>
> Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-
> rt21
>=20
> On 2021-11-03 12:15:49 =5B+0900=5D, Chanho Park wrote:
> > Dear RT folks,
> Hi,
>=20
> > I found an uncomprehended value of hackbench while I tested preempt rt
> > patches on my ARM64(Cortex A76 x 8) target.
> > So, I decided to check it on QEMU x86_64 KVM with yocto. I executed
> > both images with below command.
> >
> > =24 runqemu qemux86-64 kvm nographic qemuparams=3D=22-smp cores=3D4=22
> >
> > I was able to get similar score values with my arm64 target. It was
> > half than 5.10.75 kernel like below.
> > Any idea about this? Actually, I'm not sure it could be a regression or
> not.
> >
> > <5.10.75-rt47>
> > root=40qemux86-64:=7E=23 hackbench -l 10000
> > Running in process mode with 10 groups using 40 file descriptors each
> > (=3D=3D
> > 400 tasks)
> > Each sender will pass 10000 messages of 100 bytes
> > Time: 49.898
> >
> > <5.14.14-rt21>
> > root=40qemux86-64:=7E=23 hackbench -l 10000
> > Running in process mode with 10 groups using 40 file descriptors each
> > (=3D=3D
> > 400 tasks)
> > Each sender will pass 10000 messages of 100 bytes
> > Time: 96.973
>=20
> The 5.14 series has a different SLUB implementation. Could you please mak=
e
> sure that SLUB_CPU_PARTIAL is disabled?
> So v5.14-rc3-rt1 should be worse than v5.10. Then v5.14-rc3-rt2 introduce=
d
> adaptive spinning which should improve the situation. However it is
> slightly worse than v5.10 but it should have improved.
> Could verify that?
>=20
> Also could double check this on hardware? I have no idea how well the
> adaptive spinning is working in KVM and this (hackbench) is a micro
> benchmark for the memory allocator/SLUB and any spin/guest preemption can
> have a visible outcome.
> While I saw worse numbers here (hackbench) I didn't observe it in a real-
> work workload like a kernel build for instance.

I checked the same test on my aarch64 target. I'll do more realistic benchm=
ark such as compile bench.

<5.10.73-rt54 aarch64>
root=40euto-v9-sadk:=7E=23 hackbench -l 10000
Time: 24.994

<5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
root=40euto-v9-sadk:=7E=23 hackbench -l 10000
Time: 31.372

<5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
root=40euto-v9-sadk:=7E=23 hackbench -l 10000
Time: 35.269

Best Regards,
Chanho Park

