Return-Path: <SRS0=B5od=6O=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3393AC47247
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 180AC2073E
	for <linux-rt-users@archiver.kernel.org>; Thu, 30 Apr 2020 18:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="i9YmpfFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgD3StD (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 30 Apr 2020 14:49:03 -0400
Received: from mail-eopbgr10134.outbound.protection.outlook.com ([40.107.1.134]:4566
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726272AbgD3StD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 30 Apr 2020 14:49:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ez/T0vhtPfsaw10xv4QIqncCQeeM2Y8QqkwTmJg7V4rFlxkeTsGsD2BMo0XMwPYotULj8LvrK5Z5vUNA8uKk+Ogwgy793ZK4NsnsXczKd/AHbRBijo5kzQxkAjxkyyIX12D4AxdfuopSkqy7Hwiu7awxuwRVTPQofktdRIX+Fd6sPtRJ79xuXVkAq3BA2jGyLZW7MaVRFt5LrBJKmpw9qg8JgIRzJDHRSmEgdNIvdcH/7IUeBeTZ+//jf38ufD4U7E+a2Vd1Wz3z61502YHHKOLuYSB1yqoFZb7FvvbpHfbkwD4Ojz2PdvGsnO4fq+kJ1No7fPNTRzusxwoE23saOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heD7Q/39SovXsTwxx5rcOqtx6qY+k2DBoHbDQLkuD+A=;
 b=AKEDTT/E0RfiZIEo1LXaZetqBIQDafCsV7zWXz5SoK7UF6H17dX4xpWa1D+UjTGhhlInHUYB4ou50P8SqSXgX++BxqONkXD8Dtim5ajPjTk53g8dQhQsxtdhpu2bgnlXN1BID6ZM3kb6VxLaTnMTuKfxD5IamF3ukfb2SHsjy1y1DAXxb3p7MPreTbh9IF2VbPuP3DLndSICJSenYblqsN5jC3wspPP6WMOg5ZkQ7HfWsblzY9xYi3YYEQqBFaDZ7uL9qJgoixq06yPkdBM0eVhWEGSDzDcT+BKPRtR8wo4iH3wP4FpJ/dtdZhmcnMSjThGZ/hBA0hl+QJvJSNVGcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=heD7Q/39SovXsTwxx5rcOqtx6qY+k2DBoHbDQLkuD+A=;
 b=i9YmpfFXGMSqo2ICxBGCgeAhHp74jTy0u5ua0dCwea7uVjEtlujr5qRt9TEOwYlUDGvDq38EJs89RIKi2BUGLtDv0tktWlHLH7J+kpjnZc17KqB0SvzH0Kfng8l1agDNOx6HhvaSNOzulL/smQK9pbdn9FaMHZIrM1QMxC0a4BI=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=prevas.dk;
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2079.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:39::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 18:48:59 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 18:48:59 +0000
Subject: Re: [PATCH RT 0/2] Linux v4.19.115-rt50-rc1
To:     zanussi@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>
References: <cover.1588103561.git.zanussi@kernel.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <d1aa0d63-d816-7945-e32c-bd1883489fdd@prevas.dk>
Date:   Thu, 30 Apr 2020 20:48:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <cover.1588103561.git.zanussi@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P193CA0116.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:85::21) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM6P193CA0116.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 18:48:58 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c49f5e1-05b4-464c-81db-08d7ed37247d
X-MS-TrafficTypeDiagnostic: VI1PR10MB2079:
X-Microsoft-Antispam-PRVS: <VI1PR10MB2079AAEA0D5AF993438140E993AA0@VI1PR10MB2079.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24WOwg7zwla+qgIhtBN0FH5ShvjzWqWcnlY+GNUrV01V4na/GNwEuMKfeZRUBA0B1X16LL+jXSpGPF5OT/frSGGBYiDJy/Yz+nRIDIupFBLaDUjD907j8HLDdE5F72sf0uSCQX3r5YIuU+zBfncftVnhJZTzyBXYHWCvbMISmcRk+Tl49vT/B/Lrvpp2M+ou+6T78zwqAEMsKnz/7eKft5lMD7IAo0DWzIwmeMa7pSWaYiWqBsvyZYS0ogHwpyh2vXa9zOY6NIgy/Yyd27VWcqefE8R/mrMv5x4vPIHODWUS2AHkejinQs4MC2OVctgWATH6fjtRYvHYwxE3rR1puiNzNky3K24g/PCgVfPCyjAUWUcA0BG+6F9DunCEx5f4NUPRCDZK88P+A5aK5hb1zVQzOcOUVvl789uLJfWAi1vpYQmFzfB9X1az9Zdchxc6dSYF2dTtHkktPUI0mql+MilWRTjTaknjG/fCwMHoCtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(39850400004)(136003)(376002)(346002)(6486002)(8976002)(16526019)(26005)(5660300002)(8936002)(52116002)(31686004)(4744005)(44832011)(2616005)(956004)(2906002)(36756003)(316002)(186003)(86362001)(110136005)(66556008)(66476007)(66946007)(8676002)(31696002)(7416002)(16576012)(478600001)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: QJtE4iAV8/ZkX26GOPAdBI/o0bdheqqd8I4HHyE4EPKkr6MVtBDLZqaUaXGocDfskNc/j9SgCXU7h1obvxSnekRDSNReTLuDEeVcRKhcxTsaiSCmwZhGQjbix+4nKltdL1ryerpSYHBFNGuJnkVwWMejMr+2F/KbxQRoMgCBOQsKihxNISDJso5gTFjw5znTpr2ihdfQaEUFqWup3y2fRf3P6edjHh8Qi7+YH20iKLQQ8W6qJ1dz5JsBX0yN6vkoya96k7UAylhzCqGfCzUsPG43PMaIPmxnuXM9+nZFNJiPUASJbXLiHdVJORXXt+8NOAyKJ1Ha2LqxwBlhT/MP05slu77rU2AKteO+BSbNlvCwuvcjWO0A3LJHxtboC0+oDof7E1kQx0kzeDwnlrwi1M7Z5u+FEE3McVU8fps8JNpljMcuzIMeU9WFqtJgztl9WtbUcOa6sZe24aBBuT8XNWmFyRP3vinhbxmdxXAqUpXISVsUhrDyl6mTmNNKsG/OdkVJt2LTasSxR6qZPGKitArnUGMdQj11+6BgJB3tjZedRXZ+ysSU4/bLrBdrGym5eKbtro0l4dsU1xY91+PlhGFlDblKaRBfezEURKCG2i30a259+IsMf/gI08ewJLPao48FhAUq8zV0CoGVxVga2TNrmofdiMD2E847j/zutvxuNSckac4RNxZbG7TwCRCWG5F1cKZe9VesHp5rqTmrLY2Qea+WxhQEEMw7UbG8UTDSLU251x/Yrgh4Lk5S+RIzs+M4fBgYcL+BDPa/JDi0SbSSWAWMBnF08SIN3G71XFo=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49f5e1-05b4-464c-81db-08d7ed37247d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 18:48:59.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YurIrTNmSw2nvO8ZPuVn5ASo1tQEvJ59lDxM25Caje5QhUyvKpcmBtfR+wwylNGqlSszHOXN801hyr2xWWUmccMSHohUJcGQpAFjQ6voThw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2079
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 28/04/2020 21.52, zanussi@kernel.org wrote:
> From: Tom Zanussi <zanussi@kernel.org>
> 
> Dear RT Folks,
> 
> This is the RT stable review cycle of patch 4.19.115-rt50-rc1.
> 
> Please scream at me if I messed something up. Please test the patches
> too.

For good measure, the customer reports that 4.19.115-rt50-rc1 indeed
seems to fix the boot hang they saw.

Thanks,
Rasmus
