Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010040.outbound.protection.outlook.com [52.101.69.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CB38422E
	for <linux-rt-users@vger.kernel.org>; Tue, 15 Sep 2026 12:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789477116; cv=fail; b=Rs+23t7yViZgRTZLUO016oEfBCmHRjDwMTJX0rdMWplsSLLfDleXrc1rYW04iq1bsvXKQY3pZTprS6nSJPOK97WB0Kto5civFgH7hxnGEXPL319MRGX9cD0phTO/bIM/4gmDvK5viJkpfrcC/xwmbRLGhkMAJvTGiHHYTecQkAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789477116; c=relaxed/simple;
	bh=czBqULSjj5j/R38WFw409sxDjDVEF02dVgHUHYxYdfI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ERResgeTRkYjQlMAGLNNuDoYtHqNIifNs5Fxe7+A6oF3TeE3Oiv+3hPB8pTG4jhEtccbqa3X6d94S06C4Cil4bEHvEKL/D5Ij8dQh/OogOSYZXtl/tXpfo0DCSaXL4J8yA2Dv2eNjAf1GsDXrTDttA6q5TrTnWUqaiX/SqdGkGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com; spf=pass smtp.mailfrom=ericsson.com; dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b=MTAKJo1J; arc=fail smtp.client-ip=52.101.69.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ericsson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ericsson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="MTAKJo1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSxudtFMLeO15HRld5lYpebEGUL/0zpBXukM3vRcb+K00JDgeBKbMP9NZAZHSLlG/anuU9yD9ksHXTgP5Z8yW8sYY6+YRfMCTFkwcA6RrEnscur93pJf2bZfur6TFFLTJr/45B5lLcXjI8bCLciIZOXlr94o/PjCVZ5iFir4krMAqiAMdvHM5SDXy4MrAJdlRu36Nt+bioQuWrg1eVN5YBIfQw/gHooiCGTiFmos15rgqkHDZs+x8l6wPXtcfYac0SU9Ssr0kjaqDyibUqMcTXR9ZgVu/lBHfLPU2eyWXBNWuqw+qCCUpChnsVWFMl7M+uYNN98BHDqjRcQvCBeCag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czBqULSjj5j/R38WFw409sxDjDVEF02dVgHUHYxYdfI=;
 b=KBMjHIC/rgLUBQ+Qo+GgwmYAao7+JhBwNefW1980oU8A1DK9SFDRj21j/5yIfhRZd1twENEbSPHOBeTN2nyz2z6ZqAQjL/P2qg3To2yG78yqRHh5R5LU2oMEVtaBZ8GQA6sma6dRhxKK/1PoPMlYCa3OPuwYjJIeGpY7Y32LxFSOWkOaxGI/9rqoAoUEmEE7XSstyyIa2mU3c4MXkSCNkgo5piwBIp6jzX6n1brU0IJMhcMu16e77DMIxlaKWYz/OmB7sZgIXst4ZFUlzQ4gbik9BfGHgGIBsXn7RRP5V/zm7FWbm+IKagOaPktwZQThio+2h8rwci2plcg17WDh6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=redhat.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czBqULSjj5j/R38WFw409sxDjDVEF02dVgHUHYxYdfI=;
 b=MTAKJo1JP4nDXvqtESunbW7AiRaRtxPPL9RemWHwBBq4RtyrWrsRLSLrIQT+vS5axC+XS94FFKz3+LIUL6Ei3sGgy4MuYhOy/Dv3ilrUr4RjnZBE3sRU6xu/BnOWd6eHnBRK+7ukOoGt4pys5WuO+YbE1BXURyOBGqKPcldCU3YAgQ8ql/lI8UBhYgtTnXRK4FR0KMFdthfwIRwAZFlkZXugnxmuIaTwkg+hKc0kd4oUuODegMzhbR+VK5mLeG/L1JY7ZGBVtK4kYDnywcN6+TtwLq4db7sSlNtsfX+xTaHu3f70fpT2Uv8nk5Fe7HfvmfU5h0Exac6E4pxkx7BofQ==
Received: from MA2P292CA0005.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::8) by
 AM9PR07MB7316.eurprd07.prod.outlook.com (2603:10a6:20b:2c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 12:58:29 +0000
Received: from MAD0EPF000008A9.eurprd04.prod.outlook.com
 (2603:10a6:250:1:cafe::4c) by MA2P292CA0005.outlook.office365.com
 (2603:10a6:250:1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 12:58:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MAD0EPF000008A9.mail.protection.outlook.com (10.167.241.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 12:58:28 +0000
Received: from seroius18814.sero.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 15 Sep 2026 14:58:26 +0200
Received: from seroiuvd01221.sero.gic.ericsson.se (seroiuvd01221.sero.gic.ericsson.se [10.86.87.142])
	by seroius18814.sero.gic.ericsson.se (Postfix) with ESMTP id E0A1D40263CE;
	Tue, 15 Sep 2026 14:58:16 +0200 (CEST)
Received: by seroiuvd01221.sero.gic.ericsson.se (Postfix, from userid 7162142)
	id 94E2460968D2; Tue, 15 Sep 2026 14:58:11 +0200 (CEST)
From: Jinnan Li <jinnan.a.li@ericsson.com>
To: Tomas Glozar <tglozar@redhat.com>
CC: <jkacur@redhat.com>, <williams@redhat.com>,
	<linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] cyclictest: add --warmup option to skip initial cycles
Date: Tue, 15 Sep 2026 14:58:11 +0200
Message-ID: <20260915125811.3695093-1-jinnan.a.li@ericsson.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008A9:EE_|AM9PR07MB7316:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d409de1-bd23-47cc-67de-08df132909eb
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|11063799006|5023799004|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	U4JBdg7acd/fLn9EVvCJbaV95NgTXQK/tbn6U5UynabGAbrQ421cTXim4gbTMh11VsHbt/DGWKhFNNTjHsEeIyQXGkgrVh9NK1E5o24H265Rb8d9742edXEYdN3NbaID+1SGx7Zfl8Ia2QCr+ff4hGwTCz4E5AdnptyFlqzUzCHKNYdT5+w656KAWmnX4fVwyHm0C6YmJt9IfwzsSxVd1f/nlT/XpD7YQvkhwSOqd6R+/MXYcCYcCRqrLrD0f1XdPf33gTADY6Rllkbd8CQRObh3DKWko9J3GHEACC2z/XE0HnlnJoTyvs7S3ePn1vuqQiQII+1HWcXM6fz/8R2nFM2nXFPU+XLt0s6FZjOSmiwjSxGS2Hhhr2IbWaKyggnEFXO/oq9JFQickcSy7F75Z6vtx1Te1NBYeFFBCWQqUMomAbKLTO3VyCrlorJu65+3XdLlVCi+aRwCD2/U09hXATMUVE8O2pG8xheMbNCSAYKLHlnrUtChq2Ms/wPQyQ5YOU3W7XXeLNJamzhgUUivfZIgJ9JxqF4dzRYytE1wBL7BK0NcHNqmgljEdBgLx5DWExUQ8SlDUuzHpCzwxtiRicDZaTVYlSdiD9fszvpPQnm1ICRMEwKimuHAuz+0qqiBNx2LddTera3i+3+fvmdM49Ao2tsYO+CFCLpeh+qXQFgYvFp/RxaAWVIJVv+mA9Ql0DbX9sedknDdkQXYDhYqeg==
X-Forefront-Antispam-Report:
	CIP:192.176.1.74;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:oa.msg.ericsson.com;PTR:office365.se.ericsson.net;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tTnwpTz7DfDatzvTpbulhqe786bejJWxe21g/XtCt7PWADH5bzyw8fGia3uI8AGlljcBZdOxKuErVnUGGe8IC3BwqHhZnrR3sSKep5JR7wG6cIkE9LLSez1FgbAtkoSNkhOv9+eRryQzxi/Q1MtLPMnXlI0q9ivHEz0xrizCfER9C0KsELm66tuZYmL8AIaj4bSKHICB6TqCj412Nf7p9137Ihogtmf/WBwJTYeKFJgq1witFjpmiYPL1Wb3fx+bJy8c7SV4pWykHZR439uXJ+nGopdLq8pQvlP1xV4py5/M/UcTWPPftXmZKtV6FC1+AbJdDWpghgAs61ZAozt2GxOm5rfvirk0oWosv5qAdj88a7XO4CUQPYXwwvfnxsKD/OVcLHKU3T2Obketx54DzHeoDHINZvyMhAXPPzqnfHG1e8MJVorCbH7+GFM702dX
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 12:58:28.5912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d409de1-bd23-47cc-67de-08df132909eb
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f;Ip=[192.176.1.74];Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008A9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7316

On Tue, Sep 15, 2026 at 1:49 PM Tomas Glozar <tglozar@redhat.com> wrote:
>
> Wouldn't it be easier and less error-prone (from the implementation
> side) to simply suppress the processing of the results during the
> warm-up period rather than reset everything afterwards?

Agreed, that is cleaner. In v2 the sample processing is suppressed
while in the warm-up period instead of collecting everything and
resetting afterwards. This drops the fragile reset/boundary handling
(min = UINT64_MAX, and the '>' vs '>=' alignment between the histogram
and the average divisor), and the statistics and the histogram stay
consistent by construction.

> > 1. Is this worth having in cyclictest at all [...]
>
> I think yes. Running longer "dilutes" the average value, but with RT
> measurements, one is usually also interested in the maximum value over
> some period, and in shorter runs, the startup spike can pollute that.

Thanks, agreed. That matches what I see: on a short multi-threaded run
only the first setup thread shows an inflated Max while the others sit
at the steady-state level.

> > 2. Is defaulting to 0 (opt-in, no behavior change) the right choice?
>
> I believe opt-in is the right choice not to break existing workloads,
> e.g. someone might want to deliberately measure the cold cycle.

Agreed, kept opt-in with a default of 0, so --warm-up=0 behaves exactly
as before.

> > 3. Is "--warmup" a good name? Should it get a short option?
>
> In RTLA, the option is spelled --warm-up. I don't think a short option
> makes much sense, that should be for core settings.

Agreed. Renamed to --warm-up in v2 to match RTLA, and no short option
was added.

> > 4. For the corner case where the run ends before N cycles complete
> [...]
>
> I think the warm-up should not take time from the whole duration /
> cycles, but add time on top of it. For example, -D 1s --warmup 10 will
> run for 11 seconds. That would resolve this issue, and it is the
> behavior of RTLA as well, so it would make it consistent with that.

Agreed, and done. In v2 the warm-up cycles run on top of the requested
run: the -D duration and the --loops count are measured only after
warm-up completes, so "-D 1s --warm-up 10" runs the 10 warm-up cycles
and then measures for one second. Since warm-up always completes before
measurement starts, the corner case can no longer happen, so I dropped
the previous --loops warning.

I will send v2 shortly, threaded under this reply.

Thanks,
Jinnan
