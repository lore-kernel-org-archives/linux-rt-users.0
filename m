Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957C1C4338F
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761A561159
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243395AbhHFIrA (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:47:00 -0400
Received: from mail-eopbgr1410057.outbound.protection.outlook.com ([40.107.141.57]:65524
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235812AbhHFIq7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Aug 2021 04:46:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4kSV4hgTRP1BXQy7z2VtDvtYgP9truCHW6xTG1Ce0XFie4MKd1K7glTwKPvehseiEm8Qvp47eFb8jsiwwIHD1OypOiTlEgW/TkZWybCCkrUIGyUkE8oq8A9MvAaCCfwumsu0AoJzTM+4F2t3obb7oT52iNq59zZAuHsmttMMvmUr071DhCJHYt6mP3/WFKPCo5myn3FK1xv3OpKSx56rHCqaCQ+Q/gArHQqTF9nTC5V3PMVDYsmxgP0HGfGgEQd6A1viHnII9+jZmLak5ingaGQ9zpUH5yDxtOP7mMLkxPhwmpVmcdc8zri1fHVFgPvKJe0fWOvfNslIgpr4uRbQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk3mTHGlMcSVwLnqac++tbIezYXyrhAjHQLNaNj4oNg=;
 b=nw3c6AKAp5SyeY/Q5H2KxsS8rczjJHCPDX7toYK8682ytlhXX0sHidE9pIV6eaEdMHmK/j2nVWCYm+4p1tjRPqCClPM/37MORlDJ8zIq/uOtp3YcrAuLuZB9nzMf6G08eVMIrgeY3WElAcl4LFCz8aMAknzQkxpN2caTS+ihWDHd0odVl+wwJxvwOuD5/Z2mS4WpHrnj/nWnHk8i8AnNZzJ9cQSMPSv3FsQbUtNxTgEtIysHM7eVb9ZJ9JYL6YppYQkVTO89oFnoEuq6MwoG0wwr6M4LrHs5FUg45HOt79Yg/T6CH2/GhhkpQjcaVe1fD/k4dTzUBXdHJupyxpduWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kk3mTHGlMcSVwLnqac++tbIezYXyrhAjHQLNaNj4oNg=;
 b=WL8Q2Cxd/HPS3o9Pr1c2KCGGIqbO4rI14G8JrBsBwkrgVZA5UISJxMxbp6pDhcLvYDL6Bt0LZGm714+XTzFtPxDi5VUNAsiPI08UOQdL2WRxZJqV2b5SpLWRLKylNSQERWjeH2w0wFYUrANhDY/35Ss+iULgiD2N6uO6KeF0QBU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSBPR01MB2469.jpnprd01.prod.outlook.com (2603:1096:604:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.23; Fri, 6 Aug
 2021 08:46:42 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%5]) with mapi id 15.20.4373.026; Fri, 6 Aug 2021
 08:46:42 +0000
Date:   Fri, 06 Aug 2021 17:46:41 +0900 (JST)
Message-Id: <20210806.174641.1741870399325228428.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: stressng.py: Fix arguments for Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TYXPR01CA0060.jpnprd01.prod.outlook.com (2603:1096:403:a::30) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4394.15 via Frontend Transport; Fri, 6 Aug 2021 08:46:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa5998f8-dcba-4ddb-41a8-08d958b6b6f3
X-MS-TrafficTypeDiagnostic: OSBPR01MB2469:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSBPR01MB24691C04B5B8848EBD89F36CBBF39@OSBPR01MB2469.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:538;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9jWyMNGz56LbNJqrKJ9xsb1B+SH9sv/7eNGXw/XqD6UXLfxzhrUXZC7jZiigUueeZYqkVao4j9EufnIKrjePrBFba9Lup05scmdU/FqSv0Voe49IA3yWMRqeMKrQDtgsyrIJuL319jmX3vqgV1gWV/vI9Rx1OzlgNGmKSbi2S7B1lVZPKly6r5nJTJPq3rgiyPJWnmf8pAkoZb+KWA3Y/M0LTVeCNgTpqpARARgeAXNni1j34cv16tHrUg7Gl1AdOj15Mmigu87HRMIV1Q666L0JtA2OoKAZo31QHrETOZuEfVWKUk5zgg4TYLoD9YOia8ppTGfwYcf6Zo27QwUwF8acon+t30d9w9vkRlOVMZYGCCuO3Ywludn2Aauno2eFa5QwSdJ0A/xitybbS4FNiUFcUVcy7993c5m/hc8lnG/RnK9h+WjTeIsmJvT/B9kfdTDs5NUK1ZnZa3gDZU7hbeT6UV9kyVSgFJ3UHQwevSOFvNC0fYJL+eDBxKiCq3H+MtE0vzE1I02hKzsyHoQyRD4tmlYrog0CiZ5ZDAttHBsKt8VK3cn9FdpiPV4OAdm5tkKGnYACrI7pjzBWox/SOyC5GhLBAyN21De98hAiz6v2X9OVhdWkRCv3v9lWUe51uJSvnEniCJFHWWA/3iRdARKpq1i8fR+zaGYWOJ8mkdv7lwpX1eaicS0Cd5PxrZ9wV9UulkwESKwsNJeAOcNsrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(396003)(376002)(136003)(39850400004)(66946007)(86362001)(5660300002)(66556008)(36756003)(103116003)(66476007)(44832011)(83380400001)(6916009)(38100700002)(316002)(38350700002)(2616005)(8676002)(186003)(26005)(8936002)(478600001)(956004)(2906002)(6496006)(52116002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2co+i1dlhxcTcRfSsn5R9Twt4k1x0esfwUMz7da0baednPLF6GUSRrkzQuDq?=
 =?us-ascii?Q?c1AMyWKSJ/c0eAf/sftj6ZmzZ5o/XKCnGA5UT0wwGoTaBEgcpWcGF/EifATJ?=
 =?us-ascii?Q?i0laIY/q2sKSAElymqcN7O/zS4K6Mr+B8o6bc9PFdLRBjSCaPg1UT4BjNLTu?=
 =?us-ascii?Q?j/0rfqcRcT0JukgAlUhqV3CzlmEQiq+umMwluvobrm1Hn2DVq+3me6bgcDBT?=
 =?us-ascii?Q?r62E51Dkcwjsbp4h4S9BzVja64yldgAmk86E5cpFWZEhKYFSFL1cbbIe0vyA?=
 =?us-ascii?Q?LC5iCXYlZrQ/thne4f33idnqVVph9f5Z4wD5mE6GWEXzCqFqBRL4Wp44qljx?=
 =?us-ascii?Q?QtAXQsGQx2QQAmpsd4vGhbhDvL9RAzooNmEjRjlwugDc8mnCtRaMBVy3zE16?=
 =?us-ascii?Q?LmO14lCMQUJv01ebPyY4HQbbHF2t2O0w+5N1gdJvZWSp4ZiEubQ+Zs7VNb+r?=
 =?us-ascii?Q?gsfCBsFHJGyvWARabScuLEOLcjV1ecJkTIuF/lF6LF+W+8LKp0L6vMyM4qyz?=
 =?us-ascii?Q?OKigxkYIq/O4SXSDdNiwwRoD4CB/edb6ZCY4vJA0C+ZrFpBwc+Cm/BOS5ICy?=
 =?us-ascii?Q?hezyLnQ2X294Tumd+Umpwsngl84HNCAwlXXXkpBOVxcJqCY7dPFCvlyS4Z1n?=
 =?us-ascii?Q?U3UT1Xb6sT6zd24iplGnIsZrkd4Q2RxJiBTNkxnW1YM/FDu3ScUDyExOi6/C?=
 =?us-ascii?Q?TH1gOgc0InBdsx6JPXcPMg96d7ZYQXvsUe/bY0qeT9N1/9UabsQk7O73SsSN?=
 =?us-ascii?Q?aIegkv7uaW9j6HGcHY8OxHjR8MrJw42KVcrM/aYa0yGfo2zYcp21s0L9lDOa?=
 =?us-ascii?Q?wBiUV4BqZnH0WXBXazrf01Pb0QlcrtdgLifpuFWLN5axQK/OaSS1eLazZ9B2?=
 =?us-ascii?Q?D0hJ+bqfdoDB2xGS9ZjoAoZ4cehWSDEEJRh1HeyBkSF6fwWh5QGJbLfmsoKb?=
 =?us-ascii?Q?tvuSWsdle22zy0OXTi1cl9V7JxYwEAybyRAjxHrOLZYv27JSl/FoLK7azXeR?=
 =?us-ascii?Q?uQOSA3feIp2kqTkhi0g4Mn03bpSXCxdtWC3+gRo5/1AVf4J4qJJ8YZ1Tp3Gk?=
 =?us-ascii?Q?8d4PKi6ZIPWE/Q1ych/5aPDKhHG9z+um3A1+uoPDv+sSHZAOOhtagqTImRXd?=
 =?us-ascii?Q?Q6VicJsjsmF9IdM2QGiC7tMmxEFVLcMDloY6nnWjKpRVqRT9/wbUXH4XbjYl?=
 =?us-ascii?Q?ky3tgvHuqhyE8iV4CwKl6AJcFMfNcaPFpJW0WN6c6g5vV6c19m8UGKiXpJXf?=
 =?us-ascii?Q?lHhphFeBkEY7oFedhduaDg5CMwXP8L9M6diwwfn2YKA6+X6c4GJO0cCRsSp9?=
 =?us-ascii?Q?bbhPgjoZcKRhHWO6ITU9kXw5?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5998f8-dcba-4ddb-41a8-08d958b6b6f3
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 08:46:42.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONkbY4gZ9QKGZ2spu2PYMRKQ5bI6HuctGYOoHx9O84brdxvZmGUPr5k0UMyeUL721jf3YyMWdTYk+5f2rg3LgBes2IMW9YUQgXaO0LFYjNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2469
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Make each element of self.args contains only one argument.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 rteval/modules/loads/stressng.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 926de38..c259554 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -50,9 +50,9 @@ class Stressng(CommandLineLoad):
         self.args = ['stress-ng']
         self.args.append('--%s' % str(self.cfg.option))
         if self.cfg.arg is not None:
-            self.args.append(self.cfg.arg)
+            self.args.extend(self.cfg.arg.split())
         if self.cfg.timeout is not None:
-            self.args.append('--timeout %s' % str(self.cfg.timeout))
+            self.args.extend(['--timeout', str(self.cfg.timeout)])
 
         systop = SysTopology()
         # get the number of nodes
@@ -74,7 +74,7 @@ class Stressng(CommandLineLoad):
         if self.cpulist:
             for node in nodes:
                 cpulist = ",".join([str(n) for n in cpus[node]])
-                self.args.append('--taskset %s' % cpulist)
+                self.args.extend(['--taskset', cpulist])
 
     def _WorkloadTask(self):
         """ Kick of the workload here """
-- 
2.11.0

