Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20530CDBC
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 01:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789435321; cv=fail; b=Psn3L1fmdQVkoAaXW9ytRn4TNwhzw9kqTj4ll6p1DhNi3bYYa7KVTtWRCCjCcG2hg++ugkfELgTjaGQapy9FadtvIFsx61vDypyDDLqGP2OZE7ll2j9Etc3O/TbouCQ2CD5aPrTNfO7j2ImveaJmX5XAhUVbz+uwWz5bF5mtGfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789435321; c=relaxed/simple;
	bh=gDVknxO6PDOxS83z9SdviUptMOYAL1xnIkN0CRgu0gE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oh0FMjdTEr6aT3vB+sqNCqUnzN68OkiP+8xzhzSiQ+C4NVLl8QO5YQxha53ZFkHmCnRHKpg3T6yBv47GHdVQRLQ/nQg+ApI/OXQNEMXw944JkYRpXZriNjDo/AEtytcpRrLZOMla6fF+YmyM+M0EoQNFtAhnd+T6HAyVtBdMOmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=fM8YGgd+; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="fM8YGgd+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWEz7eYvKycwaYtWLBeLQSbWgDZrnUl6qLTjHxrtHNQnqpSKz34imYXYfKTkQypGhzVuLi8tJLy/I/HrgITXPLydZuU1VG42/q6o7DJUlu+ijsz+ofIHAmtPy9HUBMYgqD67DRJHTS52BW1nOmQQSgMlq+V9RQWRGn2LSjBkf76FrO9HeJpxCMvF66xGbTCdVgB6NRxinjfuSn25jlVEGr37klZuIkVkS4hn5kN7W5nujwGuWPjzldzHsqLuJbfjsqG6z5DjFkUuDzaxlYiBrxkeiiBfITgTFef67Wer1JLY0Oxtp/VE4EfHOm4GrfZZDylzK9puhKB0RGv5S2DJHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vKFBIXhdU8wk0AK6yWAcqCFDAFhR9iIu8KN9A2yF7g=;
 b=aJBJlvGpfBjlvbUw6JODnwAO+b1BXnl75xSxRYN54r08Lm1Xfc10+nm3BNPCXyyKiKpxy0fMHOM93GOqrjJji8jghLMVg1+3hSf0SKDY5hmgBThfiUy6FmRffLZWrlwGwUh7qnF1vfbeHyRBTxi1A9RGB5kszQvB9m7vkQx2rbTO0YGivS2B3eGGbdxwlFXEcSQFkG3pHhBQY1/v/ZTVrkX+2OWPx4rHpMQYoi2vkSNTlRQglFEfFVNApBBjrYY5bCzRZUoDGk10o7DPElhndYQ0nzThMXAqVzcXXb/HvxTaweFFOe8OmmVK3weTdNXErjvxFThsOO1zjd2zY1JbDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vKFBIXhdU8wk0AK6yWAcqCFDAFhR9iIu8KN9A2yF7g=;
 b=fM8YGgd+0rShT2/HGrwOy02heFo3Hs1ugF2ucbVaqXqVZ8SaqhKiD2IJ5/oRf2wFSSnxSOG2C9WTXWqCO6resIsOo8iDmocrVYVk+ieaomLOC/5HctZRVz9/kTxqbGYVOamaHWYpAm56dCOtZeXJ7MyPke1vESdi1jcdcxuGOaVftYSLsGPsTl2RhsPyzGVbcXeNNBohonZU6vGnRh7JCJ85ZRsbGavQh1HEs8zB4apRK9xjq1UwyUlcbNxyPfE12cu67zO819nQD5AUqfDT571kaqyVE8J/HkAacTmH3PxU5k/sBOBFayHhMXhMV2U3dBuet+/IgzUVsyLrmR23TQ==
