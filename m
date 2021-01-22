Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C1EC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B9523437
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 13:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbhAVNYI (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:24:08 -0500
Received: from mail-am6eur05on2079.outbound.protection.outlook.com ([40.107.22.79]:41564
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727626AbhAVNX7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 08:23:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENEVhx0BK+A8E7WaTT7jAMhzRJsUXEfAPdMAzdHwJ09LYEwBAHBirnXD0s7ClB6zdVaj0IKOtvx9yMY83gMsYjWZlBFhXPGRuqI6YTRLc7d82xvHvdz4jN4HywNvOX+WCBeJee7RsR2ocHvPAoZIJNVGiCRkhkeVPPQSb+D4B5uxmjWYb1jViMD7K/M7LvJ6MoNSBVskvwZ0AgquC0EsDlTjsATq4Aj6JFww/ZBK2QimiJDbmknBJfCjdUinH9DpNQ4LkEGGLd8q2EFlQ/wu3x4NNQi9PsSC5Zi77g4T9F/uIbhLU1sIzvH9dS64mM0QL6BXbi1xHhHkyOipz3frIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UBqkyhJ5gRILlaVIjz35Jehwpr5E42MS6CyDLyuHKU=;
 b=Tscd16PZWGd13mczaQ1JSNjBAN9ptDdcWOEZUF8QgwxfUxqNzoZ6osgtdpE+4d7Kx60cEPtAkYkg2F665z65mkOIUp4YskG1/BrHQC7/0eFwaMp2PQaXFIK10ciDoEfhjFLhXvebQke3uXNLweCHQbnjQp9egmDzqf1BihbAaWJHuuIu0Me287kL8P/fyTqiVhWu5Ii4aN2LGdd3lej++E2gOXhZ0kMtunVlh0wGikxxeEXbfMrAQBfS3sH4BOSAM3qomd3/MmZ1+efmvhOgAsTBKs6nXivVFaDO7CDYvEmyH3+u44z4RvXOVM+5zmZQ3tfEpJEPjNMliPwIXCP2cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UBqkyhJ5gRILlaVIjz35Jehwpr5E42MS6CyDLyuHKU=;
 b=F2g3SBkAmVCJZf8IgtnIp7VuyqCn+56gl2bU9dO1vRNz3wdu3NG+s8iZF+tDhLuHYUHygGxEkSgRhMqLBYspWveE26waZCLvdndhOma/+fZut0R78nXU4f1fWTUtNADehy8xRzqCmLxJM5DieuBvmt4WpN86yWYAseVfpNTIs8c=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by VI1PR04MB4559.eurprd04.prod.outlook.com
 (2603:10a6:803:74::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 13:23:09 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::cc3c:7c5a:38c1:60fe]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::cc3c:7c5a:38c1:60fe%7]) with mapi id 15.20.3784.015; Fri, 22 Jan 2021
 13:23:09 +0000
Message-ID: <0374b95d874d2525f4f354de600b62d369068017.camel@oss.nxp.com>
Subject: Re: timerfd performances
From:   Sebastien Laveze <sebastien.laveze@oss.nxp.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org
Date:   Fri, 22 Jan 2021 14:23:06 +0100
In-Reply-To: <20210122123057.72aeag672rh3omcw@linutronix.de>
References: <e4c83482f22059647c546f202470d05e142134bc.camel@oss.nxp.com>
         <20210122123057.72aeag672rh3omcw@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.102.252.120]
