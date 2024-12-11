Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2093.outbound.protection.partner.outlook.cn [139.219.146.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF811C3F27
	for <linux-rt-users@vger.kernel.org>; Wed, 11 Dec 2024 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733942737; cv=fail; b=YP8gsODCTzt4R75mcBDuu0RUNe9DzFWIBE5cJ4wgaeLbhMK8cjKZ5ikjZWQDYqCGGD7XpTZvuK37KuUIrWsaj/5OOCfqQWgqSysJgKRHd2BwS7cCApXmFrZd5MGbc6MFUSwoaTkVz3+inXNrDT0dGbhFfW5zRyFsyVuQs2VyQVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733942737; c=relaxed/simple;
	bh=4+hefnrWfuQQBJ3V3s9sdQJiwdS8a6Ug5wGBBC/dZAA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cK54P3O+JspkOo/P7vAHSBkkl9yc9l0bEXvYsOZSwo96Nl8kzw8LjF9ykMB+f505OSlN4UCKBk3jBogN0/RIGu1KBbwmChBjlA69O7+HvVg/zvogFMG2KYO7jhYpZsWnsNrPbjyhoyEJ/N3F6ptWOOKI1fOaXpGZupSihEdmYI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItBAOLCWOpHgoRgR//SarB86/0DctGwWfZFLtOzd62DPgsvtDuwsVDD2IUucuEVt9hXQiXDWoZsIl1en2Bm+gPdJ/iMRC6s0KmG7faiiwbUawy8ciHAT23Mnr8wCpQaji1RI82diDT9p1OBKJNA9p4XbaPXCDRPZ7Loq9vdL71LM8VBO4FzJ5kypL5x1phVRjuVHFGUq74m/BI7Q+b9svxtCJ/P22t3QRL761BUWUnFoC/20j0NJdIdv6zrCoXTytTNabBH2jnhdV6u5Ntgx/kSNNf7dOSVNfIWmngiqnTRNgrUfT6Uo+4SfbkSTAvFT5L0rHv7jwOwJgWLWsba9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH0wwODkaqaa4Ng0KakKvrNfKjSgOetFzI5C20T52x0=;
 b=ShR4WrOnbL7FHGsp4O5BGGPCUZfZdn0McGCknKCZPKQqWDSreRqmpXH3HQ/grp42nMhW4o9d55MdXWddeA2VwYtX/0c7EamIeXKzT9xWjuBj6ZXLGHV+i4tknkd+GLXF5MuJYWSZKTIlTvTXxpF0Hcop1f+Ab780vY0a5iQTLj4QlzLYKUJUt+JfWzL/o3G2yybdlZB/8B1QxpR1vjnfQ4KmIYvLk2pln7vmqIHYDtmGcixU3XscFHpqzwVKIGr/UK+m4DgWvVsTDCyTtO9O2i1Qj6HiXYR/E5QIzn+nK/mvZsoBsJkmFRq2vk6rV1d7LqMsj+sPOFpsTGHGYy7DXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1049.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.6; Wed, 11 Dec
 2024 17:12:56 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%5]) with mapi id 15.20.8230.000; Wed, 11 Dec 2024
 17:12:56 +0000
From: ende.tan@starfivetech.com
To: linux-rt-users@vger.kernel.org,
	mtosatti@redhat.com
Cc: williams@redhat.com,
	jkacur@redhat.com,
	leyfoon.tan@starfivetech.com,
	endeneer@gmail.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [1/1] rt-tests: determine_maximum_mpps.sh: Introduce '-F' option to specify CPU frequency
