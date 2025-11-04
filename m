Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022092.outbound.protection.outlook.com [40.107.168.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D71A256E
	for <linux-rt-users@vger.kernel.org>; Tue,  4 Nov 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.92
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264817; cv=fail; b=peYw1BvTU7KhQ+Q2KzBY/Xunw+WkgcDFd0yMqFwoZn+iVQgjwjas01LIkQMG/90E5y6KB7wnKldpt6ArQuewzM0HEEHteOYsDEezIvGVqr0x6p2JXFMu5i0bPShGQbW8XXSfMwMwJCLjjWv8HGSaRQcV8H8ajZmZjwAYBWFE224=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264817; c=relaxed/simple;
	bh=x9ywngDcZycalMT4T3jxQUlBIXYWYLx+0jNRbhfxT9w=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:MIME-Version; b=gOwgFWte4yAvANfGDB4WcI+ZgWMyzz8jeZLSVlKW6fkeKNh/88IqOPkOFm7CI1EJ3im6YtN6V/VfMgrggYtJ1Dh+s1lPU2ZxELx6Pl+dsYxK34JsScXZI2Dl+Qq2oDgm51GnSH7m35Wujl+wqMXX6aAxdR1AdJfUvsc+OVX9KCM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=temperror (0-bit key) header.d=duagon.com header.i=@duagon.com header.b=NhpQLThd; dkim=temperror (0-bit key) header.d=duagon.com header.i=@duagon.com header.b=NhpQLThd; arc=fail smtp.client-ip=40.107.168.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=duagon.com header.i=@duagon.com header.b="NhpQLThd";
	dkim=temperror (0-bit key) header.d=duagon.com header.i=@duagon.com header.b="NhpQLThd"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dlZWtW+/rAKfbyHzJPxjCqkqyQ9YrGCsWSXYmjZQnTwmGuT2xQM5xH+5BmcCZEY8NsHNZ2iPVRhizPgKvCJmsBNCt6cQfMg/WPNsc1n5rTZ+chpx6wyKeMZzRPSKTSd3lNQfwKPEIf6ABn0IfiwRon/8eqNT5zCmBBZLrmvS5rbjeHBP/GpsP01IAIyoIOldrUaCfuhauA2eAzWtOkTCX6agkpFh5Me0bVygLBAjoBWOplXr8pj/F/MmVAyeG6HqPzvtr+X0+rfUfyla07T/088Vqjdf/kdFL6yD+as30FiVuixGAkpq/3+epE1OIW29SsvhUxUkDjkDxrm1DonQow==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PzMtu/+hcTGxrIk+d5+2DgJQrN4LgsgoCzQVpZG5gA=;
 b=HEeljSisZaz4Zu2LN+UnEeIgH8VN8MK1e0XYOOm/SbhcKKRJa5pDvTiReblT3fshuJZdAX/2gABANF5o9uqrYga9FjTD7gw9O/cP79rM3sHGRd9k9m0tZzQhLAkrf+B9KiXYIOI7/1YzpCRuNI45ibhfEkfVPZ0VrSnXzxraZUNwAUwPxYsgc/pHSloWdHeYZ5KtJwbSIZ1w6PoJwxlOsNZwR+x5TLbRp9IwWGA+JQ5Ii11Iyhxno3mxeCpdkOUlzsEXvP45FS8I12zIqpuile7ibaHXAwGtVoJbBBW75egBgNEKqIhjyHh4gWGdYkFBgVu/rsakMLUI1xDG/8JcyA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 194.38.86.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=fail (no key for signature) header.d=duagon.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=duagon.com] dmarc=[1,1,header.from=duagon.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PzMtu/+hcTGxrIk+d5+2DgJQrN4LgsgoCzQVpZG5gA=;
 b=NhpQLThd5m4Rc3SOsVvYhQXf+hkGTjdv9dKi6NnYXhbHJg6Zdxe/b3j6S6xycAU8SDFkjep6+6ubWvnFVgrEKdAslIGaCYHkn995iC2O8UZ19tKGPBXiPyBNJ3N7COyHaranCa8gZoZVJ6VB2zAwZARKZdq/8Em01jHZFs+IwbQ=
Received: from AS4P189CA0006.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::10)
 by ZR2P278MB1051.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:61::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:00:08 +0000
