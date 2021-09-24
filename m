Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 07:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 506AB61242
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Sep 2021 07:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbhIXHUo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Sep 2021 03:20:44 -0400
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:60760 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbhIXHUh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Sep 2021 03:20:37 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 18O7Iqcl005386; Fri, 24 Sep 2021 16:18:52 +0900
X-Iguazu-Qid: 2wHHmJkRpwOzUm8gTI
X-Iguazu-QSIG: v=2; s=0; t=1632467932; q=2wHHmJkRpwOzUm8gTI; m=SWMItt4nIbdFY056vPPaCx8C8WPf8n6jQ5dU1iXAH8s=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1113) id 18O7IpNH016638
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 24 Sep 2021 16:18:52 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id B43BC10012B;
        Fri, 24 Sep 2021 16:18:51 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 18O7IpVq012533;
        Fri, 24 Sep 2021 16:18:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EctqGTj5YiLsiQS1e4apKQmNVpWk+jfCcn2opRbVMCi+dCBZwkustDo5msItmYFpMT/j+1ddpLHwvtHFp7Oz01Hsl9sHhwyzme8MBg7Gv9BcS5ruwe+uRYQvbMGbYKxZrMO+krMQx2ZDD9dLYlbPrU3XdWB42Jc/JMHNa3zbzVLxnAP1m0pfOERVfh/g8AHoGYdIGoQs+PO8IibmTGRDiGaMDmoLfPqYoP9juaFu7u9IdcYNM06gCkwjWQeftoBeiIVp+0lOIEH3HTL8FEx898oi0Ch3t2C+4wf/0PGr+ZDexAu8Hbe+eMRPZMJ0Eavid5td1ixF/PAJMtEukFWbmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7cmku+Ig49UoK9s21InPg+4/ojqf00P+Tj6tbZgjVdA=;
 b=cxiXIBMtZTW88Nec30vuk8PHmrwvdjnz1/7c6XSS7jPJJudCPR2JDEqBTArf27lNOko9H5rJJr9P5bZvBDJCwkd31JWyI5kqE8Gk/8n08JZwDIzYiaWHlIcy3iTrTqvVtLAg7irfPq1XbYCswp5s0bHDhoULoZK7jWK+9xv0ZhMO3h7jZyX4x6oLWMHjqlHh9nu6rMq6WC1tHKFruSF42wT2v223FXJ73auEdLgcgP6tVRkOlEK0+hX991h2KXNK+qye8c30bx8VvUEoEV/2OtHgociJVeNKDXWgflb43fVr9yjpVuXKbFVD8JStCqUTxZ2cdeqDO53YPN8yxzMUwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From:   <Venkata.Pyla@toshiba-tsip.com>
To:     <jkacur@redhat.com>
CC:     <punit1.agrawal@toshiba.co.jp>, <daniel.sangorrin@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>, <linux-rt-users@vger.kernel.org>
Subject: RE: [PATCH] rteval: kcompile.py: Relax the requirement for kernel
 tarball filename
Thread-Topic: [PATCH] rteval: kcompile.py: Relax the requirement for kernel
 tarball filename
Thread-Index: AQHXr9W0SxIZJ3eyEEaE/twZp/yQl6uyA28AgAC0hBA=
Date:   Fri, 24 Sep 2021 07:18:44 +0000
X-TSB-HOP: ON
Message-ID: <OSYPR01MB55421382C76DBBDF644DBCE3A4A49@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: <20210922171740.8939-1-venkata.pyla@toshiba-tsip.com>
 <f735b9b-3a71-7ccf-fbaa-e6aab76748ff@redhat.com>
In-Reply-To: <f735b9b-3a71-7ccf-fbaa-e6aab76748ff@redhat.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none
 header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec454548-91e7-4198-17d8-08d97f2b8afa
