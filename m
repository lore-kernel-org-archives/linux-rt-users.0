Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14CAC4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 05:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CB460C3F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 05:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbhG3FD0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:03:26 -0400
Received: from mail-eopbgr1410075.outbound.protection.outlook.com ([40.107.141.75]:17472
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229696AbhG3FDZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 01:03:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEIfNaTSbVHI0WcaNiIntoqY7otDM1Lz/y9pBDbqiVAKluM0XRxDTd7DXVSL4KdtAo4vURqzjmWB6n7Cjo1AAbHb+xDGw40RTvtISmSpwspvb0oDL7uc3MRTvfVTN3pllNvv2vKx6pYklzAsuZeywMTdD3XpK/R6yHZ+mxOOTR2p4RyBs4mb8xNcjlm/0H/qE8csHEXh64UJvV6RGAAoUnwxUSV0x0laWoCcCDc7E+l8WPwXAxbOBz+yecaQ37Q+IROzZBExqbsdejo81kNYNx6SxWdOseW9gKBayNod7sctHy1n7m8BrvM9UOkLgXz+BCbB/q99wI87kxAKlM5WXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2OgRz1cc1qGMSH6SY+zeP0IzxT2FG0UEgDZleJJ8iY=;
 b=Amqz4uMWj39yImMWDwt5khPx83chnbN/6StNXMB78YRU3o56czEOhv2Y00PTtRddi0u6Vt66V5aWSIHtAesLiN+UsikRmwxR+ZIcmDyj3On1bmuM+0II7wizt7qtrZUSfQT22k+GxE82n2hikuZJLD36u297qvaAtJEMa8O4wYo22wDdrciDTQ8l+HOXZD+hVigI3LGUUBB3/Oc7JyXg9sxOxQ+4nAX/HpIWHmUJrbOKlKmdMORY/jfFblrjlRLBtXckbIUmD/c5lh30OaZXWzSsNAiHBdMvAtm5dKNlfN2DMGUotZnPNkO2pIgZLogMAsqg1jhFhxsHKja8Ht7cgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2OgRz1cc1qGMSH6SY+zeP0IzxT2FG0UEgDZleJJ8iY=;
 b=bcYSGH4Mkb68/UyzUe+cE5kRkyDxBAjNYy0LO/xwXYMX7ncyx/Kn7egd4eJk/+coMcqYsBu0l3tiACOj5eue/wM9nOFgf3g7Uih9UxiZeGv4vXC7cenmiT5UrMMylk0495YEox/d7PMSicpF5SI7RzsMh7jKT+Lg094ERk2xL3o=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSAPR01MB1762.jpnprd01.prod.outlook.com (2603:1096:603:2f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.22; Fri, 30 Jul
 2021 05:03:19 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%5]) with mapi id 15.20.4373.024; Fri, 30 Jul 2021
 05:03:19 +0000
Date:   Fri, 30 Jul 2021 14:03:18 +0900 (JST)
Message-Id: <20210730.140318.1967218651294711984.atsushi.nemoto@sord.co.jp>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, williams@redhat.com,
        jepler@unpythonic.net
Subject: Re: [PATCH] rteval: Add __contains__ in rtevalConfig
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <20210730030540.1098438-1-jkacur@redhat.com>
References: <20210730030540.1098438-1-jkacur@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0032.apcprd06.prod.outlook.com
 (2603:1096:404:2e::20) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR06CA0032.apcprd06.prod.outlook.com (2603:1096:404:2e::20) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4373.17 via Frontend Transport; Fri, 30 Jul 2021 05:03:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8adb76d0-6117-4af3-d254-08d953175902
