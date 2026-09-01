Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB81137F729
	for <linux-rt-users@vger.kernel.org>; Tue,  1 Sep 2026 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788250791; cv=fail; b=ZUqeZT7Gep7pjHIL9o+oh3sxE4R3l82Zn0/fzyGrwd++JMZQXJGASqnwwChdjsFMO3nrG00XFHVXoiGYTxp1YBFzhnrvBrlj4dBqk1I3HS3K11P2Ehp5La2cycZEHyqxuoTC2FPko5pRum0SZwO0Q+z7OtREUeDVnXzHqolCLTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788250791; c=relaxed/simple;
	bh=Czl0POwhQNfwKdyiyZlqUtHDbvJI05atLRoAtfoRs78=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KEErhA1ympWZNJo/s0gyBwUOZk85UbEoWYXUTbunbUX1uxr4cLidEGZSW8dTdIavPnTyPz13jHh7kdKoZdySMrAA7a56c4/o/IDpJSLls79m4iiaKdehOW9Ca08atfupT0ZBurw+5C9ertanjTUg2taMNFal2keHlHlRRYRSTlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M5u/Rhjt; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M5u/Rhjt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EDJA6ELYRjp9wEVGe8/wwrr3pWXTXDInsqD0nr4Re7AVao2SEh1GGenFjDaQiHlbrZgQcMeZ/KqchfUneFN0TcjWOJNI3TE6DpjKyEQWuBwtnagEQMlIAZc5scPLJeuEu1EyZnXhGItPSMbL1inF8Gz1SmrnBU9TPqqCl17gdL2ah4Vb/YofqwXa8GKiMkDdSVBlqdXvd7lsLzM3CzLOMqxIS5bEC7gdUQBVfVkCpHWxZ0Y3Kn7RZGq22q62agktmFo4SPeTu9yPYyX/4wLMyZ7EgI4Vx0uqvIE9rDzU4ySL59eIkX989jVjtvlxz1LvfU0pbLRegY0lIRaIDEguRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y5ulWSG9C1xCK+9YguzE1wNtVW8f+K7vT88k6w+SdsA=;
 b=L/+yQznrZEJ15/UqV6QziGf848YgrDNDUy2zzbMKkbbO0mqVC+oSQjoL9OPaUv5aPBMTaXptk6rX8nR3LCdEmtZ98YQpOpYRBecvv2NiHyX0HWd8/ze99k5H3/mv/vlMvpC8Llov0woKOuEIhsJvIAH8q7RTnrMUm7eQhHB1aIxIS7YOvQTzsTm47BsjYYbS2mkY+lHa7q3sKguS76YsCFOAUUDCj2U+qy+lhdTG1XFOstfl54XlSCE9LFx6QrQeNfRKu+lalMj+ovQDVPKj9DKSqloUu4v9nZiSm64xOHOfQz497E0HzmzrMgdmZTLcBp9fzwIl+sWMRtX0K/Txaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y5ulWSG9C1xCK+9YguzE1wNtVW8f+K7vT88k6w+SdsA=;
 b=M5u/RhjtCp3FpD96aW9i2uwqRRm5Lo2u7V/Fd24usuAHI/xqbn53irEqbclrxdjJzZ2LRvNwy5Z77yWPi82/ozpn//zlR0YJ+fI3OwpFHXgTXtcTumPsGozHQ5qdxJ6dyLIaIEbfwZU6xgiAM1sZUfVyAPs9lFL1bKjQ1uZ3ORs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:19:47 +0000
