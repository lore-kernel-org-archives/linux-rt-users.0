Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648DC433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 04:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFDF86113E
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 04:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhINErM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 00:47:12 -0400
Received: from mail-eopbgr1400071.outbound.protection.outlook.com ([40.107.140.71]:28860
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239271AbhINErF (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 00:47:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PlHS9q3T+G3o5UYHb6l/sJhItyHt8pcQP9quySDBkJSiI/Uejyg0A0pb3VHxmdgGkpiuHp3UuKKbTubYzN4NjHOHyO+oaIvAYvI+jYnja9Urt3YhwhOrNm1W4Qv90ETqtOIYjHoq/9cT6/uf4C7uyRq6IDaJ/30JWmuk6j1BmkQrYaPz0Dz1kab/rKYGrzsE/SIKN+5xBN4CYpjzA9IYT/TMCweCPHcnrs0z7jkbnSF1xzPUEZKIACtKwUVzQlLSdUuQ4LGRdc0qN2pGOtCDaGCAT/x7H2uh8kdqAXmRPyg5UoVh6DuE99MGufmwXDoLQdChcDGDK8msHA2zMjVWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ewSQTeDbyOjNuhFUbXazHjdaT8e4m6C6C1ziKQzoFHQ=;
 b=NlVGcdv3jxJSQJNvktaKKeEs1wbcnnwcZAwINtjhi5JB3lSnoLnPDYYzANHZ/DukM9sUOFQI5oCAKq68r5qLy0sVGLLR+cYT37eOwXSwQLrRhfsV1mOgpFZCJGpzGD+VqhG0JsVrfZNtOm3PxX4470KsTE+XY4SN317wUHjB0aWmIBvQZPkg2imP1ocVU1y2B7xUIE98xGPqGbHknh0OZD73rKP5PAXIYO/b57fh8EG+oNQ3Z9KNmPohD5Fk632S4ySgrjGDkXZDaxL4JarbkbbuiaZ/PFPToN/sM8jkq7T5VrbnqJMkQlqtJ5qnrapG3JQ0bLo8+bf0KkZRWx+XWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ewSQTeDbyOjNuhFUbXazHjdaT8e4m6C6C1ziKQzoFHQ=;
 b=w6mWWwBxaR/TB57YskomstWBolOAnQDgSno4J2vMXURF6v2KVJC5zVLp3Bo3Rx2O/3KObkwoUGt9QxSpIM651bjzZVAkjAFoRZ46qw0RvVIfryKlDa4CJaJVHyORnT2R1tVKR9jP5X9PzHY3CMppGa0YCvRrwMqcsFs+AjIK54Y=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSAPR01MB2644.jpnprd01.prod.outlook.com (2603:1096:603:39::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 04:45:47 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330%8]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 04:45:47 +0000
Date:   Tue, 14 Sep 2021 13:45:46 +0900 (JST)
Message-Id: <20210914.134546.1926575477327712294.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix arguments for Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <20210806.174641.1741870399325228428.atsushi.nemoto@sord.co.jp>
References: <20210806.174641.1741870399325228428.atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY1PR01CA0167.jpnprd01.prod.outlook.com (2603:1096:402::19)
 To OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY1PR01CA0167.jpnprd01.prod.outlook.com (2603:1096:402::19) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 04:45:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07fbc20d-215c-418a-badc-08d9773a84d1
X-MS-TrafficTypeDiagnostic: OSAPR01MB2644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSAPR01MB2644EC9AEF265F3C5AA87B7ABBDA9@OSAPR01MB2644.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBV1k0NW866ROeUWxGPuRXpIYpAV1f5QFxrjFB8bU8VjkQmY4FQpnLckw6GLlpk13Vdr+m/1JbDZdhNIuxAnrukfIUMPnR46AnJRw4wfY5YzUIbI0i9sXq93GzynVI6Ax/GORfYGA11zeknuEmAZW9uyWLAhd7Mlu9wHoRrHSy1UJEnyR29wd/UyeSHMmbYn0J+hOT2HMMc3qrCrwlsHkAfdM4+t7NHR/vlBDOfwsCHsLoHb7BETht+TLFOLJrThlSjq+e/h1E7SBXQWB5Jn3zwI6Z5xGVN4s/D+5ZGi4UIB3I7FC0tvxfh6cvSYH4+EDaW/zs03TtP6gHEqmnd6yY2CS74PT7PxpyuFwsJsB3ugSyvJg8owoR8tqBrEU597SBPsSNB28oXFOIcFjytVBW+waq+1I/77H5IbJg8Dht3lVifvwlEvdSh3xSy8S5nEVsime5lXcgYg37LKxzVelEUH6vHaucTJ/44u0wOE54+ohEU5WJUaEMyb+dzYtUDKDESCadBD/8OBBF7bitxFDY5lI0rjU9++Rb4hbYjw1PS/5KhDJxZtgS09jOWioUntflx5ijiaZpfp7NSP86aJOjOprt5J1pP5fdR3QOjSFbnPO9eXC1Yury1r24Zmctt9nlJKyOJkzQ3m64Xq6U8LfybJVsGILpr9Q1azHoc60jwcAT34GhWmLANbgRgfG+Z2xqq+dwix4QtXD+NSPxMFsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39850400004)(376002)(396003)(136003)(66476007)(36756003)(66946007)(66556008)(186003)(478600001)(5660300002)(52116002)(6486002)(6496006)(103116003)(8936002)(956004)(8676002)(83380400001)(86362001)(2616005)(38350700002)(38100700002)(316002)(26005)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6OuIUiB0SxkQovnTi8DnQExQTrUbg12fnqLysCTGq1y7pj0c5m69bHsK72p?=
 =?us-ascii?Q?R0Z0BiI/8UsRwwfwAzaaJ7GGhxiZlmzxBPK0N91N9+NCbsjFq37v0skTtiNx?=
 =?us-ascii?Q?nQKsNIhbTQTSTxZwuFY9//cd6gfRCFiq51c+b0ERgkFWigB/XnlqgU+muJPS?=
 =?us-ascii?Q?qtpBKHhbw5GsErLl4awGG97VGTBUhm+kcXi6tj6lGqYkNUPnMv9m8LB6kvc6?=
 =?us-ascii?Q?AYYR1DvR0e3OfAfiSf4seruUiLngmFCdl63u+x8PIi1wIyYZBfa/f6QvFIHy?=
 =?us-ascii?Q?1q4+v6yGx8f7+fLgKi7+enaIVtMua3lNdgEFHKJtqqedwgJqme7m20PIc5lD?=
 =?us-ascii?Q?PDELQNbeW3ai81DRfRhAv4xwk3gEJCtKKb5CwC0xBLDqDm70bX3aCRvV3RhC?=
 =?us-ascii?Q?OUb/kFiNtODuCqgO0ythyClvpUSpiQDLiuKw9Lye9af0jnexsVEI+iIhiyz7?=
 =?us-ascii?Q?Pl/W6Mv2P42WG42AgreOjpT/dED+aJnDDPdf1pJv8G1gbSQwiGSjV8XfIY46?=
 =?us-ascii?Q?UYIwAWsDYRm/GRqPx1aG4FP3gZQDJZSUdguiOcmzg9bSF/Fm/xsT6jiqxMNS?=
 =?us-ascii?Q?9Gl2gPDaYp+LJONB1nHfM8VYQVzzY66PFLX2P5JlL+sMoCbSCOOBbTUClYcE?=
 =?us-ascii?Q?c4hde6a0boFBejNJl1XXka6goebD/gof+EA0+/Hjk7npuxU50x4E8KmAgOXz?=
 =?us-ascii?Q?h9cQ1QAn1m9pV3oKpd1pNfPaXeBnGk0ah321v3FLDvEiUHu/KV+P3AWW99B+?=
 =?us-ascii?Q?m3jLPedAroajiNzQ6hAivSYGmgAC5srTSUZBKRYEMUkWYzifKDJHJUPr4Kog?=
 =?us-ascii?Q?T0DBEupJZ3H+8inpY4W7853xDOvauS/ep6y4Tcy0JDT0twuNMIUMfuGb0+mE?=
 =?us-ascii?Q?Yw/Y8yXGLM2CwVWOIpQeKmfaXt+d+GwY+35RaBZDY01h+6owVmQW6Pl+fLD1?=
 =?us-ascii?Q?2Vv5kz0PWCvij6Ukf4LR+vRxRhEdB0FZgwsP/Y5NIk1B9c0u4f5g6yk795fS?=
 =?us-ascii?Q?t+O1NYbbF7PVgdjhlC6mvI+T/ZmVeMZFsf2VlgH+DyxVbobBegzhHI00BBvW?=
 =?us-ascii?Q?0uBHDBXv5G7u7e6ybPqDZI+MoIxyui2m533manJxOGz9QmokRW5VDTb6k6Tl?=
 =?us-ascii?Q?y2hx7F8lhA6i7NpgCtoggKdlvTncSbGCTgfkLIsP110pUamA4nOZi7LZ/S5G?=
 =?us-ascii?Q?IboAXivtzNf1Yx3XpWkt2r82+XXu1dT46MvKfwURf+RsPe4mL42BmgyPQVta?=
 =?us-ascii?Q?32oT5bujYl90ixmgI4TDxnhLTfkidFxFeRZyLcBYTAqeV21+MHJUqej0VR6w?=
 =?us-ascii?Q?o6PEyW8WxJCQoZOzvj9/qr5w?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 07fbc20d-215c-418a-badc-08d9773a84d1
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 04:45:47.2131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G5MsLG1AUtlXtV67Hd5JoFgPfwifWVuNmtvvzpTkQkMjYnFMfaXtsmL9O+9TcfdQPUI4Da4H4jYp3kb6Bllhhn7LDIJ6Li/Bf8z8h/aQozw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2644
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 06 Aug 2021 17:46:41 +0900 (JST), Atsushi Nemoto <atsushi.nemoto@sord.co.jp> wrote:
> Make each element of self.args contains only one argument.
> 
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
> ---
>  rteval/modules/loads/stressng.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
> index 926de38..c259554 100644
> --- a/rteval/modules/loads/stressng.py
> +++ b/rteval/modules/loads/stressng.py
> @@ -50,9 +50,9 @@ class Stressng(CommandLineLoad):
>          self.args = ['stress-ng']
>          self.args.append('--%s' % str(self.cfg.option))
>          if self.cfg.arg is not None:
> -            self.args.append(self.cfg.arg)
> +            self.args.extend(self.cfg.arg.split())
>          if self.cfg.timeout is not None:
> -            self.args.append('--timeout %s' % str(self.cfg.timeout))
> +            self.args.extend(['--timeout', str(self.cfg.timeout)])
>  
>          systop = SysTopology()
>          # get the number of nodes
> @@ -74,7 +74,7 @@ class Stressng(CommandLineLoad):
>          if self.cpulist:
>              for node in nodes:
>                  cpulist = ",".join([str(n) for n in cpus[node]])
> -                self.args.append('--taskset %s' % cpulist)
> +                self.args.extend(['--taskset', cpulist])
>  
>      def _WorkloadTask(self):
>          """ Kick of the workload here """
> -- 
> 2.11.0

Any comments?

There is an another problem in '--taskset' handling (do not work as
expected on multi-node system) so I want to create a patch on top of
this fix.

---
Atsushi Nemoto
