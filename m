Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9FD27E;
	Wed, 21 May 2025 12:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830781; cv=fail; b=LKflzxAvmgLNrsUG1xRSrp/lLj784GKrB8itXvF3/P1N2WmGI8lzHCRLgZEaEufhM24pJ38zTWnaCaH7Z21QO0UtxGtAv0klYDqblZCftxmlRfk20EjnM4YPs+RgsB3uPzhwSmWrDxGDXvvqpz+Ns6gELrvD2fCIt4S/8M+KmTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830781; c=relaxed/simple;
	bh=wOuMBLFC3eghdxMR9K/hjpe+U7hGtnUvGUdLfSwKXmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evf+d0LRWyGoHwjWPv5y0C4IcyKuQXjN01Bocl/P9u4Rde3rhowGTqdqMewMqPwLUKKlRrd8NJtkmErAAulQ2oaBwOZ9qLsZ74M7TDVQw4SN/w8fEGarqhV88IRq+upRPYvjzmBVbJ6aYsteiRT1W/UMMuBOz22ViQHUNXkHvM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=krXmiCe4; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="krXmiCe4"
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCDpUC018330;
	Wed, 21 May 2025 12:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=wph9Hi1
	BFH9fo5rqPC2rxnpVr8jeo8QKk600olC06sc=; b=krXmiCe4Y9vYAI+X3WDhEvW
	/iyMBQ1w/qzu9nY3oUQ+r9SeOSf74IS2klO16mVon8ATtR4YZIcfc1TUWng4tXm0
	hLKN0PSFa1t5IAKFgzXGlkggU+e0QbqI13gsGQvWH3PjN3BoeTc8c/Im0xqcePI7
	m9TwjTGGA5ecimYyRJnYs8J/NdoGeTQrCg/7VF8hP/ZMtrwQcRDCobXk71aJ/aSa
	w0hGdqfctyMmnG0Izk9TzIu2hiSadQvMdzeJK9iQz6L6PZzkpQatT6/NvfLSS7Tr
	Z0ITGdGBWGywPrw9T8gCKhvunOxCu12qRryUUp0+OMEKIfb24O+vxxV1YB9M8uw=
	=
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46rwgyrvtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 12:32:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmrNSw9kbJu9NlbQNU4eIt+pno2aEP9H/yH2s1qzPKpfF6z9jeev9nXdL0fHqICztbyoEjktPwoF9NFJjpbJFFlRLoUeEpl+q/NE0+e6ARKbkbVLIgKxEN7Bz2usANGDSW8J9tA+O6MaBhGkRGH/7A1DmhivXg7lHPO22ZqoG4YWklgS2FQG5CQFbxEE9YBNA37JhydKVyar8vfD+zD7DZP5RSaApO585Qq7PKmBHBO02qYiB5w2e/+Rt9huZEBrUVI8goXU8XEwK/ZjaTHylStmvc1NayT4vEqHA99iRsur0uNTZBF8Clgph+bk+XLKzrohxarr1XWSIWOB92ElcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMGrlkkQd8LouVphnhsAL6xD00u96kdlXHc3CIW1ntM=;
 b=eBJ56eFkzrBylohQ8pvmSDPejeGgpz6T4/2JK/XSJ2lcr4e+i0SeCqUsrBcE8bflJ7SzU8a+0mvZG6WXaV/h9C7QMQ1AnkM1k7MyyH56QZJgetNaUbR76lpX83dwNyNzT/9y9ez8raCtox3H0X8hMEUTWg32VY1Zuoye3ntpUoHScxkP5PfI0ht8vPxz53aj5DTTYogQijAiIPKBMTHM3Pdh1LMPrGtrtgRqKMvMsPqCCuUUG4bxtiZWfSWDsLktkIo0OVaZbWqVvnsNvDK+lTV4Z/1xOCCrKVkMpWyzZH3bpi2NRyUiNiiRNnksZdvmQx+KsFdt4s72gDLyuFGDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BY3PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:39b::32)
 by BY1PR13MB6641.namprd13.prod.outlook.com (2603:10b6:a03:4b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 12:32:49 +0000
Received: from SJ1PEPF000023CB.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::db) by BY3PR05CA0057.outlook.office365.com
 (2603:10b6:a03:39b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 21 May 2025 12:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.198)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.198 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.198;
 helo=gepdcl09.sg.gdce.sony.com.sg;
Received: from gepdcl09.sg.gdce.sony.com.sg (121.100.38.198) by
 SJ1PEPF000023CB.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 12:32:47 +0000
Received: from gepdcl02.s.gdce.sony.com.sg (SGGDCSE1NS07.sony.com.sg [146.215.123.196])
	by gepdcl09.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 54LCW9Ci028266;
	Wed, 21 May 2025 20:32:46 +0800
