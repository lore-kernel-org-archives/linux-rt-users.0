Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8550C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 04:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DFF060F01
	for <linux-rt-users@archiver.kernel.org>; Fri, 30 Jul 2021 04:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhG3EfQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Jul 2021 00:35:16 -0400
Received: from mail-eopbgr1400082.outbound.protection.outlook.com ([40.107.140.82]:48338
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229609AbhG3EfQ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Jul 2021 00:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz1vq0PgL57tKzpJB/sycpDc0+Y3X7RlmuQtFG6DnMWlw1DZ7ZHHr8s7pCsXTlh8tLJO4NZpWYqezKMOwje1UxO2f8jP7AXaYLbgLiisSlRRLQyWuKWJ4ODNNirsg8ave3TzlLhc6IrkaF6ApLWtMwH0kilSf7MIerfYrEXjJDctKZFzqEcwChmKqy4BguGEvoUl84oyK/itriw7X7YdTWMPShKJWHGnpjw324j1Jzs6rz1OP6gzJl88djjCKfD5ksCvxYXpPhMyzYM9QoahXqDyhFpQFN+oMEmbuqR3PTx79eGvvDbSKaxFq4kA4SdI2gx4JAUYTxbhqewQ6NQpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qwDhyiChc22qj91ixqSO1DmZbwIsoFH6iyyR6tjtjI=;
 b=WUZ3oFGyZUFXeNdb8xeseU3X+jb9w3nVS5KypxDwGEsUIysodlvyz0VT0h6SJCLOQ7CHG5Xs+tlfnrRGEmo3jhI4Pkz7saWXEWcNWpTxo4xpbCc6k+ubnRvodFG0sZUKfEa4/09b6diLbGszt8piz3HCQFC3wR5cRh94SHzKP3fKacxOGftzmeLOMsLTnDWzlFhMqu2ze3Mu4QaHerQqBCTETOuFPIOHN1jPfC5wQvdt/+Xy+VJ6xtsfsR7UtNBaJWrfwtupjCI0NK+KtTyRDl+N7XDXm1Ax3oX2sNCUM7df8wbDo/+whQRsX7XG3LDN1iIV4t7Xjrgt1WpxuoMjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qwDhyiChc22qj91ixqSO1DmZbwIsoFH6iyyR6tjtjI=;
 b=IxMJ8GlA74N/X2f09seEkJBTXqyqT/O8pyE9S2mnooMr1lTpf0m6OzRwvkttFHF7z6xOu2h1nj7BQJ1enrSFq6ix34IrOz4sMVMOyZOmiJB4P3MLegVPKqkUSvsZV5Ht5Bkl4m+x1wnKyTEp2WJX8zTBCwQ3BdX9K2d8s/wI3eg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSBPR01MB2647.jpnprd01.prod.outlook.com (2603:1096:604:19::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 04:35:10 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%5]) with mapi id 15.20.4373.024; Fri, 30 Jul 2021
 04:35:10 +0000
Date:   Fri, 30 Jul 2021 13:35:08 +0900 (JST)
Message-Id: <20210730.133508.2236677766467322522.atsushi.nemoto@sord.co.jp>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix argument passing to
 Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <f3f2dd4-733-2bcf-1c4a-5d7cfb2b6fbf@redhat.com>
References: <1643d3d2-250-5a9d-731f-fecf8f2f2b17@redhat.com>
        <20210729.092328.1410316616346703094.atsushi.nemoto@sord.co.jp>
        <f3f2dd4-733-2bcf-1c4a-5d7cfb2b6fbf@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAP286CA0023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:8014::10) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TYAP286CA0023.JPNP286.PROD.OUTLOOK.COM (2603:1096:404:8014::10) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4373.18 via Frontend Transport; Fri, 30 Jul 2021 04:35:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e145961e-b94c-4887-fa45-08d953136a06
