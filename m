Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18AB4C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE69A61159
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbhHFIpf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:45:35 -0400
Received: from mail-eopbgr1410072.outbound.protection.outlook.com ([40.107.141.72]:39456
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235812AbhHFIpe (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 04:45:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mjsHp3Ayf5uA8BOPixre7wBZ0jmcz2XSYBWjcUpJmiv2QqnWEpbU/Bg0Unesb3/kznUIZLGVhaWz2Wr3QslrJDJwhsQ9UAz4Bv7Ta6TSy4p7q82ZbaWPV8XNwQPZvRh79x5hjSu0/eVoeLM0A2qKG/rl0buGMPvnxwSN+rFsshhh4L6hycDTlWwKJS2ZEysnMUMU6wzh6Jx1Tig1JP6GEUrN4PipjyuGjkyOXK9Yf8OKCbDArdS7BNQdoOknOPAc5mTddmXiYEpCaqsvTzI+nmQDejSpBFsn9BPpCBJ/bpMczzNZVXzZJTSPi7WW1ffVJLgD8mcNCyidnEPD9IZOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HriSOxV4yGvu4SvXA3wE7h3jP7cYXq88LYzcBIEt89c=;
 b=j4DR3NgZ2hnQo1dRg/EBwAvLgrd9MvDRcmYQQ0cW5qXCGviQNzfMT9bqf5T85nSZAuo6xOB7vGlpt1wcAASiUYRKKmEMzKAufkSegkO5vWB8bjf6/ZHAvpfCkSImoHAGkCUBc3FWe1x5OdJr948xNGBfQ8uX0jr/F2UhfZyE7/ayoNUwjdXreP8eGQNFpdPwq4L+lb/viQILNLVjWvv1LFEriRFaPyFmzevfsg2kUfzijo+ONzKuojgeG2V5ThuzEdHW/Xf1Nvm62SvCN3xmcIz9wMFrdb8oCAQDkCJvt1ME1bE/jBc2T5pONIPx+HbutGZQsJy3HD7Ecf+xTjuqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HriSOxV4yGvu4SvXA3wE7h3jP7cYXq88LYzcBIEt89c=;
 b=RF6FdiL9aZhjCMaZYJVS9YbRgHSrzMR1a+dmuDBsiWNzdhcDAq/WQeoB464Uusa8Suthv05mwcJRXk66l6avWNzpwPwvZVtzrpZAZF66+DvkbrZlYaeBww3OQgnqNrLGG30pcnZnHlrr997ZlYbbo6mkN8IUIPOjgiRDegHX2vM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB6292.jpnprd01.prod.outlook.com (2603:1096:604:f0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Fri, 6 Aug
 2021 08:45:17 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%5]) with mapi id 15.20.4373.026; Fri, 6 Aug 2021
 08:45:17 +0000
Date:   Fri, 06 Aug 2021 17:45:16 +0900 (JST)
Message-Id: <20210806.174516.443991381227116314.atsushi.nemoto@sord.co.jp>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix argument passing to
 Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <20210730.133508.2236677766467322522.atsushi.nemoto@sord.co.jp>
References: <20210729.092328.1410316616346703094.atsushi.nemoto@sord.co.jp>
        <f3f2dd4-733-2bcf-1c4a-5d7cfb2b6fbf@redhat.com>
        <20210730.133508.2236677766467322522.atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0059.jpnprd01.prod.outlook.com
 (2603:1096:403:a::29) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TYXPR01CA0059.jpnprd01.prod.outlook.com (2603:1096:403:a::29) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 08:45:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a85ecb3c-871f-42e6-3a28-08d958b683fa
X-MS-TrafficTypeDiagnostic: OS3PR01MB6292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OS3PR01MB629264CF87038DAB55E25EC8BBF39@OS3PR01MB6292.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3XUu7ZK3225iKYxVOZyuUp+9PdK9C8napiAcWozgKP5laksgtMuKbXXz1UuJjM1elOxcMzESYfFua3YQJVP2SahG9I7pI1fGauNUFTjH4sbOobuSSTTqPO3djKvTjDHzbmfu01v+wcMdMQ5qAKpahGrL0lAv7taHeizf5Ffs+qhPwxnI25jEBtzGnenZKM25sFCx0uGF631xqOrfwYClRz3og4bH93QwEi/KQEDO+iq0LaBAi+lu4vNmv6RyZT2wRSzKhyTOh52CDalytnrqRhjl8/MZ/tOhPl3HwVI2ppmXHYVEOsRdcogHaIMQneFMOxLHaW2C6OoUtlOlo0IOwtLdthi/6YqZ9vFhZ1CV1kGvoukPfLiskPni4mj3i8iLYXsURNE532vY6/RVZ+ZC3QpxnlR+eE20iYV+Kt8Umu4IDcNo+gET1Zkc5PgSQ0bMKfc+7At9ERpDR3pF/pP1qMCpClsZ2Zdx3mEtZm9evdZcXC3MAk5thxuZ2kjC1d39jjdSuwInOm023npdfL/cL40QRfUDAPbRscCTbjPFIzEegeR7FMPYA68QbpTZstyZ4neOH1sD8UsYuLElXrtZWG2dgWtc8r0vEffpVPX8nqlIlAVqbXfgb374h6m6LsTDQ2TPWHWAeWOrn12GSr7tJ0c/NPRhak04fE2QVOEjvp3n84RPkDSjNqWx+GsTlnuXFzu8ugxuixewEodigRaktg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(346002)(366004)(136003)(396003)(8936002)(103116003)(86362001)(316002)(8676002)(6916009)(478600001)(6486002)(956004)(26005)(4744005)(4326008)(2906002)(36756003)(6496006)(52116002)(2616005)(186003)(44832011)(5660300002)(66946007)(66556008)(66476007)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZNOdFWVtoikLv5yMX5R+M7eJwr3RB+o0l2FVS7cSxYTdcJz0Z+GtcbBAz4lN?=
 =?us-ascii?Q?MKCTVoud7pCMFTF6PLuDgRYz+nQ/h8CvWfkt8TaQNbquYmtX2wrUUz64JjMb?=
 =?us-ascii?Q?sI12Sh4oq5GXntMsEruMnLxd70iHLwf6xjpw2h6LDDpXjfqd+CEWQcxkZi+E?=
 =?us-ascii?Q?07qrczNBMQqB0uyrAatjYS09HJ+E1+qEIsiMNo9v4gJWrT/VCj4yGET/PXDV?=
 =?us-ascii?Q?9fr9JDlnF0f5ncXy38SjYJOAzHTqsGP50HIbHtXgPUWktMtbmIrwT4T1nIMQ?=
 =?us-ascii?Q?wp3ggxQ1QvvNl7R/P+VujuKxEGGVGr2V7PL/oLl9IX56qfboXFMPcp0EDTVL?=
 =?us-ascii?Q?C/8PYoo6nMpV/3d0v//+nL7pgqmdO5MJR6tODpwqk5giXwIpo/tR6Zi5sTNM?=
 =?us-ascii?Q?v9dqSbveJjOSo46REYuumB/xTcZpktVhc6MUSt5mKemP+dVsYa432qRUMAiC?=
 =?us-ascii?Q?NLYSAhqlj6zrIx7vfWca4vyYHMcPpc9ZSSKUAmOz/iTXw0lj4CWg32Iwoyh7?=
 =?us-ascii?Q?lepCBGnOdma0LkVKPXchyKNaP1UIjeOWpaxSrx5H5Xe6qdT4CWRNGmQjy1h6?=
 =?us-ascii?Q?TtBBq5VLMqv0MSOTuFth824fC7lwfgboMEh/G/+c732XfzMo0KUimk1MHygg?=
 =?us-ascii?Q?7XbIjG0ibv6DjQBd7fCfzc3L0cmrMMiJNtc6SdeJ90bcCg0xaDbNxIEyfDbH?=
 =?us-ascii?Q?X94fAZDkleqOuWh0pIZ0n5bxBLxWP4BhN3XdXEYAd2zIFt+dvPjnW9uQsjNN?=
 =?us-ascii?Q?lrZvO549x3yF9C07TKRTPwfAOV5R6HTuC2mSIaXQr8LAVZ0/YfPFUKtO+6XH?=
 =?us-ascii?Q?t9KlscTxtVJSw+X1lp3Tr4d/+8Z3fagfnFCYkeVW3z5KGpDd3+QASLGYG6We?=
 =?us-ascii?Q?XaD9OaTZFjiUNY40xP/gwYaSoXf2VnK9OofM2cObnnJv36Dm9Ayu+GUSzHNg?=
 =?us-ascii?Q?cH6D4VhOq3UNvl9ZTNiksrw5wDDfYLqMSdmRGetbLqEsX2cVui/DgidJijK+?=
 =?us-ascii?Q?QdXAaqr4Za/DT8J8io2ODYH+NTJCgkAEsxTVcZ9E9M2bEYxIDjyPaImVIGHW?=
 =?us-ascii?Q?ZGo5vfxO/Ayzmpg5icnDQs4ur4IwSLjAsUc1QBCo41jgmeWlrjukFD7FNNq1?=
 =?us-ascii?Q?2yz1Mw+CUSphnoIV8u2hSAmXGsagIGt8YmrLRXGYEmpB1cSQnMb6t4DKGYgt?=
 =?us-ascii?Q?kIJnDctzCVTHZEkJtmldNF8cNOh6AifMf2nyzFTFcacq5zEULRuZzUB+yWC3?=
 =?us-ascii?Q?/YXLAgyZrbTJ0JOGqm+5ppDHJTxveZN0quDJAoB2Fi49Y+5g4dyJLoZA54K9?=
 =?us-ascii?Q?tmame/NLXZRzHKHXWy4Mi0A+?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a85ecb3c-871f-42e6-3a28-08d958b683fa
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 08:45:17.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCpXDVnyQXds3/UY+X8iXTOY1S9En2TRTgkMIPPKMsQ4SlQ2Dp9CMhHuHOZhEiMZm6MkB+mRDl1zYin35ijoIOVyGlLziUQkUY+xZ9bwL4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6292
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 30 Jul 2021 13:35:08 +0900 (JST), Atsushi Nemoto <atsushi.nemoto@sord.co.jp> wrote:
>> If you want for example to run the stress-ng memcpy test with an argument 
>> of N=8 for 8 workers with a timeout of ten seconds you do this
>> 
>> rteval -d1m --loads-cpulist='0-4' --stressng-option=memcpy 
>> --stressng-arg=8 --stressng-timeout=10
>> 
>> which will result in rteval running the following command
>> stress-ng --memcpy 8 --timeout 10 --taskset 0,1,2,3,4
> 
> In this case, the self.args will be:
> 
> 	["stress-ng", "--memcpy", "8", "--timeout 10", "--taskset 0,1,2,3,4"]
> 
> and will cause "stress-ng: unrecognized option '--timeout 10'" error.
> 
> If "shell=True" is not acceptable, how about this?
> 
>     self.process = subprocess.Popen(" ".join(self.args).split(),

Instead of this, spliting "--timeout 10" to ["--timeout", "10"] would
be better?

I will post another patch.

---
Atsushi Nemoto
