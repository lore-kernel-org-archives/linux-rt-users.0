Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3215EC48BE8
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 15:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AD8F61480
	for <linux-rt-users@archiver.kernel.org>; Tue, 15 Jun 2021 15:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhFOQAr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 12:00:47 -0400
Received: from mail-db8eur05on2110.outbound.protection.outlook.com ([40.107.20.110]:12721
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233087AbhFOP7f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 15 Jun 2021 11:59:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hC8jndffnywZbm5NMh4di7q38Sln0XtV0+yhMV5RsbfBW+K0KsIQxR8HgAViCZLqa+OrQCpJz3Jj5cIIKlHJyN5TmMFvEekI/W1y/DlOZS46qIPthRAuA0gpnvxwz7McZX1EPKah8KJEfcs3D/BXABTh/+Ax5RSoixxuOGtoAjK9TsHWc9UemS2YHhaqRGg7GJEIIIEM9SejWsWcq437ZRoAhXyZWM3dQ/lwH/cVXWl1sVlUVVfysDpoNkmQCbIVujyeIO2p83forT6GnRin0BzqpYN+dP7V9sNyNp07PmBJtl1CnF9GOGvPzY2Ne+jFtTrIig/bieL5tGRAnq47ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfay+TNeG+a9XjzNHaZWhCtkVbZbIG/AzHYSwqodI+Q=;
 b=DQoJi1vIS6c6R7uvweUINUeATMyydmwcbmoMLruxPJdY4SJESRTN6rxn7S089z7kUCkfhYrrYV2oxAafU84DpGQ7SFLxu1+JnDzY8Lf7qUvR3zrcesj3JbeA3C1RDx7Ek05hMwjPCoXNE/r2ow/cyqEVKBiGMURxIXJeGzXVGu5dZ5yZ9n+4qebR6DPj+mqox2S9O7jeyxFgQC5VW5yb+O8XO+RPLg3QQlTP+vaw9nGQtg0SBWe2oidpdG/FJa1djpOR0Aw4nlromkQMDR5PxUEa1FKTfTecBeQtNp5zMTxkEZ1ZPdTLQLhEuIkBVsSWcQziqVvKYik1agevwtWiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfay+TNeG+a9XjzNHaZWhCtkVbZbIG/AzHYSwqodI+Q=;
 b=fMqwDGVvu34GW82ubBsaFVUXlv9zxohhV7lTLSI0vN/5bTPSRUSxGWN1ZNnWzrnUFwP/Tnev9Lzm5KRKk8l2J0oIh/gzFfCPa2W5IlBqmB2iq347trtgHIoxxm5C8ynNJZxJ5e4gIcHMZnZv5BsDKcy1c7lZQglo6pTqWcvlR0Q=
Authentication-Results: geanix.com; dkim=none (message not signed)
 header.d=none;geanix.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4199.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Tue, 15 Jun
 2021 15:57:29 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::888d:190b:b3b5:1ad2%3]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 15:57:29 +0000
Subject: Re: commit 3d5bfbd97163 versus -rt
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Song Hui <hui.song_1@nxp.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Esben Haabendal <esben@geanix.com>
References: <5afbc89e-dbc4-3f47-4e61-63a77165aaec@prevas.dk>
 <20210615113312.0dad32bb@oasis.local.home>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b66ff695-7f75-2a70-7feb-0df4f5ea0608@prevas.dk>
