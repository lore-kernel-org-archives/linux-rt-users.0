Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFD2DCBF1;
	Fri, 23 May 2025 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.183.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747976833; cv=fail; b=WR0WoQvHHxyLAi4aZYcegaKAMF/oqWs96rEI4vALHBl3Dk6blRu13kyHnG7AGY4dPXKTnTy/yEwwh4pKDZyWYPOgsCWH/RBUpdI2Ky1EfCysihbCfnjMQKu3yxKr5SDPWQmiOIgDZW5gDKHQta1Vo6mKRs5p0fBbVeyTF3csYxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747976833; c=relaxed/simple;
	bh=w8gVMTK82VPmTFOG2DMWZYCd63qpvjoj1uG62qWiwl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkMQyrb7KadUMvn1dsWYTpcr/uDrNtrCvseLMmApJpHEC9ZyQU8fK43fdsg806WGEaKOz5j0xOmvt8qeKon4DWtueQ4VbyafoktMXWce49oML0/XKuh2tlhmCqn3Xb8ym/8S7IbfoTiOsfLKrH8qfyx6QNS71wacxrctmP3lrYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=OQt8FmLe; arc=fail smtp.client-ip=185.132.183.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="OQt8FmLe"
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N4RFpP021271;
	Fri, 23 May 2025 05:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=S1; bh=WYjtfLh
	nrT+et+fvrYu5l+hfWPu8/0uqLPgJBw1t6ws=; b=OQt8FmLeWAAj5KrZP4V+oM6
	YfvEsT7ceL5IuAmENApJ8aOGCW7t77Ycu9cJJrL26fdHsnFfyHlh96VyS+8aAlzX
	nvC5zhjeoIWGUw/nO0XxMp0thL3yuTQ7ojRfJ9sa8JAoDD7La9GREdJXuc1GxqVi
	0UZmCX2wd+qOLAD5LMEo3Vv0TuvtvtVSk59NVyU9YNvmvzxYGf8ACkwA6xtglZ/K
	U4xva8bD08OqzaIiXKT96bTzxbpU8kdW7+WuiygNDRfTABqwPfIsRJ8yMb09PBb7
	rsuyBZpc5Ua/xpkg6TLrC/PH47wa981J27xkglny0n4oPORdwUD0bQ6Q6WyNnWw=
	=
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 46rwh12m92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 May 2025 05:07:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfrtEOXXD1i1944erabIBbQTs1B3hC1x2fneLJuD68gGAxeYyS3aJOirzenL3XPUm5kY72TD8tzU4vHs3lghUUPf6C90A9O+kxv98pgexHgpXbDUQE/KtsGj4EcchyVWVqvjJ//D5zKR78KskOXkzKdExTqU/iZd2trY5aDYytMhc6eBUqZ+Lrb+wXiXB8KFLuIoeS8YH6SpnByEm01+JJdRP1glJj9X2QbNcviOhE8jW3JA7MGny6g20OVHLuVsa/9hxLY+RH6ByCWPjT4AOo7IZbgHu1dDb1P1m5wpD170vmXH9dTS7MHQljt1ZeU8NO6TuHgyyjF1dL3MryEpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShGteQgaWWtROn7eDmXe2wyZJIIAVEiqm9EBQwPkNjg=;
 b=ETowsnYfpMXgzgYdT1VYa3etqqEelGawEeNmu5mV0x3h4kxFGFsz0L7fwl7ACdXCkMMLWSFCIL3WngXZVgrdtndzd8N+FLZgGoc8PaU+0+/WWM1JoSH2QzcPrFVUKad0gtbj8hUxco1CQ2rQqLKAU0Z1ZMfwlsjJlRmNKvDr8kQhYTjYFCYCw9sfjlm7R81LOQDq0eggqxEbA9ws9HmPqOdWA5lUvTrZHWWettNqr1WXbPo0j2gn9UPt54H6lExQInj3ISTXQPr5PPxQeY80ShPsn43AK0n/VIh4J13xgI/0uCfin70OWRJ+4QNM6ybyY/OqIiIZG+GdOckKEfc/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 121.100.38.196) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sony.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=sony.com;
 dkim=none (message not signed); arc=none (0)
