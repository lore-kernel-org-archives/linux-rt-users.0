Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7D4430;
	Wed, 23 Apr 2025 10:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403067; cv=fail; b=he7KJYxZkcAhZtXs3CFYwyaes7B1xvrFO28D6A2mSjImJIYDHzt3Ou9Wo28eDAjITHTPwZsHYdBWpgccZIswBGszo/zpgAoNy6vP+DwLy5T4al2JoDWpsuNjjZ6cpghLvGuMtae2STJmvqoH5/CrVgx+ZjkuQbfZc3Vc9QLINnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403067; c=relaxed/simple;
	bh=g68E9GEIOyty3XpXQzf6vCuqo3PLHE2OkZgKLDLX4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnGhYEuHU+voes2cfKKUo932Ewo+pvIFnkCKEXNGhAVY9kVGS4UXqYOORqSLGpHzh+zGBbEvRwp6ZxvB9Da1bevZfI3HqpjIXUQ7CEovhYLkwjihSayrY+Er/sXWPQBPwmcUC/JxOKaFbw/o/m4nwJxuXR7UzBu9r8iaV2beaVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=TSf3WJ21; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="TSf3WJ21"
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N3YcHx031883;
	Wed, 23 Apr 2025 10:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=S1; bh=NjR0pZdypqH+crBQD5VAUMM2H3Hmqyy
	hTgJVWpxC4tE=; b=TSf3WJ21Rm/fsFaDNkb1L3jkrtjjXsYjEwAXX8SmCzu/jkh
	sguM8G50iFT4Humpcc1R9j6LNbRFUO4fe+iGd05Gw9QJRMLwAD35+SyrCPFKnaw7
	IzgUW/iIszD+sgDjIzF8gvwEuWeLmeOAt9KtmqXqt4YVg0QtAkRKnfBH/1Z4KWlt
	g1F//G59BwDuQ2hAlQM3pRGat781DMqyKISc05uyEwD7m62jSwm1QQ7Oyxy8x2v+
	TJ1Htap3STLaAqy/RJ0bGR5Du1A9EaAbQCyZxHTtNZ5BS6J6jkEyRr/ccs6sa+nT
	R4q/+OJ1J1y5zVnNbvJ0FiL+7qexzny246kHKuQ==
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 466jj48jgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 10:10:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdQtIRE6+uQCO7f73YGNOh0fRB4QscQDO629qYag7x25p/kPS4Xw4XCSgza8mQzk4LQAJ8i+bv8RelYWfmWJO+1z1uHY/iOUdG/8Qqub2t0dFgRmvnCofUpWfKuvUak1b3O3uUaCIE6LKQV3ZzXsEb1Ms6OcA/ENp4L4NwNe1XxaW6OivIPrHwX35UiHipCJQ3z3X6WFJ4eNpWrOHE1bvn+5aqU1UqKwCBNBsIH196A0z4oDFHOFig/wLqCCNVTaIpAKj8Em76nNPyvcXN11v94B1xFNiHavc13L/R4oFyrxtuMIUlKXKm6m7GHt1sNugc5gIz75u4EHzOf1GGDJ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjR0pZdypqH+crBQD5VAUMM2H3HmqyyhTgJVWpxC4tE=;
 b=yENGfi2Akw3HPM2KN3lH+EHw6CNlXCTBO5ODz/f60FZ4WY3HXAV0ViQWfaeSdUzgpCXgE2vldG4mvySlA8DlMBPM1XC7274BoYlerDYr35D5BMQMYADIKq6ABLZxfmUCliRCuN1iQC6zoyMS290jTFoYZNQeNWnYPUvB+4LUBYbLaYLHtXqUgY8Yhp7gbebsCE+ekIKPlXO+BoPWcVDu+IR6VVT9YzoyLCua+2q250m8sKetKNzHF7p2fc8VYT9We9GY8U+LP2OcmbSRrQcWl9iGlil4ei8WtALbUTLSkyhSfHAAVoVNM0wcd5nMS96szP8zYAYwiGMOXacDVahwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from BN9PR03CA0298.namprd03.prod.outlook.com (2603:10b6:408:f5::33)
 by CH2PR13MB3861.namprd13.prod.outlook.com (2603:10b6:610:a1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 10:10:51 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::42) by BN9PR03CA0298.outlook.office365.com
 (2603:10b6:408:f5::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Wed,
 23 Apr 2025 10:10:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 10:10:48 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 53NAAjCc007842
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 23 Apr 2025 18:10:46 +0800
Received: from APSISCSDT-2369 ([43.88.80.159])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 53NAAibO008490;
	Wed, 23 Apr 2025 18:10:44 +0800
Date: Wed, 23 Apr 2025 15:40:17 +0530
From: Krishanth Jagaduri <krishanth.jagaduri@sony.com>
To: John Ogness <john.ogness@linutronix.de>,
        Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Clark Williams <williams@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Thalmeier <michael.thalmeier@hale.at>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Kento.A.Kobayashi@sony.com, Daniel.Palmer@sony.com
Subject: Re: [PATCH 5.15-rt] printk: ignore consoles without write() callback
Message-ID: <20250423-singing-bat-60c6f6@krishanthj>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zg9d99mp.fsf@jogness.linutronix.de>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH2PR13MB3861:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e7ac1cc-49bd-48dd-1543-08dd824f1f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6VlyVr3MTD5UL6/uRTVQocR54PLdkvoq9620+QmxvwHulJGdPNW1SJbw0wKu?=
 =?us-ascii?Q?/ggwh+Se7hGpAnHJXBB2AS2Y+olAVMqT4bY17W5O86o41dZC+uaBJP3Wlcxp?=
 =?us-ascii?Q?Dpcvgiifw6xnx7GyiVXqOpS6tVjm2tNVSmWAJ318DpkKtG/j4qCS10npcu+0?=
 =?us-ascii?Q?53/KdGFiZO97kalQ68VOBJAK0VAG95FxUsQcLPRh+2m0ncT1l5l1Srvc1TpL?=
 =?us-ascii?Q?RIC95cpeIrVRLxD+wvof3MDtvUYBmo/xymakbvk00Q4z/j2vJMt9AnGaivJr?=
 =?us-ascii?Q?0s5KVLHhbV/p1cGA3Rte1JblyJ/HGoc+g1bwuFNSYiEW69r3twIQj3aQRXSI?=
 =?us-ascii?Q?NqpWuY9Qmxim90ccItIGdfPRNNWIFGOXqoar1CFBjGe05iZPOkyHgR6dxqz6?=
 =?us-ascii?Q?0N/M+EpY78xzHWeFDW5tNsVjuhUIxSfRQqN2TNLSjJOBYmD3D6ks+k8iiv0+?=
 =?us-ascii?Q?9YFUo4th3VN04GXiQ/2thEkqYfvSlYB6gYwWC50zb2e9ztTacUUUhR94UEw3?=
 =?us-ascii?Q?FPveKA7eXd+XpDfqORItOQrk5sTbQLiBqBLB3bvz79AM8RKgxnR8zvXO333N?=
 =?us-ascii?Q?zT9/gYpNUdJCuTbXnFjBn9uxwZrIEPUwvvqlZ6hZ+rrrREG7lJhp/WVVj7xJ?=
 =?us-ascii?Q?qIpYOpreMH+ErUHBszRA9owATUFhXWFqlckTzwSJOyI4ST8/ZVt20qmq7Y41?=
 =?us-ascii?Q?AGw4D/cfabOUJh5of5+qzpAQWCFKnwSMoNcMv3FXa2MwolbvW1w1gfhJuQw/?=
 =?us-ascii?Q?l0JLizp5HEwUK5pZNyQo1cje1uF10NW8B1nxs9LwvLQ0v3WKmaxEDruvLgeD?=
 =?us-ascii?Q?9qRIMK0CUAi+m5CQbTHvzNzzc9kCdtQfzTzUCjF5G+jiTdpjG9YfK8erHqbG?=
 =?us-ascii?Q?1oglyVhgUQsRIBvoqww9LZCpNZXE7TP1ehctjPJWc63vWWkE1ThWuLAWsNoS?=
 =?us-ascii?Q?ktRiqQnzaqZjHuPquzEc+NAb4Mh5oijUrBpkLFlvpfzTtU+BxKL9WmqdHgIq?=
 =?us-ascii?Q?yLNGprnDyRdjzaYc0bklNrRG58TPrIguUH0vPYoAL5YRhnctdzxQI185cyxy?=
 =?us-ascii?Q?ThnjLUmmtwi/ZnGNMY9pcwvVrRM0h7O/tB0oBD+zXnGThrP1eOJgzy+t29CW?=
 =?us-ascii?Q?pAyCkcNMcWM3jtwd2tmzGtcPrZiQPaT6rptQ35VQA7X6IqE3LixyWqLKRy/5?=
 =?us-ascii?Q?MmFrmXeFZqP1vVAX/vXltgsJ6aLGDFErnIaOCnCt0nPCOenB+rRrhdNLQ6e7?=
 =?us-ascii?Q?cVytrYIGCMOcPcur6YKNCMV4wngjQO7yG+AnYZQgKH8yw4AF8GLPNjbILlzT?=
 =?us-ascii?Q?B129N+6wv3h99fJWESiN23oACZq8H6YzOyPSenOnjC/aJ3N1xOIGLa48+FC+?=
 =?us-ascii?Q?wDwEoZYz/supS7hFCctEJ7vzW/IMvVk+aLN8sdqJvrVOLg8QUhu//xfERBTW?=
 =?us-ascii?Q?mqJPF2+38SDrSgcXYbOaotYPsAVz3na/9lKunSnrGf/d8G9H/+FY/u5jZsgZ?=
 =?us-ascii?Q?jlaXo6qjAdifWUco4AVYjhr5lMusEKTU3mSc?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ViyqJgcA/vweVKgfHBJOUS+Td21Pwvrav14UZmj9n4WLPf7s1FiNPsoBFrnricgeQmdk0Qa+xLc3eAGkfFl1TR6LswQp8MvB/dPySMLRnTcINpGldWF+c2BuYynnZ0DHQMzobcppc37BXfxquiIXqE71hIcPQVqt3Jsk/Yc7+E1f4GC3g7PGyKiZCUAwPs2KQSRt0FCslkTYedqCRVBHQRrbnPzKnJTOBz2QXWHreSTPz/Oj81foU2AEa8sf56IB++qqzUqj+Ojfd3JemS4XKa1zkGII1kCTe6qR2Rs06Z60iSG1gkbYM/1ktkLmr+h+ESJpdnXO4CiHs6TpakK88lBD0FaiA0sTDgd8df+G41dClhyyD9AzCrcRCLBXH+2U6DuUl5iyPEvVz62LYBZIEMti8q1SNixL3fP5FtPwnoCQ+CwBksZK0QvLLMjUO168vEubnjsyUuajlGeOxNsdTH51oKw2dZ9C7BghYlptbz0quyterFhu3X/FvXgII+btQOp1WqutO2TSv1CnxKxU78R+edEVcg5u2zmwy4R5ODo2xj8WCwpq/nrO3Myxfhj9giXX2nchubjyJVRbSVpLT51pqDdrBEcrGOlK0Il3VaZmAYA8hAx78q5PoKQfB/9S
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 10:10:48.3261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7ac1cc-49bd-48dd-1543-08dd824f1f00
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3861
X-Proofpoint-GUID: i5laYOotmuhOPORQRTaCTlG1wbm5HEEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA2OSBTYWx0ZWRfX72cgt3CUyyBR kXNjDyGbf5c1ER4TeR/4wYhhA0rdxUaDAV/OtVcs4ZGX0I+WXCT5Ur+WVGariH3X1wrX7B55vqo pK6R6SR8Z9+/b59ZB8XjXrre0rFBJKAYQA5U0tDdXqbG02RuDv3La2mhUswEiedxI008V8jS2F1
 w8CiA1nJLMLSMP2Ueb7j9cn2KtiZDifjwafg10p9OIryze7bJXGtGUzaYpgao6nmw6Y4acBcrFg Ic4Cd1wH+V/AuJ5TkOPeF6cx5cv70oGsWwQYHv6fFKXUPsc0hwx0R+/lc33wwd/g/PDMZ/3NQKg /lxEGX/4L4hyNN+Jh4j7mEGHGnK4K2clyGZQLpQtaszg6TYdWbwGF87FBdcfV16pH/g0yrdySrH BVy6m0xN
X-Proofpoint-ORIG-GUID: i5laYOotmuhOPORQRTaCTlG1wbm5HEEn
X-Sony-Outbound-GUID: i5laYOotmuhOPORQRTaCTlG1wbm5HEEn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_07,2025-04-22_01,2024-11-22_01

On Thu, Feb 16, 2023 at 11:45:58AM +0106, John Ogness wrote:
> The ttynull driver does not provide an implementation for the write()
> callback. This leads to a NULL pointer dereference in the related
> printing kthread, which assumes it can call that callback.
> 
> Do not create kthreads for consoles that do not implement the write()
> callback. Also, for pr_flush(), ignore consoles that do not implement
> write() or write_atomic() since there is no way those consoles can
> flush their output.
> 
> ---
>  This is only a problem for the PREEMPT_RT tree. Mainline does not have
>  this problem.

Sorry for resurrecting this old thread but we actually want this patch
in 5.15-rt.

I am not sure why this was not applied to 5.15-rt yet since it is already
applied to 5.10-rt.

Could you please consider to pick this for 5.15-rt?

Best regards,
Krishanth