Received: from PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ae:94eb:4e73:b444]) by PH7PR12MB6588.namprd12.prod.outlook.com
 ([fe80::a4ae:94eb:4e73:b444%2]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:19:44 +0000
Message-ID: <4ce24139-5f7e-4180-a290-bcc15fb4f559@amd.com>
Date: Tue, 1 Sep 2026 13:49:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cyclictest: Acquire a lock before invoking
 pthread_cond_signal()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-rt-users@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
References: <20260826132153.2476006-1-bigeasy@linutronix.de>
 <20260826132153.2476006-3-bigeasy@linutronix.de>
Content-Language: en-US
From: "D, Suneeth" <suneethd@amd.com>
In-Reply-To: <20260826132153.2476006-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::8) To PH7PR12MB6588.namprd12.prod.outlook.com
 (2603:10b6:510:210::10)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6588:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: 264d0b23-d5e4-4328-e126-08df0801c768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|4143699003|3023799007|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8JLgDiwD7BGRYokN2SOSoZGqUA0W6lpbIW6vG7yrliCJWHBfo3Le91eI2R2soXkYLN6cy+W56TOBada8EPSXuYfqoMmWN/x6RL4nWXvU+Dkpl9bCLSQfNbAXY/JfyxMhWGJUqwGnA4TNG5RcZJd4rqBDrvDb0B5Tf8rDLfTwi+uy/A5cSEnEmXv4ju9dXIf9cjvsU8K4jKhYWPKp/DFodtEBpVnLk1BH83k0uMkMuBjGnAroHzWT392tbkMl6bqCBCo8pEwJLz4rWSqIcRCTR/I4O32Ngb7d7cnUb+eakxWEItIAvBocim5jDEP7hUOK+9zddjdXJVrM+qCSHb7mMJD0WpJSRRKow4ph2BgtW/2FGoDQRBoctEpUiIMQTMeSUhcV5yK4GSjNvXrcxKhwBI6zTUuoUFzhMmzWixlBJrqgGu0CqHmpXvr15yNTq4JKtkI62sKwXWVMpEAQtXVqhOeeE44173P7KjquO/t8IRfBsBZMC/1VooS62FmiDVAnLE7s8Xq8dl+6c7oqJ3t1Sbe40SbXX6FrGziCgIgqyPtBpHNHnx/NKfV0BA0XUXOcwXzHpWrZ3bVPR2+zI5JTHpsbmzo71hAVk1pacbzIF8sQevtOF9UIsFJBghuwbGU6aRkHgjTFctCT2oScdh7Xj7oMVBg5cnANlFs5psrS8VM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6588.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MCthR3RpWU5BbnR6TExKSVJiZFc1Mk5Mc212Z3dTZWt5aWc5SEF4ckY4R3lM?=
 =?utf-8?B?cnlnSE5sS1NBUHFFSHNkcisrUzJEU3o2NTNwRG1mTGVLTGpWdGMvSnFGZzQr?=
 =?utf-8?B?eWJFZWdrUHVTRUcwN2h6KzB6d2NsT1pvemR1RlNoenRKbWgyWHdPb21qbXlm?=
 =?utf-8?B?YWlPVkorOG5FVjZwdmx4dHRMbkxHVjhuSTNxMnRIUXFPNDlrL0lwTzRZRU1Z?=
 =?utf-8?B?eEJLSjVac2NjdEwweENVbVlpS3l1QTFXazhkZ2RjSW5hOFAzN2I4M1FNSDlR?=
 =?utf-8?B?RUlTT2p4LzZSd3FLRnN6WmUxVWpIcy8xcWJGZkhUZFEwU2JJbnhNZ004dk5h?=
 =?utf-8?B?cWdoemJhSEZFODk3cXp5eC9lTnNzcGNZRDhybHk4cStXQm9CZ0N6bFZqekgr?=
 =?utf-8?B?cnhibHhZM3ZsTnI2R29SOG9RRDRjamlwZWQ2Q09NRkNBUHZyMVdVeDZwQ0FY?=
 =?utf-8?B?QXdoUVgyWG53Yk9ScFZHQ2tMVTBEckNmWHJRQlp1T3BLN25kZ0hxdUhFbkpM?=
 =?utf-8?B?S29zSFNpbDFBQllkUDVUYjl1aEM3TTI4Q2Z1KzZhK1VDbWU2WnZlQk9ISjBB?=
 =?utf-8?B?TXZaSUNsaHJTRHgwOEpLem9uaWxaa0pQQmVMR3dlOGNtQkNwZkUyZ1FJVDVr?=
 =?utf-8?B?UXBpdS92U3pCM3hkeUs5eEVsMUlyRlBkelcyMGN1Q01JbDdKandpaXNnVm1J?=
 =?utf-8?B?ejRoc1pLL0VTMXVFNlRHUCtUQngybk04LzJTbkUweTY3SUtKUW9XNnltSW1P?=
 =?utf-8?B?aWxJb3E0OUNwZjU0Z0hFeGNTVTRHcEU0Uk9JRmtaVEpZbkFLRUxJUnAxZjhP?=
 =?utf-8?B?M3UvOUFkQ3FLZFRXNzMwYVl0RkxqeU5pb2tCVHVSSUFEQkZGZXl0ZG5JM2hk?=
 =?utf-8?B?MHJWT29Zb1hDdFJvRzAzSExsYitDZUFDaXFQcXBrbGRPSHFxWDErMWQxd0Q4?=
 =?utf-8?B?azMyM0JDbURmR0d2NHpBaVhOb1B3a0dyNHNLeHdlaHExL3E2cThiNlQ4NXRM?=
 =?utf-8?B?VThkOFhzQjJHWThYZE1PY0J0WFl3QklHWisvZUNqbUZkVE9OU0pxdFF3TWRn?=
 =?utf-8?B?VTB6cWtRLzVQSDc0RXg0WktITkozMlE3N0UxNFRvVUxQNWdQYi9lS0xkNnRM?=
 =?utf-8?B?ckdLMmluN2JZUlRtK1Q2WGxBcXRVOVRiVzE1N0NFR1pIeFBIaDVtaWVJcHQ3?=
 =?utf-8?B?YTJ4b0VMNmtUMW0zTlZoSE9QZGhGL1U3YTJFbmhJb2J4U1NLQWNNc0xadXFa?=
 =?utf-8?B?UEhKSGFyUTdPWWpLMWdvU2c1b2VLU3paNCtEQXc1R0tCdnVnNTlVaUxyUkhI?=
 =?utf-8?B?YmFtaTArZG4vTHBTWGNVVWRBUHBxNTlFL25XOG5uV3BPZE1xdm43T3M0Wmla?=
 =?utf-8?B?L1IwZ1FlQzZka2I5eVJpUUM4Y0dQZXdYT2MvcE1laThTVTlhT3hNaStTbmlG?=
 =?utf-8?B?dUkrbzgyd1UxNSt0VTRwYUk1eUs1NUNTa0FNNzh0WnRNVU8yMnBIbFJCY3l5?=
 =?utf-8?B?TUhpbGg0eDV4TDRwNnBuRXNhNzNxaUlVQy9ZeEhFMENRUTl4dEJqSXd3WXdM?=
 =?utf-8?B?eDF1blZYMlhBWmQwejk1Y2NnbjFJMXVVOTFQYVpKVmxOSUxHZE1UTUk1UWRy?=
 =?utf-8?B?VU5DUVN1MHdxa3hoSXJCUlFnMCtyRGVVK2tqYkxSUGxzOVVTYU5nZDBqOWpn?=
 =?utf-8?B?TkpPUHUvdlkxZVZ0MFZqWXNiUko5d0E1TEsrQ21UWkxlZ1JrU3lHQ0hmRHdC?=
 =?utf-8?B?ZHdxcyttcUFVRWdxNXd5Z2l2WTVacnNLNnAzTnlPZ2NocWZaSFV4Qmczdyt2?=
 =?utf-8?B?M3FtSmhJV0hnbnNMOXc1TEZSM2JiRmhJK3BubEtHbGw1VDZLQVlTRm5OWUxW?=
 =?utf-8?B?c0M2WnV2ZEY2TXFaU1ZTSE1uUXBaNWFIaUVjUWtIV1ZXZGZ4RVArNjNRSjht?=
 =?utf-8?B?dEc0clpzM3lTNEFxUUphOXNtSDE3SG0wNG1ZbWFYTWtjc0g5OUVYZHc3c2ZX?=
 =?utf-8?B?dmxlbUlIMDhWVVE3R0xFVHdXaEg4aG9mcFp4Y1haRWpBb29UQk4yeXVOZ01D?=
 =?utf-8?B?MFlzaTBJY25iM3BOU2tuOEFxRjhNNXM0SFB2eEl4UWRIZENHOVU3MFpJY29j?=
 =?utf-8?B?QlU4eldyQ0VsdTU4eFBzV0lTZDJ0MnM5c0VWcytPQnR6OTZ6Rkx1dnJkSW5Q?=
 =?utf-8?B?WjJGWjBFK29ERHZmMlFNbVFLcEVWalIxVys1U0o5ZjFWMDdsaVJMbTJ2cTUz?=
 =?utf-8?B?QmthaU5WU1lpWXpoMWloek0wM2tNNWo2RmNiTlU1eTF2K2VXaU1sQWc1dk9R?=
 =?utf-8?B?MmpselpqdE9MYlJudnNya1hTdkF2bk5ONjVhTUVaUTNpL21JbElqdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264d0b23-d5e4-4328-e126-08df0801c768
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6588.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:19:44.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5Rjy4IXFfsMz7xTMce9IIXRVFqIbzZEmYzcWeL6CB+9wSLW3Sntrw0lk/Osa/kWYFO9dtVarqPQSTT45ZmEcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434

