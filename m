Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013059.outbound.protection.outlook.com [52.101.83.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A823BBFBA
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477793; cv=fail; b=sTY/A0q4PA5/ecVq4l3RIUMFXrhIhB+bIBBxCRjHoBrNOhW09vC27rfh+1l2gjZwK4wv0jcKOEsjM4cTfMtfAvAo1Eyg0tCzu3Y61XprSrH2Kwz0oqHRfUeN2T46IwZTLkLpyoauMUySUlv39lUc0V1vXDE+5JbnmtddlU+t0go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477793; c=relaxed/simple;
	bh=a520cV1OFMSVlbu35vshxWnLrK0VcU2sQeJDPtMkMVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaIFWPWVI4sFca5xaxuhd5mgq4axzs1RK2nL1BAMhiI4B3CmvdpahRVeIAlQpxglQSDWgoBPEmFgdGzxK0H9XHbRCFDRwjesH7d8Tw3aOkoXAVDyJnf/7ArocXv/nDPE7tcrjzaE9GMNbczAW+Z1N203s6frHlOnDyskxy730CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=hoKopN0a; arc=fail smtp.client-ip=52.101.83.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="hoKopN0a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jHwYiu0S7U8uVbYEzCGIR2BGH0bYtbpxOKXvIc1T/2MZb32yophrOHOW8CZRuz5CxLMkinWZ+1wKlPRkaBVbOSl5UPPDnwjoOLkIlXvIKUN+OtTDzon8CDKJwoQt4J7ov/VsTMRgW0G2vVVjM0LfD2XetOE9hYFifVrEBeYjUHAabhCXUEqTyM1tSRVwuLu73oGWk9uHZwhpb+3xaLAu3UNhud8fM9s8opZFZcW452sjxli9uSnbrqJ4JI3INl1Uzyke/KfTtZylfxhm2ODeB8y/F1EZqbKTswMie9LhQsMqkpHd+K0RMSZj2om7UVQ+YKsm+6AnYbcT8T5Z9WKyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=faG2IQT4DyzprdGo9aACPC/VQX2kaPgg3ZqIKayIch0=;
 b=DzYsX/0lddUIjF/72D4W0398RkHZbcgrfKqfeHh+F/NXlW/YE8oPkbkMBnWVj5xEViZwcMl+qFaOo5Z+atk+Bh8uWMKHWVBIlU4U6xblRwewIKpIFEiiDlQpbTQbRwWnfOjOMPHR7Bq//tj/Bn3sC7fl5MwXh/vHAO9+anZHxzjbtjQ8H1yE3l5eJFnfHeH1ppiGAkVlcO2lZEHcEy3OMB+PU2726X2haVtLj1qJIgriVwzwGTijr6T0gTY8nLKwnvDp2TiiRNu1CpFIiGebImDd23sTWNoHbxD70XwpjL2rki3BmoJaWv8uXsW+2+c6KkEHlfQ0lvQplWXBj2Ni+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=faG2IQT4DyzprdGo9aACPC/VQX2kaPgg3ZqIKayIch0=;
 b=hoKopN0aTqiVe7PmpDXRhrwnZM2Bt+AAsMRNHeIwDGe7bdxBY3egtk0nce8MIw4PxIrEk4lBHwoeezCMQi4JhT82tIAczBsbelZJ+Jqmw2MJu/l7WyGTmf+n7wAAe1jmCohXytXmd1xNqhxxYz0bBvINIgms4u+2ro52mX3hfDKDjj+dTpV3nqLXGFSGoPYK/BE5OeqgXy69UAyZH56SWLdWK5CSi3zunuzvdiyJnjoazmHRPctzuSyV3YNtPesFWAmTunFMdS5hn22tP01e8i80jSOZ1iPeeDJRNPrR0okCOPpnjR2SXIbsQgZqD+j6CFCdsxuQltE4xXQ4UNWh5A==
Received: from GVZP280CA0056.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:271::17)
 by AMDPR07MB11213.eurprd07.prod.outlook.com (2603:10a6:20b:718::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 13:09:47 +0000
Received: from CPH1EPF00000520.eurprd04.prod.outlook.com
 (2603:10a6:150:271:cafe::90) by GVZP280CA0056.outlook.office365.com
 (2603:10a6:150:271::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 13:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 CPH1EPF00000520.mail.protection.outlook.com (10.167.241.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 13:09:47 +0000
Received: from seroius18813.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 15 Sep 2026 15:09:46 +0200
Received: from seroiuvd01221.sero.gic.ericsson.se (seroiuvd01221.sero.gic.ericsson.se [10.86.87.142])
	by seroius18813.sero.gic.ericsson.se (Postfix) with ESMTP id E744095800;
	Tue, 15 Sep 2026 15:09:45 +0200 (CEST)
Received: by seroiuvd01221.sero.gic.ericsson.se (Postfix, from userid 7162142)
	id BBAA160968CE; Tue, 15 Sep 2026 15:09:45 +0200 (CEST)
From: Jinnan Li <jinnan.a.li@ericsson.com>
To: Tomas Glozar <tglozar@redhat.com>
CC: <jkacur@redhat.com>, <williams@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Subject: [PATCH v2 0/1] cyclictest: add --warm-up option to skip initial cycles
Date: Tue, 15 Sep 2026 15:09:37 +0200
Message-ID: <20260915130938.3703652-1-jinnan.a.li@ericsson.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAP4=nvRU3DAm2dg-TM8-6+QQ+0gNNhvFXp3Tu9rfM=2wbwJ-Ew@mail.gmail.com>
References: <CAP4=nvRU3DAm2dg-TM8-6+QQ+0gNNhvFXp3Tu9rfM=2wbwJ-Ew@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: CPH1EPF00000520:EE_|AMDPR07MB11213:EE_
X-MS-Office365-Filtering-Correlation-Id: b8384e0c-32d0-421f-e17b-08df132a9e06
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|22082099003|18002099003|13003099007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	9ublorYHrn2IyxF69wn1PJFUyXD7Y9GT/LGorlgHSo5NL7TMaAXdYkOfbFTYhvtmPLe3M2vBYqLORaUYScciIJouX5WOVOqV+4wFEzndCAwB21+QgoBnZYQ9nWg4t4c3UH3cQiuigLv+MpLIIf1zxqMfLDizQD6ZN7HkSANXtL8D6kc9I2DQONx0YXvfZxLADa362I+EuBqf6VaLi/uDpB1MuI2uPPhuK3owubD57TFYzO5lluoK+0VXkBO4xR5rE8PPL0ixYVxnyGuRjASY3JAYQqtLGxmkKT1rOuuyJuN6vR6282Cm4yaNMLf9a09FaPfKuWYeaBAgwferMMqj6TUaA0okBnfPV4Mb+hMUm3BH8VAs9jtYvHtAQCog6OI4MdLJ1Tc9MpiJkakRJj4cv+jZav6dEvZ6qqzlGPeKcdgYSYWg8xzrz3Txx8RZtlVxP40lWgMXCgTKMO5tHuxDM/NJqqYdHeViEMnok8vqMclVEaZ6sdNRifLFbjbvMkgLUan8XBtqZK/HLgivahBOxYYKKPejqifPSmNxVu0SxAsqkxjvCsSIUeilFbYYu9oXt8gkBBEaH9LcnhG+wpj1ZA2jyQp5jrz5DrHX4/1e2+mzSa6M1JoruyWVoYdC9XRbo6aiC8Q0RbC8ZLcfwAyPooZL9n/Gm+gJZYKo9hyr/M3mrqqo9tQl1pKVCRFUWXbbuUP8VDaCVTw0LCqveEG9dQ==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(22082099003)(18002099003)(13003099007)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bYFSDGqeP1NOHG6VrXp6jFe6kt9yn1fUT8X3LMqs88RQKpDue+s/pL9txi8rxdhvEVmkYEbB0Gh1ywbkw7bW0VuXorD6BHyzqWtVtc5dLIGtoSRSZZgCHLkmuGp/ECWaGUPyQTVje5FMkLeW9yvkP57OE7PzpgT+qJn3KbBTO3VpxzUkTVjbhpMuIwYOYRtMZ0EwUC8laWnPttCIw/rlp4RRX8q5F+a5ff1jtDTJwsJPzE9UROCZ2KlDmGuKI1A9K87Ejucg6vchms+nsQYAbAkkWnvS747KwIA+GGA0bWXINCdFzE3UiXZjR5KJhwVyxoS6OL8Sjxu5h0WY14x6m3uxT3C00DLMurRtxlrhtHgsZAenaw7eLqRO3N+WgUtKfAMCcfOuTMVNVilZP2ykGfcAc542lGney2YEJXVBQT8aUeeK24KB88Y4Kc3h6nUc
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 13:09:47.0234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8384e0c-32d0-421f-e17b-08df132a9e06
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF00000520.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11213

Hi John, Clark, Tomas,

Thanks Tomas for the review of the RFC. v2 addresses all the feedback:

  - Renamed --warmup to --warm-up, matching RTLA's spelling. No short
    option, as suggested.

  - Instead of collecting every sample and resetting Min/Max/Avg after
    the warm-up period, the sample processing is now simply suppressed
    while in warm-up. This drops the fragile reset/boundary handling
    (min = UINT64_MAX, the '>' vs '>=' histogram/divisor alignment) and
    keeps the statistics and the histogram consistent by construction.

  - The warm-up cycles are now added on top of the run rather than taken
    from it: the requested duration (-D) or loop count (--loops) is
    measured only after warm-up completes, e.g. "-D 1s --warm-up 10"
    runs the 10 warm-up cycles and then measures for one second. Because
    warm-up always completes before measurement starts, the short-run
    corner case can no longer happen, so the previous --loops warning was
    removed. This also matches RTLA's behavior.

  - Man page updated accordingly.

Opt-in with default 0 (unchanged behavior) was kept, as you agreed.

Testing (target board, kernel 6.6.142 PREEMPT_RT, 8 CPUs, 4-7 isolated):

  - "--loops=2000 --warm-up=300" reports C:2000 (300 warm-up cycles run
    before the 2000 measured ones).
  - "-D 2s -i100000 --warm-up=10" (10 x 100ms = 1s warm-up) ran 3.15s
    wall clock vs 2.05s with --warm-up=0, confirming warm-up is on top.
  - Histogram sample total was 2000 at both --warm-up=0 and --warm-up=300
    (-h, --loops=2000), so warm-up cycles are excluded from the histogram.
  - Multi-threaded run (-m -p80 -i1000 -d0 -t4 -a4-7 -D2s), first setup
    thread T:0 Max over three runs: 6/5/6 us with --warm-up=0 vs 2/3/2 us
    with --warm-up=500, i.e. the startup transient is removed.

v1: https://lore.kernel.org/linux-rt-users/20260915012154.2172762-1-jinnan.a.li@ericsson.com/

Jinnan Li (1):
  cyclictest: add --warm-up option to skip initial cycles from stats

 src/cyclictest/cyclictest.8 |  17 ++++
 src/cyclictest/cyclictest.c | 149 ++++++++++++++++++++++++++++--------
 2 files changed, 135 insertions(+), 31 deletions(-)

-- 
2.50.1

