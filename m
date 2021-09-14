Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD89C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B14060FD7
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbhINNnx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:43:53 -0400
Received: from mail-eopbgr1410052.outbound.protection.outlook.com ([40.107.141.52]:12285
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233336AbhINNnl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 09:43:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djJPTbJoOUDa94DXMAouN4KT2bFIKBIfrtnHUdpy/OeOpBx4TZLbYX0Q3KyJ/3Kz5hWlu2Rr1rzahI/VNLAMuAxKv+u42QvF4Ql0w4cv4yIYSNFwIlFb9TUlqnT4y1Bo6tSfGdvHGlOAuMCJFdO2+nWblP7i9fovMjUOuVHjkaKbIRI++f4y31NRnRUz6Z/VgDmMQIE0eyjEtKOKw6PkuuBTpILXIrj3zAZHsiv1IbGvgY67D56gEfqDk2k2gOKRYGiRLkNUYw5o6VJe6ItabpcZA+Sgxr2GECLzLemDqB10bUTkC3I84fvzXTa6ssbQEBX6WQ2RNaGu+KnhixH9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=2v2pNyGXGJQ+E3RPlO/rChFkeISg0CxsfeDiDDJKZjc=;
 b=Nw65Wb+GIxaihRPaEzg/G9jF9PfLw/HfFDYMusQ5TFyMyXhyfW+4lCvNllTORnybVpl21D3LWAMNRwjaRa9szy4WztmRVMPfIQHrTwQwHMyn+VtdmJ83XrzfOky/k5TrKXbTUcB1QeElCjlYK+ipQNrv3+VduhXmXQtnodTaUTFty8ef2PtKaRQ9mztVFHPnPnovJb0hwssnn7/ZZ46H+1C7LhtlJ+FTJyGo3WT/9DryWscDr94C79fcyahyCDZnO4Egv9Rlca/DZf5wz2KvRUZZjjXGFocmkCCCRS5idSSJYlFzJ4SaV9u4MIb7jSMmwBJ2+14QffrdOKX1vXT6WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2v2pNyGXGJQ+E3RPlO/rChFkeISg0CxsfeDiDDJKZjc=;
 b=gB1VuYMeVW4ZcMaByF1qYpaR13ldIVCOHMuAaMYeMkaoHrNOqF6dnWB1+Liby9tCUv3X59ef15kd6lGAQT7zrdaCZFaghC4HJ4D+oBT9PMDlkIXekPhOjC3TmDrRiMmvSwFqO6OJaVhCS3SE0KA/kT6Ab455EFtmh1nqfvUt/OA=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSAPR01MB2195.jpnprd01.prod.outlook.com (2603:1096:603:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 13:42:22 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::94cb:339b:84b3:c330%8]) with mapi id 15.20.4500.018; Tue, 14 Sep 2021
 13:42:22 +0000
Date:   Tue, 14 Sep 2021 22:42:21 +0900 (JST)
Message-Id: <20210914.224221.1499603452226149702.atsushi.nemoto@sord.co.jp>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [rteval PATCH] rteval: stressng.py: Fix arguments for Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <9a5f892-2072-7a99-b4c-9867a4dde27@redhat.com>
References: <20210806.174641.1741870399325228428.atsushi.nemoto@sord.co.jp>
        <20210914.134546.1926575477327712294.atsushi.nemoto@sord.co.jp>
        <9a5f892-2072-7a99-b4c-9867a4dde27@redhat.com>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR01CA0018.jpnprd01.prod.outlook.com
 (2603:1096:404:a::30) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR01CA0018.jpnprd01.prod.outlook.com (2603:1096:404:a::30) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 13:42:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8aa31dc-70ff-4582-872a-08d977857abf