Received: from APSISCSDT-2369 (APSISCSDT-2369.ap.sony.com [43.88.80.159])
	by gepdcl02.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 54LCVulM032024;
	Wed, 21 May 2025 20:31:56 +0800
Date: Wed, 21 May 2025 18:00:55 +0530
From: Krishanth Jagaduri <krishanth.jagaduri@sony.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: John Ogness <john.ogness@linutronix.de>,
        Clark Williams <williams@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Kento.A.Kobayashi@sony.com, Daniel.Palmer@sony.com
Subject: Re: [External] : Re: [PATCH 5.15-rt] printk: ignore consoles without
 write() callback
Message-ID: <20250521-platinum-mustang-ed54bb@krishanthj>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <20250423-singing-bat-60c6f6@krishanthj>
 <ac016cdd-f1c7-46bc-bd27-0248b5dd6123@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac016cdd-f1c7-46bc-bd27-0248b5dd6123@oracle.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CB:EE_|BY1PR13MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 49448206-62a4-44b3-5efa-08dd98639854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?RcJVTT9/T5UDJCmYZ2BVJfXf2zc9mW+ZTWfSQMW2es04o1bPEjDl336mF6?=
 =?iso-8859-1?Q?WGei8OnJFCo6dF5vIIiJPItbE312IUCOfxSMxxCrC7LrxicCtISgB7SgbJ?=
 =?iso-8859-1?Q?geqBXm+I7jIDUgmALefHuBpt95DErnRidLu4+3DUtf1zw2MbKN5QsWs+9h?=
 =?iso-8859-1?Q?fAQ/nZtx2Xg5jNA3imh6wV5MVKmcUs50itlMNMMN1HaJeO+XztfV/DaEjC?=
 =?iso-8859-1?Q?X0NxmWoXSXh1k4aLojZ+VfipGcyS7gUUp7Skb3L8+rrQW/LjMfTzqPZLEj?=
 =?iso-8859-1?Q?ffit2Nx+Sim3zBviV3ddbzXdTVDTom0uwDSM33kh656SnpiCJvRDzywFRW?=
 =?iso-8859-1?Q?Gu5NDVKI+TB87l1YKz7AUuOGXPJCwODBkugwQx+GynpAOXIN2C0LYcGnuV?=
 =?iso-8859-1?Q?TvueXPP3fZFA/scAZnGD8VlW4HR5tjPTwAqH0ddufesvNZRvm1PD0qB7Bz?=
 =?iso-8859-1?Q?+lCCeS3WR3dwYPXSttPt8DH+ClVguc9vI43rpXCJ3V+Oy9hZlbg3Z8kJ/U?=
 =?iso-8859-1?Q?pcJTtCMKALnHwyYpbl2iP7T7Ic3NLdPEBhvZngWdjGyYU1EbNYn0Pwisx0?=
 =?iso-8859-1?Q?n88Bc+Diq9ErO8BlWnUWXW+sy65spiMa0h/0p3/Yt8c+ycRXJYbCwHOTDk?=
 =?iso-8859-1?Q?NlNVnMc3dniwsyoO8bzfQ4XhK23BB8Iuw/yJvSMD5ZsTym6Se17MnAa2eG?=
 =?iso-8859-1?Q?6H3pZIUMzGBiLabTnWjHfxaUsjSlbNbeAWiYyFc+gwSTpVSV4BLlsmEfPt?=
 =?iso-8859-1?Q?PyCXz6OQuLDhwAL0pDw3MDQvSG27P/43c7qMXr23Ejv6IHfN4KpRDiLhFG?=
 =?iso-8859-1?Q?4h36ULU/cciJ5FhGRB7sADr0M9xtjQtH0dHD8I3vSNk0IihhkFu3ywCC5X?=
 =?iso-8859-1?Q?Jbh6Iw2W/acoBWuhfrtp7ZzD/wvW6lHODmDZtp2Yqsfi+gOX2PaO9TRXRK?=
 =?iso-8859-1?Q?Upg1ibs3EbFmh/nFAoR2Ugj3qFRVZO+TVF9Cw8RP/s6EkCIkcn/Pk/aPOl?=
 =?iso-8859-1?Q?xyj0dHnEYZ41l85ya0wcTbVXqAFi3NQRwJ+NHEmdTk4poA+jSMXYthiFS9?=
 =?iso-8859-1?Q?Ny6eEi5thlGspwokjNcYPOqq8RO94dS6XyhyHuHPmOgvxjC+UtnYDDlpEr?=
 =?iso-8859-1?Q?xLesWQMOtpHjMR8TP13sYcnqQbiSpDWNQ02JgPxAOUaqGMdd9NVEtOlDvD?=
 =?iso-8859-1?Q?suxAzv73b86W1Eu7xPNJKYS/zgsAIOtFpHR/cSoHQwpp/rIF2m8Dqfzh4y?=
 =?iso-8859-1?Q?mCd33JAxmn8RXNDRCSxc6YodW0IWu4UT3DbeqD4xIgGAmH4pOIFK/tnG+8?=
 =?iso-8859-1?Q?hz7P2whATqzsUo5wOys2k1ju212LiJvnhGd7GN1GA2i3eTz7FIO06RHULZ?=
 =?iso-8859-1?Q?I4E26j1ac6VwN7ba5rTyEb47d8GwBATyVhUZltj2VtygJTHtJioMzP5ceR?=
 =?iso-8859-1?Q?Scs/t75pktzLFMCAqdrsyIR7BxAj0c3k4P97oL610EPpXr6Ek0Nbk+SXgk?=
 =?iso-8859-1?Q?VDeDhAfx9tWS/yd7wBVE8NZQGSP10BqubRAgfPL2CWnDCrZfWaXdm4PSTJ?=
 =?iso-8859-1?Q?skbV3WchZVrESLOeHmdWjtG5asue?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.198;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl09.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bBPMv+nN3R7rViQqXrIY4YZ7VDjhNjn/O1eAsqkGy2+MkOhrDWMjg5iA5f7tfSpYUhAVALEqK+ukR0oPn32bqlJL+p1OVdMoKgplwWIs3+/hog0pxlw3oT+AwsfAtbW64msSKUwaX8JGN9irj7Sny23afvhxfoZOyd9U0oO3FZPTdDmp68fYws9e40z6Szn5fhQ+Epe5NB/eE3ApdbeG1mrGi/KO6refcfvvBXRbhXngO5vYQEz23DwLfa5gqPBQ5C0JZ41d9wbq/nm53Xxm3Tou9f4FOLQkiG2zRqYmqu5Fmlr+lgz6VnOEWa2nxPvBUm3llZ+UnuotqcFSD35xrmQn9I9ItlrlfKy3+gLH8FXbqBD9KWTcr4uSezSKxtrRwPu2gfm8Ey8TWOoXXvtpyGCxZybAfdjMpQZrvl85THDBL1tVYQiJLV5Qsc3Zl7dVJAqaVLsqfH1cY3hOxf6Axq1gOGFThKg1e7qqXkSx5THpmUZXRY9sVN6xsgnpK3/M63KR52grcKNUZOOYJnLFlxOJol2ya/MQQG0yX3X7cvPJLvHgOR2xdOVl0l7LsFkz14i0kQDwAp0fCPA0/y57w1tLVdoHFUMPbePZde6YcQasHxkcBFfLN0CELnBuGchs
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 12:32:47.5700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49448206-62a4-44b3-5efa-08dd98639854
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.198];Helo=[gepdcl09.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000023CB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR13MB6641
X-Proofpoint-GUID: qppoctzPhHRb_5I9xjN_bOU4-dQfBX30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyMSBTYWx0ZWRfX8EA/GqqCSW95 UC/XNiTI4VFrehW/RynhacJDV+XDuqwoeTXc2IhXgsCTtVQEegot7rC2a7shixdDQOZa6pQIxrI 1XSPgj1pknZwbg4HA4XyQXnSIdFqL3DpKdhsKYelDBUAmD/FP5BEFcLJ5G03stBz/i48byT4BGv
 qkCf2hKIwNHSA+mFsVKlNVSqgz/uBPxlsGuElYyvCbRzgDewRHVzg0QiWnWxeufEidd5hJ8ceUL Lj7gCzCmXbYnMx59G4Kuvqovic4Zwb1EXPAQ8++DfhjrhLEqRaWZMSmckA002/lZtZ0TvzoAQiQ s+NqohaLUmwsmyWPmEWG6mKlBGiUmtbIkhZ3R4/cWh28Za8YeOUOOfFHwO4abXgPGW2mdLpfZZ4
 bYsw5Gtd2b+5uqWoZjS7Y7amNpwjBEo51CIxecE+cXqZ1cFx/6d0Xv7kSzRmpqK3mFrIANo5
X-Proofpoint-ORIG-GUID: qppoctzPhHRb_5I9xjN_bOU4-dQfBX30
X-Authority-Analysis: v=2.4 cv=NJfV+16g c=1 sm=1 tr=0 ts=682dc7f7 cx=c_pps a=NmDNviYhsTavHyS1iw/olw==:117 a=DqilkWtliqFtnzj0yEUnMQ==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=s63m1ICgrNkA:10 a=xR56lInIT_wA:10 a=2BH7_tnKY3gC9vXqjmgA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Sony-Outbound-GUID: qppoctzPhHRb_5I9xjN_bOU4-dQfBX30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01

On Mon, Apr 28, 2025 at 10:45:08AM -0400, Joseph Salisbury wrote:
> Hi Krishanth,
> 
> Thanks for pointing this out.  I will investigate including this patch in
> the next v5.15 patch set, which should be released this week.
> 
> Thanks,
> 
> Joe

Thank you for including this patch in v5.15.183-rt85.

Best regards,
Krishanth