Hi Sebastian,

On 8/26/2026 6:51 PM, Sebastian Andrzej Siewior wrote:
> With the -M option the output is updated once there is a new max value.
> On system with many threads (say 64) and aligned wake up (all threads
> wake at the same time) it is possible that all of them have a new
> maximal latency and all of them invoke pthread_cond_signal()
> simultaneously. They all will block in the kernel in the futex syscall
> on the same lock. And each of them will wake the printing thread one by
> one. This is not *that* visible with just a few threads and a quick
> CPU. But with many CPUs on a slower system this gets worse.
> 
> Acquire refresh_on_max_lock with a trylock before invoking
> pthread_cond_signal(). This ensures that only one thread will send a
> waking request at a time. Should the lock be contained then delay the
> signalling until the next iteration.
> 
> Make refresh_on_max_lock a PI lock. This shouldn't make much of a
> difference here given the try_lock usage in the RT thread but the
> unconditional locking will lead to complains by the RV-monitor.
> 

We use rt-tests/src/hackbench for Kernel Performance Regression testing 
and with the latest HEAD on rt-tests/main, fd45df830803 (cyclicdeadline: 
Fix potential path truncation in open_cpuset()) I'm observing build 
failure with the below mentioned error message[1]. The caveat with this 
build failure is that it happens only when compiled gcc_version < 14.