X-MS-TrafficTypeDiagnostic: OSAPR01MB2195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSAPR01MB21959640D84C9732015BFCF3BBDA9@OSAPR01MB2195.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vu4Bpszvure52wh697m7RiyBpOLFeIP4OXrmGN8r48bhmC2nbrCzB2MZJYTqDa5u7RuAIGs2Mka/FH8bLHz7VqB52Fh6FDiw1bpLwny30TC/D/siQeLRFx2G5MXbfXs9+7oiexg0vKd5caCVlj0vpZ5xq7UQy81AtdHvOKVKf2+KEheiKhoH9OzNmUZJNv2rvdpVbJYRKb6Rhul/5cLUnAWTZjtM54ERbpmjXr2QHl2mWZucbnKvMmrt8hUIhIGRydvS8qGl0OeVLo/t6KYIaSKtdjRvTHQJs0el41KWEYqJABh3b/eflwwN/WwbvzEfzUiTIWFmR2/wO50CekQXkWaHsDv4BS4AY7Hr6qsklO2dCMPyLPRcfaTdpoZed08jBTsNMtik6MwTlmR2w155UGsXsze1P2et0PgrppknNHRhCb/JCUdax7GXk5PWh1uSPbxDfFD7rJudp45V34cl3jmq8hYk4DTXn57Ufconpo29BadravdD6WXUe7GzTlqC05feEdz6Enps8xgZ8uhbXCL9RZM+439qi8BSjE0Nop7ra64kIfbmUEYojv7qRaJCmwdEr1dX0Lie9kSyUh6TYtG5IWxUC2VHTheXDxbfBcCF5GTKMOCeYEu4riyzpClv0zJsD2F3wyIqAfIvHXlDFiiik3wnzrk1w4AFcuIpeHzsM8YwCRWbJ1Fj7e3kbzdvBNxdE9BkD+lqkD/DSqt8ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39850400004)(136003)(366004)(376002)(8936002)(478600001)(2616005)(38350700002)(26005)(52116002)(83380400001)(186003)(38100700002)(44832011)(6486002)(6916009)(6496006)(5660300002)(956004)(8676002)(103116003)(36756003)(2906002)(4326008)(86362001)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aV3aa2B3NBkmLRkU8ntnybxlgvKffQzX07LsaTue3MPxjwlLzob7Ax6D2TLp?=
 =?us-ascii?Q?W2MoJ2eamrU5rtE7lKRTqYhMgGuuWpTOBkCmlPENw6p6RDe2lte+/Y+EhURN?=
 =?us-ascii?Q?z/wS2sD58eEHUt42Jtm1iX1T582kNfP+RtZuzNC/7jH23FtPUuxCK60j9ia/?=
 =?us-ascii?Q?PuZG7V0AjHxDuXA1qhfk+zFlNtq0zPSCkGBq4TT7M2fWbsZRmymCZeeaFuoC?=
 =?us-ascii?Q?o/EZA34VftNTluEhqz/7qp3UEFVrkfJ6/WSDAvGxz5VBIlkC/SVeAsPhI7lz?=
 =?us-ascii?Q?PsD8dsg/63Q0+909DYRFc9xt+tOYQjN2b/g34STkCdRjLPoYQ9ZIS7wzxZsC?=
 =?us-ascii?Q?erBgz8ZybZvoOHjdppgdFaTokAQYETI+PG6ptJXm1vo0maABUelgl2ypa9ck?=
 =?us-ascii?Q?PF+5s10ZONCsYnHO9OmY84QWQC/TcllIBTyn/HF8fil/Y+DeTk5PF663Ploe?=
 =?us-ascii?Q?bht5w2H26xiS3G+K0EFl02sT97Qqrb7Qqp+mdve6sBJ+Q3aqWfOQYphvkPoB?=
 =?us-ascii?Q?fZ/6Uq5PcXW7NIxunUOZgR93v3jjzpQ1E5BzPmjwxkQaKeINRODjr9PkDnx7?=
 =?us-ascii?Q?wPoGQjtPUeF9WzxKbFVQnCdOv2e/1k2OCtJBVzfJjn8XsoBW8xJWbqJVaTjh?=
 =?us-ascii?Q?t1qmZtxApkPDvWsz+1Hvw00COtJsV5kydtQWzWOD1k5of9vcbkfY5mSNx5r4?=
 =?us-ascii?Q?+knM16JzjJdfmKOzfI+YNXTFO1JuG6vNaqX70qsdyffKaOT4aT98ly2//AAi?=
 =?us-ascii?Q?lUXPr/PLp3RXrLSVFM5vcn7/49koT5sKKS4WjP/+LHO8AmeHTQl2iDN87KD1?=
 =?us-ascii?Q?ENIoBY5LCxPNEjprPSGOFwcjFf/SYdlX2gcLlKdfvggMfTFcJzsafBSOAPcy?=
 =?us-ascii?Q?hE/thCogj/B+cDGTq5OezWCYE3GaihQx8A7C0RwomVxH/ABCwROiLup8rvvm?=
 =?us-ascii?Q?mgi6hJBtKcc1+NwpnacDk2PrRsZaZv0NjNwG7fzsXVcLwklaTbDSysltY7P9?=
 =?us-ascii?Q?0Y83VOc9JY/MZtTWzqDM7O9/k1EO5yIZ64kJ9sfMVKlJlgexGMGfxUXCPJDg?=
 =?us-ascii?Q?QFrBq5nI48JKEXP5Qm6alA+x6uBkYoIEva3lpXv7sspgbBWtjO5oMpbx2tdk?=
 =?us-ascii?Q?zA7k7NKISn46od3E8ZO0ze8UjmR44+fTjuAm+cfzXpJD1cqN4AB8nvKCfnNe?=
 =?us-ascii?Q?+zKRyMELGa1X5WiAIeOaQsyhXMjaJCrYod0K8oqSK3XWAwi6IsSGnp7ToFVo?=
 =?us-ascii?Q?0d10lvSwf84o24JMQFT0akVSd4oh5AAbbfdBw18Tck+4OZunCXzPQYZj681r?=
 =?us-ascii?Q?8yoMZhcY+uxFLPIrRVVvanI1?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f8aa31dc-70ff-4582-872a-08d977857abf
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 13:42:22.5175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKLq8hsvx/WdRz+W/hoOkf/jQ3pYXpJ9yi68AOBOj8Ol4GxnH7IGQiZbPWA01AoxzJb6G9NpIX3GYg/L2g5YuQ2ZPIcopcfndqDigmPJp+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2195
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 14 Sep 2021 08:51:02 -0400 (EDT), John Kacur <jkacur@redhat.com> wrote:
> 
> 
> On Tue, 14 Sep 2021, Atsushi Nemoto wrote:
> 
>> On Fri, 06 Aug 2021 17:46:41 +0900 (JST), Atsushi Nemoto <atsushi.nemoto@sord.co.jp> wrote:
>> > Make each element of self.args contains only one argument.
>> > 
>> > Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
>> > ---
>> >  rteval/modules/loads/stressng.py | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
>> > index 926de38..c259554 100644
>> > --- a/rteval/modules/loads/stressng.py
>> > +++ b/rteval/modules/loads/stressng.py
>> > @@ -50,9 +50,9 @@ class Stressng(CommandLineLoad):
>> >          self.args = ['stress-ng']
>> >          self.args.append('--%s' % str(self.cfg.option))
>> >          if self.cfg.arg is not None:
>> > -            self.args.append(self.cfg.arg)
>> > +            self.args.extend(self.cfg.arg.split())
>> >          if self.cfg.timeout is not None:
>> > -            self.args.append('--timeout %s' % str(self.cfg.timeout))
>> > +            self.args.extend(['--timeout', str(self.cfg.timeout)])
>> >  
>> >          systop = SysTopology()
>> >          # get the number of nodes
>> > @@ -74,7 +74,7 @@ class Stressng(CommandLineLoad):
>> >          if self.cpulist:
>> >              for node in nodes:
>> >                  cpulist = ",".join([str(n) for n in cpus[node]])
>> > -                self.args.append('--taskset %s' % cpulist)
>> > +                self.args.extend(['--taskset', cpulist])
>> >  
>> >      def _WorkloadTask(self):
>> >          """ Kick of the workload here """
>> > -- 
>> > 2.11.0
>> 
>> Any comments?
>> 
>> There is an another problem in '--taskset' handling (do not work as
>> expected on multi-node system) so I want to create a patch on top of
>> this fix.
>> 
>> ---
>> Atsushi Nemoto
>> 
> 
> You haven't convinced me to apply the first patch - yet anyway, so you can 
> decide yourself whether to create a version 2 that incorporates your new 
> idea or whether they belong in to separate commits.
> 
> Thanks
> 
> John

Thank you, I will send revised patches with a bit more detailed description.

---
Atsushi Nemoto
