Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964BAC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 03:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63E7260EDF
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Nov 2021 03:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhKCDSd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 2 Nov 2021 23:18:33 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10703 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhKCDSb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 2 Nov 2021 23:18:31 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211103031553epoutp0184bd9cc13e265972b3811b0abe73a940~z6uPKo9lk0749307493epoutp011
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Nov 2021 03:15:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211103031553epoutp0184bd9cc13e265972b3811b0abe73a940~z6uPKo9lk0749307493epoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1635909353;
        bh=XhzezjOjCmd+NomR3KK+ngHbDV43JQlsBLhf4rJO+gU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Pc4Wvj+3DmiQjpSuCa1AVQEgQ6yFkYgD6doj/bjSZOtE9hh45pjuV0UPXJkOXnBzv
         FFRuRWdbvO6SypUTYVXtn/34uAaOAUDNEdCGcimNVdtBjuzdy41WH2cfIiHsJxm+9B
         rNVXOcZkmBA5h5jtkb0j9DANEyf0XcxpYiyWFTm4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20211103031552epcas2p11beea624f3d08f96fdbbe94b3ca47319~z6uOEZ4WZ1905819058epcas2p1o;
        Wed,  3 Nov 2021 03:15:52 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.88]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4HkX3B0KDnz4x9Pr; Wed,  3 Nov
        2021 03:15:50 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.6B.10018.5EEF1816; Wed,  3 Nov 2021 12:15:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41~z6uK3zj6_1556915569epcas2p3O;
        Wed,  3 Nov 2021 03:15:49 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211103031549epsmtrp2750aee3639bcadb3bf51dca1abbf291c~z6uK3Ndm72723927239epsmtrp2G;
        Wed,  3 Nov 2021 03:15:49 +0000 (GMT)
X-AuditID: b6c32a46-a25ff70000002722-24-6181fee5c32e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.F2.29871.5EEF1816; Wed,  3 Nov 2021 12:15:49 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20211103031549epsmtip16cfe178e36fb59e5d8e5ee3bcc34fddc~z6uK0uCVz0378203782epsmtip1J;
        Wed,  3 Nov 2021 03:15:49 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     <linux-rt-users@vger.kernel.org>
