Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC6FC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 14 Feb 2022 10:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiBNKVX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:21:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347139AbiBNKUt (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Feb 2022 05:20:49 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FE6CA42
        for <linux-rt-users@vger.kernel.org>; Mon, 14 Feb 2022 01:55:31 -0800 (PST)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21E8kbWb014883;
        Mon, 14 Feb 2022 09:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=pRiO+yd7/P0iElOT4hDPvZkmgHCRU3bxGj8hlPyBuSg=;
 b=SsBNsf4dGopQP4djk/a31rmPAz3B4HzgpSTBRxr59kpLJkuSo85SCpxYegxEqQafXs8n
 NTv4OIDoDm0ymh97LwH5XG8Z/VhwCV4tcJwG5TuS5aq5aES5vc79u6R8Pq5oS/nfCuFb
 tMlamZxPYXIE5iKNa/AP+G4NO1ErpffBp3XTEvG4vRO0hD1XPQtCzrLDHBzh3FxFpHjR
 bUaM4W5hljbRHg40GRQ8Vxerj4qmkdgxhXKTyXPqeEdcwXDUOUnXQjAXkcdtRV8lU3+8
 qNaXO5+UInQ0d6PMn9Mg/zTeH0PpZcn3An+t9LGPkjVKC0oPFCqVL88tyspHm3utDbrP Ew== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e6240hf5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:55:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIHT9FXt2se9I6f5Yv3+E0SagaGrLYqI302bghyOrbbOPFGkgwmbGmstHSblCjhTXONl+8IhCxvGrhAV0pbc9FMl3HpwOxBOjvytJTHXBdqjO4qFoyAp/8EeH8BUX2R8QyunZuhwiyB/5CCP4WZuuIu4ecHM5bnmDt11W9fjVDJN2MQ46QfgoLOSirBQyN3mxx3CBUdAY87LgsECLgesiTtmBJt68sF7P7ilmMLbUACnCRBJuCfxliQUQ3TYRvCi8MSqmOYPWt7bt96lral+Jyff/XSwAAZ7dNbMpGR91qGjqVdraMjnTbq0Ridd8pyib/3Ye1A6xkr5wD2qb7xP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRiO+yd7/P0iElOT4hDPvZkmgHCRU3bxGj8hlPyBuSg=;
 b=HoI3HZAb5e3ydO1GQKYQS+czbZ8TE4+pDjqyFwHDf5pKqvQVAgVzfvpQ9/T1AMY7rffBZb9j9hqCF+K1h5yxVUhFUTHf2fPtCYaWmcfcgkxs8a2Ucf1vrjvWLrOlaTO2po/zbKufQP2eUewbZsdHTJ4pBck0nIfsfLjH/tItsjvDOUeXCnlS0RK6pIwfck1whprEU3Hf0Frux3WmjFUiZA4ccb8XufJ2nl3oF5MEH1P2hL06uPznIelUEVA2w54pQG60+SMQ5NCvjw/9/VlMVLGOhxtQB71hbMFeKAH0AZ4vIx5CGvTICeAkie+2VR3gbT/wX+XhS/t43pT8M1tyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16)
 by DM6PR11MB2538.namprd11.prod.outlook.com (2603:10b6:5:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 09:55:04 +0000
Received: from CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::e843:f280:ee74:7c59]) by CH0PR11MB5348.namprd11.prod.outlook.com
 ([fe80::e843:f280:ee74:7c59%6]) with mapi id 15.20.4975.011; Mon, 14 Feb 2022
 09:55:04 +0000