Received: from AMS0EPF000001B4.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::a7) by AS4P189CA0006.outlook.office365.com
 (2603:10a6:20b:5d7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.38.86.34)
 smtp.mailfrom=duagon.com; dkim=fail (no key for signature)
 header.d=duagon.com;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 194.38.86.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.38.86.34; helo=securemail.duagon.com; pr=C
Received: from securemail.duagon.com (194.38.86.34) by
 AMS0EPF000001B4.mail.protection.outlook.com (10.167.16.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Tue, 4 Nov 2025 14:00:06 +0000
Received: from securemail (localhost [127.0.0.1])
	by securemail.duagon.com (Postfix) with SMTP id 4d195s2XkYzxpB;
	Tue,  4 Nov 2025 14:58:25 +0100 (CET)
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazlp17010003.outbound.protection.outlook.com [40.93.86.3])
	(using TLSv1.3 with cipher AEAD-AES256-GCM-SHA384 (256/256 bits)
	 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by securemail.duagon.com (Postfix) with ESMTPS;
	Tue,  4 Nov 2025 14:58:25 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgvYnWwLyypJs0mKGXqO/3ZwKy8FIzAVAUROpr9Q9rhwuswm5Jtw1z6HLf7wQLrVHfB4iyELhD/3alwh3BSeCSV3RWRv6dIcd1XCqHuPKdVJ19jyfkUBVXurnFZIyjFQ9T5ggBSj8XdiwKt3oKu8HVYbVJtIreqYeHamv4CcMWVS2DalZKykGauWnvZlgutRyNKbUMru57+l/aPcEJbkZPcjNrmHi7CQ2ZM0FNe1Wrv8aRrKOEfSNmX+d/Gujc/npcAS1Lwoh0sLEpr/QbNdPqRBiixD68zESYhVWTC+NHeK2hZEf+uqsdsLfEp/bumXowNltj3xLYvGIzOxmc/7pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PzMtu/+hcTGxrIk+d5+2DgJQrN4LgsgoCzQVpZG5gA=;
 b=e09K2rJFgDW5zPMbd/9m8eM1HkNvk7+0gyicLyPJ4KvsyFBfGOPJ8P0pfJyj76iMUjdnsLcMg7Jmh8b/h7/Px2YaeLXBqvcUQxiymHOMbeSBYR59Ok5fmEHQNOjqnTgM82UqqAjjGmBkTB2O6MvQoVQOY0gtQZ+DG6Tgnrtl/2EiceFyds0zx1wrl7QI5CK63fzf4ePX/gK/FApZUoVliNDrV2vRIuUbcpKFaz4Y0Y975cTy0GWMBQyFuQRIkBPtH8lLcNldCoX7/yUidP0C/NUAdMlkOp2xbOGwIvGxHFDHKFZhRJv8BxYSYaM2K3l2P1DsVMDsQ9L4VeEKNQwx4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.79.222.204) smtp.rcpttodomain=redhat.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PzMtu/+hcTGxrIk+d5+2DgJQrN4LgsgoCzQVpZG5gA=;
 b=NhpQLThd5m4Rc3SOsVvYhQXf+hkGTjdv9dKi6NnYXhbHJg6Zdxe/b3j6S6xycAU8SDFkjep6+6ubWvnFVgrEKdAslIGaCYHkn995iC2O8UZ19tKGPBXiPyBNJ3N7COyHaranCa8gZoZVJ6VB2zAwZARKZdq/8Em01jHZFs+IwbQ=
Received: from DU2PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:10:2b1::25)
 by GV0P278MB0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:00:02 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6d) by DU2PR04CA0230.outlook.office365.com
 (2603:10a6:10:2b1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.222.204)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.222.204 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.222.204; helo=de2-emailsignatures-cloud.codetwo.com; pr=C
