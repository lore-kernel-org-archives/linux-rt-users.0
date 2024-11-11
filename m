Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17362150990
	for <linux-rt-users@vger.kernel.org>; Mon, 11 Nov 2024 22:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731364118; cv=fail; b=KlAtpv8Bf6C8AjrxCyDjVlNi1pO615/mtHJXI9p0xQGjnxHTFr3s/z9Dc0/vvYmyyZRtuoD47E9rpXGZuG548zUuIeAmRW8tkZzLp9gxUwStWQACw3RQmyqunjKXDTARowLaOaMYNJyTRQKTCJWw+qL2w9gDD+CM5if4j+O1gJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731364118; c=relaxed/simple;
	bh=9HiYdz8+cynbrQz9teMvx52Usx448llq2UWtp1bbDZM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EYFJiFpTuLIqGbxl+e83RY3LrDDpNhJQgemFh6m7lmACC1IZLZUHobAtxJmgwEXPaJJF7+I3cvEMc3kvylhzvfXB+2BpZZIbxhVnChuDfILCQ8bYZyUFP4mFMonb9K49M2xLmvx8a4PIxj+Iar7xQFoaQ0Wc5WRtmMmpY8RsAc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from NTZPR01MB1003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::7) by NT0PR01MB1008.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.36; Mon, 11 Nov
 2024 12:52:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llTLtpBvuo5TJPhxIXrkPLwGNPP3T5Nvr41RasucOw1YQs1hnHbaic4fomfYSvxdn4AVx6+FyKkB8WKrmmO3JECng6Oo4hikWVQ/7iji0GnKzgcVxfTKfLFwPYK9bKwRDwiyTXZNyAuJFejsr++GmkiJx7vPBW1OHdNmPTFUJRjFU2xUNGlTOg0FK0Ihh1V8pX2NOl2EnP4qiKnOnXUvNjsMJ45FA9foMCx3F3zqIPmJY3w7hMHWXcKO+EAJTAe1G2PQtO7dCHR0MuMe619brJmW0lWOtaMZZFq+9pR4Bh4k27a171x3G3s++4q+D6dhpnPXXHKhkV6kwtADWpgcWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDHrVk56Z+SxR+/Ht9iAnxUtYXXwWbY8Bbeaymg/WWY=;
 b=I9fyRjkpzplwdgGkGXNgo4TL4Y5rx6dTYNrdwT6z4CMTek2I0PzAhzMhvpUUcHtaCvNxvidegfeuz9XyI6LbDmssQgUQltUQl8/C3scNAJ5MYziGll+lyEgyPmPC8St5zvYg0eZQ8+wA1bYiuyH7f7EHHBsJHdFUUApnkrMPkon7TTbua6Y+lW5+aY2pRlL+JmGSNF6JKjnSIRPVyc6UyXH4kn+FALDTxq2Zujz8usvcxbtrE+b1kehz5XV2lhw7HdRjZLFsqCnGpgH71i8fdBRNeiSNhgoVOfRBK8WE207IRr5ze7yp0McUaKbVZneWfle+FBB6qt8qMh0qKkzYJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 11 Nov
 2024 01:50:16 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%4]) with mapi id 15.20.8114.028; Mon, 11 Nov 2024
 01:50:16 +0000
From: ende.tan@starfivetech.com
To: linux-rt-users@vger.kernel.org,
	mtosatti@redhat.com
Cc: williams@redhat.com,
	jkacur@redhat.com,
	leyfoon.tan@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [1/1] rt-tests: determine_maximum_mpps.sh: Get frequency from timebase-frequency if cpuinfo fails
Date: Mon, 11 Nov 2024 09:49:53 +0800
Message-Id: <20241111014953.11604-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0008.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::13) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic:
	NTZPR01MB1018:EE_|NTZPR01MB1003:EE_|NT0PR01MB1008:EE_
