Received: from 189.cn (ptr.189.cn [183.61.185.104])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D08144D1D;
	Wed, 26 Jun 2024 08:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719390390; cv=none; b=WmCngbsGMYNCcNYJzBue7p80fZr/PseRVvEPrSqD5o5x1Vu2u3xa/P5jGu5lgD/UuvF86kOHeY3l6uQDKP4R1xdYVdnsrbd04d/Uqh2Xyf3wMtCtBA5mvGflJzfjkt22/mn6yUevZbd0x1V79OfXULlFjYQDzmo1NecoHhjQtVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719390390; c=relaxed/simple;
	bh=41WVn3qyloXsUi/SRq4AoTEiB6Nz7RIdAF4U67QT33Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQSjWdgMqJCMhQjTqMCl/C6I65/4JIeKeudz0sYmneb6wuAsBTH/QrADIY1Xa/0xIzbVAqiX+tD701cL3eroM1krh2IO7X3Pp9jZyzGrGytC1SbF4pVa9stKyvqGYv7TQeRuTf1F0m+7KtBQZORfRoO3fblBMEbBXJRqs0hVzTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.64.8.41:52346.1035618608
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.156.73.12 (unknown [10.64.8.41])
	by 189.cn (HERMES) with SMTP id D6DAD1002AB;
	Wed, 26 Jun 2024 16:26:06 +0800 (CST)
Received: from  ([39.156.73.12])
	by gateway-153622-dep-9dc64869d-cgdr8 with ESMTP id 341c2eea31894564a47544999d022694 for john.ogness@linutronix.de;
	Wed, 26 Jun 2024 16:26:22 CST
X-Transaction-ID: 341c2eea31894564a47544999d022694
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 39.156.73.12
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <7252f93a-ef60-49f8-ae93-73d269cc62f8@189.cn>
Date: Wed, 26 Jun 2024 16:26:05 +0800
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a question about how to debug this case in ftrace
To: John Ogness <john.ogness@linutronix.de>,
 Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 rostedt@goodmis.org, senozhatsky@chromium.org,
 linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 williams@redhat.com, jlelli@redhat.com
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
 <e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
 <8734p0jhdc.fsf@jogness.linutronix.de>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <8734p0jhdc.fsf@jogness.linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

not really, sounds like it meets my expectation of merging logs either 
way, "printk:console ftrace event" in cmdline? I searched it in code or 
google, no luck.

Song

在 2024/6/26 15:25, John Ogness 写道:
> On 2024-06-26, Song Chen <chensong_2000@189.cn> wrote:
>> ohh, by the way, i'm curious why softlockup/hardlockup/hungtask don't
>> have ftrace dump as well as rcu stall, or is it possible to add a
>> parameter in cmdline to redirect
>> softlockup/hardlockup/hungtask/rcustall warning either to ftrace or
>> printk.
> 
> Are you aware of the printk:console ftrace event? If you enable it, all
> printk output also goes into the ftrace buffers.
> 
> John Ogness
> 
> 
