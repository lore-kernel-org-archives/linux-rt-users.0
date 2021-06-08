Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE06C4743E
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EFE61249
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 04:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhFHEkj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 8 Jun 2021 00:40:39 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:11282 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229507AbhFHEkf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 8 Jun 2021 00:40:35 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1584Wj9h007379;
        Mon, 7 Jun 2021 21:38:00 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-0064b401.pphosted.com with ESMTP id 391j7b8m7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Jun 2021 21:38:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBCbsMa5uEqDhAdnLl2xNXeoGGGtR83RTD5zUkwIB7r8c9htOPNtnV07JlKItd0rc3TCpl39ndDnyH4i+/CMVAqmFepXrbo3a0/oEUEnq0gha89jai5E9qC42LnATLVHHqZqQW8UUDvmSFvcd64jx8mDB/8rDYIbiblkU7N0bBbaxvKMuhy7RGShOllXbedmoRHvrkKd9t+BSXDClSpj2scMnUaR4lOagXk3t5wDPxp2uEVAdqGuJjjVkY/YF2DvD+6MLHhZXep68zIzCnNDhpATdJ48XVlQqohOxHHwiFnTzy/wXteGLfTjlTZKrdtkd8AiIDeY3LWDzGom/7OQ8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7lIdJNJsE3VxAH1WYhh/aSxlWfrsq521kXw5vLTbNo=;
 b=WndjP7QtPN0NHWRJAe00F5PxVW1lpHeiOA2yz8BWL9oXAGlco4srhpcxLRgcL0cTIWQaHGNbJ40IZFoN4KM1MktWFabHOGlmA1LvuwW22GcaeFPzKEqXCctG2nnF8BukJurKxIcEYGQUNOCeY0O9KEIlpmp+5NVQ1a+frtqHn6nITG5rgkhY0sygSn0RJ5jR+hgnchieHSJDNx/mE5Ir9xnCc3sa+k1zz97oq+YmI0/mpocPvc9v/mzbEuIiOA1Ff1Pcg9/PfXrrCSx6tLd+n3046I5ogitIDAd9ThGSSQMeL8W97T43i0cMH/xxHFBwrgTYHR5XBWk0KZSynsN5Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7lIdJNJsE3VxAH1WYhh/aSxlWfrsq521kXw5vLTbNo=;
 b=fg+u+ghvD1oUg3KdJ46fdz5TlZwmsdJTbCCC/nRIdCan8xbcz3mdfMkB9BnF7mKIDG0HCAxNw/bTkdqUHRdio/kCpyBG5RzWF/V3NhEredqtTmeD8nVv8AY3HJRUfn6IRlRjGoSZxyppzZTzVZJhkqym7encGnUqV+R8E4QsqhU=
Authentication-Results: goodmis.org; dkim=none (message not signed)
 header.d=none;goodmis.org; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4491.namprd11.prod.outlook.com (2603:10b6:5:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Tue, 8 Jun
 2021 04:37:57 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 04:37:57 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v5.10-rt 0/7] add fixes for mainline migrate_disable commit
