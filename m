Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FC7C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Dec 2021 07:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhLYHSF (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 25 Dec 2021 02:18:05 -0500
Received: from [40.92.98.13] ([40.92.98.13]:38597 "EHLO
        JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S230298AbhLYHSF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 25 Dec 2021 02:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdNIzmnqQ7S6mYsilBK7pV1iPW0lssMZy6DKddIQ77hSfChbSZbn10UtXvWuyoNmD4M3iwNSbwxFxidHNwqLw0Wualdf7uKa5CrTfFM8QXTmoEOQGgxqsyM+rCzUrD8Mtx8UCma3NAVFqwdK8K9ISLfIdgkcZWmbOojVOS6izm4hC4Y2/ExxOIcFxeaq8CNlBmqz4qF5cT/kzuqwgcG1gKJoG1yGXxR8odasEHJehxNLoSZ8XFquQZdb0tmHg+htKa/sfDuOX8fp6izESjjSwfcgy6YFNMGVGJJl6vRt37sQi+bqJM2qhjt/Q/ykpHL2MHr5mjIuUT55snNTSYPoCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHMEqlakycRIn4FPgim7eWgEDoH+HRg02a326Y7WYLQ=;
 b=TAd5zepiivb7lFu/kGXkTbBYSRn3M2I3Ct8q1Dj7R/nlXeRdWxuW3/AqulEQ8B721366vTKtHp6sa2zNfXJ9/Iwbf3SZAsK0VwvWudX15dIATz6bwWjdGaYJ+HuhKv2QCJj4BuUllEG5KXgZ6/JNKsDpK6I7JGDU7r4/qiHTra07qlY4xZdvQn115KI/beXtO7Zc4cl70xCc9Hn1fVXv3ZNbPo+MBTokNG7X7ir+6/miRgj+JND49FqHtmX1RtPXdiaSR7QDf2Uegb+fNrFzmypNA5xSEiT4FVKwy8Nl9n9tcGG0DBg0EC8C+1VnSknVv2Ipqm+4RirwK+zoZpSF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB1946.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18; Sat, 25 Dec
 2021 07:18:02 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::807e:a600:21c4:42a2%4]) with mapi id 15.20.4823.021; Sat, 25 Dec 2021
 07:18:02 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     bigeasy@linutronix.de
Cc:     jkacur@redhat.com, linux-rt-users@vger.kernel.org,
        oscar0225@livemail.tw, williams@redhat.com
Subject: Re: [PATCH] rt-numa: Correct the comment of numa_initialize()
Date:   Sat, 25 Dec 2021 15:17:12 +0800
Message-ID: <TYCP286MB19139E08FF93D414E381E4BEA1409@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YcSdzd3jmjV/rxBB@linutronix.de>
References: <YcSdzd3jmjV/rxBB@linutronix.de>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [oIqWqKriQto/M17xmNOM0qLCLNePWJYg]
X-ClientProxiedBy: HK2PR02CA0153.apcprd02.prod.outlook.com
 (2603:1096:201:1f::13) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20211225071711.25085-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24f7ddc0-f677-42f9-f93e-08d9c776b046
