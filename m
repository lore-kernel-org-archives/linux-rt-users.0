Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F6216E0A;
	Thu,  9 Jan 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422047; cv=fail; b=mykJNmam6/3kS3YSrz2mOki70VjyoRqrW0FJ8KvdjMAOHpQhuT/rprXXauxDriQRkyqQaMGmz4AqnX9yb7Nj9DCxjkGYtrNp60y/Baj8n/B3Wl19I3AWFaK4wQiXoZchgxD6Y0v66bIearpCLM6yt6b6dQThtpBhu4j2mfBkOgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422047; c=relaxed/simple;
	bh=YtVBWdOhmSQRzTjDF/3VUuMh1aLk7k3VK6x+R6RQybY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6eGPWiuLiHB6BPWfX79g4pavgEWzNXXmwoMdML0xIsMgVQPumyFkyHXdSX+vAt/oO5wfiATgklOdijzMAqVh/tlnIx93rckvn76NDG4pL1HkgWPCy5SU6Iu/z0BMD9eXuutlDNoQ6+jJL/K9lh8ggLiobFLWiGjoVcMRm8pDfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=cXJ+BV9n; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="cXJ+BV9n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cE+56oCE6SxUkTkgO29JhU5Jm5Bt9gIPIjynV1QIKE+98GglzKfa9y1HRq+Nixx0H6ys4Tzk7CU56bp+j38EIOAR8EiDTYMmCpZEOtyZttfiTPpppPVt04VzAaIyNwszmHakAGYKzIifDxKqaT37i1dXT+ZGOQ5ZjQyS5tl5vtkAXImtGVm88jZgjRdrFeA2ry/TFEH/eE3H3CWJHtQYeYq6u+LDI1b5H47bFDDXtyrBjYYjFKuyydPjeemGiAlIJ+h8Aqrnvxp1mY9/UcTEc+SZ0h8qIlhmKj8hnVZbEanvifh9BVsv2B1qX0ozFB0+gwLifCCk3y74JH8t3CJDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCcSfdkpZTcmzSsi90ZaurcSmnY8sc8C5FAV43sC59w=;
 b=pc1gCUPFahe8PAEkNDE84ZdwLpcyOzlwy4oFbqnHrBfSE9yq3Ky59qULVS7snByp2dkFPsw+TpYlojPSzn+6nNReBdW++Y4gGjJJnH4NwNMF/xmRlcwTTbVRulGMT5+6srCvR8/KVRdANxUa45Ec6C6hGHlBL0hT4UgRTFfFcEZzJhPxNqFdGpge9P5OBQXoBPyu67Z8pueEVU5wF6XW6f0FnLP66IQCkhf+zSJTa1AbF7r+qYvZonMkyFagl3YBtM1oCotmopXdXQKyIy+33o3M7iS7aPIefHsAANA/rt3FvpYn6VdeOvJfdW9XEyLfN2+ypayCNxCJpYYKATEP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCcSfdkpZTcmzSsi90ZaurcSmnY8sc8C5FAV43sC59w=;
 b=cXJ+BV9nCbPXBVgjdnovVBnCboiEugHOBY/SFLwR+UOXp8ZPg+68ePZfUP255lygAAwb/DZSqefnh0lxAhxUaN29gDgccWJ6PswMLaEo33tF0nRcLFsSGbiA67MlkfUHv6zxlw6vfWqO278xNOHsqEfqWSk2COJ7q7EzykSoI1s=