X-MS-TrafficTypeDiagnostic: OSAPR01MB1762:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSAPR01MB1762BC42E4B75EDA194467AEBBEC9@OSAPR01MB1762.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5HF4Mkzn5wg1nGA2Vs14Lz5C7lEe9/PTWxmtDyBawKZfK2OsO59gi2w+oJF6S2sz6SO6ZVzQ+jOSYNB0S/yZmkaM2+LTj0MkK44K2IAIr+cybLbc+d14GyoEb5Hi4RoKB/4UPhUg4/ICDnDtwGhuhe5WDL5X/mAz0IF/8vMiPfVcEqha5KtLYnX6lrHiPRjJOwtH/BvFeFo9G2m6+lhgEAzTWWQalcqxyf+YYH8yLI3q9IJ+hIIwq5f4zwzrqSXj5jBo+6DEKAMP1LKs1oh0XfwXfM252oDqavxM8T6gsG9macuslSHYqOMKRFiCyI700X9aUocgtbOTzc1PpGj9g+s9BRFKpNLXh8VTba1AoOTtGrSCYw+n7Qr5RiyIsjY0UE6Lag9tTMSvbZdsgdKwG1yC7qnHJR2BQR9XONJG4s2j9w++kzATkRHmTYwEE+atvn9q9W6lA2naT+cn00i7sAqmJ4V3xod0WMxDqDN3CqykT/+2jj97XAIGcNsrDsPZ6HqJNzsHDX2fHafjq+FizEoN6+LudJUTamQloVg8XCdxOSA0pmPrcd441czxXTb3GBTyu24Ej9jkXkadW4E+5Kohu+eXRie4/y/d2BwOMsrFCp/fGqjGzfPLmxX+kj+cztBcIFLF6dv9kDP/QSCC0eh8miYkpZqwbiWiB6DjuqIjM6+KFEmvjgKma+LxOW9pFlm7NAsdRlWXi8JY5G82Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(366004)(39840400004)(4326008)(26005)(8936002)(2906002)(6496006)(5660300002)(186003)(83380400001)(6486002)(103116003)(956004)(36756003)(44832011)(66556008)(66946007)(8676002)(86362001)(38350700002)(66476007)(2616005)(52116002)(38100700002)(478600001)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9QxUD7ItI8pTjdIdofriKY+DRUzMTBIsQQaO9V8O3iDa1xtayJ4lOMh47ueX?=
 =?us-ascii?Q?/UeMkJU0i9AlUCbfD0xHDfNMXgm9DBWsHDqKp7odqrFUSXkJexvER4s8clIt?=
 =?us-ascii?Q?Jb8qu3aQc3gIeG6gMoa9n7PFPOKNh6ZErElmy/fut4i83HDceyje7n2PTq6b?=
 =?us-ascii?Q?i298f1woKPL8S7kqgNNcGuvpACAU8o0WQw0g+CTmN4wxLNERNZqDvz0YXhSQ?=
 =?us-ascii?Q?0PLvQ+cwN7UfftgsnuxpmFt5gPy0jGuLNMrJ3umaSoWJ2UZTAuX44OPxXfSl?=
 =?us-ascii?Q?s3qGWVsWiC+zCEiJfXYZEoIDzM9HcQuT2Vl1SqNjLKlMRBVNmU9Q5OpvPzlS?=
 =?us-ascii?Q?8RF2gRaI+M9Ty9sFezD71LsE+hg2nLupMLpeaGpryuCtJcOMcBK4FnjZlMq+?=
 =?us-ascii?Q?sKPStHTxWAy925XbPTuBGK2KZFFDFaCoLGN/bbWgFINJeJemwchP8KftJ8gY?=
 =?us-ascii?Q?gfKJqlq7ABi4WmH7irBxSirgWA+ENtlJbOsfhJERA9CeDtPzVhDKRO/F7Y7a?=
 =?us-ascii?Q?6edDyR826R8b69oniCf38lMieOANLsHLK97GJHsFqUDPQ4zIpkQp2FvYdU2l?=
 =?us-ascii?Q?8SWCyLC74H+7TRsZ6TpuNpOnjForXQ8W5r/je/cP+YmlH/mHVtnSoPPoc3HP?=
 =?us-ascii?Q?HmeJPoD9/OG7C/sMxK64y7QwgsSyzo8wp65vJQIw7BmajmgvKQd2lcq8IG2p?=
 =?us-ascii?Q?lY5T9CE+LZly3vG3C3sAPXNgIMn+lHrtFS+e0WrfmuLDt3ezTsnSLlo0yXh6?=
 =?us-ascii?Q?jeD68WCK2Tg8E1/syKr88v//6DurofpyZnRrrAk/WXQnxE8NFHrebkjIj5jK?=
 =?us-ascii?Q?7prhTh0AlLQN3T62CuWV61rk3WX5j0kixH5SEvZHYCAXoqWqlAYu4SgYv5TK?=
 =?us-ascii?Q?eSFQ4x6WrfoCSEdAeTdASeadxPVWgUiBoT/5hB1mFhgeclnGlsF/0BI78cI2?=
 =?us-ascii?Q?0DU7MePcgUMbSiPDNyLkwy/QSEuAJ8m8PubcL5PTiJCNTVxxQ6TLCmy1BzNz?=
 =?us-ascii?Q?Bu7CtskJ+SY0nEdEqQpYrOrz13Dwij7aqfUSTVAgdKh/6BK3lS/UC6lklZtT?=
 =?us-ascii?Q?zDGvplFq1d9Aj45iCDQk2oGcv9aeLrwl31z6c/U+4iFI7zu0lplKfxmRVGON?=
 =?us-ascii?Q?mdPpyO11bhb0MnBJU5cQ+9C9Ks9XaSynXnZxXd3K/6PstSQwdyDzGeRvN6K6?=
 =?us-ascii?Q?QNUNbPPFyWQxQlZzKUYE1vGuUgw7isL/HPMdf4nANPKOFK54/x7N1FRon7JL?=
 =?us-ascii?Q?7lrzrAuf85QQRwL7/Vez+rJVIp+RVFkMXtUI9DERJOiq8ESxXgbRnuVsVvpM?=
 =?us-ascii?Q?p0/AsgSThyXmZY3lS+/8v3Ro?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb76d0-6117-4af3-d254-08d953175902
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 05:03:19.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bn4+UjiiDX08lv7D10YYg1AA88U5KgpXSt5OT5VLI7QF9Qpfvf1AiwqMbuJuR6KqQDRVFObJz6qAVLfwO0+B1iKtsU1cf+dV5sAAkkDb0W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1762
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 29 Jul 2021 23:05:40 -0400, John Kacur <jkacur@redhat.com> wrote:
> Add the __contains__ function to the rtevalCfgSection class  to make "in"
> function correctly.
> 
> For example in cyclictest.py, self.__cfg is not a dictionary, it is an
> instance of the rtevalCfgSection class, therefore
> key in self.__cfg
> does not work as expected. In order to make sure this is fixed
> everywhere, instead of comparing to self.__cfg.keys() everywhere this is
> used, implement the __contains__ function so that "in" works as
> expected.
> 
> This bug was introduced by the commit fd3b732f714d ("rteval: 2to3
> transformations")
> 
> Reported-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> Correction
> Suggested-by: Jeff Epler <jepler@unpythonic.net>
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  rteval/rtevalConfig.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/rteval/rtevalConfig.py b/rteval/rtevalConfig.py
> index 578aaa3ab58f..56bbc9ee0de6 100644
> --- a/rteval/rtevalConfig.py
> +++ b/rteval/rtevalConfig.py
> @@ -126,6 +126,8 @@ class rtevalCfgSection:
>              return self.__cfgdata[key]
>          return None
>  
> +    def __contains__(self, key):
> +        return key in self.__cfgdata
>  
>      def items(self):
>          return list(self.__cfgdata.items())
> -- 
> 2.31.1

Thank you for review and correct fix.

---
Atsushi Nemoto
