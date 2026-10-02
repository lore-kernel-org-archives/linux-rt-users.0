Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92628B4E2;
	Fri,  2 Oct 2026 04:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916329; cv=none; b=Yq/Ec+OWEU0Tu9O8211DAtGin8wwnyMGDU2s27n5o8hc9VDSLwsNyKAs3WUjMjhtEOHtcBFrHZOBj8JehX0rn+M5DC/VmVqtTKalZQ2yvCSLphetXNxElK1t8bjJmqAk9csYVgjVXfuhB1OHCBcDXdzcoR1f2GCOTU4nICzu4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916329; c=relaxed/simple;
	bh=wyAORYeusP4vcptey9/n2NPgydi9/Gw5lAe0phtrrvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoRHws6PKxOPRJniEBpygCnTUZbHr5rlhyAJ/fmhherkZJW0bBU+6V8OVfRfYFUviv0ZrSf2EdbJyOxUO3tMzEsccdueURb3el5Q/NtY3nXroYeKnpxLGv3F45BNkLM6OPm16L3X9puJygFYrf75GDfU+vxgFRXSXnJcB1kUMWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c5RRVgnq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c5RRVgnq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6922ZUxa1680368;
	Fri, 2 Oct 2026 04:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=98Wq12
	iIlaIraiVSCF0jeRQmWRURkESi4objlUGIYfQ=; b=c5RRVgnqbtU4LjUDFWU0iQ
	Hww3dMcTWV1YiRHd8g6woW1i5QIv6hLvN3pMSHoSeDQNaCNuAfU9FSQMYxy7U/g2
	QAmDcFkmDtufWs3FTkXGlS4zqM2kyEumqIRC7njcEI9oyzlEi00hmkrZKyg7l0ck
	amovJtZc0Iwx6kpaxkHF4R+XLCcOQxKc2kYeCr3KdUTox/Aak+zdXXWWFsSSDftl
	F8bVbGZvCaE5Hreqkoe0xq8opP2XacktCTLb8Ncx0/s9vTvkTNHp174YQUzD/NxK
	cc3070aif4h/b2n0U0RvkujGYcevZUWxNIRYvn//RBxCs6235NouD0MT8QVQsMHw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrqe8p-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 04:44:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6922KDs81834253;
	Fri, 2 Oct 2026 04:44:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h1y2dhagc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 04:44:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6924isI147776040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 04:44:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43AD320043;
	Fri,  2 Oct 2026 04:44:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6836420040;
	Fri,  2 Oct 2026 04:44:52 +0000 (GMT)
Received: from [9.124.216.180] (unknown [9.124.216.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 04:44:52 +0000 (GMT)
Message-ID: <37b02446-1e54-4ea1-9532-11056053de6c@linux.ibm.com>
Date: Fri, 2 Oct 2026 10:14:51 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] v7.3-rc4-rt1
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Maarten Lankhorst <dev@lankhorst.se>
References: <20260922144152.x2J3_tNz@linutronix.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <20260922144152.x2J3_tNz@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAxOCBTYWx0ZWRfX6rzjqGf53FZd
 BwACgFfzH0XWOQ2PQ3+HvyVzlFKnsPbCcmx018kMQMCWQfGfVryMiezZqwm7N1ov6+niYKN8yLG
 eSmCWJQWoXOX2JEsFS5GnGXjOeuJ85beHSznYpTFoMuX/KPQVslympCCRLEWbwWiintmiMvLL/T
 IniQOAtuI2ykDXibyry2BQl9wx8LxeRR8SjQ+0KP/bWQZ6ZpTeGgnn4C9pcWEtd3AHVLoiPIwqn
 m6cW3ZQrOg2NsU4OelWnsend96TypV+EHtvlz3RhDfcsZt0Kuuwu/6biiTHWjVCZrdET6tFHwq7
 FersjydK66r9chj8JwVsJRLmNxkGxLj0ZMiZ0sksi7F0UQlPI+sHcH5TMfmv6T0QWAwisbd1aPE
 PSvBO2o0IlU7VfKz6AgnGertX61WYRQ7G383O8XY+Qdkn3Kz1Kj72fAOv8798rO2KtXTCmelguO
 B1Mk3449ig+6hJZfOvg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf36c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=DQibb4ZKopN1BLnJEHUA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-ORIG-GUID: vQvH7_aSxS0iulhrs5hhgItPoqTZXnUb
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAxOCBTYWx0ZWRfX2uls8LkMKnIS
 aXfK1eY4jV7tV/LvWWrAPl58nqxqGIfWLmSQOpWCX+DQA4DNXxHLcyfH+j3kJjvPrFWqBH/md8/
 dcpjo2u9qNuQIsWGf4ETKIDiq3vOrBU=
X-Proofpoint-GUID: vQvH7_aSxS0iulhrs5hhgItPoqTZXnUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_01,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020018



On 9/22/26 8:11 PM, Sebastian Andrzej Siewior wrote:
> Dear RT folks!
> 
> I'm pleased to announce the v7.3-rc4-rt1 patch set.
> 
> Changes since v7.2-rt5:
> 
>    - Rebase to v7.3-rc4
> 
> The printk related changes are all gone. What is left in the queue is
> PowerPC, i915 and a sysfs file:
> - PowerPC
>    Some progress has been made. What is left is a pseries related MMU
>    change, a patch dropping KVM_MPIC (which is e500 only) and a stack
>    protector related workaround.
>    The stack protector workaround might work with a different fix since
>    only arch/powerpc is using boot_init_stack_canary().
> 

Thanks Sebastian.

It is nice to see a little progress has been made atleast.
But it was mostly my mistake that I couldn't get time to work on it.

Let me see if we can atleast get these ppc patches upstream.
Most seems sensible to me.

But then would come heavy lifting on function and performance verification.
That's a different beast altogether.
