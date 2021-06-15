Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C229C48BE5
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 16:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30DD0616E9
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 16:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhFOQ0a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:26:30 -0400
Received: from mail-eopbgr70133.outbound.protection.outlook.com ([40.107.7.133]:22279
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229979AbhFOQ0a (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Jun 2021 12:26:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X58YzWD5wvuaK3C+FXJ7tE52PY2SuCBxVheCq4HByNIlwE8+bZTKsE/XiMlUd/d49MlIdCa0t8T2Tic/sQdxMGLpjsetgA4//KvjE2Jm+4Vg0TXRagAxbPdR36X3qkg++96ATMfJ4ckHZico+D/IiJX8FtLp90GidY1Ie+g9+ZdFSdE42yUoz1VdKfHJDak4SsvNtW9/c3Rp4UG0AYdRJxTs/rAStn0f48X6/C5spmbhdoWTuyixyQtErDF2UCfD6Id0JNhb5kKq1fGFIseZS4Sb/IFRWogMf4057Gj0e3jVU5u3iaVg6vlphsrgVLSrFz6Mpsdgh05rpqO72MdwAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHxPmIjaaBLp1fD/ieBONCB+4VPYGkNbYcj0B8pUs0g=;
 b=HUNz4bneXcGZMiaV4U/kWfcbJwhMsTqNFPD+9oFnEFmM9N71ma512COJZlS8Qskd/awl3JzKr/dM10O4pSAt4PT+CGLmmL7YijsZgjPK/3z8JAXa7d0BcVZoSr4YfMbezJMLkQs3O0zfzq2g8DqGQpVTdnPxIFI9dA6yLHCCaNvyJIw18BAw1pBYKyM5JRuZLeghC5s8MRtpVhtX9LFs2UvH4rhMWRRJqGA8u9va2PKq427KsIhFaod9JtUbEixZKfixqzYaHGJk8yM+8rMa5Ef/E4NaOuPGQ7qzbDeAutG0uBd/d6PeaKHmNw4oXgcwgKs0AT+HfPVO1fCJxY+RYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHxPmIjaaBLp1fD/ieBONCB+4VPYGkNbYcj0B8pUs0g=;
 b=OxgRQd5DbZPHiVnqZ/VOXUXoKQiG/WyO2LGbpY0+FzxYl0A3j5KZpjaGgHeBePTqF1nT6ggXogRFH2Nv52V+3m3cF5KNq/+bi27I7Gy1BR9oFV53dpt2gxNn7U8GSEmacsJBBQtF2cTtBFVq2Fhf2QeNU2Ut+UPuZds4nQqM2fI=
Authentication-Results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM0PR10MB1873.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:48::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 16:24:23 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 16:24:23 +0000
Subject: Re: commit 3d5bfbd97163 versus -rt
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
 <20210615113312.0dad32bb@oasis.local.home>
 <b66ff695-7f75-2a70-7feb-0df4f5ea0608@prevas.dk>
Message-ID: <37e28373-c6ec-2602-ec5c-cb0b65ce6697@prevas.dk>
Date:   Tue, 15 Jun 2021 18:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <b66ff695-7f75-2a70-7feb-0df4f5ea0608@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: HE1PR06CA0129.eurprd06.prod.outlook.com
 (2603:10a6:7:16::16) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.20.67] (81.216.59.226) by HE1PR06CA0129.eurprd06.prod.outlook.com (2603:10a6:7:16::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 15 Jun 2021 16:24:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87a1ae6a-3d72-4499-d8af-08d9301a094a
X-MS-TrafficTypeDiagnostic: AM0PR10MB1873:
X-Microsoft-Antispam-PRVS: <AM0PR10MB1873AE24679340F7C5C0FFB393309@AM0PR10MB1873.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lHFxhAoDeZ7UwHBdn/3+B4qbI/c/aGu2VkEZ7DP7+HpjNHysGpMS0XC1f+IySJcpd95+XZ4xG0qX/XTucjgUGfxojGp3ANpsIRUlYpTlSQEwH+4hiKti1gthlc7mTk+AdnRAgkpXEjQlMZgc1zJHloNmnuB6+D0pHUv9xrLNUqKTixnTTMnIrGI9DGlSKbljWpL/Xz2vTdVNZl41TvJooSPNCC6FYsKC8euy1AaZ1EfB0PbYpVnQoc7ez/Ag/T7EBXygW6mCLLxa08mmU9XRo62+Ox/24G1AJ4RCzuYZM25ZpLLUUiemYIlW28eut8AjmeXNO+8RrLmnhHJhA4vcUcoN65Kjb7DJf1y4wOV0OSBLXd0vR7bHJKM23WgaZ8V0EGwVWRfJm4XHjM79n3w/MqEGo9uu9MlBSVIFdMZz8IQyTCoGdK/U5ZzSQjqT9u8+JfdjA7FMrtzvlBH0FwAreQgMYIoXhCMfEqN0eAAgjRFTUbuQKPKOxzGdHgVW7pQnKNoct6OwKJqv68rn0vOr4k1W4eu09Rt9GTuw1xTYJUMf77UqpBv9cM81QE4BiAj+m46fkdZQsTfqeJLfXtaL/DEBASHDEwJMYRgdPCUSVr/163P+U70bYDMLXg1U+0kHfY8iNdIk+K2mQZZucABXzdubs7xfMJhxxpQ76P0j0eKRySSXOvwbSLqgvar2oh6mBbJqQrYMCz5bDJSk9N/Dwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39840400004)(376002)(396003)(366004)(346002)(136003)(2906002)(478600001)(38100700002)(6486002)(38350700002)(52116002)(26005)(86362001)(54906003)(8676002)(36756003)(66556008)(956004)(83380400001)(31696002)(6916009)(66946007)(2616005)(66476007)(186003)(316002)(4326008)(8976002)(16576012)(8936002)(5660300002)(31686004)(44832011)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?xB+jA6W6GYHCnkkPcDVP7BW9ddzxFtKV8GEtZK4Il7P+L0m6ZBQHM4QZ?=
 =?Windows-1252?Q?+RRmpGmGQc63uAs1UM42XRB1t+8QUkoNDjROLA27muIWRBO+aL5Rj2e6?=
 =?Windows-1252?Q?FNqccYGJMRN/HJqWwlhnbyRpNG1spsoMFzJB9+0ggDJxc1RDV9Ymx6xs?=
 =?Windows-1252?Q?9rYU0K6vt2ucPBeZPKp47iAA7TnreDjO45zarxyWx8FVRdtzPbgB+N4V?=
 =?Windows-1252?Q?zrexaMkzgjvy/hyMVuZiXL2lf6v9EpEWfYKY8HM9qdeqme36VF4S7bfk?=
 =?Windows-1252?Q?TxvgUvFNOaNBH5AKMOvayc3CiiTPP9Q6+0bbxsBCNw+tHTt7t+1jp4J8?=
 =?Windows-1252?Q?KfVFHskZDB2Z/AM6zuKDX2WaXbEXNbCdzsb4vRT7MU95eUmmOjJ/QXBO?=
 =?Windows-1252?Q?o2Hym1x0buox3ciLM5/+MZ/yye3ucGu19xFg2TOU1mt7fJ2+VlnSC01I?=
 =?Windows-1252?Q?0H0l4dVlqEth5n2G3g0QGnDd9rvRLQX0qBPWq5bMyTl80I6Kv/UCMWRC?=
 =?Windows-1252?Q?7CHwPv3lDagH2S38aKg6jaEGTltquKeBdilae42GJDAMfUyLtDIunKOU?=
 =?Windows-1252?Q?OqW/0nRvZoKzZ33bLkzxKjqTUkJMEhhG+jvDy0AhZV2h9dLy4ZBiBaaN?=
 =?Windows-1252?Q?mlXBDK5wcRqeo2Y/qba1rSBBDAurZaUldTvKdronciL3Uoj1OhUyL2KK?=
 =?Windows-1252?Q?v7lmrDigf9k9Az6Fnc7zxbr4/w+ZtOZQhDboM0F2bZcsAHPAxEroQT5E?=
 =?Windows-1252?Q?euhxVZPgR0D91z5x/9gKKki0LKcZQ5dapXYYUWx+zuIZoyCU9rUq8vkC?=
 =?Windows-1252?Q?8b3ZrnGK6Cyc0iMyMeN8r6AlnfsViaX3xbSyDzEf0B2IGeM2F79Fc7AZ?=
 =?Windows-1252?Q?BT5e+tnQTeriq002df1OTZNCIGSKxiszqrlLF8DS+/HBphb9XuS9p5v9?=
 =?Windows-1252?Q?rfLSqMCAmM1nEBVJVrQP2kqGn81bx/r0bQhi9MceYVmDrTLcIItCI4Py?=
 =?Windows-1252?Q?m1w4HhVwC3v6FfFNM9rAZc+UQeAQNi5YtNq3mvsMv5KcQpZ0FUv/rK7j?=
 =?Windows-1252?Q?kSrI/LvIIIg7YJRBfwchRPUiJwJtz+1Qa5ifSnPR/UDMY8NrQReMGHRq?=
 =?Windows-1252?Q?lWGf+PoY0IxFc78O9R56XJnWlP6p7GxGUvf0o3j/nJXqHtUH6MHFDE6V?=
 =?Windows-1252?Q?QWSWVQMM+RuJO3yK0099tqGMhkPW2pJAUJT3vcssW3K2ndjN5ON8PJkY?=
 =?Windows-1252?Q?QzX9dOVpdvChohaaqEJ/ZYEWKnXUsIC7CaWCWCA7HoS3TPkWDectLMRe?=
 =?Windows-1252?Q?rnEtAnyqSNpHT0gp3c2SBEauf/d2CYRjXbnnB08CWrk7ACK3/l/TdKNe?=
 =?Windows-1252?Q?Lk5BFqN2gc/0I0PO4ve3hsHhn5nYcdQJOtCodHyWsZXUkwYMz7yidCTk?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a1ae6a-3d72-4499-d8af-08d9301a094a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 16:24:23.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fICpZ8x/ZoyBAwk1wR7CxqsDlsiw3pIKTNrjEzcG3iRVl3wBsienQQ5mjGQ7vDO6PxtwyDX/XHrlyA08B/ow2LUVhFlV5L12/fxG9jJlw9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1873
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 15/06/2021 17.57, Rasmus Villemoes wrote:
> On 15/06/2021 17.33, Steven Rostedt wrote:
>> On Tue, 15 Jun 2021 14:35:27 +0200
>> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
>>
>>> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
>>> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
>>> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
>>> that option exists but cannot be selected).
>>
>> I'm curious if it will also trigger on vanilla v5.10.42 but add to the
>> kernel command line: threadirqs
>>
>> Make sure you have CONFIG_IRQ_FORCED_THREADING set too.
>>
>> Because it appears to be an issue with that being called by the generic
>> threaded irq infrastructure, which PREEMPT_RT enables automatically.
> 
> It doesn't:
> 
> ~ # uname -r
> 5.10.42-00001-g10216cf63a12
> ~ # grep -ow threadirqs /proc/cmdline
> threadirqs
> ~ # zcat /proc/config.gz | grep FORCED_THREADING
> CONFIG_IRQ_FORCED_THREADING=y
> ~ # dmesg | grep WARNING
> ~ #

And as an extra data point, it also doesn't trigger on 5.10.41-rt42
configured without PREEMPT_RT but with threadirqs on the command line.

Rasmus
