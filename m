Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5ED1F12F7;
	Tue,  7 Jan 2025 13:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736255444; cv=none; b=i8uh9BYYQw9+qlBxQ2nTaL87GDQkchWECe4d3hvTVzPkhqzJ+1LC/2EO5T7RomCzw7Z+y2EUUc9skjuKRxpyjugROS7yqHEYi0+unl1XS+JnMKGYETtlKfe84yjhB4QOVfSEju6dL2PWZk6JirMOxIpV0HNN20mg+roSSZK0ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736255444; c=relaxed/simple;
	bh=h4vlhYHxjkXm3rLeVEewakCvgwvlld/uixx1SB7+rXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpQzvrLA8VRLvU3lpTkQ3qeQe/zBYieXE73KRF6CWxuDZizfzLne6+MbCNEVkREPpKJpyIc87MKs7Ss+BORPpE40hWoYbpTs7aV38sMku3xLEgoeRJ9UG7VuMiBQXWxeHIdEb/88Cua3TZ5VLlBcyMU9J6KVGfefORNrGJNftZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Whiwu/Dx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Whiwu/Dx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507BQaaX009294;
	Tue, 7 Jan 2025 13:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4PD7N2
	yBEKAQar0MgzcVjshEjfCIhl3yzr49X75OBWs=; b=Whiwu/DxRXuVa5VS5gbshM
	bsQC4c55mNiUVgpCjMoqPkeROtMbF3L54FOXJqpBU3aX0Z4Qw1J9GcgzHbi4sK2B
	4aebw/Ox8hUlIx/p7UiJY5Z7xxc26I3jHpp53jxZOtIm0V+/+xAUhOHhYo3Pbi16
	cm9uzP+/GDk98el81mmuW2X7MhvWC2LcsptptFdUFXVnlVEQjqzmdFj/U8fLjn6R
	l99/Nt7GIYWi3K9/ToOri4dRn4agHVemYqiqEcEJHO9TVh16AWaikd1dWj8MHASP
	BMDLlYPDQbIGFZTxYukCvXSPwR8Tt6ucZEqub2PWjd2E8ak7HgMDV/lzQNylz35Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440s0aaw1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:10:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507AHmI7026195;
	Tue, 7 Jan 2025 13:10:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yj1228j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 13:10:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507DAOLb57934276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 13:10:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EFD62004E;
	Tue,  7 Jan 2025 13:10:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C6E020040;
	Tue,  7 Jan 2025 13:10:23 +0000 (GMT)
Received: from [9.39.16.169] (unknown [9.39.16.169])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 13:10:23 +0000 (GMT)
Message-ID: <da4d15ce-eabb-4c8c-bc8b-cee75f9993bd@linux.ibm.com>
Date: Tue, 7 Jan 2025 18:40:22 +0530
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] powerpc: Allow scheduling of IRQ with PREEMPT_RT
To: Robert Joslyn <robert_joslyn@selinc.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20241226191238.2559880-1-robert_joslyn@selinc.com>
 <20250107115606.q67--i0f@linutronix.de>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250107115606.q67--i0f@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DmX_D458T-9_2Wbfhdx380CW3Rw19oOX
X-Proofpoint-ORIG-GUID: DmX_D458T-9_2Wbfhdx380CW3Rw19oOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 phishscore=0 mlxlogscore=533 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501070109



On 1/7/25 17:26, Sebastian Andrzej Siewior wrote:
> On 2024-12-26 11:12:38 [-0800], Robert Joslyn wrote:
>> This branch is needed to allow preemptible IRQs to be scheduled,
>> otherwise the kernel hangs during boot on my e300 based platforms.
>> This branch is needed for both CONFIG_PREEMPT and CONFIG_PREEMPT_RT,

Hi Robert.

Are you running with preempt=full or enabled preempt_rt ?
rt is yet to be supported on powerpc. are you having it enabled out of tree?

Also, I have sent out patch to enable dynamic preemption. It uses preempt_model_preemptible.
I think it should work for you as well. If you could give that a try and ensure it works, it would be great.
https://lore.kernel.org/all/20250106051919.55020-2-sshegde@linux.ibm.com/

>> so broaden the check to CONFIG_PREEMPTION, which is selected by both.
>>
>> This was previously set to CONFIG_PREEMPTION, but was reverted as part
>> of removing LAZY_PREEMPT support.
> 
> I remember I pointed this out while Shrikanth posted the preempt-lazy
> patches but didn't realize that I need this in RT tree, too.
> 
> The lazy-preempt patches for powerpc were merged upstream, I am going to
> pull them into the v6.6-series.
> I am going to Cc you, hopefully you can confirm that it is working.
> 
>> Fixes: b33022a48c79
>> Signed-off-by: Robert Joslyn <robert_joslyn@selinc.com>
>> ---
>>   arch/powerpc/kernel/interrupt.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
>> index af62ec974b97..970039af8e92 100644
>> --- a/arch/powerpc/kernel/interrupt.c
>> +++ b/arch/powerpc/kernel/interrupt.c
>> @@ -396,7 +396,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>>   		/* Returning to a kernel context with local irqs enabled. */
>>   		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>>   again:
>> -		if (IS_ENABLED(CONFIG_PREEMPT)) {
>> +		if (IS_ENABLED(CONFIG_PREEMPTION)) {
>>   			/* Return to preemptible kernel context */
>>   			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>>   				if (preempt_count() == 0)
> 
> Sebastian

