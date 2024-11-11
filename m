Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B4F4C74
	for <linux-rt-users@vger.kernel.org>; Mon, 11 Nov 2024 05:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731302522; cv=fail; b=BdLqlH2YIClIdkiU+SJodhkRqBlCoeL+XYbH5MYJ8Y69SwR/r9j9LuPXSzuAfK3yY/w0j40203Am0GLW5lwySR8u+VUixCV28Lepa8MraVIU9v0i1Q2I1D/BaOObVMazaFP9tx51F5ur+VVbgrc0wwSsnGLSrjdd6+JNHrPMy3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731302522; c=relaxed/simple;
	bh=7vYiY3YtvvdhruwKWJ8TlGXciEDIq3I51/2HtYyNFmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s+IK/R2onPP3SBXmHfrUx1OPqO+ULPLOfVq8SCG4VB6PDmZbi4OlgpC7Xzc78Nx2BuGesoi1UtJK5ggkzwvZ8ZEnaKuH9LQmUg++XKjKRh8ETxeguE3O8e/Ge2dkpyrPa05yJHbVFPWKJhE17Mu5zengVY7KjbFFwAcUMlB51oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wn+81yaPa8355pmC6l3EWecDlIG7XdaJbjNPtqGDnhzj1bvBe4Mw9/9PZKpSqQ+4LiXdthyjZxiJYHWTxwtoNlIpH2cpGxVh7yUuKGHhmeIGBCIMsYYyYVp02mSgGdlsF9dH3jIRD2shGYiUOPc4pJnzghagxEs46YytkmVJX9CbT0kZVUDt7awd3A32+SaO7N0Ia5NaLWNpToxctZOMbFaIK8KKgklRr2UzwTpaYPagysQ7+dR5B4hpjpghRAEDewz5SbSpC30C7pxCq70CRj6sYqP68wwkNO46QLlaHah2+WsXr0zq9/QPHRyK5MUSby2n1ecSah4UG0Fdu7u8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQI74Z1LC4dJq8iCuFZEuyT/EOC9UJ/uZOfSCi3CATY=;
 b=k5YMGiSuvLkgf9P4V6ly1KvUsYcsvBcmr0u/5CcuaSkH+6UyF1zHDFVR6Jdr9vxnSsUprz/f61c2mON6fZY7GJJShWhmTafxmhuJzgFFIhiH2IL908B4Uef4aarxMsE6olpUr12C4uT1FEUKxNjAu0qzCDhmkXGQuKBQBAxTvXmwU1JLHF4lYI/34pwaYp1GCmU5X1Z1goNPuD26+UmQCklgMTNGLkgNvkRRLoyweg3poNyvtnWS18230vw9DC7pHjgP7rH/a+FTmYyKkegDK0Q5zZEJx11pHH/7fTtoQN7uAYIVmGcfbYhbK8WAvHVFdRqHPxYBFI/Xk0fHZueobA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 11 Nov
 2024 01:49:48 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%4]) with mapi id 15.20.8114.028; Mon, 11 Nov 2024
 01:49:48 +0000
From: ende.tan@starfivetech.com
To: linux-rt-users@vger.kernel.org,
	mtosatti@redhat.com
Cc: williams@redhat.com,
	jkacur@redhat.com,
	leyfoon.tan@starfivetech.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [1/1] rt-tests: queuelat: Fix wraparound in __clock_gettime()