Date:   Tue,  8 Jun 2021 00:37:29 -0400
Message-Id: <20210608043736.1102914-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::11) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by YT2PR01CA0006.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27 via Frontend Transport; Tue, 8 Jun 2021 04:37:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8175b7d3-ee24-4838-7a07-08d92a37309b
X-MS-TrafficTypeDiagnostic: DM6PR11MB4491:
X-Microsoft-Antispam-PRVS: <DM6PR11MB449173C133DAD7F393EB492283379@DM6PR11MB4491.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 245PZ935kKmDD/lyRDIrEfiHTVe59POwxf3Q8nvKoCxwU1ZsWMYvxWR+00dSPiV2ONlDvIsu1zCXJ1XXdFgF2hvcmxAxs1e4ck3K3hk0Iqgdd+JnO7hyrmSHz9wkVuHvr6SvhZ6tpyM9PWTw3yCz6Grhq1rn0xxNSKvjEFCgOvbuTm7rmBkjD0PeYYDaaE3CR9nkqGrTts0m0BOFziZQLm42KOiQa572XdipYqG+3MLrNJE5xbA7NqDLfaR1FEJhOfenqC5XGNQQ45BXGZnGIrRyIcHTskiWiZb5LUHte6+D4J1/sh8Uf2I5C+kwwTJB1oT2z9VPV88/r0LUQSaL8W/8e2zc9Yg8CuYlHHJBwOWmE3WvHvg+dNurjUNNysvCmtvW3+HflrhDdwbPSNhBlwETXwe1umDdS3xtB7ir9XrfMoZlPtasUm8mTE7XeK4HnJ9ZoB9D6IbEPVlxjsV4AOZb5g8xwWHen4fxlDQQflxQL59cRnLnl/jOJMlkFh0soSJdfq6C7ctAX0UaCAF3vhGYwzTV6Ng4aVNm4Kh7fzlA7cs2tIxjSEMmJypSrPXCrWB5VNlNZnkv4/6nAvDnnT83GUEBGdDsbOWLV1MNDfcbhOl4DH6lAGQVBsvcGQQNdJvgQSwG5LmsOvF9sVOzNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(376002)(136003)(346002)(4326008)(66946007)(52116002)(316002)(2616005)(6512007)(8936002)(38350700002)(66476007)(38100700002)(66556008)(478600001)(1076003)(16526019)(186003)(26005)(2906002)(6666004)(5660300002)(36756003)(86362001)(6486002)(8676002)(54906003)(110136005)(6506007)(83380400001)(44832011)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?88SNPOGFEbaMkHgORSUJh7N5SUbL50Zjg7Vq7kVYVmgzEs3HfJMJOj3b0YXI?=
 =?us-ascii?Q?lRAKEpcIBmr0x5UNQy74dbEXtn3MJZcEfwBx2ibvIbm3h1ObtfJiQlmcJvtM?=
 =?us-ascii?Q?qFUEAhDntQXCz7rE9VJ07TZ0x4quaZ5W5TihFgs2pID5fx74Fg/qyMdMMXs8?=
 =?us-ascii?Q?Dif9h/gCWAYL/xv/j9j2c2Kqs8TRRznse8JEy0TN23cAEPnd66qtTWw+ng6f?=
 =?us-ascii?Q?ww7ehP5exLqfiDTDlnTBbbhXrhc2ClwP1fyC4XLQLgarvZrXPBXVnLPRqUQ9?=
 =?us-ascii?Q?neb6hJhyDFzqTotB2Yqk9LtpeTIcIhSOfKdZaJFJPd/4bgX2lgiQFfdoQusJ?=
 =?us-ascii?Q?NkKucs0J+fQUR/sA5uL328Pfb78fldOsRJCWHOvzon2tLDth5zmXUqpffdhz?=
 =?us-ascii?Q?1bQA8bJtT+/VZGYO3LR0x4moNMRVJHgSJx2SciK48xSrS/BSFoKxI5xF22Li?=
 =?us-ascii?Q?0dLdUvGz1fqHZqLrabUW1iuNkS72rw6sQZhlacKAybrmTCqu2BQopBbmjvqI?=
 =?us-ascii?Q?cqYn5aQ3edqAv6Cy7S56GdHzqrwZT0x/z+Oujl0rs1d/ASubbEYzBYBH9heY?=
 =?us-ascii?Q?k1wLUqqkuyxjL6evsgKdEk76xjT2z4CtZGAY6Azj4LvSPQLxx5IvtVunVrq/?=
 =?us-ascii?Q?MYXDI6y2rTVmAtJa0YRxz8LP2e1eHoLuwU0nzj2y/V1dsLTK5JpRx51bpJrb?=
 =?us-ascii?Q?ykDYAVX6Ksa+KOZC5OPmvOdjXBbdSrus+GsshLf+WOX+uxdgtxeJaw87uRCt?=
 =?us-ascii?Q?HRf7MML8iFs0Sc/qjf16ME/72pqPXH/LL8uKjBSXHapZtxzaDsTZ0lZuM3Zm?=
 =?us-ascii?Q?ZFbl/ihyGbQZ66l/ngkM1b7qjTyv+YeG0VtCDnP+zuCeUVOPT8jhIkBlo0uR?=
 =?us-ascii?Q?4ARMyI7Iabeos55eNBQsRdvvsbz1TCV1UN3ui1MbFW54cuGNQx+NPOjo8lxs?=
 =?us-ascii?Q?8c+KSUcPeyEjxu4PmW98Ox/755dSxKjy3I416kIEp9q3rxG4jlqJSUL8W/vz?=
 =?us-ascii?Q?2kY87FxwD7+dE6/hFmniJuumTnB/m4pLoWMRFHQJMk6IHM16lb5FQZ03He5S?=
 =?us-ascii?Q?UAUyI/5migcaroaODvlYfRgU0tEfEb1xHwcYSNUfYz3mTdyCnXR+l7GLtExg?=
 =?us-ascii?Q?sR2lqG0/YXrDcj0tipeKbJzesSpkLbQ2wIGhbbYDFl2R7JnCyb4jqViNzRBV?=
 =?us-ascii?Q?v4FHu7h3csYn9UC+O0fGs7Qmhc6b54Yso+Gd5XJspe+ZOmiBjZ4TUJm3vRxA?=
 =?us-ascii?Q?eqS9AlOwB1bOZuewfEJoNoX4w+h703aWxwXDC6Nv6fG/pKoVQeDslHpJ+GFZ?=
 =?us-ascii?Q?0EeZLVu3Px9rroQ2JU8TctYv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8175b7d3-ee24-4838-7a07-08d92a37309b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 04:37:57.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OPCHlQxw3npfpF1n4FTaATRqQ+tmxe597jmBXb1gs4c6CtuH52TBZ3sjjawZe0Jwb/UO+HPglAjR3OsvzGT14aWAhdHWMEVaLJWyfPOHOCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4491