# make install
Makefile:48: libcpupower is missing, building without 
--deepest-idle-state support.
Makefile:49: Please install libcpupower-dev/kernel-tools-libs-devel
Makefile:48: libcpupower is missing, building without 
--deepest-idle-state support.
Makefile:49: Please install libcpupower-dev/kernel-tools-libs-devel
gcc -D VERSION=2.10 -c src/cyclictest/cyclictest.c -Wall -Werror 
-Wno-nonnull -Wextra -Wno-sign-compare -Wno-unused-parameter 
-Wno-error=format-truncation= -Wno-error=unused-result -O2 -g 
-D_GNU_SOURCE -Isrc/include -o bld/cyclictest.o
src/cyclictest/cyclictest.c: In function ‘timerthread’:
src/cyclictest/cyclictest.c:653:9: error: unknown type name ‘bool’
   653 |         bool need_refresh_max = false;
       |         ^~~~
src/cyclictest/cyclictest.c:580:1: note: ‘bool’ is defined in header 
‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
   579 | #include <cpuid.h>
   +++ |+#include <stdbool.h>
   580 |
src/cyclictest/cyclictest.c:653:33: error: ‘false’ undeclared (first use 
in this function)
   653 |         bool need_refresh_max = false;
       |                                 ^~~~~
src/cyclictest/cyclictest.c:653:33: note: ‘false’ is defined in header 
‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
src/cyclictest/cyclictest.c:653:33: note: each undeclared identifier is 
reported only once for each function it appears in
src/cyclictest/cyclictest.c:850:52: error: ‘true’ undeclared (first use 
in this function)
   850 |                                 need_refresh_max = true;
       |                                                    ^~~~
