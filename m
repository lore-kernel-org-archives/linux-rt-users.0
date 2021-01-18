Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C669BC433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 941E022BE9
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 16:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406180AbhARQLo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 18 Jan 2021 11:11:44 -0500
Received: from mail-eopbgr10068.outbound.protection.outlook.com ([40.107.1.68]:34667
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406500AbhARQLJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 18 Jan 2021 11:11:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgR/DH7r5/6GOpvl6jOcadBK09O6SsbC0xdMaA8ft5QjqaTzCXW6kfQiNI1v4ft5/plvb81f2uE60IEe5XZFgHMNC3OZ7z9RZw7ArtymCXk50e+W+Bfxr88TFdb9EnkaQLiiXSXm5mCcrULvfgLR1dJZG+cMQokQi7KrJUCCYx2VGmCxvvDxC1A+5C0sT699p8KXvsmH5DfhsZcZ8FJn+pABnhOdk1jDNX/H7B+d9tkrNMabU6EwiHyOYWL1Xia5tFpuMQtt+Mef2TTse5xgWhSRSTX2CPzAwNWUqmHblTTiXvzKsRSAT/AiMnTbTytSJpRkATXY02iknXPfTZn4Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/OF25DlK2WQiEcgL48GcRPaD2xDWoEODKxQOC72lRc=;
 b=ORM39hT8InxMQia24HN6culzS5+9uhJmprcg2LdEB9bEyMJkf1BzkKyzyVqjub4qqh2r48VcpcLsYU0D7aien9CdhypmJVc2ImpTn3chvcTlEz0y945LIt1ALCqD7nVwbjKNNoA4Y3AwOUxt5su9Oi4xZXDWBBmeOo2mj0a7dJbNQr7K4PFf57P/MNgBQBwEjGNFxrE/R2c9y+r2OIRPk9r5LfUPyHKfA3TLX9+/5xi5Qeg8/GQIBHQ5ryhNwfIE9CBQv1OnbBU5kwKc3ySGRWxIeMw5+0covksLkPxysblnzZ1T6gGZbI8OUYdpwvmLuh+XZJrSQvwtJfuPcqzO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/OF25DlK2WQiEcgL48GcRPaD2xDWoEODKxQOC72lRc=;
 b=cUA7aA3MV8tMJFqGv/XAMEKLEiOv6nTRDH4h7KHGD072vzKwInqeb1h8N9OiVL1VSn6xXmfG94tqP/ImGTvQ4xeLEpk/A6gjRrFxe6UaV4znXt8VLqYAXldHHULUpIeCJLD/3DgIxflP5P3QhEjT91gDYL1veLgfwIErCCXz+l8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=oss.nxp.com;
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10) by VI1PR04MB4157.eurprd04.prod.outlook.com
 (2603:10a6:803:46::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Mon, 18 Jan
 2021 16:10:18 +0000
Received: from VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::dd31:2096:170b:c947]) by VI1PR0401MB2671.eurprd04.prod.outlook.com
 ([fe80::dd31:2096:170b:c947%5]) with mapi id 15.20.3763.014; Mon, 18 Jan 2021
 16:10:18 +0000