Received: from de2-emailsignatures-cloud.codetwo.com (20.79.222.204) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 4 Nov 2025 14:00:00 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.25) by de2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Tue, 04 Nov 2025 14:00:00 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 GV0P278MB0082.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.16; Tue, 4 Nov 2025 13:59:59 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::39da:49d1:7c23:953e%7]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 13:59:58 +0000
Date: Tue, 4 Nov 2025 14:59:55 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Reply-To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: williams@redhat.com, jkacur@redhat.com
CC: linux-rt-users@vger.kernel.org
Subject: [PATCH] README: remove reference to -n in cyclictest examples
Message-ID: <295d62f6-4a0f-09a1-7c9a-d6db4254c2e2@duagon.com>
Content-Type: text/plain; charset="US-ASCII"
X-ClientProxiedBy: MA2P292CA0014.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::10) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|GV0P278MB0082:EE_|DB1PEPF00039230:EE_|GV0P278MB0036:EE_|AMS0EPF000001B4:EE_|ZR2P278MB1051:EE_
X-MS-Office365-Filtering-Correlation-Id: 94eb5f8b-e74e-4351-146c-08de1baa75ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?VMQcIyg3mPhfexAPf9Zr/ZjaPcCwEJp3FomneW98uIc8Y/PmDhnI9/gE4HZ1?=
 =?us-ascii?Q?uAy6Bnw/2roblNkxGLQWWV6Lzq2VO4W12LmeRH/7aC/WHvKV1Bk5jsrpbMA3?=
 =?us-ascii?Q?UOX2VcAz6mhDeEdRx1+KSUTuF2FctIslSWrN5lREaoIP7XyL6unieDiy9REi?=
 =?us-ascii?Q?vSSBfAhNCB25vqoxUZfJzZWFq4aOofaMd7R/rNW/2ePw5UUwnW0lmuHVWWdw?=
 =?us-ascii?Q?c7eDOxiyHiNRhT2WYCWQ1oufj3QCXp3yNgxYQU5Ym2wi96oDr1Dpn4AfHzdg?=
 =?us-ascii?Q?2eYO78NBGXpXWxG17RlEE1Vm5cXeDkClM1ffVDW88fOJLFedMTBvW3HKnP9k?=
 =?us-ascii?Q?1gIuBl8i+rPgSzmX9BG3er570DwLQqsSfdn8DmraiKhOJUXn8Ncry74aLyQT?=
 =?us-ascii?Q?8KQajdm0dNn1ii3KB08LRLf6NxXGHcAdVxeFvEboNppUkrkkFde3e9lc1E9t?=
 =?us-ascii?Q?zH8klyd4bKUeDUe9tQ0NA2IvF0fKZo0q7yz7CF9l/WavfcDlUygr4qwIiOlR?=
 =?us-ascii?Q?JAy7xStl5los+Qk+MLpvsG9cxZp0xEPtoXumKjJ75fK5VxhesfF8fxrwbv7H?=
 =?us-ascii?Q?FPKBKWzgkDMZ7uCGTE08/9dQMLI6dOx6NxepqZwx03bbVVtulS8dGCzJuLLH?=
 =?us-ascii?Q?Csq8hRfRvdOyH671CNIyGxRPoZZWqd3lpe6bj/nMu303gYPmXGfI2Wgh5x6H?=
 =?us-ascii?Q?guDN2TVFUTlMX8EudaB/n8tMCi3oN7L+UHBvY7kyhUnt4Els6A9T0onamsMZ?=
 =?us-ascii?Q?/PIuwmb2cXVxVpNfRXEnBa+UFdcuw4dZYquFxFT1WRqkjyvFaB9GfdjdxLUZ?=
 =?us-ascii?Q?HznHc4hS/0C9SoF+l8lCh133kI0fv5KJjwzDUWFKt8weCjuL1fQHo9AZM/We?=
 =?us-ascii?Q?x+ENFpREfx/6yXUHS60tAUrHJyGxm+vBgL+O5umA5ayPNBLJn5HkZQlPztTh?=
 =?us-ascii?Q?DES6cBIdL1TsqEU27+1N1lBYLZuwojFtgqy570WCjdxZIEsWeVs9KKbwOzqj?=
 =?us-ascii?Q?EGHM21MO+8FWfbu0RSKP/YArROIuSSEqDqX0rqMt5AmvwHRtkJ/c7aF0NguQ?=
 =?us-ascii?Q?3JdkTtKa3HzWaWQEb57PKSvGbzpBy1o6W78s5cQDjmvndA/EXrNC0leSm3EC?=
 =?us-ascii?Q?9Tqno7mwzF1FvMvgNGGB0fkaM9D3pb/aaWDTXSoF+mO5v0CgWy9LvVi3bEli?=
 =?us-ascii?Q?AAjK1troquVkeKbqeq4decRS98z7vY2S7MRZYOxPndAQATmgzVGOKgPykxnB?=
 =?us-ascii?Q?V36PBTrHmWItFcsQFoIdtOjFh9psTAFt1wnTPr3/q1e3zsiJWeNuUXO8+mut?=
 =?us-ascii?Q?EsAwtc1KQDNpH0NJb0UzhwNa9/3US323EbFzPQ/3q3BsqtXtwTJUy6wDlbh1?=
 =?us-ascii?Q?Gl2P47w7jDzJT3ya6W8ixzQZ+ZWfzSPMkCThzJEQgdK/0cywifxlmqgHWXY9?=
 =?us-ascii?Q?C6APqqYF2tKsiGnmwpj5ASCEtvAqktky?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0082