X-MS-TrafficTypeDiagnostic: TYCP286MB1946:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sODi2b76MzH096N12GY1ZBEzMvJ+MCi4wc85oCpTz22uXi2vFbfjlWBL7+CjcoYd7XyZDqZ3QIIKuoBbLyG7Sxe+/Z+WvW/NuhqpEbiymh5vltg7SvK2ACM7ZduxaHRkTvZ9szcDOk+Vyw6aJ63HbeDP7++bNVyNb1qKobTLu1iocEiV+epI7AlqlDrEJfgLfjbYC2g7QyFUwUqIJ5DWG8VpQP5NPWXJW8cUqaiVeS3uMbmPyyu5YMRFkKBzT1cKsd5Kxw35TIpgKcRGris0vr73NRSDZmzmdDoxLTCntjCisvwIdBEh2If8KTLUm30QvCcqsJppF+kKqeeLbdTWz4yOQerwc2qXy+OSRFu91NzLddWwzVee2PNJGV58QRm6Al8O/VfM+eWiAlY++istQ9AY2zQHEJQvkSRVYVzLo6a/ZUeaobMPlkkCiOe63KXY+8CBRMkvq6T8ucY4GksB7h92fm+7Ly+P2KBgM0JnhftPWTfJ0rNPmAhwWuH6+Q5UkCoQCE7Wsat7ohVADFtIpsSjo4PVJ9liRYHXj7R5V/iYIdq843hI11emGoGO+TS85CWeao/lnUC5vnRBG4t6LA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?65bc7BhS6jyPFs16GaDq0F4nmZUz/5X6vbCuiAVpwfrvsr6369B1hXzjdf68?=
 =?us-ascii?Q?yQIo0GMEqzk8nTixbUeto9gtnK74yJk1At3/W8WfTn9zpH72UxFRy8O9Sif6?=
 =?us-ascii?Q?MN5o8KqrTRoKJx6P/mS9wjPMMrAc4LbgANfHHcrslGa0zt67wpQm26PdG9i6?=
 =?us-ascii?Q?OYj4PC85kGY2iiXy9VfWnQSIhOy7ZVCN4Mu7D4vzJfyA/POBYyuy2olsEO7B?=
 =?us-ascii?Q?L1u2oGU5RCwuZ7OAlMBCINe98I9lR6QQNhMnE4cCDTwUlkhvMGynQzb4s63r?=
 =?us-ascii?Q?jAh+AgMTeiKe1KOW7Tjdvg4bp/FP8zNpfW9szqnvnbvz0dgSBuieodig8qMO?=
 =?us-ascii?Q?2LJgEhzH9ClJ7nPiAr1M58ZchsvObWHORXppfcjqtaYSIn0WxPWKAfqXZEE9?=
 =?us-ascii?Q?CbGbyXAhj+vECpafuXp7ee2FWt1AaHZV9U0gXDfiznmuZ3BD7WK+V3y0LGx1?=
 =?us-ascii?Q?JbcdQfXkD2NWQYNTWuNd+rw/wuEbmwh2zQIIQ7r5wW/2drNLIBsLvgeZqqDB?=
 =?us-ascii?Q?qFIsEAmURRStzpWgZB9ImwLfJp0bqwfnq9rmLB1kdGK4FQO4gUD3ho6TcKoS?=
 =?us-ascii?Q?2U6cbhiC2BZep25+xAHUTN5g1l80kPLkfPNnA0IOt5qRC/Sclzxt/Jtbn5Fk?=
 =?us-ascii?Q?YRCSpEB14bioRMUs+BzxmU+If7m3AceFrhCNtOUaMO1Kgxs4qM/k2zQAMAo5?=
 =?us-ascii?Q?+mYqRebcDAi1VeXE3wqfJJnCt34JfT1KS+M36DeQCXm0TMMLWM7jf0WVJd6y?=
 =?us-ascii?Q?5zh26yOztBkuqQuuyHTBRKwWH9QvruMvvFNYwJYza9J3Ss8Hdd+iRbyj6isz?=
 =?us-ascii?Q?nLc5ZCnh7oDp9+tCc9wpcGkRFkmv5cyPQNOxy9JVM9fvAmRkstLSSjxmIN8m?=
 =?us-ascii?Q?gFLX3hVm/RWAfxqkFthprs5E0aZ0jVK7uGFCPX0QrP0zmzJ4Pw6TD74PPEt3?=
 =?us-ascii?Q?footZl0ZFbmRa4BesExTDA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f7ddc0-f677-42f9-f93e-08d9c776b046
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2021 07:18:02.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1946
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> Based on that, neither 0 nor 1 is defined.

Yes, it is.

But I think the comment is to describe the return value of numa_initialize()
not for numa_available().

That is also the reason why it has 0 and 1 as its return values.

Oscar