Message-ID: <e4c83482f22059647c546f202470d05e142134bc.camel@oss.nxp.com>
Subject: timerfd performances
From:   Sebastien Laveze <sebastien.laveze@oss.nxp.com>
To:     linux-rt-users@vger.kernel.org
Date:   Mon, 18 Jan 2021 17:10:15 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.102.252.120]
X-ClientProxiedBy: AM0PR03CA0033.eurprd03.prod.outlook.com
 (2603:10a6:208:14::46) To VI1PR0401MB2671.eurprd04.prod.outlook.com
 (2603:10a6:800:55::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxl65009.wbi.nxp.com (84.102.252.120) by AM0PR03CA0033.eurprd03.prod.outlook.com (2603:10a6:208:14::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.11 via Frontend Transport; Mon, 18 Jan 2021 16:10:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f9963713-b2a5-4c4b-0ef4-08d8bbcb8c5f
X-MS-TrafficTypeDiagnostic: VI1PR04MB4157:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4157FC924391986DFE9B14AACDA40@VI1PR04MB4157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: myGXvIm3p+YhN+ZxxoGbiAU9xNDNXQRai5k3jRXRcisAaGKaIHg9m95CEUe93/Msg80XPNP8td28VV0MYvk91DTHJ3LR0R5KRnqdxKwpMV8sU2KMgnIrJJVl0uC4wSG7uLuhUNjvXhvWLkpWXLbc5Btpbo6zVHYq3YWx2EKLxxKr1/CJq2YkThciMLh24eEAfNzUc6JPCXfC9ghhbR6sNgHoHb2hWQWtJXbI5QMOg0whrEN0Asp0dq4xcgHKmzwmZvzlQjM/yF5Pl28c2InRz5zOBT0kYzeyDZou+7ArPoQIOnYZiouBgNr8S+jRnXRVBrxfBjZLeTmNjnvq0E2IGsHDL1uOG/0xsYvgQfvH26+v6Pfbh0ng/+hisNLCMbZkT/D+kq62dPnYQoyz0dqmjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2671.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(366004)(376002)(396003)(346002)(52116002)(2906002)(6506007)(66946007)(5660300002)(478600001)(6916009)(8936002)(44832011)(66556008)(66476007)(8676002)(86362001)(3480700007)(6512007)(83380400001)(26005)(186003)(956004)(16526019)(7116003)(2616005)(6486002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGdZcHZuMGltbG5nOFN2Q29mTUZaa0FSdU45RGZ1VkdvbjBpQk1BUmsrQ2Yx?=
 =?utf-8?B?OGd3MnAzRHFKM204bFQ1bmU2Z3NDZURabWlyVnJFUERFK1o1d0grL2JobkRE?=
 =?utf-8?B?Z3Z0Wjc5eTlCa3R5L1htcnZGOEM0M1dYRWl3RjBLSjkvbzdqQ0VlSzVBVDhp?=
 =?utf-8?B?TXc1ZEVqNXpmTG5mb3FrdnN4THJlRG1vVEhSMnhFM0o3RGtheXFYMnVUM2JU?=
 =?utf-8?B?ejhOR3h3TDl6TzNOT3lPb0NZeFpQOWI2RFRIRFNGa0l6L3pJZVl5UE9tV2tG?=
 =?utf-8?B?RjBvT0Evd1N2cUk2U00wcDVoWVdaZWJjeCtHclNuZi82NUM3bUEyQjZQUGlW?=
 =?utf-8?B?N2RKMmw3UU56M2ROS1ZaYUJ6SEx0VkpLV3FVaXdLWWphZURnb1dBM2c4eUIx?=
 =?utf-8?B?clJqMzk2bDJhRnZUc1JGeUNCcVZXcEVhMVFmZTZoa0Y1MFF3d3kvZ3VBM3Ro?=
 =?utf-8?B?ZG1vSEo1KzlJbWdhelVHM1pSdTZVUE9KenVjWlZvaXRZeU9QTUdURTFZSjVy?=
 =?utf-8?B?KzFWcHRKOS9vQVJhU1lEVy9sYVk0QldNbVNPVmkxSEd2dzlmY1hwTC84aUNw?=
 =?utf-8?B?QjA3TVVWU09qK0ZMTG1vSGY4THliOVpXdHk4Umg2UVFCL3N5RjYySzZidGVs?=
 =?utf-8?B?Y3pVQVlNNnd0ZXg2YVNhbUI0MjZQK3VMOUR6TlV6MnlWNUpjaXY2Zlc2L0Nz?=
 =?utf-8?B?bC95alB5ZCtGZ3lPTjJmSE5qS3hFUlNJUTdlSGJ3ZVFOSTJiYytBN0VjS3E5?=
 =?utf-8?B?Q2YzSGNYS1VxT25BeXJKZk5Oays4VkNSRnJYOWVtY2tjSStCa3lWTkMxYWJX?=
 =?utf-8?B?WHhJaWErTHZGQWhSMEJweXJmS2VMMDJ0QnpmNUdjVFJRbTBsZFppVHd0MURh?=
 =?utf-8?B?UTlWMU8wcEpnbGc5VnpnSXpDcTlGMnN1b1VpWGc4WkROb2p4eVhhajh0MlVG?=
 =?utf-8?B?dEQwY2lNaUE5STgrS2Q5SkJJM2s3ejBKd3dhZitTaDJOeGUzNVhpSUpRakds?=
 =?utf-8?B?b1l2RWxlRXljVE5sT3JZaFhJYWJVdWlOTVB1SVdXMHV2YVlvZVZmb1NaeFdL?=
 =?utf-8?B?eWpBL2VNN3FpZHVMVVFYVmNQMDZEMlVjTmJzMDlkYStHajhNc3dKVmNSQTVV?=
 =?utf-8?B?VDhHM0RCOWIvN0V2YXJLcEtRQ3VGZUFJYjY4OUJFRnk3S2dxdzU3MkFROENG?=
 =?utf-8?B?S0tsTUNsNm0xSjJSOVdZWlFTOWMwd1dWVXpLY2g4eThOb3hPTzZ1WGdPK2Zu?=
 =?utf-8?B?RWZaRnJiS3BjWGN6Qmc0aDNiTFRLN0RSL0pnVmszclc0Y0pMRUd0Yit3TFZH?=
 =?utf-8?Q?tZCZloeleJn3pZpJRCuY6SCWKeGXMkvTPz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9963713-b2a5-4c4b-0ef4-08d8bbcb8c5f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2671.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 16:10:18.3978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIMxEeKG6Q+NYM5f4rhmIW5sqgLORWPnwxjGJjhmAT0uhWOcF94g04vD7zV4lru9BUhrodVQoLdttNL4Q7+zM1E4FbXA0q5XvM+/hEaegd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4157
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Since the removal of ktimersoftd which happened in 6f6ba7715a91
("softirq: rework"), I wonder what is the best approach when using
timer APIs relying on softirqs for wake-up.

My application polls on a timerfd, and I used to have good and stable
performance (< 100us) by setting a high priority to the appropriate
ktimersoftd. Now that the timer handling is handled in the unique
ksoftirqd I'm having increased latencies since (per my understanding)
the ksoftirqd is handling other things (in my use case, networking).

When I say increased latencies, with sufficient load (~450K fps UDP
traffic) it can be over a millisecond... And yet, I haven't added other
load handled in ksoftd like tasklets or IOs.

I tried raising the ksoftd prio over threaded interrupts, that helps a
bit but latencies are still high and setting ksoftd to a realtime
priority doesn't seem a viable option anyway.

I guess some tuning could also be done such as tuning the NAPI budget
but this doesn't seem very robust nor generic.

In the end, it seems my most viable option at the moment is to move to
clock_nanosleep() but it implies radical changes in my application
architecture as it's not as scalable and flexible as timerfd.

Any hints on how to "secure" the wake-up latency of timer fds or what
is expected in future works would be greatly appreciated !

Thanks,
Seb