Date:   Tue, 15 Jun 2021 17:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210615113312.0dad32bb@oasis.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: HE1PR05CA0259.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::11) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.20.67] (81.216.59.226) by HE1PR05CA0259.eurprd05.prod.outlook.com (2603:10a6:3:fc::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend Transport; Tue, 15 Jun 2021 15:57:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c794757-d847-4113-89f8-08d930164705
X-MS-TrafficTypeDiagnostic: AM9PR10MB4199:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4199FDDA5FCC7C0CE5F2FDE493309@AM9PR10MB4199.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGKU7B33HJ31IYQzzwyFG0raI0kGXhc/T8uFU2PnCL+uc1sLOfzdi0q8i+AeIGhOlvLB3xV5VXFE45mRmv5WKXeH+h09x2mFRjK1IpVzP+weKayoRTNsoq5NOvRfc3IF/KyQ1Lr7g8b/eO6hRFGd0zL8iy+dum6Y6DHvHxC0RwjO4sOEmfpkqjgSGVmdgchA32NJVk/jxF8EJRTB/Hwc5c24xXzXF22IkmOZnlE16IU2eiYk6Uk1bn9ctgNVQ9I6puw+r6YVKRjtQ8xhdVLCA03222NwDf3+5dKaZ4AGUD0VdHyIMQgxrbMU85J+npt9HwexRv3kbzh/Ax81AvgsGj49BhWgw+aKJj5Py6/qF8HY6QzHo0IaKStkcM/xT1qJmgD4mDXSwceR2K314k6yf5q5+L2IJgmA5EjvEPStmJg6KaS3ZhbKnM98AuomHguh6BR8hfJd6JeS1RfrlEwNfBJRHs6SSbYktGKEpZa2f+Vbl2FzyC0CGnvRLlnCuimY+8hbX9Lpp/xmo3vULhENIb85HCActgJqd5Cij8KVGw1P1B/ctLwd6juFO0qhwRqxznQvdMqH6WuJQ+jUQz7w/6WL1N+GIPUs2V5mZKapg60tnk62/GHfkdgDZOA8EBU9/PAasTZSAyDMlKPJbRkVVR/3ZaO02S1WnSJ8I4VHdazqjnUrrfMlaE+HKE3uyQ4YV+i5qdSNdO5NtMpHHQBIGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(39840400004)(346002)(136003)(376002)(396003)(6916009)(8676002)(2906002)(16526019)(2616005)(8976002)(186003)(83380400001)(31696002)(8936002)(38100700002)(478600001)(86362001)(38350700002)(31686004)(6486002)(5660300002)(26005)(44832011)(316002)(66946007)(66476007)(36756003)(4326008)(54906003)(16576012)(52116002)(956004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?Windows-1252?Q?Zv4YVvWutOZ0kWAiXfy4Ud5C+M4i9okc5YpHTZftur01adb5ExmECJfO?=
 =?Windows-1252?Q?R5uWAn+GEryC7WTjHbGEPw3t8ZmVv0GAVbLBusPiSKh8HjHfc+yfkK2y?=
 =?Windows-1252?Q?DuWxhlk10ZuGUyAj2utcIORLvQc5cX30SXWZUUDnbm1hRDT/5Jp1YhoX?=
 =?Windows-1252?Q?0JYQIDlo38P3tDkjVREP0XBnuuy6l1EYJqEDlioc1j1GElZoDDmuSz7S?=
 =?Windows-1252?Q?gURZlndVlt1VJRM1OOs954cbsIpOLvBeP6BiEgmmp5wcKLG62jvZP7gi?=
 =?Windows-1252?Q?rQchz4Ss8f+UoHf15wG6bqOBmOVQKj2vLoPTRx4Qyl5Gu4fGRrZO/RJ2?=
 =?Windows-1252?Q?e/CqgYnuL3epDQd54ezIfxNS/jYU+qKdKgXAal5lYr1YaXYcSMp2ZEwl?=
 =?Windows-1252?Q?PAOAwnuF9f0AO36qzfwTcpLGMl9EhAzVbufKwyQ72L3BCqmoVGfk6FiB?=
 =?Windows-1252?Q?hAgRr3E6hF8CcdTWx81UiNl5y4iPiVeeoOCOKr1dgehx8jt4kdN0bFuX?=
 =?Windows-1252?Q?HaxHFIWj04bjg3MYgNPtTLxg1HWbS6Ui7o3/nRJ3u1pdGDRMsCLGubVd?=
 =?Windows-1252?Q?VXcderGlyEjMGNADdsFUs6NKCj6J1VW4XBEiNz7GgtmmYf8ppiR2kWwf?=
 =?Windows-1252?Q?o0qt2vZiIIpxtTBJd9oPvfqhw7De10U7EC0xN+rfnFGuWVBP0WjUhXM2?=
 =?Windows-1252?Q?2qsN1tUNrWAzvX/Wat7Pu3V0vCvTLq48k5ml3zY+eRKYaBmA6XxCeZ8s?=
 =?Windows-1252?Q?h/wYKp9uGIwi6pXXcbsSknPl9R39MBzlhxUIjuaLuwTthX/+N7lhrQcG?=
 =?Windows-1252?Q?lCePGyeyIiDX7tpkB8VRMfoTwEa+l7kieU+UbQbFADH9McGdA/MhdUat?=
 =?Windows-1252?Q?iGfqT57+WDJf0tcSTwpGOCMoi6JJYxGrxNfWmV4FDeBlpYFgwAglIgJX?=
 =?Windows-1252?Q?SdKCFI7Oa5uQLWmx6getGSYNHeGrnAQbpI6p4bG+dGLKqS4iRLTZ8IXp?=
 =?Windows-1252?Q?2w7M7JgySL/NwwcvFjwWlM7tUrmdj23vaYYm9YiKDTQhLREHj5nijqeV?=
 =?Windows-1252?Q?0l5YbH0jzr7j1rPPP1QmZSE7RKdv0wVTrUOHem09EyVPgf7cBCRoIbjj?=
 =?Windows-1252?Q?zl445ZWIr8JGH6OGolUC4xbiKoSBQdQMpZNWCKPpP3ng0/3yNZUKbDPL?=
 =?Windows-1252?Q?ClLHnr2EssZrHV50+DQQq25cro4RFkTqnVT2NWwX+58Xl/FBzEsq18mM?=
 =?Windows-1252?Q?82eaZ1vB3QR0jMdsG8M31RwDQUboSsW5eipJIu1x70lX7FXnXlKhYwPE?=
 =?Windows-1252?Q?ZeL+B5Z+xkyEFmpd+F+wFHZLnMZYNTH2y82JAbNYlS92GXBZz3tiT63Q?=
 =?Windows-1252?Q?doSBE5AvLTnmfY38wavFXIwNbNW4dZc5tKIj2UWzKPUmHfjLRm6CI69H?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c794757-d847-4113-89f8-08d930164705
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 15:57:29.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8bd3UgLnG6s4a4q3imx8Yu4TcOBcwc4CWwuMUAl8NnT6DDGChRoxMsgem7AEQRd2MNwGxJ/c+kf1x8N2k+EzMa6Hr4y8ZE3Gs93o35YJJAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4199
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 15/06/2021 17.33, Steven Rostedt wrote:
> On Tue, 15 Jun 2021 14:35:27 +0200
> Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:
> 
>> Reverting commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5 (gpio:
>> mpc8xxx: change the gpio interrupt flags.) makes it go away, as does
>> disabling CONFIG_PREEMPT_RT or simply booting a vanilla v5.10.42 (where
>> that option exists but cannot be selected).
> 
> I'm curious if it will also trigger on vanilla v5.10.42 but add to the
> kernel command line: threadirqs
> 
> Make sure you have CONFIG_IRQ_FORCED_THREADING set too.
> 
> Because it appears to be an issue with that being called by the generic
> threaded irq infrastructure, which PREEMPT_RT enables automatically.

It doesn't:

~ # uname -r
5.10.42-00001-g10216cf63a12
~ # grep -ow threadirqs /proc/cmdline
threadirqs
~ # zcat /proc/config.gz | grep FORCED_THREADING
CONFIG_IRQ_FORCED_THREADING=y
~ # dmesg | grep WARNING
~ #

(the one patch on top of 5.10.42 is a fixup of ls1021a.dtsi that I
should get upstream some day, but not something that should affect this
issue in any way).

Thanks for the suggestion.

Rasmus