From:   Liwei Song <liwei.song@windriver.com>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, liwei.song@windriver.com
Subject: [PATCH rt-tests] rt-migrate-test: increase the buf size to 2048 when parse cpuinfo
Date:   Mon, 14 Feb 2022 17:54:41 +0800
Message-Id: <20220214095441.23390-1-liwei.song@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To CH0PR11MB5348.namprd11.prod.outlook.com
 (2603:10b6:610:bb::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8717c9a6-d5de-4afa-adf2-08d9efa012b4
X-MS-TrafficTypeDiagnostic: DM6PR11MB2538:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB2538DCC9534F29B2263555879E339@DM6PR11MB2538.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dK94WNfQHSbMufYahA41WdvSH/Pctv8nbYPasOjlvsoqK71W1nHq3YP7WiMGmqDV+vxRBb+IydHl+MhCyDZGvfGC7u5RmfjrUK8Ad23nI+DP2U6AnseV7bGDk0MHEyUXMXoLISvgNKL8lYWh5ZnZu+umcILgf/f58MxzF5dzwzpbsOL/fsRLMs5Lo+2Y5N77I6GH909bG+G4DB2EQdnEZwEYT5wiJDDwh7VDVfsDb8P++lengtYY+hywvLjdTZi1WlHCnXcyW4tQZe3fS7ja/1sSK2oYuPAHStDqq8RVpu3XemiawUF2RrhStDJeyYnp+pdGb26zi0quAmcarvezp2Qw67blN9v7z7J/0022P0mhu2Ct2smIFZq0LPKb/2uRnqO0blyr+Y1KFNOYHNDdT0//XbIovWj0MIbS9zx6j2gpOa1ueIzEm+FyjRn6bkIAkc8bSpEbXFrgFavTFWmC8Z4D4MPCNfvxY05D7MX+RybQYI9JaLZbcw/IdQaua6XbB+HBB4UM/riPnnKvCuswx79euk7eGoOfjVv8CynHte64VNROlTw6hBQA8YLl0qJAyOjjLkhqPTdPj40MzO+I2VL8Nmip8fNKJSiQGZYIV8CQOYYdHwg49RGv3VV6ZIveodhm7QwpgY4XQ+yEd0KALyKxt2XKjet8C7yG85UdbIHQzR8iX5eio4j2pknraIMiELzPAJVnf39pJS/Aw+jrzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5348.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(6506007)(38100700002)(8936002)(6512007)(4326008)(66946007)(66556008)(66476007)(8676002)(86362001)(26005)(38350700002)(107886003)(316002)(52116002)(2616005)(186003)(6486002)(6666004)(508600001)(1076003)(83380400001)(2906002)(5660300002)(36756003)(4744005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O7uugAD09DAGoROaGVDUthpeAkpMQaOd9dmhtpmqSqgTNuUDqjp8qIXo5FRk?=
 =?us-ascii?Q?HXmYYK1A1sBFBaracgPdRPvN1nJNmAQo/gmGri6SBKzFDj52ci3nIT0A8iZB?=
 =?us-ascii?Q?exirkGh6zugM8aWhgLhi6rjz0UFEcKQ4m2SRBBl5fonJtMBe+pxS9DtG5Ql9?=
 =?us-ascii?Q?z2wHzglQe2rJGxPjmUZTicemu3Q4f7U9XAjlJK4LdoRLyIPSVIQKLIpi2HFQ?=
 =?us-ascii?Q?E17g2o7jWRl5Ve+gUdzBWM/KJsbpGTQrxGCCdTyymlH31KjiP5/fjgv3TBld?=
 =?us-ascii?Q?DpCpReS5+1HA58F2yAOEfkWY2lQxPp4yEXR9PgWbSMrCgrnFqHU9EvXE5MAg?=
 =?us-ascii?Q?OGAHT+gHR9Oqdh11N0rRv8MKwsYzn/py+hOndFaVVDRQXa78jFfL4RzkeoHL?=
 =?us-ascii?Q?3TfyK+lZeG4IfbRR8S9DWux7+dMI1Izd+umAbNbvUoXkn2wJ/jX1jSYAOHw9?=
 =?us-ascii?Q?s0RVxoeyKyo/fGVyUSdTwE4lVBFW/B6k3h6M1nnMIeqho9lPRyf/uMd5gOGL?=
 =?us-ascii?Q?HRXnuRRjvUNCZbvdImPIiWA/OhtwQJmBv7PyBKHAM+ak3wGxlJebCiJpaKr9?=
 =?us-ascii?Q?ULLFlEBhP8cT3lhouMXawWNePe+kq2qRY9gQ0683TrnAINU6UF5G2ZhaVSuD?=
 =?us-ascii?Q?QrKdWPwlA0yQU83A1y0hyANnaZk1j2s0mKTTwYLmMuEvyo3At8EAXoDL0o72?=
 =?us-ascii?Q?XAs637t0lo4lqrNbWHP8UEguLJqIajMLHP9Z/+XwcVJL6wjzBZlKB1M8DuTw?=
 =?us-ascii?Q?UXEJPvwOBJPO0PC3UM3CcInydt+wUx+t/qaVls5RGRsSGCuKw1BqKuXPcDzT?=
 =?us-ascii?Q?7+oXk5zmWr+X7wgdMntJ5IpVuA1U+sNp0N3XxvuFeKkuqy+zVDA+z9UqD8aw?=
 =?us-ascii?Q?RFQIpRdMDJ9d47yNFqgzOjuIHhXFTrNRQLJxjf7y3xfulUEfDrRa4oMq5a0p?=
 =?us-ascii?Q?Mzyr02LT+1J/X53MJ2iFwx1o/MgXZoH2XGkXiaa0ZwGew/NHOcBHQG5pX8nT?=
 =?us-ascii?Q?Bhuac5TmJDkJL4JYx83vpm3AwadjolP0wB/sAykxVssQFxxDHt1/iDYrZCZ1?=
 =?us-ascii?Q?7IXWGNIRXdFsP3iPj/KOhzCVOmGwMkJ4oUFmMiBhP/cbiJ8sa0Wly61UXCA6?=
 =?us-ascii?Q?W+p7zh/T//+XGXCmPD9JVziISm17+D2e6QgfXuACF44seIZzEeDEvZrh+9dH?=
 =?us-ascii?Q?ExMxnmBCK+UKlBSOfjnR7Z6OSlO6TSxejtg+ExBOODGywHQXFzYEktXXYzKj?=
 =?us-ascii?Q?7jkKxVSy2vZjMQOa8fBV0pZrcexFUGKUMwJK9JvW8jMiUsjDQNlSzIXeafBO?=
 =?us-ascii?Q?Pit9CEpX3WAkis806MPGb0CM1+BY4rKBMocj9Cj3TrF3QKLSc4QSJZ7641p0?=
 =?us-ascii?Q?lrkcri2Jyn7XF8viKpcpllI52f+uGJOpF6yrwEArBSj9Loh/zI5oJz7i4CCN?=
 =?us-ascii?Q?ayKkVepuq+JW3szo/gZ8ylo1fMv/eWVCsUGlJ0bwQ4nbUinCDCs+AGkjMtut?=
 =?us-ascii?Q?F/P8xPx4XKRgEh8+iyEIYj0HMt04aUNUHcJ84g0sVJtXL7dp9vpQUyvHLT+R?=
 =?us-ascii?Q?epZPlDdhFi2Jdfvdl/FnTrSQiHwTrDg/k6B93U8qUA8Obb4ypwfwHWvEMfvr?=
 =?us-ascii?Q?KrHlrm6azpKGVN1WQBcK6nXHPz6lsw3BuEJ3RG25eKDv38qs/9tAio1HypXL?=
 =?us-ascii?Q?sm039Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8717c9a6-d5de-4afa-adf2-08d9efa012b4
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5348.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:55:04.3836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tud1XEms6vGf1W8ZUd1QyQtURtKZ7peJ2PXz5WQjWmu+YT9eji+MdOwF6gwIYMspy/GHRud8r6M2KrElNqJAmaEF2KrhzKiLkW8IYIfj8OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2538
X-Proofpoint-GUID: VbnSBz8jncx04TNljmHUylf7B95kmikp
X-Proofpoint-ORIG-GUID: VbnSBz8jncx04TNljmHUylf7B95kmikp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_02,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=680
 suspectscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140060
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

When parse /proc/cpuinfo, the size of "flags" may exceed 1024,
this will cause "realloc(): invalid next size" error, increase
the buf size to 2048 to fix this case.

Signed-off-by: Liwei Song <liwei.song@windriver.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index 62cc603c983b..883e60e21bff 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -497,14 +497,14 @@ static void stop_log(int sig)
 static int count_cpus(void)
 {
 	FILE *fp;
-	char buf[1024];
+	char buf[2048];
 	int cpus = 0;
 	char *pbuf;
 	size_t *pn;
 	size_t n;
 	int r;
 
-	n = 1024;
+	n = 2048;
 	pn = &n;
 	pbuf = buf;
 
-- 
2.17.1