x-ms-traffictypediagnostic: OSBPR01MB2375:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <OSBPR01MB2375C89E6E9376DC2270F482A4A49@OSBPR01MB2375.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q0W4uuuRm8dwcgJL7UAogOQxCv1UCTljgBUZIFXqZqA566GOsZM/2RiBqxsxYpadcTMG1T54167PCgs8DP0B9EwHeY3r/w8wVuTmROZI9WaujiSvjCrhvMLInX7NMwdq/caW9mNuVISb/ZWiy88oPgogVjnQoHwZ/5fpSBAd+V8HxM6keL7ZWgrfbErXZ66OXX0od3glC4ajeVN+7+yAKUYJNWO2fdcpPCq8I5iDceE/1scl6wwQsqalB49pLDreKQTD7TpJeLtKO4FfMQ1WAUbsf4KJxbEj+qtwqAUdCx/MtDDpeU+D0sADOTmik2fUiIcz/VGtjrG0THO2rDjEEwS3nY8KJSN/BwBQFXKiBgaUvI4XQHr8IVv/I89c+Ssp+oETpf12XCtgkv3fQEEXTwbiDgXjszT449BcvRj2aj+PA1E6UhC3QTyawB4rHbmoHBjVSkOR+XhsTAoNnyEARZgJKJTxknGgeUOEstpx5ux+2eJK/Z38aY8wGHS2jhW80m++TgMXMVF32MCFrzRIa7C+obwrO7n3Uek0eIQ4zbPqunDGGCcSD17Qn1JuCGuNWsn7pbY+E6EYyhuglpdDVXsix84GlcJxDNEchVVb2W5NcL23shtMZJdpBxUByDGj/63/05zzxS1UdB8iBCztTwWMZ2vSo2ur7SN0Rd8blDHOyprkh8BfHjrAxT/LUbQcuflfZSuIakXcz3v/kTgHYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(122000001)(6916009)(85182001)(316002)(71200400001)(2906002)(38100700002)(26005)(4326008)(55016002)(33656002)(9686003)(7696005)(38070700005)(508600001)(86362001)(6506007)(66446008)(64756008)(66476007)(66556008)(186003)(55236004)(76116006)(83380400001)(66946007)(8936002)(54906003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VFRYWmhhT0IvN2tRdERIYWxZU3lXdVlTZWZmcFEwLzhEdTFrbTlPaVBF?=
 =?iso-2022-jp?B?MW1yUzlMZ0ZDRTFLU0dMM3R3NnpKVUZTZWQ3NW9sbnRManNOWU5OL1Y2?=
 =?iso-2022-jp?B?WWJBRDFUelNZVlFjdWRDTXN6TW1SSWc4SnprZVpUYzhTcUZiTGhQb1pp?=
 =?iso-2022-jp?B?ZlhlSHR0c2dRY3dkbGRFZEM3b1ltenh1Y21MeDdtTVRqak1YTklpZ3VG?=
 =?iso-2022-jp?B?SzA5ZG1ITVArMVdzeEtUKzB6YUVVb0ZDQUpBanQ1Qk9UUHNVQzAvWnNu?=
 =?iso-2022-jp?B?dGMwSVdOLzZLejVzVmdGeWZ1bmt1L2I3ODlPUC9Xb0ZIT1kvcHQ2TmtM?=
 =?iso-2022-jp?B?VkNvTWZ1VjZZZHJIbG5CaTVQbFdPV3EzelVxVy9ja1pFakIzT2xNMTZL?=
 =?iso-2022-jp?B?cHQ0NkF5L2FEbWJ4ODVqM25FNE50YWhwRU44MFFXaXVHTWlseTF2ZnN5?=
 =?iso-2022-jp?B?ZHYrK3pWbE5nYWVIWXFuTGNRSjA5bDVzZk1XK0ZRd1IvYnFINWk4NzV5?=
 =?iso-2022-jp?B?VGhLTWZDY0NaL0htNkFYRHVvcEFJanBxOXVYLytlM215NUJhTXJVWnFh?=
 =?iso-2022-jp?B?RzN3UmdHT3k3cWZiOWVxWXF4cC9SeFp5c0dnY1RESFBxTGZGT3VSYlM5?=
 =?iso-2022-jp?B?TzlBNVFHV05VUHdiRko4VnplMG1lTWdNVVdhMnJwYU81UCs2SldIeVlF?=
 =?iso-2022-jp?B?N1lINXRTWjhDTkUxNEl3eDRvNTFMTTA5bllRYWFvbWJlUUY3aTNsb25u?=
 =?iso-2022-jp?B?dEJnVjNIUzNJSHExNlNuUkN0WXpLcnR3Z2RMTzFmdVVxYm5IZElFdEk3?=
 =?iso-2022-jp?B?ZG1BV3FrYkIxRE1wR09jUndNd3lHV3F3RVZPekUxeXpZUTNYQVdLZUg5?=
 =?iso-2022-jp?B?MEh1T2lXSXJBSzlTOWdLei8rTXZGV2NQT2JmSTNqUXV2WE4vQVdkWlBR?=
 =?iso-2022-jp?B?Y09pS0tkcWQyaC93RXBFSkR4NHBDR1B6c294d1Q0WWh6Q0U4bGhWMXNK?=
 =?iso-2022-jp?B?Z3lGSkNmdkJ0Qlc3NmtVcFI2eW9mZWxGWGVaQVpsYU16QVZubFdLaGFr?=
 =?iso-2022-jp?B?NjdzMFVCT1NIWkNaNmpVeEhuN3h3U3V4b2hEQ3pZV0s2NzU2UytZZXFo?=
 =?iso-2022-jp?B?UVRDdmtrRGV3S1lBODA3emhKTE8rVlhpZFV0bU1MSUVaLytFU05yYmhq?=
 =?iso-2022-jp?B?b3NqL2ljb1I0S2J0VS9mM0pNMXg0QytDN08xOWRVNGh5aHR2TlVVZnFM?=
 =?iso-2022-jp?B?QXhBaWZENXh2QmVIVDI2WnpCc2RzZFpYTHQyTGdxOWxuYTdERjAyQnFx?=
 =?iso-2022-jp?B?UXErdnlUOWtrRWtLNzdQTnB1TDBBNS9zSG1icWs5QmZCdXE1eG1rcFBN?=
 =?iso-2022-jp?B?aEUvVUhMTnFPL1Q4RERGUUpxVTFXcWlLMVRwUllyOTkzb2pzNTZmc3V4?=
 =?iso-2022-jp?B?c2hHZEdxdlBTK1pSTUc5VVdpQ0l5UmZNbXEvQ2Q2UEt3a05WeGowbXV1?=
 =?iso-2022-jp?B?WFljYUZOdlhzbXBGVko5dVZUT1RPSTIrSStsd3puakk0Q2drS080ZFd6?=
 =?iso-2022-jp?B?c0NwbmF0MTZEWmNOWjlpS25vUlRaR01iZUtJb2l1bnFHWC9XbkY1M0lp?=
 =?iso-2022-jp?B?T2I3ZWVPV1JpVSsva0duTGFTR0dabjhvNGdTOC9ORDBBYkFncTdjWEkv?=
 =?iso-2022-jp?B?MVdUcFhxc1gvKzg1ZlFRN3U3M1pKa1lBWjJqYVRKb3owZmVvdUFEdnlL?=
 =?iso-2022-jp?B?R1B3dTFpTnpiSFJLNlBIdnBlTUNCb1RRY2FlRlAzZmlrbXN0aXNwa1Q3?=
 =?iso-2022-jp?B?TEtVUlNMcENRNjVBWnJLaE5SMlVqM1NSWDNSVEVheVBQWGR5QTZPUFFx?=
 =?iso-2022-jp?B?cGk2SmwvM244bXp1TTY2UUpBdGhEeTk4ZlZOVEpxQUN1RHVQQ01hczRI?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec454548-91e7-4198-17d8-08d97f2b8afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2021 07:18:44.1155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEDodavm1a+yMORa56droM+jcHvYrA/4dqgVSF5Hdg1h2sSmDCAlEM+y2oYZUqMp2fXRLneOWgpgpdCrOvr4uwul99HQ/b9Nv+e9GkqDB3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2375
X-OriginatorOrg: toshiba-tsip.com
Received-SPF: Fail (TGXML363.toshiba.local: domain of
 Venkata.Pyla@toshiba-tsip.com does not designate 104.47.93.58 as permitted
 sender) receiver=TGXML363.toshiba.local; client-ip=104.47.93.58;
 helo=JPN01-TY1-obe.outbound.protection.outlook.com;
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John Kacur,

Thanks for your time and explaining it.

please see my inline comments.

>-----Original Message-----
>From: John Kacur <jkacur@redhat.com>
>Sent: 24 September 2021 01:01
>To: pyla venkata(ＴＳＩＰ) <Venkata.Pyla@toshiba-tsip.com>
>Cc: agrawal punit(アグラワル プニト □ＳＷＣ◯ＡＣＴ)
><punit1.agrawal@toshiba.co.jp>; sangorrin daniel(サンゴリン ダニエル □ＳＷＣ◯
>ＡＣＴ) <daniel.sangorrin@toshiba.co.jp>; dinesh kumar(ＴＳＩＰ)
><dinesh.kumar@toshiba-tsip.com>; linux-rt-users@vger.kernel.org
>Subject: Re: [PATCH] rteval: kcompile.py: Relax the requirement for kernel
>tarball filename
>
>
>
>On Wed, 22 Sep 2021, venkata.pyla@toshiba-tsip.com wrote:
>
>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>
>> The kcompile module includes kernel version when looking for tarballs
>> or source folders. This necessitates periodically bumping the
>> kernel_prefix but also requires the user to provide particular version
>> of the kernel sources when using this workload. As the intent is to
>> generate a compile workload the source version used shouldn't matter.
>>
>> To make life easier both for users and developers, relax the
>> requirement for specific version of kernel sources when using
>> kcompile.
>>
>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>> ---
>>  rteval/modules/loads/kcompile.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/rteval/modules/loads/kcompile.py
>> b/rteval/modules/loads/kcompile.py
>> index 8d08a3d..be40a62 100644
>> --- a/rteval/modules/loads/kcompile.py
>> +++ b/rteval/modules/loads/kcompile.py
>> @@ -35,7 +35,7 @@ from rteval.Log import Log  from rteval.misc import
>> expand_cpulist, compress_cpulist  from rteval.systopology import
>> SysTopology
>>
>> -kernel_prefix = "linux-5.13"
>> +kernel_prefix = "linux"
>>
>>  class KBuildJob:
>>      '''Class to manage a build job bound to a particular node'''
>> --
>> 2.20.1
>>
>>
>>
>
>It shouldn't be onerous for a developer to grab the right version of the kernel
>from kernel.org and save it in loadsource

IIUC, my intention also same to avoid the hardening the kernel version in the source
And let users pick the version they want.

But also, I agree with your point for the comparison purpose, the loads should also be same.
This needs more discussion and specific to users points of view.
 
>
>As for users, they are probably getting rteval from a distribution.
>In Fedora and rhel we split it out into two packages.
>rteval and rteval-loads. rteval-loads has the correct kernel version.

We are downloading the rteval source manually and so the load sources as well.
When I use different kernel version then I need to change the rteval source as well which I felt little uncomfortable and so I made this change. 

>
>The idea behind this is that rteval changes more often than the version of the
>kernel we compile, so the user doesn't have to download a new kernel
>everytime they download a new version of rteval.
>
>You make a good point though that the purpose is to provide a load.
>We have had some discussions in the past about whether making sure everyone
>is using the same load so that we have apples to apples comparisons is
>necessary or not. I might revisit this in the future with some innovations to
>kcompile, but for now this is a NAK.

I agree.

>
>Thank You
>
>John