X-Proofpoint-GUID: A_9IpdRHjxvbpE_wQFXQ0KsKUIzVlprE
X-Proofpoint-ORIG-GUID: A_9IpdRHjxvbpE_wQFXQ0KsKUIzVlprE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-08_01:2021-06-04,2021-06-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106080030
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Mainline 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
first appeared in the v5.11 release, but was already in earlier versions of -rt.

At that point, v5.10-rt was still in the -devel repo ; the commit was actually
first added in commit/tag v5.9-rc8-rt14-patches as:

  patches/0010-sched-Fix-migrate_disable-vs-set_cpus_allowed_ptr.patch

...and then can be found as commit 5d7baa3f554d in the v5.10-rt fast forward
branch that regularly merges v5.10.x-stable in the stable-rt repo.

This matters, because 6d337eab041d is mentioned in a bunch of "Fixes:" lines
and those fixes made it back into v5.11.7-stable, but weren't considered for
v5.10 because v5.10 (and v5.10.x-stable) didn't have 6d337eab041d.

So it is on -rt to ensure the related fixes make it back onto v5.10-rt since
we deployed the commit which is the subject of those Fixes lines on that 
particular version baseline (vs. mainline or stable deploying it).

Commits are applied here in upstream order.  Note also that the final commit
is not yet mainline, but is in tip on sched/core and hence I'm assuming it
will land in mainline with the same SHA.

Active non-EOL Shoulder releases:
v5.4-rt:  Does not have any variant of 6d337eab041d.
v5.12-rt: Has all fixes via mainline v5.12 except for tip 475ea6c60279e

Testing:
Sanity boot test of v5.10.41-rt42 +7 commits; with defconfig + rt enabled.

Credit goes to Kevin Hao <kexin.hao@windriver.com> for spotting and reporting
the missing fixes.

Paul.

---

Peter Zijlstra (6):
  sched: Fix migration_cpu_stop() requeueing
  sched: Simplify migration_cpu_stop()
  sched: Collate affine_move_task() stoppers
  sched: Optimize migration_cpu_stop()
  sched: Fix affine_move_task() self-concurrency
  sched: Simplify set_affinity_pending refcounts

Valentin Schneider (1):
  sched: Don't defer CPU pick to migration_cpu_stop()

 kernel/sched/core.c | 144 ++++++++++++++++++++++----------------------
 1 file changed, 73 insertions(+), 71 deletions(-)

-- 
2.25.1

