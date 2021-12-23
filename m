Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177C6C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu, 23 Dec 2021 06:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242286AbhLWG3n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 01:29:43 -0500
Received: from [40.92.98.69] ([40.92.98.69]:61187 "EHLO
        JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232444AbhLWG3n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Dec 2021 01:29:43 -0500
X-Greylist: delayed 86462 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Dec 2021 01:29:43 EST
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5ly3sSjLtnuNB5IeLQmKOweeuWlWod7VwDwEAyBOffxjMRnpzmBvCxWHILbhLFkAUqjwNJKt6RAK3XhDLjgS1qqdUBk6Kd+m8WvK0jloPE1+h/JrtoDCOXkeyS/huC5hz1M3rFhvm8V7KvfoLbBMHGvKQ3Bbl0tnUErEBh+j7NIauQS7AEeTOsZgv7BFjIE5cCx1clQZRzsQ7XLZ479aixOYRNZpZLtszJ8QG/D+O6TIQZczs61FDYtwjJ2L9yBuB1OfscqQxxmYLvFpLJKRW3ow8b+af0YEooM1ONuXFDLwTT+rJDDbMjqBbD/u497aC9IuqqTAQPbyE7/tpXFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnPyyOztUkp1wJ41zcQPGDfAPSZAnBFT+LeV2KKzAQE=;
 b=QIa4+WtfKmCsVQ2Qf7v4cm4mAt77pU3fx8t0GCDjpEpebjAn00o854S4Q8XmXbekCdL7hX8q9ufa7nmVofF0zwjfiQ8AbzQ1qNZIpX+yblzWY1H0i4yOSRctKaV0DN06iw2FG8olue8I+AVEr/AFU+x8W5HlB4yqz0yJ/ECKo9lwcOkaCdrdaiMV9gXJ6AwyQ9nah98L1WoOk6lJGVOAdg0O4gFWpel9/vYse++yqR7gICX8DaKiayy13lOG1A7oQJGZVfE4JxCosqJSb7L2MnS0EZbhqIsVkUQ5QT0XcG+B+66BASpZM8VngbsvZOq80YKFYxI6vyGcLXphAUs5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB1972.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 06:29:40 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%6]) with mapi id 15.20.4801.020; Thu, 23 Dec 2021
 06:29:40 +0000
From:   =?iso-2022-jp?B?GyRCOH4bKEIgGyRCN0pPSxsoQg==?= 
        <oscar0225@livemail.tw>
To:     John Kacur <jkacur@redhat.com>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-numa: Fix the value to check in numa_initialize()
Thread-Topic: [PATCH] rt-numa: Fix the value to check in numa_initialize()
Thread-Index: AQHX9v0nLlGh/6I0HkGs3EVTfxwm8Kw+p9AAgAD3IAA=
Date:   Thu, 23 Dec 2021 06:29:40 +0000
Message-ID: <E3FC7213-F685-423A-9105-61F780CD1219@livemail.tw>
References: <TYCP286MB1913E08DE65A54E19F3286F3A17D9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
 <edf1dff-ec8-c42b-d1c-8fba1b96d36d@redhat.com>