src/cyclictest/cyclictest.c:850:52: note: ‘true’ is defined in header 
‘<stdbool.h>’; did you forget to ‘#include <stdbool.h>’?
make: *** [Makefile:122: bld/cyclictest.o] Error 1

STEPS TO REPRODUCE:
-------------------

1) cd rt-tests/
2) make install

FIX:
----

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 99194378f946..58b56bcede0f 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -15,6 +15,7 @@
  #include <stdlib.h>
  #include <stdint.h>
  #include <stdarg.h>
+#include <stdbool.h>
  #include <unistd.h>
  #include <fcntl.h>
  #include <getopt.h>

I shall send the fix as a neatly formatted patch if the proposed fix LGTY.

Thanks and Regards,
Suneeth D

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   src/cyclictest/cyclictest.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 960c905606684..29ddf2d98bbe1 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -198,7 +198,7 @@ static int smi = 0;
>   #endif
>   
>   static pthread_cond_t refresh_on_max_cond = PTHREAD_COND_INITIALIZER;
> -static pthread_mutex_t refresh_on_max_lock = PTHREAD_MUTEX_INITIALIZER;
> +static pthread_mutex_t refresh_on_max_lock;
>   
>   static pthread_mutex_t break_thread_id_lock = PTHREAD_MUTEX_INITIALIZER;
>   static pid_t break_thread_id = 0;
> @@ -640,6 +640,7 @@ static void *timerthread(void *param)
>   	struct itimerval itimer;
>   	struct itimerspec tspec;
>   	struct thread_stat *stat = par->stats;
> +	bool need_refresh_max = false;
>   	int stopped = 0;
>   	cpu_set_t mask;
>   	pthread_t thread;
> @@ -834,7 +835,14 @@ static void *timerthread(void *param)
>   		if (diff > stat->max) {
>   			stat->max = diff;
>   			if (refresh_on_max)
> +				need_refresh_max = true;
> +		}
> +		if (need_refresh_max) {
> +			if (!pthread_mutex_trylock(&refresh_on_max_lock)) {
>   				pthread_cond_signal(&refresh_on_max_cond);
> +				pthread_mutex_unlock(&refresh_on_max_lock);
> +				need_refresh_max = false;
> +			}
>   		}
>   		stat->avg += (double) diff;
>   
> @@ -1910,6 +1918,7 @@ static void set_main_thread_affinity(struct bitmask *cpumask)
>   
>   int main(int argc, char **argv)
>   {
> +	pthread_mutexattr_t mattr;
>   	sigset_t sigset;
>   	int signum = SIGALRM;
>   	int mode;
> @@ -1946,6 +1955,10 @@ int main(int argc, char **argv)
>   		}
>   	}
>   
> +	pthread_mutexattr_init(&mattr);
> +	pthread_mutexattr_setprotocol(&mattr, PTHREAD_PRIO_INHERIT);
> +	pthread_mutex_init(&refresh_on_max_lock, &mattr);
> +
>   	/* lock all memory (prevent swapping) */
>   	if (lockall)
>   		if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1) {