X-MS-Office365-Filtering-Correlation-Id: be6c9a45-8ed6-450c-1784-08dd01f330c2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|41320700013|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 iEv5qz6tqfBI4xzY9xVlQYt/L5SGqPNyzxPFAmlYsRFqZ/CFyouxKOmgclO/EAW9BtosHr/UtsEwQ0EYjWkr3+K9MmMqsS4D/Py6/1Wp8lX2fatU2WhHfjND6pBJWeZzCb5F9eB7hfhMX0NKpKx/vYIgmhOOY5IJ2XcSoEs06m1OnW5ueyoklHTgooG2MQubP03Axcr537uS93Ev7p1g5MetdI6xm5vUMrZgEaFwYJHEzE+CKpdtQPBoJgp/Zq4FQp7oDIUj9NYWux/CNPIkZemGWy9wqxuL1NLcqdZ6k6R90dCTYd9u24bJEiTKX7frI+JiFFGDtyDFXDI0G+mMe891vNuPa4ikHc8u2EW8z7ZBEHFqzX628QuLaJEBuhkyVX+iD6PJJ6PcJfVZqBjA1mxM5uSl5jFS6xJohltYs+rQea8fMox3yJ0kfjdXkK6xt03fJ00AI6T8+MRq1qrfPHsp8KopL7jZkGz8b+Drqocq0v8kFkXX3EHwjT9XDpXAVjU9+KceWc7UgJr/kavNNH31TAcXXBvziCxmTP0CcLhI+xhGD9HL9JC+nth92dSACOOXjoBYtf+joBu3tjmvE5tcA+kI4tDg3/GJK2u7T+oaWXj1TOmu22Cbrjf434NQ
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?SdFF7yuoeinnQKpvdp934THRIA0ybrrQRdBjYHNQuVUc5srAcWdCOYgpiFM+?=
 =?us-ascii?Q?BFpf9wLiN4JRLXPPjXDTvaO7GhgKpuTjovsY5ujZ+OM8X44M1qYIIeOCqhoO?=
 =?us-ascii?Q?2V1LoqA0hSfwc1ShB/DGdsFjY4ig/ZIgxdcZhETBnlEnG/JKoHZt0XHFUCH6?=
 =?us-ascii?Q?0qAGbvaTRJXh09dpgW7dhy8oZFAlZz3+6X0s24k6kAno7sT3ouJLcQ1NQfIU?=
 =?us-ascii?Q?rmzDDrcix9u37VMv1r1q+4liwnZ9/CIjFp4awayCGnOI///Y3ARAL46fXXSi?=
 =?us-ascii?Q?aQajTTF+u0r1IGNo6knnBHufxh7TB0ULxm4sN9Cc9/saQ/9uFNTUojGnk4Nm?=
 =?us-ascii?Q?VSEPfA40SGbVipLW8ZBuuP34lZlcrncZxfLZU4oNht+zmE2KqHBBl/6qstwG?=
 =?us-ascii?Q?VECyP06iMpnloFFM4DsDRqXt9iR0Awy4/X7WcvFp/knew5qQLppYVH2WQzK+?=
 =?us-ascii?Q?AnT6i45mpMZcD2XJ7l5YBzNyyG0PhMa5c+qK0B8QC7zjCjn+HQDuXdvGpwUS?=
 =?us-ascii?Q?Hye7kDZt8c9UFtZLwz7MdJ1DqZI0+3Wu1acxDobQs1TgGBLA+7RT8tPIrlqh?=
 =?us-ascii?Q?JEDxWCvlN7x1oE9LOThFpifadUbRbLs35RUpSN8ZCSPCXxsEAhdxQrkFRPwI?=
 =?us-ascii?Q?BrgQ3sG6zoTuqxXkoPJXM3Zxdy74nJXJNnIGvNAYN5IL0zF+L4OMNlGye9kQ?=
 =?us-ascii?Q?ntISxwcoGCQ8fBjALNHkGehiD7VzB96Z3m/8XTwSFc+uTe2cYJnUNiSMCOTz?=
 =?us-ascii?Q?Z8ghVsmiZK6a0TZD+6o9su1oB8Wb9QPIMmQN2YB75iDbIY5uc6p7IcJGu7pc?=
 =?us-ascii?Q?f4XSMG49Swt2fUctnO3QWQ4lnvKDT+oBR5ZVCj9ajIroMVCuCZ2SK+ewJ396?=
 =?us-ascii?Q?73Z76qyYQaK+QGxL9gjDFGWV5O9rfYEFgom/Z2KNmrFjXjq9pWLRgIvS3RVR?=
 =?us-ascii?Q?3xLCXSBirytvY+qzaRlkjKo+5PIguT9vN4Je+YAycVZm2NhUX5efIQMHO5Fv?=
 =?us-ascii?Q?y16GMyxaTq0zxIL/dgIgolPmPEEt0JndbU6C4N8urWCvgIFTu8Yo8tpDV7Jm?=
 =?us-ascii?Q?4ZxsfPFmkrMB5CowmbNts6jZ8TQyRLmMhgUTZAjBUfOElajkhFE9xEvvPeXt?=
 =?us-ascii?Q?Zkuqycim/vioa3OszBoqZn7kLz4mWQcd9rGSNe6hxwmXgIxoQkJoVVy1m0Ml?=
 =?us-ascii?Q?CVAjqHsYmuOY9cO86olsALgPbj0XAo2x6/kMRfi7Qu3V+e4jDt+kElq7NADg?=
 =?us-ascii?Q?MtoKxHMyK4JeSLi1JgkSVuo6OFYA8Io7qzQxYm9dD512qRw1eGQvAQxA7Pzv?=
 =?us-ascii?Q?8ntSD5lZ7b68kSwnwzIC9l9SOQws9EdbSsCNx5+OKJMSVMvv9tIG+T0iEJNt?=
 =?us-ascii?Q?Y9dse/ZfBRDplVv/A5oQ6YbJGEGs2PLYjcaAK/WNOg8JIyGD1PJWhdl8jfA8?=
 =?us-ascii?Q?Yi2C/xuLchXPE+w3fWy2P9VuQNS7Qqfcn2g3W5b1Wu4AdUwWM8adzeUVVsc0?=
 =?us-ascii?Q?brRA+qn6E4aV2T+3LHJNZBmPCAzzjWsXX4beGSuBRtvOlvHeryq7amf7AQWv?=
 =?us-ascii?Q?PCPWz/Y33kJ0Dh6ysBFI4ZiHsPm33fESSyVKlIpM3YVlhVaeO30u2njSQX9G?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be6c9a45-8ed6-450c-1784-08dd01f330c2
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 01:50:16.4396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUvdPFEBnNv3u81hR1/oRMlm53THv2W0SvKebIJqfhYI++GdNzAGDXkcmaVkt9jzNxeAnTdJ2BJgYHaDsku5DpXaZkroWanrK1b3k0fHRDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1003
X-OriginatorOrg: starfivetech.com

From: Tan En De <ende.tan@starfivetech.com>

If cpu MHz is not listed in /proc/cpuinfo (as in RISC-V Linux), get the
frequency from /sys/firmware/devicetree/base/cpus/timebase-frequency.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 src/queuelat/determine_maximum_mpps.sh | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index 733b6b2..adfd809 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -42,7 +42,15 @@ usage()
 
 get_cpuinfo_mhz()
 {
-	grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1
+	# Try to determine MHz from /proc/cpuinfo
+	FREQ_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
+
+	# Try to determine MHz from /sys/firmware/devicetree/base/cpus/timebase-frequency
+	if [ -z $FREQ_MHZ ]; then
+		FREQ_MHZ=$(($((16#$(hexdump -e '1/1 "%02X"' /sys/firmware/devicetree/base/cpus/timebase-frequency)))/1000000))
+	fi
+
+	echo "$FREQ_MHZ"
 }
 
 # Check that the scheduling policy hasn't already been set
-- 
2.34.1

