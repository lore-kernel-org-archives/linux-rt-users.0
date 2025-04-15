Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013025.outbound.protection.outlook.com [40.107.162.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24AFA48;
	Tue, 15 Apr 2025 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700048; cv=fail; b=IY8TbEGgVmwYDMcdo6PpG/KdPfqZ25vYFfEdafxU12qxGGUi1WD9lrUwJN1N7cTgJl/m9NcB3Lu/ES2RTm/4MgT4RdXUG5e5NFrIqWvyDlj6hvaIs9IuP/aodfkQ/H0LK98Y2/2X2yoE+05KPqClmsnhdy/JaDVp9f0ELwhogFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700048; c=relaxed/simple;
	bh=ktxmIsDtEV08NxV/a2NvxLdb9RLgOwtLgBHREmC1UVk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TFC7+HKEHzokQDjBBWV8ER4i/im/h+V1eE8qJGyk/ARtUnHUki815Bv+/PchD81QWau/p/DPz7Lt/H4DlP7Jek80zjus1SUcMbkrhVUhz/nasNrgn0xUtg5LHYiXmnu21/LBrCqSUhd62H36esy+ciyXY4b1/A7khNZzeg4adc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=bb1mlWOl; arc=fail smtp.client-ip=40.107.162.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="bb1mlWOl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKi1S9ulhvPgQTS5U6FVXpSze567N3SwKIV5sCg2vsFH2/1eG0nHQWQd+Oq+/k3JY4hwxFjK3CDYjDTkDei6TWCmvw1M4ycpWvqih2eAcSz0epaBx0wPJ02b8ZIg4OqLp5xljPmJaU5gNLd89X/+CRlcA77oqf4/RJOT4n4NHtLk7adON+DcIRWcOoj2kf4RwQiWV8Q/wOds1VnXUMYdjbO0KI2f1oJLKaSWW39fltwTPyg/mdDdZAEbuzJO/sbnJX+7MdN1Se28Rh0ot3Ck+M7WpnMJP36vdGQRotnvvi7/UeQbLtCnqfhSWKL6Sj1XLbOfGJ+8uFlfOsT+x9vXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6PaJUPw9VNpt0RtiOeTZL32UkyRxjyyqMMqVFshI0I=;
 b=XSSUbz+Km68QDFWP9GGWcjx1pHeQSO0ashKRbtQ/jXSZBxbXnpMjHgr/ebZFTsZD9F8vpIXVG7uYAyhyOYmS4d3JUxpMLnA4lV2TP6zf3+c5bzKsMaYMaY42Dr+lBev+5YPIgNSDCsbHcR0f88cn0jIOyr72APM3riT0Zlqmn7tXAuYo+QUO5y9zlSaEv75ciMnKsY/hIedWt4w12drjg9J4Vpkac2JzVS9hhKfaWmB1+52GjJWWDYx70M3VRNTzYNlgtXt/3YTalGGqaBeSz1HPfUTCOYGHTBe7rLzBm60kOEO5v5PCoE0UOgZRrm2NCmmX27VdJq6trzrbwDsZqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6PaJUPw9VNpt0RtiOeTZL32UkyRxjyyqMMqVFshI0I=;
 b=bb1mlWOloAWMZI6aJKz7bmwL9Wv4kSdFv/pZXnFx/MWbRHTRnUHwFbOZUe0G3OSUIk7EwESdurVmyo05TRLe/d+x0ta7suvrcrR61RNoAGGF0PCVYAgzCaS7D1fV/8wyQOCfcRrbxM4atOwFKqHoZyjlVzFYKsnDKniKEc5iiUjfIaX03ntOmKwcKT/KinArrFVe4jBgCOGVcDHNs/hZdcXulWtus4nBpfzIe4jX1lnIAjzwqJ1klH025sYngPTUqn5NEXUYFgXQKvrm9EtuoAr/Fqw4DRnLBQfUNYXJcs8fJ+8DZ/2F7fE2aCMMS4aXzbYjR1cjy8eOvAN0tdcPHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7840.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:64e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 06:54:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 06:54:02 +0000
Message-ID: <f5520221-b5ec-4204-966c-881b3428d4c0@siemens.com>
Date: Tue, 15 Apr 2025 08:54:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RT BUG] Stall caused by eventpoll, rwlocks and CFS bandwidth
 controller
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 Aaron Lu <ziqianlu@bytedance.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Juri Lelli <juri.lelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
 Andreas Ziegler <ziegler.andreas@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>