Date: Mon, 11 Nov 2024 09:49:11 +0800
Message-Id: <20241111014911.11571-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0047.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::14) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB1003:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ffa371c-48c2-4298-ea62-08dd01f3200b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	hnVmkdau9B/bxZOjuWvITwh/JdZ8++/WFK9Yt3OJXQ7YlGIuP6rMAo0kD8w1wqcm85blD8xho32C5qcnx4Fx0qX8Hd+aNwCKC+gMRcAgfVsF53LjTx7kow4BEfWyulNdMb73Eu/2SHlrixy8H5e8A1KOHXjX2ODJcsPUsveF9VXyuS0ZutB0bi4how4h/A1KFxuJxrmUJd3rDQTo8Jk6IG8UFLyDiYN606SJ0gYI2eXKctQKzK0AvJt4/tqnR+RaNVqoqjOrQLgMpl2K6F6AupQSu1JeMBuennBGRgs9L7WH0to8VxZELq+Uy8hfhoqA/Do7YiG8oHSBG46hAqp+MMWl7cLQCBUQxOtPRJGq89jtL7greY3Utx7M0J0ZwGmHAKbKLO4C7jdHQ2En90P9fJRP8E1UxX7xDE/AdGflg22YfbP6SgEOfDQjAn0fIQD9vpj5yS7fuwMcquDz3JxicruD68qCi0z2HEAMTdN8+yNo2DhQoFGwK28eyqnD3yTK1pxORWJa6gNO/DKeALl8j8Q21udCSKNXpD9G8WjW3yzuuqGGWVvEIwAMK8VaOOnunTruN1Tk+GJlRd4OM2XN5W0oZ7kLcwlW+x2IZco1QdrFDyvxaDwlE54wdUTTmvvv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yJCGDNqjkfeIAsXt+MWgwOAWPDz6Ts59ZGgwwzEQ+CROMw/XiyHyX5O/Hxfg?=
 =?us-ascii?Q?fTKvp4YIK1w0fN93t3n7hfoCIGZVIDJ2HQSfZgBj9tJVWZUVxnTBfxJN1f1X?=
 =?us-ascii?Q?Dv5bgqebvh7UOEsTR1F1qQE6wxOPqDenxv7Ij0VnrfVn4Nr+vvBR+S5Ena6b?=
 =?us-ascii?Q?NsTnClKaPuOHcyzeG4j7cjlo5cUNLSXp25cPXDmYmniXEFUB8deyf8DiOq1R?=
 =?us-ascii?Q?r4KpvmTeb52xFqz11QNxKIEwKRPnEY6ON/ZbTO/ewJv9xpVoAXO1qlEUjjkK?=
 =?us-ascii?Q?RKD1Y273j0HaUtop+zAkiooluKiIkPuHmfP0E7E+xy75gd9ONiFNkBVCoqAP?=
 =?us-ascii?Q?VtbMe7OtXhuu+1+uZOal4RfGKqYD3sl91XFoFQG+PlpxncDkIg7nG+WCiufF?=
 =?us-ascii?Q?lwYFfel4+LACbwAFKjZlOb/1vH5sBx0AuevwfeaZGo4SiNK0wClRwVMvwnyM?=
 =?us-ascii?Q?ofPRg/Ew/f2GHL9jl6q3GPDwjQPjDK23tyYPffjUzOVOXwSGpLhQkOXloieq?=
 =?us-ascii?Q?UXbxiQFfvHrJ+fVDNVidtlBfNKTn7wkRixPPICqHhhj99HmOZIowWdJmiVNS?=
 =?us-ascii?Q?IfGEfxJlGlfIM+KE1Lc7fe8+EWrlRdRmIGKkWclxyyY9Z2eS+gF7LFzG2cPn?=
 =?us-ascii?Q?QmVJ9veanBCb8yk0zf7b0fVtMceIoLJjiE3kGA3IA9kDHPW30e8p0DZiTmBK?=
 =?us-ascii?Q?9JgkkwZODy9cK5iqHh45El3oCaEit2ofu4imCqLQ9D0170PZBpJm3lHntxi3?=
 =?us-ascii?Q?8siWispiMZ1O8Kn+/QFG5LYsy0h626Jr3HcanWjzPjdX8CmRyNfpd9cABSI+?=
 =?us-ascii?Q?wRQYuC+cOVHHC2SH67CFwQVgS2qZrpx0g0dw2w7AbasOFC33e+Tb9EzyJHDL?=
 =?us-ascii?Q?2lcIHVmZ+nphh0GrZ9OTp9T9oQPNIHYa5JC7hnbUWiczfLWev4XzaniwGtAO?=
 =?us-ascii?Q?sfW5/1rJGpy8g4trRbB7Qqpy0wsIeCt0AOq00QoqmYyIj8YLIG86HYMwQvmy?=
 =?us-ascii?Q?3Z3DFH9BAuqDRj7VzXYwX4QUUCe8K3LKZE8QvRTZP0tKcL7vBmsH03QsqjgK?=
 =?us-ascii?Q?PVnRoPnwF1LsxhV1gV/nlwASFo3cd7ZnVpGE8Bs6p21DdxhfKVDrEpFT87Wa?=
 =?us-ascii?Q?5hf5iR8iycFiOv6AVM9XwXmoN+3Cg9t7/an0sqLEpHR5ms0jvpmy05i8zL3U?=
 =?us-ascii?Q?J4HApTA6DaY1ca9+jrxERfErTGPfJJtTrNWYFTjpYt4ayG39TKdtwwOdVwFf?=
 =?us-ascii?Q?LpGqUAQL9Y/+tOA1a1Da3bW0UDRmPfMRNFBqqogKhLBdzEwYCSn5Hc+w5dAg?=
 =?us-ascii?Q?fA0v22smhoCTpfmdPaKa2zgbmrHlF0DTLeB1fJPBqlHSqclf31pxg7P+iErJ?=
 =?us-ascii?Q?pxYl3owIMsqB8r5Flqh85LBeRCwM98LXRB6w5fNoY/H+lBWMl2zDHIxolm2p?=
 =?us-ascii?Q?OhyGz5mycaAxqsgApUzt2JZVVqtqzAZFoIHkZGFDri4ALsJutwgHHSPcI6Ca?=
 =?us-ascii?Q?cKwPaLdK29HG4ubmtQyEu93XG+dAA7vA3cQHCxxxqK9SEU5739eN39W1ViN5?=
 =?us-ascii?Q?f+vln56CjT3F25M3w5R3rUzEYRH3Tc5CSRKHF4Lk2RJSIzsaHK+fGnkLFDqG?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ffa371c-48c2-4298-ea62-08dd01f3200b
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 01:49:48.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k1QQ4MrCU2uJAyglQ9AiizBR3ePQ2n8wfupRuZ1eJJNMQNkq4Ncf5rx0mpwuuEwNbakYmo2bOYCMzAqhfb1z8v9KZdQRYpH9ytqDA9rh9I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1003

From: Tan En De <ende.tan@starfivetech.com>

Include tv_sec in addition to tv_nsec in __clock_gettime(). If the value
of variable 'a' wraps around, it may cause 'delta' to be negative, while
'delta' is defined with u64 type.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 src/queuelat/queuelat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/queuelat/queuelat.c b/src/queuelat/queuelat.c
index c549cd8..c057389 100644
--- a/src/queuelat/queuelat.c
+++ b/src/queuelat/queuelat.c
@@ -292,7 +292,8 @@ static inline unsigned long long __clock_gettime(void)
 	if (ret < 0)
 		return 0;
 
-	return now.tv_nsec;
+	// Combine seconds and nanoseconds into a single value in nanoseconds
+	return (unsigned long long)now.tv_sec * 1000000000ULL + now.tv_nsec;
 }
 
 #define gettick(val) do { (val) = __clock_gettime(); } while (0)
-- 
2.34.1