X-ClientProxiedBy: AM9P195CA0022.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::27) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxl65009.wbi.nxp.com (84.102.252.120) by AM9P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.14 via Frontend Transport; Fri, 22 Jan 2021 13:23:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35bb6e01-500a-4070-ff66-08d8bed8dc38
X-MS-TrafficTypeDiagnostic: VI1PR04MB4559:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4559F413BFBA67DFB88FD9CACDA00@VI1PR04MB4559.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyixVSfCe8O3ekMxUbTBjTP75JeYKEO9rL0iDL55nk3B8gUn6inKVE2RRJfF+c9IDNSp0pUsg2VQ+DFs8LZKeTcEbVd1amP21UG3OVpy3Cz+/5WULcvuc7pDxC1n4cM1CPa7EeTyy4oiVSI9WsRZ0YKEc42+AXawtKFoxW6jxFR5bXkywM0luBDOVtPnCLp2IzKMP0VN/qnkpmGVUqjVy7hClN0u9QeepsXu/J00ek8TVp0qyEIW8aapU1Of3iDLjBbQWv2LUNIEKmAkNSk4IjLU8saw4uBZwVQfZzw5/geoc6T0gMK2mpDdx4HdY6UsFDSPLjP2Lz6/LA5pXE2+ulIdXKIXXF9RN0qLdZPLUMqCpqOZQuqNpPWCwoIUSWEjfVkXPxIniBdVeF2a+BLaqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(66946007)(66556008)(8676002)(7116003)(86362001)(4744005)(3480700007)(5660300002)(83380400001)(66476007)(6916009)(956004)(8936002)(4326008)(2906002)(6486002)(6512007)(316002)(26005)(52116002)(6506007)(478600001)(44832011)(2616005)(16526019)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YXdXK01yaUg3Z2NzV1RWKzJkMjBucnBzVWkxUzd1Zi9KdUxYbGxMSkV5VEJX?=
 =?utf-8?B?bUROcDlPWE9pZXkyQ0Q3SE9SSzBFMURFV2IwdDg5UXRYMzRqTFJ4MWxIRkFw?=
 =?utf-8?B?dmtnUmZ3eDdJUnRVZXQrZ2h4QU5EcmNsMlNPTEpnYkNIdGxXbUtzTWU1RkVk?=
 =?utf-8?B?NHc1akwyK2dWRW9haXZ4ZDJBZzhYeDJmTEx3bGtjNER2Sml1Y3ZPSUZ5N1hX?=
 =?utf-8?B?eXgwV21EUFFiNmhvZjJMNlhHWmFldEE5N2NzNlhqdEgwVStCRk1tTzFocnh4?=
 =?utf-8?B?Q3NuWTYxbStETGtnNnd3Z21nTkRldmV0Ykdya29mRDI0LzdYdGVtK3hRT25h?=
 =?utf-8?B?SHpsbG9RT2FtaXRrekNla2FGaEJvZ2NjbUZNYVpaWGRyUG1IY2ZJMDFGRW96?=
 =?utf-8?B?cnRSa1FKMjljYjd6UXlXcWphdjQ4dDBWUDlrZzU4NWRMNW96eVFyeUorOHNZ?=
 =?utf-8?B?SEIzVkV2cEI5WTBIbUl1a3ZDZjRnVUZWYWJyNlBYN1hDeTlGVFh3Nkllb1BJ?=
 =?utf-8?B?WDVsMFVxL1A1cWJrYUluRzc1eHB5MXBnWWhkZE5Nclh2ZFluRTdGYkhKdWFk?=
 =?utf-8?B?K1VpLys3Y1Z4YURPRUc0M0xpTEhtT1VUTjRvTk5RYU93OHZFVkN5SXRCcXpO?=
 =?utf-8?B?UmNHZkRzc1ovbU1UZmZRRHRJTTRMc2xmSkFNUVRXbzQzYWF5c29OczFhN2Ix?=
 =?utf-8?B?VjJONEZtNkN6NnErakhnQi9sY0FxeGFJOW05d0JVOUlTVXpCYk9JelBUeVNE?=
 =?utf-8?B?RGdPckUzWWx1QmFFSDlLWEY5NlpYNzFpZlp4UVFFZElTR2YvMlcxdG53YWxB?=
 =?utf-8?B?Skc5U2pZYTZBQUprM2Y0RWdpUCt3c24rdEtUMjNsL1dySUt5VmpYVjJLWjV2?=
 =?utf-8?B?aXVpWmpVOGxvNEhWWis4UVFLa2JRcHF0WFRHendlSVNOcTlHOWZhTU4xUUZ0?=
 =?utf-8?B?TUE2eHZsdlFDUUpiRDMydndETFVKM0h4MEVoakFnd2VuYXdESmtscFo1YkJj?=
 =?utf-8?B?TG9UZUJySnk1dk5vR3lDMnlUZ2Z6UEdLY1ZlOHgwR05oaGVkTWk2cVNQOGZ0?=
 =?utf-8?B?QlFxdDAremxndlhHMnIvQy9HQ1NFMCtaVUpsQ0s2MndSWThxWG5rOEFUMEI1?=
 =?utf-8?B?M3RaS1M4V24xd0VSRlZoR0JSbFZvMUozQ3dZdWJNa1RRZlcvT1pRZldGVFVw?=
 =?utf-8?B?dzFGZFpEOTBkOVA2ZUxhVU15cm9VV2c4anRKQ2pVN3F5akhjZzBCYWJLQ1Mr?=
 =?utf-8?B?aitBd0ovcWhTYW14T3k4cEI4aU9abFYxVGVJelVCS3hTVG8zOUQybjFVNnRN?=
 =?utf-8?B?WTE4bktIOEJlYzAwSUZtWFRGaGhNRmR3b0xtOVU0aUZ6Mlk3QnhyRXljaUVW?=
 =?utf-8?B?MFp2OE5UT1pHRDVmSkY1UEVmWTBwMWNRZlRTcG5neUcxcytJRHRmMzREYnBK?=
 =?utf-8?Q?GJskAbu7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bb6e01-500a-4070-ff66-08d8bed8dc38
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 13:23:09.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JG43UWnOPvw/0To3AIsXe3RaiQkb2p0kF2oZQoW+wK5myg3/GNp0HTg/95Spv06nidEuPNpldOPaBY14a0B+bpEtMilaaH/510zgMfW96k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4559
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2021-01-22 at 13:30 +0100, Sebastian Andrzej Siewior wrote:
> Splitting the timer-wakeups back into ktimersoftd would look like
> helping. But note that all timer wake ups would happen there - even the
> accumulated case where we have to wake 100 tasks at once. This would
> then probably ask for split on SCHED_OTHER vs RT tasks like it is done
> for clock_nanosleep().
I didn't know there was a difference in the wakeup mechanism when using
clock_nanosleep if the task was RT or not but that makes sense indeed.
(just looking at __hrtimer_init_sleeper)

So basically, if re-introduced, the ktimersoftd (with a RT priority by
default) would only handle the wakeup of RT tasks ? Other non-RT
POSIX/timerfd users would still be woken-up by ksoftirqd ?

> 
> Sebastian
Thx,
Seb