Received: from DUZPR01CA0107.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::25) by AM7PR07MB6262.eurprd07.prod.outlook.com
 (2603:10a6:20b:142::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 11:27:18 +0000
Received: from DU2PEPF0001E9C4.eurprd03.prod.outlook.com
 (2603:10a6:10:4bb:cafe::68) by DUZPR01CA0107.outlook.office365.com
 (2603:10a6:10:4bb::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 11:27:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU2PEPF0001E9C4.mail.protection.outlook.com (10.167.8.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 11:27:17 +0000
Received: from n9w6sw14.localnet (10.30.4.249) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Thu, 9 Jan
 2025 12:27:16 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RT] v6.12-rt stable branch?
Date: Thu, 9 Jan 2025 12:27:16 +0100
Message-ID: <4776411.vXUDI8C0e8@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20250109104757.lszbnJUq@linutronix.de>
References: <2732654.vuYhMxLoTh@n9w6sw14>
 <20250109-sensation-diabetic-9b082008c6d4@thorsis.com>
 <20250109104757.lszbnJUq@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C4:EE_|AM7PR07MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b38dde-bd2a-4b1c-fcdf-08dd30a092eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yd+yD6rG+JoslWtaufs2k0z1ye01WM6nbe5aRRehOHmEGryvhrAacZEeRO6y?=
 =?us-ascii?Q?KLM5U14zv3SqiN15IWmaYb8Y2pZavLO8z6C5+QwWxh7NUkd8o9GrU4niBCde?=
 =?us-ascii?Q?xKddECkRoTjXgd6wwduASJh3daYzvAMdw+mi785MxwW/Qr2bFedOp1YRRBlW?=
 =?us-ascii?Q?ek4A/kT5Uity1FXYePv+7zVxZDJ7Ny2RX2KCe2WyV/ND6e14naKvpNsAdRxp?=
 =?us-ascii?Q?ILdVrk8K+ZrwgfgBDSljttdOjWLQlYeIRW2vKWY++hhFPrJpagvP3UAq+tvs?=
 =?us-ascii?Q?xd5wzlJISPJ2RmR/U2HfF4eTZIXQ/0XmmT0A0gqiYW3H/eVS4KUVMBmtLTTO?=
 =?us-ascii?Q?8AXPKaFIhUcULuhU4+fb4nTAWq0ON+eRRWc+r9UPjKmKbHyngvV0e9ThHVat?=
 =?us-ascii?Q?dTnqIKd5Ot4PpcdxAHD7GgGphnXWXb6Pgo8DyP6FTZkeuihLCMHxEa2uhIvS?=
 =?us-ascii?Q?Cy7SxARFgdlTJwQhEADug9ph4vTBo/9IKjLXdD0vBbqr2b0XXfbwAY3qPRZ8?=
 =?us-ascii?Q?MeDvJFS+P5/4zz+zXsGJm98VDevuX8/dVPn+qksUGDK4WU3x34KhQtz4SWK5?=
 =?us-ascii?Q?pZ7ekwjmOIt+C3BK2r+Oqtf/ypq+PYyyjruW5GUzF/lFXhdYqxRKpJFKicGW?=
 =?us-ascii?Q?a8u/hohoCZNPouYPsZ+/HDI+lpe8CBjBCY+PcMDy6PmQhQyPDPdPFQBflNYm?=
 =?us-ascii?Q?IJJv222IRAiBscYY0T5e8jDJodTYboLtRVbhWy3suiecGlTCMW2/ofykyStF?=
 =?us-ascii?Q?qIRlWQig7lfEkzRzhcsPzbKwm1LXhmgj+ced6t7oLqI5aI2PXVH+/74G5N/o?=
 =?us-ascii?Q?/Stzn0eTDKZX/73jUm+fYW9jB8iNcpwyRk2fGrQeLtJSheUUjMmD6fGleG6U?=
 =?us-ascii?Q?pD605nrf5TzUn8TqdJpzvvonPKQnHGbHJcNb8HinYnPIpiGu0Bxo592nTHAD?=
 =?us-ascii?Q?AMwL1xlp+IdKYXnWXNkHnwospBwsCq8oP+Pcea7ryC32BA/xxZs1iwiTDFHl?=
 =?us-ascii?Q?6vy+hDSJSsWeIVIBvCF+Xpy1lwITiuFGzAuL+dHXDZIhvXSukrIjEqgAhZvv?=
 =?us-ascii?Q?yhngjagJivc5CliFq9uggIph2wIVf1q0GRypkNR115u08/kNgkHC+X0WkxVM?=
 =?us-ascii?Q?UtTr+7IIwYQqanD3S9nNVoCw8A+JndyMYDCqg7cYyMjueNR1xftQKbqafr4O?=
 =?us-ascii?Q?lUpu/Pcm30kcuAbjEz46cOmQT2Gj80Uxqr9cFK6Hk+TQL3a9ZwQxykBY0wfw?=
 =?us-ascii?Q?DuPU4e8McwSKN7ugwC6JBAdeP6A/gO5n2XAqzAS7NJk23VcIRUXDtSrKTx8k?=
 =?us-ascii?Q?fXRfn1Ux+sUOe3UJofnwMuCIb7339UW8+x9GmbWHZ4TcnysT31DV47ZPKAHl?=
 =?us-ascii?Q?swyXWemT5fz/7pnPasY1lzODyrLe0uQGOOzRxA4tf7tmZn0C3FaALpczG2/Q?=
 =?us-ascii?Q?Bhu7tE9+qMkRLRihFqcQvoitNWK5JdPBjXqsi7skqnG/ueqfssF0vvIz2AnE?=
 =?us-ascii?Q?AfHQIlQk6cu3oHc=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 11:27:17.3693
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b38dde-bd2a-4b1c-fcdf-08dd30a092eb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6262

On Thursday, 9 January 2025, 11:47:57 CET, Sebastian Andrzej Siewior wrote:
> On 2025-01-09 09:35:20 [+0100], Alexander Dahl wrote:
> > Hei hei,
> > 
> > Am Thu, Jan 09, 2025 at 09:23:23AM +0100 schrieb Christian Eggers:
> > > Although most of the remaining RT stuff has been merged into linux-6.12, there
> > > seems to be still no out-of-the box support for RT on ARM 32 bit platforms.
> > 
> > This is also how I understood it.
> 
> I've been asking who needs ARM support and nobody spoke up. Arnd then
> picked up some of the patches and for v6.13 the ARM queue got smaller.
> 
> Looking at what affects ARM from the queue there is just the ktimer
> thread and the ARM specific bits. Lazy-preempt isn't implemented.
> 
> > > Are there any plans to release (and maintain) a v6.12-rt stable branch? Or shall
> > > I pickup the necessary patches into my local branch myself?
> > 
> > We have some systems with Microchip AT91 SoCs (SAMA5D2, SAM9X60) and I
> > would be interested in those patches as well.  The last patch
> > published was 6.12-rc4-rt6 from october.
> 
> v6.12 is a LTS. And I wanted to add some PowerPC bits because it does
> not boot on some parts as I've been told.
> What about I make a release for the current stable tree and then update
> it once the patches no longer apply on a newer stable tree?

For me this would be fine.

> 
> > Greets
> > Alex
> 
> Sebastian
> 

Thanks,
Christian