References: <xhsmhttqvnall.mognet@vschneid.remote.csb>
 <3f7b7ce1-6dd4-4a4e-9789-4c0cbde057bd@siemens.com>
 <c92290e0-f5db-49bd-ac51-d429133a224b@amd.com>
 <20250409121314.GA632990@bytedance>
 <3d13e35a-51bb-4057-8923-ebb280793351@siemens.com>
 <f2e2c74c-b15d-4185-a6ea-4a19eee02417@amd.com>
 <20250414150513.klU46xkw@linutronix.de>
 <438a5250-30c0-4820-9084-cdef50f67865@siemens.com>
 <20250415062320.bMvqQsQ4@linutronix.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250415062320.bMvqQsQ4@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0295.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: ba998154-004c-4b47-28b5-08dd7bea4e81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTc2anhiYXI0ZVVKbk8xMXZMOXBaWXR0dlA5L1dNMFo4VUZhR2ZLRnFRckc5?=
 =?utf-8?B?K25sZkdRa3Q1ZHJaQkFlUlBSS3JJZGlRNlZEYjZiamhreUllcG5pWXJIK00v?=
 =?utf-8?B?Y3RrNFlRK1hQVFlzNFBDYkRpSmFSNWhReHhMMVNCS2JGNGx3bkI0eDZwL255?=
 =?utf-8?B?V1lqYXBpc0g3cEdwb1lHNHRNQzhiMmZITXkxcWllUGJVVWVTL0JmeDRwaVNt?=
 =?utf-8?B?dDBtZnh2MklIMzRidm1pdnpldmc0U3VRd3RQbC9hMlB4MjdGTnU1Qms4OWUy?=
 =?utf-8?B?aHcvdTFGRzJHWTYwQjR6TDR3WGtyV2t1SWRObHNIMk5iUjV2Z3c0akNJSy96?=
 =?utf-8?B?QUFYejV6dkVQSGtDRnNHems4aXpCbkxqcEV0cm9TdURmLzRhSW5GOTZtQ1Vz?=
 =?utf-8?B?SVZwNm5MVk9CaGJHWkZxZmQ5bU5UVUp3T2liTUZFTmo4Q0syUld6L05Wbnhh?=
 =?utf-8?B?Ly8wNkVlRXQyVHZLVVVKU1VUQ2doS1lyTE8yK2FSRGM5ZmNYZmYvUE5RMUxh?=
 =?utf-8?B?bGtsaFFubEtJS3NZdEtsRDNFaklZcjNHbWQvay9tS0ZGWXFUOW9rbXN3SWlz?=
 =?utf-8?B?M1VET3VrVFpIMXB2dU9qQzNPK3RVRHFINzNKRStScHJoS3VoSEFFbTA1Y0J2?=
 =?utf-8?B?dXVRVGtwU0ZEL1BscjhMaU1ac2tsTmh1cGtaYTZMM3MwbXlBdkFsVnNydXRU?=
 =?utf-8?B?ZTlvQi8zTk1iTmZnYXBrdFpIZTlueGQ2ZnR1RjRpRDNheVk2R0VSZDlNeHZV?=
 =?utf-8?B?MmFLNWl1NmpOY01Qak1LM0tIczhraEM3R00rNlBxMVpTWkJmdDAxdnl3L1Nr?=
 =?utf-8?B?Z1dmRHFGSDFobWZ6RHBFbTZ4NEVWaUFZdU9keGdBR2s4blNkV0YzL0czS1dS?=
 =?utf-8?B?VkZySkRGSXFQTjU4cW96eGdFdWlyZFRHSVNTYThyU2tubW9kZzZZQ0hnQy9m?=
 =?utf-8?B?NnBnc2ZReGxFMnlUOXc2VVlaNkdKOGx0NVdHTXpiSk1nOGdFY0FKVWxHaVlz?=
 =?utf-8?B?UUtYS0pQbXQxVnVucVkzUWE5ZkpBRDhVZk9LaWdwUi9rVkJpRm9YQjlJbmhG?=
 =?utf-8?B?WFhPbnhYclNpc241OGNSRnV5bzdEUGV0R1FhTG5Dc25hN2pmMk1Nb0Z0Ykk4?=
 =?utf-8?B?RzBwQlg2V3VLS1AvL0kxcEhuK1Z3eU13VHd4ZXJZSjAxaWdSZW5PcHdtdFdX?=
 =?utf-8?B?eVFCSHRXVlhrM0N2a2c0N09RNC9Ob0wrRjBwNW9CTmJiNFJ3NXljM3VmcDl2?=
 =?utf-8?B?WW83UlRpL3h1VXVFQXpQeldQRmFHb1ZmMWV0a29kblZreU9hTUdZclAyWk5B?=
 =?utf-8?B?dHNBb3BhbS9vZStuc1VHR3VYVW1ReUd1S0x1QXR0NmovYmtDR1I0L1Z1dTZo?=
 =?utf-8?B?WWM0czFlR2R2Y3RxRXBMTlJtcVhGcUxVL0xRUGszdjhZU2ZreW1TL2oxQVpC?=
 =?utf-8?B?UTd1ZS9Lbld3SjlUOHZmVEJINGd2ZVladkc5eUtGa3VoK1VNa2ZReFZDZURh?=
 =?utf-8?B?UHlqLzVIT2tBWEU2YlBGbWt3WWdRZXpDczdBZkFqeURkZGtRUlBkU0NlS3A2?=
 =?utf-8?B?ekZTdU5vSWVsMXBEN2taaHBYUjZhbmw3Z0NJTEtrVFl2TWduOTkrL29aV1dM?=
 =?utf-8?B?WVJ3S3lTd3lzL1RNWkUycVdUZkNKVjhkRmxDSUlSNmJBUVA3L0Z4djRhZzgv?=
 =?utf-8?B?OEV1Wk9LejJIU005d2RGQ2N4S1BHcks2eHVkSHlsRjZtbDFIZ2luT1hlOHVT?=
 =?utf-8?B?R0p1WW9GaVJBT1FDVWp2ZEF1bWpBYzE4dGVhZEx3MG80N0tiYlp1bWxIYi81?=
 =?utf-8?B?cTE1MWdZMG5Zd3E2eHRyakw5eXV6MHo5eDJDRGVvRkcxWDFmalF2OFhBODhJ?=
 =?utf-8?B?b0FENzkrMHk4bUppeEJpeTAxaHV0QVN2ekthcm82VUZrRkQ1ZkdrdjJidGtm?=
 =?utf-8?Q?4CZa6+uqq+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c1JSTWlpV01jbU9jekxZRi9XMmdZTU1rRW5WSzRTSWQwME4reW9kR3ZFeEFm?=
 =?utf-8?B?S1NwVGVFbHBBTzBRcjJ4QnpZNFZLUm43a2JFM2JUZ0JYU2hGMkdMQjc5WGQr?=
 =?utf-8?B?d1FwNVI3L0F0RFpzMDRtenlISVFsSDQ3RHdqUkF1b2dNTEd0ck9kQ3ZxZ3Bj?=
 =?utf-8?B?RWVXcXlMd2ZSTEpQa0ZMbkRLRGJzRkF4SjJab1J6K05zdTJxcXR4TW9WVW9x?=
 =?utf-8?B?Vms4VjhDampVRithb0lHKzlQWFh4TWVENVBJQWQxZzB5ODlDUUM5Y2NzbDBl?=
 =?utf-8?B?R3BMS2d0VlhkOWhXS3FvTUk4cjFMWTJxenhkRXRScmxXSHMvVXpPYi9DeEN4?=
 =?utf-8?B?a3dVSDE2aC9ydG9kTkErSnV5dlg3RngxT0s0TWk3d0RCVFNqb1NsdExRWDlV?=
 =?utf-8?B?Si9UT3BCT3Z3TVVUaG5wTjFBY2c2NlgwZUFWaVU2ZEVXckJtS2VTUHpFak9N?=
 =?utf-8?B?Ykp0TjhHOGdtU3NkeUZubGlzZG1pcDMrRmJpT2lGQ0pJK3NHWlFKRjErZS9v?=
 =?utf-8?B?MkdyQ3RVWGxKbFJMMjFNUXYvTEg1cTVmdzFlZzczc1N5SjhaQlBqUTdrL1Mr?=
 =?utf-8?B?STJZc1kydXA5K1c1aWI2WU5sdTgyb1FyTlpaeTNFdU9UM3lTOU5nOE9Zdi80?=
 =?utf-8?B?eVJjblNUWUZpQUxrdk9rV3hCTVFtaVlzZGlkUDBSQVg2VWVkSGZmbWxuVjEy?=
 =?utf-8?B?TVNQQ2IvWHQzdlhDVWRKWTV1NUo1aTVwQU5EejR3NnNkTUdmUnBWbFo3UmRP?=
 =?utf-8?B?bWJraWtXZXpEWjlyMGlSVXdBMDB1bkxKM0gzVyswY2dUaHdTQTZXa0xXMjJ0?=
 =?utf-8?B?OWRiRnAxRkVHa1RDaDFmZktuWXhudk1yZ2luZm9ScUR5L3I2OUJaZDhza3c2?=
 =?utf-8?B?VWtWaytDejI5elEzR21jdlNaUVRhdDZEMGgzU3ZzWjZwSTZxVGJRd29iVGRl?=
 =?utf-8?B?QXdKNXk2aWd6OG5vL1dKOFVEVDgzMU1lV24zZE95WlJBTVN4R0ZFSzd4Mm0w?=
 =?utf-8?B?dUE1SGVYc1dNS25QVWtlcndodlJnVUlKVUsrZlZ5eFM5Y0lNWW1lSVRldHdt?=
 =?utf-8?B?cFJwZThQQnV1NDhUZzQzaW9pYllBWGpUVFZwSGQrdTNzUXUybkljK21ZMkpB?=
 =?utf-8?B?NEplVmpvVHJiRCtiNHliQXdiWkVqTDRwajlKNGVOdzg2emxIc1ZtMHh1UzQv?=
 =?utf-8?B?OHpkRk1hVTF4V01naUhDRCtPaU5DSXg5VkJjQStWQ2lFQUNDQUJQNzR5QjNW?=
 =?utf-8?B?eXlEYSszS3FwUHRqRlQyaWdvYUNRaHZPbDU3N054ZEEyY0psdVgxSUpxdjR3?=
 =?utf-8?B?SkdpZnZLNm9ESnJPaTNLOE9LdW9KZGNlKzhORVB6L05NMkNucDBab09GeXox?=
 =?utf-8?B?eDdSelcyamdoeXJ5a3NRNnJ0MDJEaWllanJOMm9sb1FQSWI3YlBrZWd2MnZ2?=
 =?utf-8?B?WHVLSmdpN2JQTW0vaGxzUzRaUmQybS9KY3RUL1A0aUppVXUyYkdrYzdRL2ti?=
 =?utf-8?B?NFlwbCtlamJkODZHZE9FSndwdldQcWRraVV0NGpvaVpMbld4amcyVmhiVi90?=
 =?utf-8?B?ckExM3JKUng5Tkc3Q0RFVVY0NlltSW9TT09KbUFXUnBBcTRXcUtHdUZBcndp?=
 =?utf-8?B?eU9hTWIwU1A1SlB5c2tSTEUwRXVSWW9Ob08vTndXQnd5bjBwQjRVR3RuWE1S?=
 =?utf-8?B?MlVaVmtFSkU0SmVUdVFMeU1YSzlLRVN6UDBWLzh1ci9yK3RtcHFMRmNXaS9n?=
 =?utf-8?B?NFhlVTBCMGJxNTFFbzQ3NGJlanUvWFJIdTEwbmRWS3d1a2VwL0IwdmxLdkZE?=
 =?utf-8?B?R1VjK0JrdGZzSHI0eWVnUDlIYzBEZlYzMEJyaCtNS1BWaUxHVzFoZ1hobGty?=
 =?utf-8?B?REVIcU0zM2dQUnZyZmZ5a29QTGhMQTQzalJ5YzJhdUlxQkZuQjRvdnI4VmZS?=
 =?utf-8?B?eWNaZEhqZ1MrbmRxdVlNcTR5QUJiREg0cncrcGdLdnpabHhudFFBWWhMSlVQ?=
 =?utf-8?B?bzVicmxPSUtrUnNZd0FrV1NMNnhxQ1FJMFNBZ2pCNTJOZjVKRWJFTHNwYXZZ?=
 =?utf-8?B?WGI4aER5NG04SjFUSWcxYzhWQW5lcUJXaVByRVZuWGJrZFhzZjdBUWxyT0F5?=
 =?utf-8?Q?iODRKqUP5rAsUBxeJYUewRka5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba998154-004c-4b47-28b5-08dd7bea4e81
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 06:54:02.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+NY8KGLT38zo4csVCzr1N0iu8m7ReGIdp6m6YyQU5KABzj/zgM/K/KSFlxQ9qXd4OUCGdWkmVJYeHMi39FCYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7840

On 15.04.25 08:23, Sebastian Andrzej Siewior wrote:
> On 2025-04-15 07:35:50 [+0200], Jan Kiszka wrote:
>>> On RT the read_lock() in the timer block, the write blocks, too. So
>>> every blocker on the lock is scheduled out until the reader is gone. On
>>> top of that, the reader gets RCU boosted with FIFO-1 by default to get
>>> out.
>>
>> There is no boosting of the active readers on RT as there is no
>> information recorded about who is currently holding a read lock. This is
>> the whole point why rwlocks are hairy with RT, I thought.
> 
> Kind of, yes. PREEMPT_RT has by default RCU boosting enabled with
> SCHED_FIFO 1. If you acquire a readlock you start a RCU section. If you
> get stuck in a RCU section for too long then this boosting will take
> effect by making the task, within the RCU section, the owner of the
> boost-lock and the boosting task will try to acquire it. This is used to
> get SCHED_OTHER tasks out of the RCU section.
> But if a SCHED_FIFO task is on the CPU then this boosting will have to
> no effect because the scheduler will not switch to a task with lower
> priority.

Does that boosting happen to need ktimersd or ksoftirqd (which both are
stalling in our case)? I'm still looking for the reason why it does not
help in the observed stall scenarios.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