Date: Thu, 12 Dec 2024 01:11:58 +0800
Message-Id: <20241211171158.1344674-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0007.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::21) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_|NTZPR01MB1049:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e0a922-1dde-486d-7005-08dd1a070e2e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|41320700013|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	UnMuMK2JCnnRQviwCUbWjIDHW7jqBuQ6hDXfdhtMVbgsm7yxTVrUSZZ7GUCL/cd6QFww2NX91jBUKG50wMSnm3SPqD6zw0cUMCbFM+O15dJFWyl/fuxvwM/g1XwVnTJ3veOpBs47skpRE42Nbr3iOOG6H7L1KTe6spVcWLEydFDiGZa5vWucaO5U5RO4Nk82d96GhPIZtrbN1iNWm17OP/50Uob3+sPyQ5Yni4YbitZ+S/SIBGr5s8VFu+yDdsD4S9J7i7+0mW82EI9tONM0iud7r4Kl+GuBUOx7OOxrHZu+5SZih7J8vihkUoDhG/ni5Pq/pE9XboArbpoapm2oaPihilZMLJQ3QUbKh6EoQUVvzd/Q6lcGaw4tIKj4rU0J/gxoDreI3RycAoHMzULyaP18i/K6Stj9V5b15LadM4ys4YzNIB4f4MIKa51XKfHPp4yZ8eFjyPJ4lnzN9XSUOKtRixfT4RxpCkSoCszuPKZ+mUtQOh5JTjCITMOPQu/89l0vKDVMD+YjYQ0jaHt58lGgp/OyJuoD6U8HtvL8Qg9a8ikPmqSgyDhLGEbiRAaHB5V7nkwM/n6uvv5J1VsKObm4972CIQqLcAfT/WwarI8gi/MmA5L8ae0ucXLZWXJn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(41320700013)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V10vh/r77tTv2Y4dxZlh/Hft5YNglL+uv+dtAkE360zsClI7Q97fL8JRAq2n?=
 =?us-ascii?Q?7FbEKF+wG8Zq7Lc9NtFzw+Nb6zgNPQ6vr3CF8/tYL33PBYaQn7Tc5K+1cLXU?=
 =?us-ascii?Q?uPLX/RTpNN/tp8oq63uZp7+yir+p6mZxI8ElC2vIHjHq7zEUUS4d0eoVOMpf?=
 =?us-ascii?Q?YV1IhiDhxvuLQzRs1Z8Lzpg6W9NYSU3GaSz5qrN43Ax2CX81KJ/KgzuEHn8Y?=
 =?us-ascii?Q?l3wWCkaKsKKaWOOlrrOBGCCtpEnPZ0UhBa3TZ4bm0ZMKAd1RAegojS58PBxf?=
 =?us-ascii?Q?npaj+nP4czTSQwI7ZbwiK0uUC0jfZCUY7B3bEiluLhqoM1n4jYt46pjhZigt?=
 =?us-ascii?Q?9vhpqfzJPVDwTVIkTHmxV03je0NyKMPuYR8XX7iPZ3sMIm+DzUUUVvl9YQOW?=
 =?us-ascii?Q?ar0DJiXIqUxDz8WlTmsigvxuvShoN/3rIFY0/2Izkfozmy+fcPhT6NFNt/nF?=
 =?us-ascii?Q?bmr9kbl8mbzovfjum8feRGa+LTfhaZYDh8VunsMe3VjShsSyAjDAGih68MNm?=
 =?us-ascii?Q?9rtc4L9K7ZPTj3SqolKkIsY/yCCHZ2qWt46WcrtDLC/t9t1BmWqbUm53E+rc?=
 =?us-ascii?Q?Hz97g5rptyVMDfcyFaoz1hdF6OmEDDRX/QZiUzFgjLuzgiG6OoLR8dTdW37E?=
 =?us-ascii?Q?q9YQGjd4MUjb8waQnWtF7j2mq5/V7UG0Rg9F5wLNTn1Pe5mxZNxUDPIyBsJO?=
 =?us-ascii?Q?ztMECF2i91PoirOjH5b1YTOGjLvYlK6V9gS6U9tyiT3c4EbtTjp2QhPAPxsh?=
 =?us-ascii?Q?BybCM26TM1RhAUg/kwKkiptlF51veWoEJZaQwoqVlvjiwqYuVlX8z7fah283?=
 =?us-ascii?Q?U/KiSXrcJJLKnctchZpUf6oidCw/w1mbJhDYzp7T8fxLOTwK9QA5sd0t5Yfc?=
 =?us-ascii?Q?w1bZAV4ec9ZbwO0/fBxKsRlNniXzunLDu7Jr1EKLYjqQVZNewN5Z8td5abRX?=
 =?us-ascii?Q?NypDk1HxYy4hajZuJlBoejNLSJr7tbk7GH/diSOURYetwL4JHERy82zkY9iG?=
 =?us-ascii?Q?+qVOOe2jo0BPNhPjsqEUJWwezG7Slmroo/WRROWzADd3EStl5IVblhin5rCe?=
 =?us-ascii?Q?h8mdSlJH1X67v5Ad1JO2qvMH03fizrimc/1K03OYMyow0S6F5mtWfYtegzoM?=
 =?us-ascii?Q?mulWajN+aeASz9R4WGuv4sMkmqpQ9tA7d/OOpoy/5GtjSXzHBJM7kRQgVEW0?=
 =?us-ascii?Q?l6yvmadjTRgJ7D5FQywHj7tXIpQOfYFkblGE6TrGz612fVztR5I9olGtgzDj?=
 =?us-ascii?Q?CdW4joKQqoe0psfugKE6hFpS7VkNKrlIHM7Cq6vPDKv4Xk9eNea+Zr/MXcSs?=
 =?us-ascii?Q?nBvaBhM9UzPxyf3VLYFxV34iRq1J1hjmgOBHB4WnvMLGSbMGO5CNSsu5tqfT?=
 =?us-ascii?Q?as9NNQKeRXK1eu8wg3tRWaZw/aMLGpLePkhAYsQt1ELQw1NnjkHKy6vZWcRv?=
 =?us-ascii?Q?Y14Vqa0Z6GrjXaa84lpo4MH0l+SqDTFyTxf/nayGfc2kTcTSleEoMDv7E2Xc?=
 =?us-ascii?Q?yBSLNG2De9QXyCgFXJTNIZZAXrRxxoVlYflYn3ydauHp7McXMoETUgIPPwUN?=
 =?us-ascii?Q?UPSlSY5L67GNahW1EEw9gCo8WENet/Fp9qnjIE59s7Oh8nsvTw+KNLUftRVQ?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e0a922-1dde-486d-7005-08dd1a070e2e
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 17:12:56.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6xpVv0HYQlZxobRW1LctVRQ7xdl5oXQY5fav4ganuhZPjV6qok3w2feRviILXqyDjgUYWoFVBrs4b6OJBWxYAz80PRCvAxzWhIFIKktJvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1049

