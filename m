Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC251E48A;
	Mon,  9 Dec 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733743231; cv=none; b=iimOGRekKD1elGdR9HCQ8TTRUqQHYjbs5Q4tF9wPiK7Wk5qTGF1naUKa76JEo7ChwMoCkbrIG79bV6Yq87PUDJt++s1ihaUrMQpYDnGcYSQEGaA3I/SpYY+7AjGBpuHzga8rvVBon1ilUvv/0XiOCmCmsWAKySjwoG+p0kn58F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733743231; c=relaxed/simple;
	bh=KDevS2Hkw8s7WYikkx4Hpb22sqMerP6mD/+le5FFPFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSl7ZcGjaAJ6D4oIFnen1x5BbxYiuA/EL0ZqMpv2g7fBHT6CnB1SA+GaKL6gHwTd598RLUb9sLLk+Cc4HPGCSXTk3QuQ6QAl0dPLPPbde/JQxD6uNWkpr1c6idg+XBqUTlW5g1Sr1BRQH1RI+St5Rkl9dVyPB7zLiTnd3jA9Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=sEO2nEDf; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=monom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="sEO2nEDf"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2B96FDAF54;
	Mon,  9 Dec 2024 12:20:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1733743219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ekpL8i3dOqRnCd/tciZffdl+zfW4UL5mHw6Tl+ZF4Y=;
	b=sEO2nEDfuGwZaWQKhVmpqos8qub4+GwrgQtPuLoT4Yu7vtnBPXdE5si+4E0u3gqY3OpiiU
	OuDOTciYPzf5P1XMw5EmHUOUNnFlN0GULNds3ARVmL/IgV/GEJ7uBJOnZQjUcxoG3q0X6g
	syEgUVDbm0aj1TL8OhMDZq8xYvo6Jd8BcgZAZJBnOVv+f0Z193BLusyaO/WrW/Bcidaqn2
	7ClIkpWY12nHg+g8vbO7wAV4CKLZfAfAM6MCu4dRYw/1iMuEwHmuaqNRGqLMBvgX2qiC7p
	L5M0Li7h3fH7UT+Of9a8y+BIkdzOHYgwJsBQBTlvSNRoFgNBM54MKdSQ3taq3g==
Message-ID: <36387dd6-d21b-49f0-bdcb-0a36e7f49c3c@monom.org>
Date: Mon, 9 Dec 2024 12:20:15 +0100
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RT 0/1] Linux v4.19.324-rt139-rc1
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
 stable-rt@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tom Zanussi <tom.zanussi@linux.intel.com>,
 Clark Williams <williams@redhat.com>
References: <20241124190222.112239-1-wagi@monom.org>
 <Z1GOZVPb3Gzz30zh@duo.ucw.cz>
From: Daniel Wagner <wagi@monom.org>
In-Reply-To: <Z1GOZVPb3Gzz30zh@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Pavel,

On 12/5/24 12:28 PM, Pavel Machek wrote:
> Hi!
> 
>> This is the RT stable review cycle of patch 4.19.324-rt139-rc1.
>>
>> Please scream at me if I messed something up. Please test the patches
>> too.
> 
> 4.19.324-rt139 would be very useful for our -cip-rt release, can we
> hope to get it soon? :-).

Ah sorry, didn't see your email in time.

> We can also help, if required.

BTW, I understand CIP will take over v4.19-rt after the last release 
which I queued up last week. I am supposed to release in on Thursday.

Cheers,
Daniel
