Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B596AC433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9574061B3F
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Nov 2021 13:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbhKPNph (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:45:37 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:50601 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbhKPNpH (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Nov 2021 08:45:07 -0500
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211116134207epoutp04d2d3ea4881ba13974d1bbf6735142a44~4Cpt7xEjM2933629336epoutp04S
        for <linux-rt-users@vger.kernel.org>; Tue, 16 Nov 2021 13:42:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211116134207epoutp04d2d3ea4881ba13974d1bbf6735142a44~4Cpt7xEjM2933629336epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637070127;
        bh=QWlOd1eMAh5zDvBIBHHDiyVNF/yvNdXs07cAZcDWXhI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=aFjtGEF6hQ8RoGd/UHcmXGo6ejw+WGU9YoapAx74Mp4iK0vq+U4ZH/Yzcxuw/Vtdx
         F4Z0v5GatvrHMYL5OzkxBe+hf9iPEYhBNaC0Hw6sFbHyJyPY0a8DY1PLC8tMJ83YDU
         WE7t8YGF1mhfYMC5VRH0pI30HSFjs63JVjJeDkp0=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20211116134207epcas2p190f191b93373fc8d8e9933b63672bd17~4CptmW_cS2743827438epcas2p1C;
        Tue, 16 Nov 2021 13:42:07 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HtnKl1XJtz4x9Pq; Tue, 16 Nov
        2021 13:42:03 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        85.46.10014.A25B3916; Tue, 16 Nov 2021 22:42:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20211116134202epcas2p39b66d4595f55bb2cd8ebfa1e7d1f5eb8~4CppoRNFl2111521115epcas2p3B;
        Tue, 16 Nov 2021 13:42:02 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211116134202epsmtrp28391e58ded254b634a020fc72c24a5ef~4Cppexvf62157721577epsmtrp2e;
        Tue, 16 Nov 2021 13:42:02 +0000 (GMT)
X-AuditID: b6c32a47-489ff7000000271e-5e-6193b52aa4dd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.27.29871.925B3916; Tue, 16 Nov 2021 22:42:02 +0900 (KST)
Received: from KORCO082417 (unknown [10.229.8.121]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20211116134202epsmtip2aa1696e38ffade5b872a6a7146d64698~4Cpo_4xMZ3053030530epsmtip2a;
        Tue, 16 Nov 2021 13:42:02 +0000 (GMT)
From:   "Chanho Park" <chanho61.park@samsung.com>
To:     "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>,
        "'Vlastimil Babka'" <vbabka@suse.cz>
Cc:     <linux-rt-users@vger.kernel.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>
In-Reply-To: <20211116094251.7nux2fwjn55pt5m5@linutronix.de>
Subject: RE: hackbench score comparison between 5.10.75-rt47 and
 5.14.14-rt21
Date:   Tue, 16 Nov 2021 22:42:01 +0900
Message-ID: <022001d7daef$bc333370$34999a50$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQF6b1C5A31qlqi3pgFWq9aeFpIZMgLEO9yXAZZyEH8CwWvX1wHxzAZAAOmCcGMB0dm5i6xis97Q
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmua7W1smJBvN+qllMuziJ2eL0xB5m
        i82bpjJbzG7sY3Rg8Xh37hy7x5kFR9g9Pm+SC2COyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        Si1IySkwL9ArTswtLs1L18tLLbEyNDAwMgUqTMjOeHryEGvBCZmKTx9OMzYwLhbvYuTkkBAw
        kfj/cBoziC0ksINRYt783C5GLiD7E6PEovcb2SCcb4wSi/9fY4bpuPOnhR0isZdRYvaCGYwQ
        zgtGiTsLXoFVsQnoS7zs2MYKYosIJEo83LyYDcRmFgiQ2HP7DTuIzSlgI/H35BqwGmEBf4m1
        qxczgdgsAqoSl7u/sYDYvAKWEncvPGaFsAUlTs58wgIxR1ti2cLXUBcpSPx8ugxqV5TEsrZ9
        UDUiErM725hBjpMQeMku8fPfViaIBheJ2Xsfs0HYwhKvjm9hh7ClJD6/28sG0dDNKNH66D9U
        YjWjRGejD4RtL/Fr+hagbRxAGzQl1u/SBzElBJQljtyC2ssn0XH4LztEmFeio00IolFd4sD2
        6SwQtqxE95zPrBMYlWYh+WwWks9mIflgFsKuBYwsqxjFUguKc9NTi40KjOGRnZyfu4kRnBC1
        3Hcwznj7Qe8QIxMH4yFGCQ5mJRHelKrJiUK8KYmVValF+fFFpTmpxYcYTYFhPZFZSjQ5H5iS
        80riDU0sDUzMzAzNjUwNzJXEefPY+xKFBNITS1KzU1MLUotg+pg4OKUamPxtlRNzQ2elnPsR
        8ePXVOXzpSfvd6/mVzzMcUmCj7eqM+jit0RLL7H1miFSDazshlyP1zyvEH0VJlQ70ydQY+HE
        i8kiEjEFDX+L5LMCy3/t02u2/bjJU3K5OftBz1QntjfT7tbXfJm95kF9nnDb4tXxfKKseRmF
        LS+WfDSI/pq8hclvdUiH7b/ad5KbQ411/D7HHL94XXT2S42l+hqz1h4Xc9tUr6B09IZwVSX3
        5HNi359elwi4tda/s/Hot+bt9+fMf/B125vgH9s+me/8XTnzvJTJ4f1nrK17F68pONOqpaR/
        aEK94/YQCYf3Sup6B14I5jXNbGX498z6AD9rbF/+TLbUtNWfZb+8WX8rSYmlOCPRUIu5qDgR
        AOWSLpcRBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSvK7W1smJBmcmM1pMuziJ2eL0xB5m
        i82bpjJbzG7sY3Rg8Xh37hy7x5kFR9g9Pm+SC2CO4rJJSc3JLEst0rdL4Mq4tu0bS8FW6Yoz
        LSdYGhi7xLoYOTkkBEwk7vxpYe9i5OIQEtjNKPGwsYsRIiEr8ezdDnYIW1jifssRVhBbSOAZ
        o8SLv6EgNpuAvsTLjm1gcRGBRIljUz6ygNjMAgESz9f0sEHU/2CSeNrLBGJzCthI/D25Bqxe
        WMBXYvnPk2DzWQRUJS53fwPr5RWwlLh74TErhC0ocXLmE6iZ2hK9D1sZYexlC18zQ9ymIPHz
        6TKoG6IklrXtg6oXkZjd2cY8gVF4FpJRs5CMmoVk1CwkLQsYWVYxSqYWFOem5xYbFhjmpZbr
        FSfmFpfmpesl5+duYgTHhpbmDsbtqz7oHWJk4mA8xCjBwawkwptSNTlRiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkmDk6pBqad9+ZdSGRQedjnuHPTQa61ew8f
        izEP3963//INPzGb43U7nzN38wv3a39nfvPt4sFfR4W9sxiqjhtmaIhM9X9b+sVFdOHn6L07
        L27h6t1apqabPmFHwrsLTBqlb2cKbrzIo/VH9J70k51BKQfu5F/823ze/svjUsMpRe4nN1Sr
        fd2/crvm74MSdz/FvK1LMt41P+Xv2XXZWy/rXYxObP4WvyTsG1uc82lxn9tTBavM9y22uiV1
        MqHxoux5GYb9UoZxG8PXRL8q3vg+QYV39Vq71yySk7/G+ky48vHty02Sd07k3Dx4yGpL+3Or
        ys3TdJIm7UljPtXgnDKPY21PvOiGzhPRVd+kt3y+/ZEhtvHQUiWW4oxEQy3mouJEAAg3lKH8
        AgAA
X-CMS-MailID: 20211116134202epcas2p39b66d4595f55bb2cd8ebfa1e7d1f5eb8
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
        <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
        <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
        <5057a47c-dcdd-5420-9e09-7ade50553dd0@suse.cz>
        <20211116094251.7nux2fwjn55pt5m5@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

> -----Original Message-----
> From: 'Sebastian Andrzej Siewior' <bigeasy=40linutronix.de>
> Sent: Tuesday, November 16, 2021 6:43 PM
> To: Vlastimil Babka <vbabka=40suse.cz>
> Cc: Chanho Park <chanho61.park=40samsung.com>; linux-rt-
> users=40vger.kernel.org; 'Thomas Gleixner' <tglx=40linutronix.de>
> Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-
> rt21
>=20
> On 2021-11-16 10:37:22 =5B+0100=5D, Vlastimil Babka wrote:
> > On 11/12/21 15:00, 'Sebastian Andrzej Siewior' wrote:
> > > On 2021-11-05 10:41:40 =5B+0900=5D, Chanho Park wrote:
> > >> Hi,
> > > Hi,
> > >
> > >> I checked the same test on my aarch64 target. I'll do more
> > >> realistic benchmark such as compile bench.
> > >>
> > >> <5.10.73-rt54 aarch64>
> > >> root=40euto-v9-sadk:=7E=23 hackbench -l 10000
> > >> Time: 24.994
> > >>
> > >> <5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
> > >> root=40euto-v9-sadk:=7E=23 hackbench -l 10000
> > >> Time: 31.372
> > >>
> > >> <5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
> > >> root=40euto-v9-sadk:=7E=23 hackbench -l 10000
> > >> Time: 35.269
> > >
> > > The last two are equal, is that on purporse?
> >
> > I see the first of last two is without SLUB_CPU_PARTIAL and the second
> > with SLUB_CPU_PARTIAL, so not equal?
>=20
> indeed. I didn't notice the missing o. Thanks=21.

Sorry for this confusion.

>=20
> > > Any feedback on v5.14-rc3-rt1 and v5.14-rc3-rt2? v5.13-rt1 should be
> > > identical to you 5.10 numbers.

I got below value on v5.14-rc3-rt1.

<5.14.0-rc3-rt1 aarch64>
Time: 35.948

Unfortunately, I've got below panic on v5.13-rt1. I stacked same patches fo=
r my board both v5.13-rt1 and v514-rc3-rt1.

=5B    0.112294=5D Freeing unused kernel memory: 5440K
=5B    0.131064=5D Run /sbin/init as init process
=5B    0.137371=5D ------------=5B cut here =5D------------
=5B    0.137373=5D WARNING: CPU: 7 PID: 1 at arch/arm64/kernel/fpsimd.c:286=
 task_fpsimd_load+0x98/0xc0
=5B    0.137381=5D Modules linked in:
=5B    0.137385=5D CPU: 7 PID: 1 Comm: init Not tainted 5.13.0-rt1-00032-gd=
ee4765ed8ff =23317
=5B    0.137388=5D Hardware name: Samsung ExynosAuto v9 SADK board (DT)
=5B    0.137389=5D pstate: 40400009 (nZcv daif +PAN -UAO -TCO BTYPE=3D--)
=5B    0.137392=5D pc : task_fpsimd_load+0x98/0xc0
=5B    0.137394=5D lr : task_fpsimd_load+0x18/0xc0
=5B    0.137396=5D sp : ffff80001004bd60
=5B    0.137397=5D x29: ffff80001004bd60 x28: ffff000800098000 x27: 0000000=
000000000
=5B    0.137400=5D x26: 0000000000000000 x25: 0000000000000000 x24: 0000000=
045585401
=5B    0.137402=5D x23: 0000000000000000 x22: ffff0008000986d8 x21: ffff000=
800098000
=5B    0.137405=5D x20: ffff80001004beb0 x19: 0000000000000008 x18: 0000000=
000000014
=5B    0.137408=5D x17: 00000000ccf04c01 x16: 0000000027fe4405 x15: 0000000=
0083da15a
=5B    0.137411=5D x14: 0000000000000000 x13: 0000ffffd305cbf8 x12: 0000000=
00000000f
=5B    0.137414=5D x11: 0000ffffd305cfed x10: 000000000000001f x9 : 0000000=
000000000
=5B    0.137416=5D x8 : ffff80001004c000 x7 : 0000000000000000 x6 : 0000000=
000000001
=5B    0.137418=5D x5 : 0000000080080007 x4 : 0000000000000000 x3 : 0000000=
000000001
=5B    0.137421=5D x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000=
000000000
=5B    0.137424=5D Call trace:
=5B    0.137425=5D  task_fpsimd_load+0x98/0xc0
=5B    0.137427=5D  fpsimd_restore_current_state+0x78/0xac
=5B    0.137430=5D  do_notify_resume+0x10c/0x1300
=5B    0.137434=5D  work_pending+0xc/0x5f8
=5B    0.137436=5D ---=5B end trace 0000000000000002 =5D---

Best Regards,
Chanho Park