Received: from CH2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:610::23) by
 IA3PR13MB7151.namprd13.prod.outlook.com (2603:10b6:208:532::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Fri, 23 May
 2025 05:07:04 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::79) by CH2PR05CA0010.outlook.office365.com
 (2603:10b6:610::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.13 via Frontend Transport; Fri,
 23 May 2025 05:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 121.100.38.196)
 smtp.mailfrom=sony.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=sony.com;
Received-SPF: Fail (protection.outlook.com: domain of sony.com does not
 designate 121.100.38.196 as permitted sender)
 receiver=protection.outlook.com; client-ip=121.100.38.196;
 helo=gepdcl07.sg.gdce.sony.com.sg;
Received: from gepdcl07.sg.gdce.sony.com.sg (121.100.38.196) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.18 via Frontend Transport; Fri, 23 May 2025 05:07:03 +0000
Received: from gepdcl04.s.gdce.sony.com.sg (SGGDCSE1NS08.sony.com.sg [146.215.123.198])
	by gepdcl07.sg.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 54N57092008571
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 23 May 2025 13:07:01 +0800
Received: from APSISCSDT-2369 (APSISCSDT-2369.ap.sony.com [43.88.80.159])
	by gepdcl04.s.gdce.sony.com.sg (8.14.7/8.14.4) with ESMTP id 54N56wIY028904;
	Fri, 23 May 2025 13:06:59 +0800