In-Reply-To: <edf1dff-ec8-c42b-d1c-8fba1b96d36d@redhat.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [ZouIWozT1EcvMf0T0klJBlil8zzIwcIJ]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f64242b-4d82-42ab-4450-08d9c5dd99d6
x-ms-traffictypediagnostic: TYCP286MB1972:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0yxnZXvB7/tT08Rur6ShFI7ZsYgIRmmP/FRnYBNdvo3lqJFWXi545giYMI+JzQ/qusApyYF2AN3NLm13jVhXKJ4Yb7z/NYp0ucTHXSD7g7mTICegVAoltMe99lB0lR90/ec52A8piQm2AfDttWBzX/eLRkodXOJEjLZgqVHgMF/d+akXKPtVBl7co9GOtIFjDlrs5Xvm5nmXpSeixAICpOF1H37+wVRuFkwx1nkRKptMu/4E1ibfYRCjn9T8uY/1xKmb2Eg5aNqNnF+la4MbYvQ/IYZOGuO5pjqN4f1Fg+6BRffBSwuAfPGl+0Z96mXO1OGka6Zh0dZ/WJxq2ngdUHPJ/Rh9lrQJz09nQVhP5ConRoEBNZ7v76PqIMNwHoy1IKoPIrwgsp/KNvuYo9layYYoW+xLjRk3WyOi16KUdDyhvL8//jP4BPWwMxcSiYRH6NCyPaJmJi4y+yc3xHaNWQbmYNQ04eDJu79DYRrZt/lNvwHMJaWBlrm1s7WBxPv6BxJnJNGjCSq5RPhwjSvekyGDg91JVFpNAq3UG5us0m9MFz9NQIZAItFKEH/f19dVo23quGFiB+F3e1WWsV+BGA==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?SyswMWF5TDdhSUdaWk93SFZTOTh5blE0WFhLOGNBSUp3L05ZSzhJcmh6?=
 =?iso-2022-jp?B?d1VzVTczUXh2TkI3UERkYUtHTjB2U0x5SHN2dnFCK1RWZ3BwcnFBUFdC?=
 =?iso-2022-jp?B?ZTlUNGFwK3hRQkN1eHQ4aEpab1MrODRJOVVKQXBuRGtJV0txSXFUYTRH?=
 =?iso-2022-jp?B?cUQrTncrNnpOSGZteVdOaXFMelZZaFZXZlY4YnNKN3JWTmtoc0ZNcXVo?=
 =?iso-2022-jp?B?N0ZldGN5S01EUEJBMFJaZU11a3VmMHF6T3VnYjdHVGFzUC9zUmo2MjBz?=
 =?iso-2022-jp?B?b2Y0OVRUc2g1K3l0VzJkeEFmcnQ1bENOMTJmSlJpTnhSWFpSbFA0WE1y?=
 =?iso-2022-jp?B?dVh5b1VBVDVqY29JR1NvZVlrdzdDcmFQNDgxUDF0bnF3NTM0K0lQeFBW?=
 =?iso-2022-jp?B?cENLS0FMbFJDaVlPTHBpVE1jRmdWWEhVandVS004WWFIeDBBU3FWczRm?=
 =?iso-2022-jp?B?YzllN0hXaWxkZlM3Y1RycDduOU5NdU81ZWpGYldRYlBMa29LZFpxS0Z2?=
 =?iso-2022-jp?B?OW5BL29LZ3VpbVdJZkp3a0FwUzVNSDJmZnFhUXBTVFJ5eStHMFZDcHFl?=
 =?iso-2022-jp?B?cVJ3aUwxOWI1QlNTVlQycFB1dlVVRjZYcnFrRFExRUdXWTJGRXRtMmpw?=
 =?iso-2022-jp?B?bngrUEhRSU9jZmNpQmpIaldLTWpsVWR1d3o0eFpvYWZabUN0SnkvNkRx?=
 =?iso-2022-jp?B?ZDQ4YStZMTUyS2wwQmNScWVzQ2ozdkExVFYxR0NZMVhqNlJBMnl2TU1W?=
 =?iso-2022-jp?B?RTJ1ZUNpK25yMFN0VWlkbnFRMEV3RHZIOHFONVhlT21sMmwzV0Z0RVdF?=
 =?iso-2022-jp?B?elc4dmMxZVhUdkc3cW1Bc3haY1JqSDBHTG1FcVZsTVJSSVI3Z1ppZ2tw?=
 =?iso-2022-jp?B?Z3hWcGZ2cmI2dzNoQVlDZmVZbXFDaDNkc2x1QWhQUytwcTZrSkhkZVZG?=
 =?iso-2022-jp?B?T1FWQVR1UzRSb2hxQnUrVjF6KzhLZXdMNDFRdXBqV2JaVjBHSlRZN3dh?=
 =?iso-2022-jp?B?dlBtS1Y4eEtpWEZBaXRuV2VKQlpTanc0ZGZtVUh6eFc4T0YvMEROWSt2?=
 =?iso-2022-jp?B?VkltcVo0YThCRXNabTkrQ1dmejZKRFVMNmJRM1VtMXBrRUdUUGFqSi9h?=
 =?iso-2022-jp?B?RldobUNjQlpGR3Btdzc0bFduV2pudi9zQzlwM2hUa3ZXN0N2eDRZNTFs?=
 =?iso-2022-jp?B?enFZVno1bUNqWWFPU1l0US9neUtaSitkT3dPQXRmUlM2K25JbFcxdkp5?=
 =?iso-2022-jp?B?M3RIRmZNZEM3U0VrQmVkOE44RVd5Q212M0xSNUp5M3ZQRjd5dndVMTlL?=
 =?iso-2022-jp?B?d0JFS2ZZbVh3YmJCWmpWejN0UFJnYzM1dk9nS29CUFg1NXVQT0ZjWDF0?=
 =?iso-2022-jp?B?aVJvemlJUEw2cjRkSEc5dz09?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <8336C5ACBDCB454F8EAA9D96659069CB@JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f64242b-4d82-42ab-4450-08d9c5dd99d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2021 06:29:40.8578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1972
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



> On Dec 22, 2021, at 11:45 PM, John Kacur <jkacur@redhat.com> wrote:
> 
> No, it looks to me like the code is correct but the comment is incorrect.
> If you submit a patch fixing the comment, I'll apply it.
> 

I agree. I will send another patch to fix the comment.

Thanks

Oscar
