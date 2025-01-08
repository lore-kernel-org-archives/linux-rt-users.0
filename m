Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843179FE;
	Wed,  8 Jan 2025 04:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736312217; cv=none; b=q9Ae8rfBD8pOrzPr6m6Yu2WRpjD3EXxnZlBFHTabgih4USPcMvoevDwi0VdsGtPQ3eKX++FQeewvTyNOG33v8jsIRIVM1hBwSz750zyqq2pI4qzdDNvfimAOPkGioav59Elo9XoHtgIREm81tPlJFayzuDRT7wyQeXB3Zo8jOFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736312217; c=relaxed/simple;
	bh=2w/rNo0EdC6MPXNXtBSlyh+3s3vZO2+7r06jX7Nw3dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kePwvY5La1Rhh4gpDv7Hx1yWll3RMvJWXYAPbc8Jrskm7F7o6exHlqkiUJMhDIs7DQZkssBuNJcgz2f8uSckYMGNO9dI89Tsf+I7VOphELC5pi+FG6eGZhxtj2H/rCG9j1DM+/UA2dnJlXcBB2WDbn85CRNJyPXDFVl0Nk5SPjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o6loSkfe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o6loSkfe"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507Nx5cj024746;
	Wed, 8 Jan 2025 04:56:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yl7WOU
	HBv0UNTaIo+rq/jnbruTQsoczPnl2Vyg7Z2Lk=; b=o6loSkfeRvMhzRjd9ll9Yf
	vk54YpZ0qFH2XFELxdvjHcnm0XPRdPryGAf+6HbTSYLFWb2Aqzy92cywLDBnBggF
	2y5d18ODBPy0baiz/PKQQEh+Vf3LBpMsimzgHTsI9vnnEsPYuMr0aNg4a8DS7UKF
	7jCuuE2g7BSo9UslQ1U+XUDaeBp7is15ugVVJygIHnzmJWV8ZcmOSLmAHs0hpIte
	mCXimjqvvGSsd/KoRIanVkSsx+NHC3SxMQ8k2JC5PLHXjWJ3Tz/6QpmGrotNGJoF
	cZSl5KY2Y/i58lgE1dSaEtwgfTI0lO/n2Rh1vD/4oe6BGGD0n74GWS5FhfLSI74Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441edj0wa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 04:56:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5082NTQ5026179;
	Wed, 8 Jan 2025 04:56:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj125qe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 04:56:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5084udDu62456140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 04:56:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 575C920043;
	Wed,  8 Jan 2025 04:56:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDD4320040;
	Wed,  8 Jan 2025 04:56:37 +0000 (GMT)
Received: from [9.39.20.66] (unknown [9.39.20.66])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Jan 2025 04:56:37 +0000 (GMT)
Message-ID: <e0364c9a-0364-4993-99a1-9e51a47529fe@linux.ibm.com>
Date: Wed, 8 Jan 2025 10:26:36 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
 <da4d15ce-eabb-4c8c-bc8b-cee75f9993bd@linux.ibm.com>
 <SJ2PR22MB3822B4550212A2418187A075E5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <SJ2PR22MB3822B4550212A2418187A075E5112@SJ2PR22MB3822.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Vn5aBguMhkirMZeKmLiNSvu1ylBlAjje
X-Proofpoint-ORIG-GUID: Vn5aBguMhkirMZeKmLiNSvu1ylBlAjje
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=450 phishscore=0 malwarescore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501080033



On 1/7/25 23:43, Robert Joslyn wrote:
>> -----Original Message-----
>> From: Shrikanth Hegde <sshegde@linux.ibm.com>
>> Sent: Tuesday, January 7, 2025 5:10 AM
>> To: Robert Joslyn <robert_joslyn@selinc.com>
>> Cc: linux-kernel@vger.kernel.org; linux-rt-users@vger.kernel.org;
>> tglx@linutronix.de; rostedt@goodmis.org; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
>>
>> [Caution - External]
>>
>> On 1/7/25 17:26, Sebastian Andrzej Siewior wrote:
>>> On 2024-12-26 11:12:38 [-0800], Robert Joslyn wrote:
>>>> This branch is needed to allow preemptible IRQs to be scheduled,
>>>> otherwise the kernel hangs during boot on my e300 based platforms.
>>>> This branch is needed for both CONFIG_PREEMPT and
>> CONFIG_PREEMPT_RT,
>>
>> Hi Robert.
>>
>> Are you running with preempt=full or enabled preempt_rt ?
>> rt is yet to be supported on powerpc. are you having it enabled out of tree?
> 
> I'm running PREEMPT_RT using the out of tree patches on 6.6.58-rt45:
> https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/
> 
> I haven't tried using the mainline kernel, since as you said, it doesn't have powerpc support for PREEMPT_RT yet.
> 
>>
>> Also, I have sent out patch to enable dynamic preemption. It uses
>> preempt_model_preemptible.
>> I think it should work for you as well. If you could give that a try and ensure it
>> works, it would be great.
>> https://urldefense.com/v3/__https://lore.kernel.org/all/20250106051919.5
>> 5020-2-
>> sshegde@linux.ibm.com/__;!!O7uE89YCNVw!IDeomstGeuiEZi9FmLHH8C2xo
>> PPo_ewL-
>> k2kiQ9CmVID35U4J_v3Dkafjo3RnS9ygPoUZWwyyp91SP2euRkKArk$
> 
> Does the dynamic preemption support let me enable the same functionality as PREEMPT_RT with the out of tree patches? I can test it out either way.
> 


with preempt_rt, dynamic preemption allows you to switch between full 
and lazy. without preempt_rt, you can switch between none, 
voluntary,full and lazy.


> Thanks,
> Robert