Date: Fri, 23 May 2025 10:35:56 +0530
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
Message-ID: <20250523-imported-raptor-5ae9ca@krishanthj>
References: <87zg9d99mp.fsf@jogness.linutronix.de>
 <20250423-singing-bat-60c6f6@krishanthj>
 <ac016cdd-f1c7-46bc-bd27-0248b5dd6123@oracle.com>
 <20250521-platinum-mustang-ed54bb@krishanthj>
 <a009e3dc-6c68-4dba-8eec-4d0e9be195f4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a009e3dc-6c68-4dba-8eec-4d0e9be195f4@oracle.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|IA3PR13MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a4ebda-fe7c-421e-f478-08dd99b7a840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FwqW2VVBap3VIJI3gBArDJ6p9JhADeasXhcMh0PhhV1rHBCMILUkPh0riV?=
 =?iso-8859-1?Q?/j/hjXFZSxUYU2NUMGW1RPPlOBMmj+4x1UeESL7pPaja4lKY+a0OScDI/c?=
 =?iso-8859-1?Q?wpTaMhaFSEsk+ah/MmG2NbtCQfhldffyqNMXv/O4zyQY0epQetKzwd31UL?=
 =?iso-8859-1?Q?Q6kpgexBmSvapKPQFlH+z1JXNEfZRIE9+GXAC0nhofqkZcj915h5uaZgQc?=
 =?iso-8859-1?Q?r/QXKyXmqSZhfLQJUJ6v2KwBf17MJUq7GiObQUbHxhryfTMji4S/HCvoFT?=
 =?iso-8859-1?Q?FxX/5MhPE0fpvvjmc8/Tes6uI2tyDBvP4n4SMSaOJOlpm16wMMbGYksNDz?=
 =?iso-8859-1?Q?LG4aA9LPUMgXOl60FCcOABS+5kDh+uMtMhty0T/zckuKrjVVZsU4YnzjEo?=
 =?iso-8859-1?Q?bT0bzOuuGhXmtmmtXVC6v1MPyDCo3n1N+Qom18NqpsqRx1J5CEfLXBo6zV?=
 =?iso-8859-1?Q?74dYAWHxuaFNy3UjwVNR5cTWOtEww0PloNj05WFSDJTw8u066m0jSyjEv5?=
 =?iso-8859-1?Q?3vVr7IqNoFLVzAHKXKygmJcg2CboXmmRMg/Y+57OymjfEKAQCGYpVM2tX/?=
 =?iso-8859-1?Q?ouMDLu2aJigPVQ0TdR5C/4b3t0RCX/iAwCn1+up4B1wfSUT+i/gmNbAWHf?=
 =?iso-8859-1?Q?y4rGhW8ZX2PCGD0KipSVtK2By12W984HG38VhddJT5rrXwqn8oNh/Qllvl?=
 =?iso-8859-1?Q?MVBp0LuCdHM2bUsjqE+TOuhbIyCD3knxsLK0TZfEUheNKMUjDr4c/l5ryG?=
 =?iso-8859-1?Q?joENdEenRDIVpGkVWqZCePyZ+LwLv93mci3t53w/RGF1/d17Lsqb83BXM+?=
 =?iso-8859-1?Q?bL+sdBwuOfZEiywkXV+lIMjepxtwFpoDjqY1tY9NhZh3HMSj2e63lCtdm4?=
 =?iso-8859-1?Q?rzh1IVh1Mn9TR6gJpyeH0cIPOvvVCX9tnjVoYG4O5O//6adLBRvNrP7AtY?=
 =?iso-8859-1?Q?v4mzMI5vGJuNdbLx9FlQH1v54rubFhNNWTmV0aojj/Q0OCDjYu1KTVwNlp?=
 =?iso-8859-1?Q?Hq44yunDNurX43kxa6Fo1gDTDfUgh5OLRZ2ozSHGRRsR6WY44ahC+32V4Y?=
 =?iso-8859-1?Q?F3uiUOZppezojtzufbE6MOLySAnVTQ7OSA/sX8zpZelSXsqLEPTdoPxzkb?=
 =?iso-8859-1?Q?GixE+2QXgLiGxLycbnRTPtQWkn4zmr7ae+46PIT1ds5lDpCb/iIlGRvvZW?=
 =?iso-8859-1?Q?FIL18OfXH2n7b+usQvnPxFqZt7ki3izZ3hpQngumqumGppNji9fW1h6gzI?=
 =?iso-8859-1?Q?qDZ2drEJuI6LepX7ue8iu0zgvgMXHYiCKnIlvCf89PJqUF6XdX/y+6jHfw?=
 =?iso-8859-1?Q?/1KwJflCKwVQ/Q2BsmgKTbtJumxDpR5MIHiB6beuzu/MmppBKB+ImeopSG?=
 =?iso-8859-1?Q?vy7UyaLcQ47zy80+1PPnyxHwf/HYEXxvCoMLKhbuRNrmunmqC/5Le1kKEs?=
 =?iso-8859-1?Q?X7PuYxCiLuTenyitfQKlysPoL4vP9WDpA8ytS71QGgWYE/HftFea0zf0+E?=
 =?iso-8859-1?Q?CQGlrD6evCMsGvbck6PxvnRI3Mtj92ar6OAbqxJI4bAkKpHgCD9Mmr90og?=
 =?iso-8859-1?Q?SBtdmHs10DFEBulJF4IS9KcSAEAd?=