Received: from OL1P279CA0024.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::11)
 by DU0PR07MB8906.eurprd07.prod.outlook.com (2603:10a6:10:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 01:21:56 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:e10:13:cafe::3c) by OL1P279CA0024.outlook.office365.com
 (2603:10a6:e10:13::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Tue,
 15 Sep 2026 01:21:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 01:21:55 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 15 Sep 2026 03:21:55 +0200
Received: from seroiuvd01221.sero.gic.ericsson.se (seroiuvd01221.sero.gic.ericsson.se [10.86.87.142])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id F1A5195800;
	Tue, 15 Sep 2026 03:21:54 +0200 (CEST)
Received: by seroiuvd01221.sero.gic.ericsson.se (Postfix, from userid 7162142)
	id B740C60968CE; Tue, 15 Sep 2026 03:21:54 +0200 (CEST)
From: Jinnan Li <jinnan.a.li@ericsson.com>
To: <jkacur@redhat.com>, <williams@redhat.com>
CC: <linux-rt-users@vger.kernel.org>
Subject: [RFC PATCH 0/1] cyclictest: add --warmup option to skip initial cycles
Date: Tue, 15 Sep 2026 03:21:53 +0200
Message-ID: <20260915012154.2172762-1-jinnan.a.li@ericsson.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF00000520:EE_|DU0PR07MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e14223b-6740-4d14-e5ce-08df12c7bb26
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|56012099006|11063799006|5023799004|3023799007|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Qo/to1LdpERhttOf1Ow00zXs+2N68s3kBL5Zr3TXu1vMcb9rbcflZXoU/WI7RKZ2BZYOmW9e31QdxtbFmvweUUeUKEQMD+LiqovskF5G5fQgbISsOSPXx+KMiPBmy1EG+YOTd4Yt5vs9mggo5Pvy37xeVjyQVIxBdswwoaOVrKvvaIMqIzGul2QW1o9KmxPpG9cu83QHwyYG8EAFauhotWyJW/wZnCz4imCn+EqfTAfqSBt5hCNBUytxC2sM7AEFFQmdZn79dQjUSAuE6mXfbBmpqYh8zDkp2OnhCAGWe8o8mDbjTq5l+yY8K47uZtrt+8K6zfotQO92Mla8rnq7E2ssFr3Ew7wJp+6owePhH+96kvJOq449DItutC7UvmDVGED2NlMmNI0OnY8kRSMvzmK9q1alxI/NACQSOubdei7ObwG8EKwJOV1DOTMUObnk07BbH7HOcx+j4rt6+b77lqdiF/5hpQScv9a0KawdaUMn3ay8sxiSZzZr7saxXF0ucgukXr7mBeb6RvyreEO2rIlTjSCaAc6AINfnTa0sEjMA8RJutKlaE1BVF81s90XfmLfu6ELtM8aGBvVTyQxUQ5EZEJUS8L/gZefdbAH8ZQwEdj6sDEAT731xgHyYPhGh6GVVq+7NCmVH7oAP1fjGn/eOc+pSJY403P/5/QVuEKEEd+Z5LfRd99sMiOUq8WvLnEUPg35cQ7vMBCHnqlUiyg==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(5023799004)(3023799007)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WOIa10yOY4TdCvFws2IHn7nOJXdvYPBdjAbgySNGhO3Pvq5qXqJl5GYWgqTvdi3qBkCcaSbIx5m0lcg0PJNu/XpS47+VYwMPIV1UVREv33e1nN5vFDZ4Vp9QOCgcVYf0v9vMKUnj9seR75rR4eR2MTYpR3Cv6eJDWlafKKNsJuRWa3W/myQoX/AtczwbWQejgt62uwdVXpK3C8+vbFU2puT/R3Uv2uPaFaQ10Ftc801QZKZirEL4JMk6nLRzeUlfn3j5HUGZ61YoQvgz6HLs4o8PLFbm9GV9TNNatvXJEHVTmzkFZQBon9zHQwFD9vSujJLk87F1hQdTbH7qHEBVM6bvtFT9Og0YFH0WtGerjjsHdr/B/YctCfyHGykQYNo9Cti6JDwDHoHsSdy3YkGeQXbF2omdtYjZu5N4Y/GSu8bS0R/LcPzJPVLrvwop5Z39
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 01:21:55.7182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e14223b-6740-4d14-e5ce-08df12c7bb26
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB8906

Hi John, Clark,

This is an RFC for a new, opt-in --warmup=N option for cyclictest that
resets the Min/Max/Avg statistics (and excludes samples from the
histogram) after the first N cycles, to keep one-time startup transients
out of the reported steady-state latency.

Motivation
----------
On a multi-threaded run, e.g.

  cyclictest -m -p 80 -i 1000 -d 0 -t18 --affinity=6-23 -D 3s -q

only the first setup thread shows an inflated Max (e.g. 7us) while all
other threads report Max 2us. The first thread absorbs the one-time
cold-cache / TLB / page-fault cost, which then dominates its Max for the
whole run. Discarding the first N cycles removes that artifact.

Design notes
------------
 - The option defaults to 0 (disabled): with --warmup=0 the behavior is
   unchanged and the histogram path is identical to before.
 - When enabled, Min/Max/Avg are reset once at cycle N, the average
   divisor excludes the warmup cycles, and the histogram excludes exactly
   the same warmup cycles so all outputs stay consistent (verified: 1999
   vs 1699 samples for warmup 0 vs 300 over 2000 loops).

Questions I would like feedback on
----------------------------------
 1. Is this worth having in cyclictest at all, or is "just run longer so
    the transient is diluted in the sample set" considered good enough?
 2. Is defaulting to 0 (opt-in, no behavior change) the right choice?
 3. Is "--warmup" a good name? Should it get a short option?
 4. For the corner case where the run ends before N cycles complete
    (short -D, or --loops < N), the stats are never reset. I currently
    warn in the --loops case; is that handling acceptable, or should the
    -D case be handled too?

Not yet addressed (would fold into a non-RFC v2 if the direction is
agreed): factoring out the duplicated effective-cycles divisor, and a
guard for printing when min was reset to UINT64_MAX but no post-warmup
sample arrived.

Jinnan Li (1):
  cyclictest: add --warmup option to skip initial cycles from stats

 src/cyclictest/cyclictest.8 | 22 +++++++++++++++
 src/cyclictest/cyclictest.c | 55 +++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 5 deletions(-)

-- 
2.50.1