X-MS-TrafficTypeDiagnostic: OSBPR01MB2647:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSBPR01MB264763C1609D58413EF0564BBBEC9@OSBPR01MB2647.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfOP8dLNVJNgo4r/TW91faUjrMqE0Vj6fUDo4P8n4aF9N4582EGey0GM6LkOKVjLzNvCksZcl7ygRrk+mDLYa5zNANWpNt+2nq3GCDG0CciGQjpJf0z9MyLx38xzFrtJJWy1/NoZ+1cxxVXrPYsHx7HGXmkQKzr3f8jh/HZbeXFivQP1W1dw4FHeeZajC34XrgFEVPBlBrqB5mN+3KgAnUZTcP85+RjZoLqv5/L4q/QTfD3p3yc/FQubT7sFjt0RrmaUdV472xn7ylNI08pJOMcBf7yhclnIxRsUwf2Y6VNsLG4DbuQO96we+FUDCuOsCVw3L/lkPjbv8FPKaeW20Xi0qzetguWk7+U/7aa1tB4RpbBya10GrVmrGkiTCmw62zhKQJdvZjXDsKukwD6vde9z6MyeU1vdoktDaJTk/RUrF+Q7YeP8e7v77xZKhKFJbC5YjDAypD0IKsmFXx88Q5rIkuo0qycHs07SBkIB4A5mWxAV9aKWF8O1NQkxI9N+ZrL5Pt5e9dg17pkoxSMqliFuLFzvUu/+AVBZ53NXiMBOPZpvxEsomhW1rXybR/6164MChln55oKgRTrKuxUfJHAAculpbpwGvhOntPr24gqx87VScpYsena7ZscjnbtaJB1og4oazUNOAktJExyg+kwqXVfahA0JiX04nAqERH1RAErLfeWnfd8NZU4Ynm3tnvGHyw0wVlFAGtoESkiBeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39840400004)(6486002)(38100700002)(956004)(8676002)(316002)(44832011)(5660300002)(52116002)(83380400001)(186003)(38350700002)(2616005)(4326008)(36756003)(86362001)(478600001)(2906002)(66946007)(26005)(66556008)(6916009)(8936002)(103116003)(6496006)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZTH80cRDjTgjaijYehCFxtlPV7QIaml1D7oIQGreQjhbbY+V8OJ1RrPFD+hG?=
 =?us-ascii?Q?lSpA2tR71G++bUGhnRbZjZIX1DDAs31uS+GTRvopWaKv/HSTcxd+zp9of+B5?=
 =?us-ascii?Q?jl5X55IvbDubVpk4FT+RBXxYw5MO3ZzB01soy/y7y8svR/1tnNqHwmxQoRHD?=
 =?us-ascii?Q?Skhe0vifq4FZJKW5QHc2m4dpxQ1JeXldNZgKkBsJU74xwDtN7DM8Tw73ZyPK?=
 =?us-ascii?Q?NlQ4daicP0WiwlD7nDwKzRGG4/GyVEKr9WZukZjfFKeU6f3BqDY74xm0uFM6?=
 =?us-ascii?Q?BkVudSdmmmmLXUnXFjpWo4Y24nd51V+x71xHBhlzxE16EjsegpE028dqNcQJ?=
 =?us-ascii?Q?79IMWIDQu80wxKbSsshi24UAZGhV7QjnrWjKzG8KPR9YkZMuTjR17nt+iFJj?=
 =?us-ascii?Q?A5Wh/59lXqXa4DH2O1L/ZfKlY4Z0Zzby6+8u3rXRcDAFuyNuYcop5RX9MLc3?=
 =?us-ascii?Q?nUhp6i2vLa7w/XXMpkJtNhiCCsHDUzPUd4iC2XuC9tkxW0T2TN/FINFptYMN?=
 =?us-ascii?Q?kEMCi0xejnS2jmLSojejj0X8nMFoeTZ8oAyYw2PfXZC0UzctE/jeuUNGTaTU?=
 =?us-ascii?Q?xvnCL/MQXfDzQJ5JGOPYHztEzV5pGBXWCy6k9l0yOHMOYtn0Wf5yxHFd+v2F?=
 =?us-ascii?Q?VEpWFEl9S1aKxHeSI7jgQtGQNrGzX6r7Wz8Ztdy04ErWVflnvuWQh5wVr62h?=
 =?us-ascii?Q?Juvfa8rxnTJZzVQi1s4HC7p3Jjoi7oQFegNmJeX9mYR3A3wLqZvdjxLhq8m6?=
 =?us-ascii?Q?4YCSUtgV2KFy7C94y6HECHGXHhcy8MaklVgwlLIHhqgMo/eI/R2jdVgbh7Zx?=
 =?us-ascii?Q?9bNgl3xnrur4TTC5M5obCES4ctl/RrPn7K/wFo6oYhoUDhmLI05ek2ZQbPEc?=
 =?us-ascii?Q?ZaMYs98rtefpMavr2qxUy08OSroWcQfvQnSmR1uxNcAsYk1sUwhC/+5r1BBV?=
 =?us-ascii?Q?DWoPyXaYHRvDFtFW+cNQapfGArXegn/LZBPY71Q7EVYS4e2SqGtv7oyEoApn?=
 =?us-ascii?Q?eKmQEUpQC3WyccQ3OBGiAWA+sSzwU7g17+aWo3n8Kh93+UbFTt89a156nE2O?=
 =?us-ascii?Q?psfkbvXtFZzmy9auCOM6/HVFYQaASU9q0mp5D5ZQY/1qLIJKmSSkoZTErSO+?=
 =?us-ascii?Q?mTQHE1Dv1DDHy++j+g6C+KNkynrMazs25Qler8eQZgy312UH61tJnd0kyjzO?=
 =?us-ascii?Q?1NAHsslpey7S2DvuZEqrg9Jhfe0f2QXR2Lg7urnZERMG5kzAIEPwtH+IAeWG?=
 =?us-ascii?Q?bI2po7b/L8RF/3A1kHGirmqnsrP/5zcqrX71C+cseX1kHnX6VoGVIt/nvzzb?=
 =?us-ascii?Q?r193m9ResnHe3hQ3FqT9LZ3s?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e145961e-b94c-4887-fa45-08d953136a06
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 04:35:10.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfRac1LHC0vBdsmssK+5f/7QfCxeOoXYdc/3Tj3Pyl2zMaNznvblYmkY+6QHAhwusgHqQAC8J96CSXKjuzg/fBsTViAUeZuYRlssbb7+/Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2647
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 29 Jul 2021 19:10:37 -0400 (EDT), John Kacur <jkacur@redhat.com> wrote:
> On Thu, 29 Jul 2021, Atsushi Nemoto wrote:
>> On Wed, 28 Jul 2021 17:38:05 -0400 (EDT), John Kacur <jkacur@redhat.com> wrote:
>> >> -            self.process = subprocess.Popen(self.args,
>> >> +            self.process = subprocess.Popen(" ".join(self.args), shell=True,
>> >>                                              stdout=self.__out,
>> >>                                              stderr=self.__err,
>> >>                                              stdin=self.__in)
>> >> -- 
>> > 
>> > I don't see the need to do this here and in fact there are some security 
>> > implications to using shell=True. Is there a reason you want to do this?
>> 
>> I want to pass multiple options using --stressng-arg.
>> 
>> And also, there are elements with spaces in self.args already:
>> "--timeout %s" and "--taskset %s".
> 
> Running stress-ng as a load in rteval is fairly new and purposely 
> contrained so far. So, you can't run multiple tests right now.
> However most of what you want to do is already possible.

I just want to pass some additional option like "--memcpy-method=libc"
using stressng-arg.

    rteval --stressng-option=memcpy --stressng-arg="8 --memcpy-method=libc"

> stress-ng is like any other load so you can specify the taskset like this
> --loads-cpulist='0-4'
> 
> If you want for example to run the stress-ng memcpy test with an argument 
> of N=8 for 8 workers with a timeout of ten seconds you do this
> 
> rteval -d1m --loads-cpulist='0-4' --stressng-option=memcpy 
> --stressng-arg=8 --stressng-timeout=10
> 
> which will result in rteval running the following command
> stress-ng --memcpy 8 --timeout 10 --taskset 0,1,2,3,4

In this case, the self.args will be:

	["stress-ng", "--memcpy", "8", "--timeout 10", "--taskset 0,1,2,3,4"]

and will cause "stress-ng: unrecognized option '--timeout 10'" error.

If "shell=True" is not acceptable, how about this?

    self.process = subprocess.Popen(" ".join(self.args).split(),

---
Atsushi Nemoto