X-Forefront-Antispam-Report:
	CIP:121.100.38.196;CTRY:SG;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:gepdcl07.sg.gdce.sony.com.sg;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RFeNNfZOoYgT9IPOCnxYVYNfK0rPYuv8LrCKihQwfYAyz0//4J7FnUGQReUSMsu47fW8dChlrPdxFPHNPWEkwlSKd3t0P+rbsR3Sz3R3Tdk91JagAX1tKfAwZlA5Yp/e0E1RWn3a7D2DIqnGtC21Yx2ffF4UqzDlCUAEjZn92fGDd76tbZ/2JOym3Lk1NOuHr9wObF2uyCZNgxjXesu3rdIbeAaiUztjJmrvNrNN2+UHHY9QiSEOmUeO3yUH954irtE0NeXFkCzFlHC52nML4ky5xdAIwrF6tBezprHgcunks9Dzdn140yvIYp5iGeDEGmaUXUmns9xICPS4IbIDzjhDUvBBxPJ3JWrbmTZ/sC+97rJ5IIHrudoow06JqQBnyujzbFy67bW2gtyeYPpQin457x2UjwFLj8Fog4k+8IomlruJPgSVtzBw79/VN1K8fhw0qMM9/3fZhIrRsbPTQvPZ8l3xSE1QlGt0JGYmPCmEFZgxdPCJd7WVcFip6ajxm0gPMYbq48mSNy+csTn0jkjeB4x9mTGX/kpac5wIXug9ioZesYqyyhONTiJe2Z5xZ+wTcUbMVIsi9emvJYQ38VhjMSlGX6mlZO1JJnAvv60UFJUo3fP9RiJuuBlkltEz
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 05:07:03.0429
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a4ebda-fe7c-421e-f478-08dd99b7a840
X-MS-Exchange-CrossTenant-Id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=66c65d8a-9158-4521-a2d8-664963db48e4;Ip=[121.100.38.196];Helo=[gepdcl07.sg.gdce.sony.com.sg]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR13MB7151
X-Authority-Analysis: v=2.4 cv=Q7DS452a c=1 sm=1 tr=0 ts=6830027c cx=c_pps a=PWVUOCyTA7FSuaM6ltj0gw==:117 a=6wFMGaBZ+STnq1QQ0xxGfw==:17 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=8nJEP1OIZ-IA:10
 a=dt9VzEwgFbYA:10 a=s63m1ICgrNkA:10 a=xR56lInIT_wA:10 a=V7Axyp2jc2pASUDidcwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: UGVv-80FdNZ28ckCPsS0ZHp10aWTbiNf
X-Proofpoint-GUID: UGVv-80FdNZ28ckCPsS0ZHp10aWTbiNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDA0NCBTYWx0ZWRfX7+i50jEkvgcw ZP409iYzodXWaDMxoSDe2CdriSHNaNMbwqh7hzquH7c5VD5vnHCUBun/7SKRrcjgZndiMC8AvFh mkHGUqkb5j9dgNS1/3tC5UbzVzo2Oc8SoGq3uWPxVe1oed7OyBZiKM2vikcq6luSv5n2ScsBuvO
 CrbL7NUeT+CbsGD4/XElZrIlHGLiFSNbO3K4vaD54lFrxkQvMJMIpt7MQBPhPg+aoJDihgtAJdr ETRrtV5Qg2ETdzI6WfAtqeozTJEWDQm5tM3QvxzmdtzE9hK+A1ElGetLcVPRJY/k1slUGarANq8 IFD+Is3Pmsp+N8hI0gtoUxnC94H9aiHMn1yRhlSv1Z9by6epjeeoAH/xwgpKYIC2CAUadUcvALj
 Bx47j1+AIfGCOIRJvzL15zwxmgiIeSEmbnZc+Yglgh+99OIfJJD7t/QjkLkB3YgnmyOT56lY
X-Sony-Outbound-GUID: UGVv-80FdNZ28ckCPsS0ZHp10aWTbiNf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_02,2025-05-22_01,2025-03-28_01

On Wed, May 21, 2025 at 11:32:54AM -0400, Joseph Salisbury wrote:
> 
> 
> On 5/21/25 08:30, Krishanth Jagaduri wrote:
> > On Mon, Apr 28, 2025 at 10:45:08AM -0400, Joseph Salisbury wrote:
> > > Hi Krishanth,
> > > 
> > > Thanks for pointing this out.  I will investigate including this patch in
> > > the next v5.15 patch set, which should be released this week.
> > > 
> > > Thanks,
> > > 
> > > Joe
> > Thank you for including this patch in v5.15.183-rt85.
> > 
> > Best regards,
> > Krishanth
> Not a problem, Krishanth! Just let me know if you run into any issues.
> 
> Thanks,
> 
> Joe
> 
Sure, I will let you know if any.

Best regards,
Krishanth