From: Tan En De <ende.tan@starfivetech.com>

For platform that doesn't show cpu MHz in /proc/cpuinfo, introduce '-F'
option for user to specify the CPU frequency in MHz.

This corrects previous commit that mistakenly used timer frequency
(timebase-frequency) instead of CPU frequency.

Fixes: fab7d9057887 ("rt-tests: determine_maximum_mpps.sh: Get frequency from timebase-frequency if cpuinfo fails")
Signed-off-by: Tan En De <ende.tan@starfivetech.com>
---
 src/queuelat/determine_maximum_mpps.8  |  3 +++
 src/queuelat/determine_maximum_mpps.sh | 17 +++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/src/queuelat/determine_maximum_mpps.8 b/src/queuelat/determine_maximum_mpps.8
index ba2cc2a..bcd3078 100644
--- a/src/queuelat/determine_maximum_mpps.8
+++ b/src/queuelat/determine_maximum_mpps.8
@@ -56,6 +56,9 @@ default priority = 1. Valid numbers are from 1 to 99
 .TP
 .B \-h
 help
+.TP
+.B \-F cpu_mhz
+CPU frequency in MHz. This is required for platform that does not show cpu MHz in /proc/cpuinfo.
 .LP
 .SH AUTHOR
 determine_maximum_mpps was written by
diff --git a/src/queuelat/determine_maximum_mpps.sh b/src/queuelat/determine_maximum_mpps.sh
index adfd809..6a90ca0 100755
--- a/src/queuelat/determine_maximum_mpps.sh
+++ b/src/queuelat/determine_maximum_mpps.sh
@@ -37,20 +37,20 @@ usage()
 	echo "-h"
 	echo "	help"
 	echo "	print this help message and exit"
+	echo "-F cpu_mhz"
+	echo "	CPU frequency in MHz. This is required for platform that does not show cpu MHz in /proc/cpuinfo"
 	exit
 }
 
 get_cpuinfo_mhz()
 {
-	# Try to determine MHz from /proc/cpuinfo
-	FREQ_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
-
-	# Try to determine MHz from /sys/firmware/devicetree/base/cpus/timebase-frequency
-	if [ -z $FREQ_MHZ ]; then
-		FREQ_MHZ=$(($((16#$(hexdump -e '1/1 "%02X"' /sys/firmware/devicetree/base/cpus/timebase-frequency)))/1000000))
+	# If user does not specify -F CPU_MHZ
+	if [ -z $CPU_MHZ ]; then
+		# Try to determine MHz from /proc/cpuinfo
+		CPU_MHZ=$(grep "cpu MHz" /proc/cpuinfo | cut -f 3 -d " " | sort -rn | head -n1)
 	fi
 
-	echo "$FREQ_MHZ"
+	echo "$CPU_MHZ"
 }
 
 # Check that the scheduling policy hasn't already been set
@@ -64,7 +64,7 @@ check_sched()
 }
 
 # Process command line options
-while getopts ":a:frp:m:n:h" opt; do
+while getopts ":a:frp:m:n:hF:" opt; do
 	case ${opt} in
 		a ) CPULIST="${OPTARG}" ;;
 		m ) MAXLAT="${OPTARG}" ;;
@@ -73,6 +73,7 @@ while getopts ":a:frp:m:n:h" opt; do
 		r ) check_sched; SCHED="-r" ;;
 		p ) PRIO="${OPTARG}" ;;
 		h ) usage ;;
+		F ) CPU_MHZ="${OPTARG}" ;;
 		* ) echo "no such option"; usage ;;
 	esac
 done
-- 
2.34.1