X-CodeTwo-MessageID: 31aeb3d3-fc39-4cea-831e-5a7c6f0a608c.20251104140000@de2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 f643455c-23fa-4e06-55ee-08de1baa70ac
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|36860700013|35042699022|376014|1800799024|14060799003;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?guAA3RtFYrocAmtHYB3/gxyuY7RBCRIINrxJWZ7wUlBWsbQP+EzttN9xmVfL?=
 =?us-ascii?Q?2EaYEOsqWb9+tHSjb2FAjuy/IMO78AvA9Y7YR+GbayAZtKxxe3VjFEWPwhNg?=
 =?us-ascii?Q?jPsVlqRji+nlKfvXlQoev46sdLZznajFo+6TGFIJ9r4VCX1CRy3yxmj2IkM4?=
 =?us-ascii?Q?CYFiqtSohWSv7LeFpsZDd1Q5Tjb9ARTSfteJ6FiXpgJ9gmKm8NzbKaEcc4oY?=
 =?us-ascii?Q?t5CKmA72oiwbt/0eWPEMJhsoWNaBm8r09hnHY4RZDrTa3Tal24IGPxZWJFfn?=
 =?us-ascii?Q?gc2pVxLkki/6n8fU/rymJMtXmq/vfpMEkeS6w0lP4XPw6rLvg8CBjOkWFbT4?=
 =?us-ascii?Q?GEkcYm5NRGee3c7/Vfp1ThrSU1abaiouaYM9mFFcmzwKwMiw7lcd151uz7Xl?=
 =?us-ascii?Q?A/RqPIsioYftZRlgV2gps/4OAuxtc9DzTSgzOQlnMA3gZQyBd4QiRN/rTayP?=
 =?us-ascii?Q?5IE5ODznQdAqzESDlOTb2H8lTvVrzjycsRGT9cj8bEvk+ksP0WpLa+qz2Sme?=
 =?us-ascii?Q?jErcWAu5UVIu6TuqGdXqa6Z7Wk+mNyDevCPnKsW3v/aWn68if9QXgU79Vic9?=
 =?us-ascii?Q?q88imE0NwN68tFNN7tI1IdEpvDL/zI5kCquzGVBYvhvgfgZTtoswyN8s9DHt?=
 =?us-ascii?Q?GX48l0RtIbFr5tJ2ksdVe+/bSJTDkPxYItWPk0aa1YN6rmdS9AINr7rBBJL/?=
 =?us-ascii?Q?PYlZFxWBgJ0qOEnxUlz1p5UcuPXh/hGZmg1TKc2iI1LAyx0sHgsWt2YHsl1W?=
 =?us-ascii?Q?KLxqNi5Au0+jX6QSVF1lftAuK5pFlAeZp/z5Tzijo8UsbgRcVaiEMzKMLJ3L?=
 =?us-ascii?Q?7VXwSpjXZl3zszzNDzWTlk+ZYLkfI8wM8fElDGWvCdZIbxqLntOJt1oIfeIM?=
 =?us-ascii?Q?zT0C/tmZsqNFmXpRlOwKLH+UTWbFFMqnAoYAme+Vp17BdimRx9ZIhGg8eUj8?=
 =?us-ascii?Q?zK59mcM4k+neeWUpQCkhmIUeMirLFP4SrEZTZR98kxopECgrGoAjjC+S90FY?=
 =?us-ascii?Q?vR4qImrsLUIOWjABEDONLR3m4PJL3HCeKBZHDeIQRgYfE1TTfZpqX19qCitd?=
 =?us-ascii?Q?M08xW/n+VfhWIYboJpOBL7WgWxHE8/sK6z7wfrSdF+y+Ic0mgw3Ja1b/B+Li?=
 =?us-ascii?Q?ZGrcUkIpbaZ6s0JkrmjxZgqt0TvT6RGgKjNpxEPUEPVWYy3hDjYSqX6IJK++?=
 =?us-ascii?Q?5rI2jnI8+7qaS9nu5FAIu3pLOjBofkna6c5k2Z4aVpek100n2PZaxb9R4TUo?=
 =?us-ascii?Q?okHy0YoBkH0tCu59pqhzwnf0bunHBkMN8dVrHqFBzmIA7JVfvT0YscuLSeIB?=
 =?us-ascii?Q?RGo1igChirNJFKa24FCi9seID9PUd3TfznjvQjr62S4MDahoB0x3R6Z+OHvB?=
 =?us-ascii?Q?vjxmE9oYjzyto3GjX7F5c2stBoFWqSE94SbIyJcuW6CW/YLXRlaghRm81AFZ?=
 =?us-ascii?Q?B5nIB4gOvu77Z4RMQ3uBZdHbg7ng9vmtdTk+DGNLvpbAhc1FC80CmANvMtGQ?=
 =?us-ascii?Q?i0C6SUDwYrVLjFRGAUkdfxjaZ6MzjdvY7KBKjHBzEOrYZ+PKrMb7h8AUi63t?=
 =?us-ascii?Q?66tmwlq2US4JE/93aXo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.222.204;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:de2-emailsignatures-cloud.codetwo.com;PTR:de2-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(376014)(1800799024)(14060799003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0036
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d42ced18-d8f3-4cf1-9123-08de1baa725f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LNg5ofj0de1fVI9UNF3fhLKhMk02WStAUlf6RiR0Kno6fFba+/czfirdqIve?=
 =?us-ascii?Q?cd8RNT6zxFI+yTDeKDv7A8OW6MJslbJo/LhQO7TNaaeCqJTDfcx4VIYKvfmQ?=
 =?us-ascii?Q?Wrh84l29du/vELHKIPammuV1VdSu87Q7Lwy6jHitcx5ZcyoCrl5Me7cMBYw6?=
 =?us-ascii?Q?EOfAea7zPyKhEuSocbmM60TKkN6rU9Yz5K3IBpVb97ZTAOdDMACBeD5xNl+C?=
 =?us-ascii?Q?jW+j8dV5D74cCnqMrdE1wE72fvQ+z5eQlKLgxf4aBIlag4mMuGstxoZcXNvG?=
 =?us-ascii?Q?FL+izTbqAicr3epg8EwiCdqRmIcl4+xHTvJ8F8dm3pBPdWnpURGvUwNWLIEa?=
 =?us-ascii?Q?OcNM729O4yVtVcmeQrL8E++3xtpD6n2yU4w5o/Lj17v5v0Fab7rcri8BSSIi?=
 =?us-ascii?Q?X5cm4LR5NEtMTr0XGLEHzmORHkd/UBx4eDpursazrDlExeUFrqkDH2gKrEkY?=
 =?us-ascii?Q?RyY1mvnhmaGZXZ1AGoquSsalh0LKtHl+mg8ifOMxCmunsGsFGE7D4OrIf9Y5?=
 =?us-ascii?Q?bTGS84snpK3uvIN7BLD0cshWpey24hKnBr/JEXATNHI2kQq5gXxagLYiG+N0?=
 =?us-ascii?Q?lBf2TVaK3TpFJVxfbBXZpzB5CzGijNj9Q7HQvzT46gPBMz1rq1gAPC8RX/Rs?=
 =?us-ascii?Q?85tePDwibXuio2YqJ24oHoQcmHZ80sDBzYMZdMgDMGTldKOTP+EvM5WcH47O?=
 =?us-ascii?Q?iRxG7JPnGz3Klgg9MeIlEjrLkon5Ly74vxfJClgW/EqjtvLkQe1VA8+4Fdkt?=
 =?us-ascii?Q?ZtZHVHYyukyE/arqi/FYiwTUN7yFXpTJTiQUeMLnq/yDw6CNfj+sRXMmPYtB?=
 =?us-ascii?Q?GntBcyV41V1bZmAr8ghfUeQwN1BltbZh6ae+Sq4+l0jieHlw9Hr8l3KVrO0g?=
 =?us-ascii?Q?OhPXKLdShI64UrICWO45KhK4M83sKb48fJzfM3H6H7q0YGvfPAJI1BIUmbvR?=
 =?us-ascii?Q?5HRCbrdrxYHqx7PcpZidiHTmx5+4NSxWeSBiMknd4tmkRZRnADVdGzpMoDIZ?=
 =?us-ascii?Q?q9XtYjfSiyKe/BQ+RFNMN3scIGH+OX7fIuJRIpbUDrLC028Cav0VPUMkyxqU?=
 =?us-ascii?Q?vgZX3buk+Qm2gMMNFjG+nLa4NF6H+Fs73qEQW++hUvHDenpJdX3udzRcCwQ2?=
 =?us-ascii?Q?meZcYAATCudSlibZWGj3y9inTSWQfxXykaNCGrQTcgsx6UtT2jKKoqGF6GiG?=
 =?us-ascii?Q?HEnkayd+l2FZX2I7KsSxsvRm/6zxc7/81+VRNOVGPiicJZtF/NLPZzCvzJzE?=
 =?us-ascii?Q?3OD/+a4PWP+YNBnyhRMeGnrzJFXupfpgdm82QGkKEtmqp6kZLSmJn0uDRCKT?=
 =?us-ascii?Q?SNjSej+tQc6KgfB5y3+FJ5d3GSNh1dkmanTm+r34SMA/K/WU/6ETTkGHy/mW?=
 =?us-ascii?Q?8f5E5xirb2/t1CgM4uUZNHm8VehlMxGpdQx2ZGMpMzOuDARJHQyROnKkAj6r?=
 =?us-ascii?Q?5F84WQqiOUjnGz2ZKuFejcWcRbfebvuy3WqR2mLurdHHZfyQsXt9lPrh3hQk?=
 =?us-ascii?Q?W37N+BnJM3f6zVATjeWIKQDK9DcB72Nggw/QfJFEv2Y2mli7WWISoqVpBjcn?=
 =?us-ascii?Q?FcNKHciLcYx2+lyypYY=3D?=
X-Forefront-Antispam-Report:
	CIP:194.38.86.34;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:securemail.duagon.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:00:06.4129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94eb5f8b-e74e-4351-146c-08de1baa75ba
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[194.38.86.34];Helo=[securemail.duagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1051

From 0f38baddc4b47c66fc66d4f01b018554e50c8a05 Mon Sep 17 00:00:00 2001
From: Javier Rodriguez <josejavier.rodriguez@duagon.com>
Date: Tue, 4 Nov 2025 14:47:22 +0100
Subject: [PATCH] README: remove reference to -n in cyclictest examples

-n, resp. --nanosleep was removed in 9d2c9edd8694 ("cyclictest: make
clock_nanosleep as default and add option for POSIX timers.")

The usage of -n is still used on cyclictest examples, remove this
non-existent argument.

Signed-off-by: Javier Rodriguez <josejavier.rodriguez@duagon.com>
---
 README.markdown | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README.markdown b/README.markdown
index 617b57e..6370784 100644
--- a/README.markdown
+++ b/README.markdown
@@ -14,7 +14,7 @@ This repository contains some programs that test various rt-linux features.
 To run one test thread per CPU or per CPU core, each thread on a separate
 processor, type
 
-    sudo ./cyclictest -a -t -n -p99
+    sudo ./cyclictest -a -t -p99
 
 On a non-realtime system, you may see something like
 
@@ -62,7 +62,7 @@ tracer must be configured upfront. The resulting trace can be invastigated in
 `/sys/kernel/tracing/trace`, for example:
 
     echo function > /sys/kernel/tracing/current_tracer
-    cyclictest -a -t -n -p99 --tracemark --breaktrace 100
+    cyclictest -a -t -p99 --tracemark --breaktrace 100
 
 This causes the program to abort execution, if the latency value exceeds 100
 microseconds; the culprit can then be found in the trace output at
-- 
2.51.1
