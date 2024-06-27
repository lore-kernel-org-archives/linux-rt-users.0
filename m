Received: from 189.cn (ptr.189.cn [183.61.185.101])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBA117F3;
	Thu, 27 Jun 2024 02:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=183.61.185.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719455192; cv=none; b=IERswjCnwbjd/CrD4dn7/BenDc/dtcS088Ge9Q2A+aNxvq1Mcngah8aAN2d0g8Nq3MRmZhxNj2Ym/cr//cl2qnwP0ZMlJCzakEJ0Sa2FEl9+SSY/1Dsh3X7YizZl6XfOr99XUvqjTnzKL68CZTIgJF4RtsCdCnGp+zXwd928SUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719455192; c=relaxed/simple;
	bh=8jnK82A2kkbzrMUTeIppDDnkugBY5xMAxwQcUq2I2jQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/SwVsZfk1Gq9HJN1X/0iXV/IoCvduLD2VpyA/CR2y1EY8A9gIyZ8GkeNXNs/OPdRI0UsjLLHceEE2JyTdJ4jqATNgSUqTr3G42MgSJHRpKC8XzgqETPcc4nOKoSnBB09EOvSQflSFUHpwfu9UvZHJYnXnxt69b2OKgp5dz3y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=183.61.185.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.64.8.31:45610.565408704
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-39.156.73.12 (unknown [10.64.8.31])
	by 189.cn (HERMES) with SMTP id EC3C41001F0;
	Thu, 27 Jun 2024 10:26:20 +0800 (CST)
Received: from  ([39.156.73.12])
	by gateway-153622-dep-9dc64869d-f88ns with ESMTP id 623abdc51ecb4758ba9ace4e73bd628a for rostedt@goodmis.org;
	Thu, 27 Jun 2024 10:26:21 CST
X-Transaction-ID: 623abdc51ecb4758ba9ace4e73bd628a
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 39.156.73.12
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
Message-ID: <9fdbd9b0-d7d1-472a-98af-4fc927ce6e02@189.cn>
Date: Thu, 27 Jun 2024 10:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: a question about how to debug this case in ftrace
To: Steven Rostedt <rostedt@goodmis.org>,
 John Ogness <john.ogness@linutronix.de>, Andrew Halaney <ahalaney@redhat.com>
Cc: Derek Barbosa <debarbos@redhat.com>, pmladek@suse.com,
 senozhatsky@chromium.org, linux-rt-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, williams@redhat.com, jlelli@redhat.com
References: <ZnGlt4uQRP_4nWu4@debarbos-thinkpadt14sgen2i.remote.csb>
 <6802e81c-1926-4195-812a-1a5fe13bcdde@189.cn>
 <xiune2bsqgin5ksk33q5bkihuz5qrv5casjofdyopes55zfcpc@uvvnlwxb4wcp>
 <4d198032-d4e1-4a84-8f56-1b31157e9323@189.cn>
 <e6b0ba9e-e8f6-4c42-9f63-e3b67d7edbf0@189.cn>
 <8734p0jhdc.fsf@jogness.linutronix.de>
 <7252f93a-ef60-49f8-ae93-73d269cc62f8@189.cn>
 <20240626105046.7ad9299e@rorschach.local.home>
Content-Language: en-US
From: Song Chen <chensong_2000@189.cn>
In-Reply-To: <20240626105046.7ad9299e@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It works, many thanks.

BR

Song

在 2024/6/26 22:50, Steven Rostedt 写道:
> On Wed, 26 Jun 2024 16:26:05 +0800
> Song Chen <chensong_2000@189.cn> wrote:
> 
>> not really, sounds like it meets my expectation of merging logs either
>> way, "printk:console ftrace event" in cmdline? I searched it in code or
>> google, no luck.
> 
> Try adding:
> 
>    trace_event=console
> 
> -- Steve
> 