Cc:     <bigeasy@linutronix.de>, "'Thomas Gleixner'" <tglx@linutronix.de>
Subject: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Date:   Wed, 3 Nov 2021 12:15:49 +0900
Message-ID: <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdfQYQ9XY61w41R+Sqy2HitDwXY5Kw==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmqe7Tf42JBttOiVtMuziJ2eL0xB5m
        i82bpjI7MHu8O3eO3ePzJrkApqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3Ml
        hbzE3FRbJRefAF23zBygHUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM/OISW6XUgpScAvMCveLE
        3OLSvHS9vNQSK0MDAyNToMKE7Ixpk48yFqxir9j9WKWB8T1rFyMnh4SAicSSK2sYuxi5OIQE
        djBKXDhxngXC+cQosf4eTOYbo8SWprnsMC2fNh1ng0jsBapq+AlV9YJRYvaEdkaQKjYBfYmX
        HdvAlogIqEhs+HsJLM4s4CpxaEYf2CRhAU+JX+t3s4HYLEA1/68fA7N5BSwl/u/6xAhhC0qc
        nPmEBaJXXmL72znMEFcoSPx8ugxqvp7Enyn7mSBqRCRmd7ZB1Rxjl/j2VR/CdpHY//ol1AfC
        Eq+Ob4GypSQ+v9sL9o2EQDejROuj/1CJ1YwSnY0+ELa9xK/pW4CWcQAt0JRYv0sfxJQQUJY4
        cgvqND6JjsN/2SHCvBIdbUIQjeoSB7ZPZ4GwZSW653yGBruHxMl7y9knMCrOQvLkLCRPzkLy
        zCyEvQsYWVYxiqUWFOempxYbFRjB4zo5P3cTIzj1abntYJzy9oPeIUYmDsZDjBIczEoivMxH
        GxKFeFMSK6tSi/Lji0pzUosPMZoCg30is5Rocj4w+eaVxBuaWBqYmJkZmhuZGpgrifNaimYn
        CgmkJ5akZqemFqQWwfQxcXBKNTCxut9S8FijfjU76cE+qwLevgPzP7Nz928Ke8iQPjFq9Qu5
        6ml2GcHLDKN4d32Jl99T0qVScapE+NgM8dzf7ov4NeWduh1uSIVOX/3riezXI9smHZp6MO3J
        xCcLY5q7Hq31X/bH/9DhgBKmwzJxvtydB/fvr0j0ubXyCdPb7wJrSvcb34hq/9l+JrlOKtnA
        W+H8ojWHy4sKC9Zp3/fa+sRG+Vez2RbxOzLavwzvbKoL5p2z/63ZLUfbmSe6UspZ5l9sK7u8
        f+Ls18fDt62Wl/i7eaGUNfcPXz++W/FWgpt9z+7bPpPb0jFJte2XuZF/kbT9coU65hev7Bwn
        H0z1XHcyhIlZ7M2WcxEz1l+pzP2jxFKckWioxVxUnAgAsvMMCwYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKLMWRmVeSWpSXmKPExsWy7bCSnO7Tf42JBh8nClpMuziJ2eL0xB5m
        i82bpjI7MHu8O3eO3ePzJrkApigum5TUnMyy1CJ9uwSujGmTjzIWrGKv2P1YpYHxPWsXIyeH
        hICJxKdNx9m6GLk4hAR2M0qs/vuADSIhK/Hs3Q52CFtY4n7LEVaIomeMEl92nmYBSbAJ6Eu8
        7NgGNklEQEViw99LjCA2s4C7xKOvf8GahQU8JX6t3w02lAWo5v/1Y2A2r4ClxP9dnxghbEGJ
        kzOfAM3kAOrVk2jbCDVGXmL72znMEDcoSPx8ugxqlZ7Enyn7mSBqRCRmd7YxT2AUnIVk0iyE
        SbOQTJqFpGMBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgkNbS3MG4fdUHvUOM
        TByMhxglOJiVRHiZjzYkCvGmJFZWpRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1
        CCbLxMEp1cAUm3Lt3x6/s7v/rb/E+SDu7LvZx35GnisVs74rHPG8VlorlbXUrzcpW691k/rk
        6AlntqhJNFjv4Bdp/ZR/p/E+p9XbM7M2rsuJ4vs/Tc1EZsOP1Ot7Uz4JLf8/+9vsB+wh/i/P
        XHa3jXtrtultWsq62YJi8jOM9LYevNzQYnPsovHMZW4rrnl8Kj/0Rd1etUPmttX/dknXvTNe
        3QxeErr6cbzV5PCn0e+ZYxZ4hm0NPSL8Y6Xu3olf1ma7H1hkae24196NZ/2943b77k0Unr4/
        ++CfKSt2zxLcucR3frXWCcE/u+77/LkgrrKl3oVTbGtfQY7QHNPYV857z0docU7/05Oz+JH1
        r+JVu9TXsNxj5VViKc5INNRiLipOBAAnQaab2AIAAA==
X-CMS-MailID: 20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear RT folks,

I found an uncomprehended value of hackbench while I tested preempt rt
patches on my ARM64(Cortex A76 x 8) target.
So, I decided to check it on QEMU x86_64 KVM with yocto. I executed both
images with below command.

$ runqemu qemux86-64 kvm nographic qemuparams="-smp cores=4"

I was able to get similar score values with my arm64 target. It was half
than 5.10.75 kernel like below.
Any idea about this? Actually, I'm not sure it could be a regression or not.

<5.10.75-rt47>
root@qemux86-64:~# hackbench -l 10000
Running in process mode with 10 groups using 40 file descriptors each (==
400 tasks)
Each sender will pass 10000 messages of 100 bytes
Time: 49.898

<5.14.14-rt21>
root@qemux86-64:~# hackbench -l 10000
Running in process mode with 10 groups using 40 file descriptors each (==
400 tasks)
Each sender will pass 10000 messages of 100 bytes
Time: 96.973

Best Regards,
Chanho Park

