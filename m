Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8B37867A
	for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450714; cv=none; b=dLdhFHLTEnQYWgmbMXByTc6sZATmTGS8Jv5Khvz1Xoyc07iv2a2fnfHzkO+9OXYyu/h+Yt1X9Mwcb4cNrqjkJQH1gIrMDy4lzyBPqhLJThb4n6ti6pkJJvJPjG8W235uDm0++YuutpbBcqT4Ms4fwV2ZyNUF/HtZqnML52Tk+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450714; c=relaxed/simple;
	bh=sWPQxpJ5JhFTeEb001dgjhbqbJO6mGNTN4LhH7v9mso=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bqU/D0JB5F6NoU+mZcGn8tcFbaFj44m5scw5ZwCalGCJYjhOkgENEZ5BY1N6eAAB1xtWK1ozOlNIakqlVsrIOA7Qmolsjzs6BPfST4nZ4qJbghGvBSLPE3VFNmkBB3T+sPEjIEZhpj7rkcXmvGigIwQUSr/g40hpiWdyVHTqezg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUtbcg6I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUtbcg6I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708450711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
	b=CUtbcg6I7RQiiJQl4ovHoybHixIkZ09p8DF65nRVNrpzwwD12p2/6/Xmn9hs1FPB3oeTTQ
	18ewXrAWan/aLIyzqqT7l/irXQqMZSbXF/35wYiot7m6DGWOjCmx3ISKhKo22jMBXIwwMh
	QmAQag6qb0A+6+OW22qDFG6cLEf6m1k=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-cq9qayA_McyjNE5aDsS9DA-1; Tue, 20 Feb 2024 12:38:30 -0500
X-MC-Unique: cq9qayA_McyjNE5aDsS9DA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6800aa45af1so78043516d6.3
        for <linux-rt-users@vger.kernel.org>; Tue, 20 Feb 2024 09:38:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450709; x=1709055509;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qn55PbDxlcyDzSN0idKbH2F2di32wdsURfOsZLp+bU0=;
        b=TPj7M9uSmZp8l8ovk0wrglJxv85LCnsyu06KKKyrCbbIM81IX6DJ20H2qwYqp+Hirr
         oU0JAKgznpfzIgW0bQsJgQZFwiV+24JfurGr4cjrE9hJzsVTFpnM5YVZxsTNfVxlsDLB
         vfKxkGCxul5A2B6sbwZCsU99FAA802fEyy53H/VzA0HuE0yYThjTcipJzbgYpYeFUEdQ
         WzQe7wJKWK+jFSB2Fzby9LtdCUWKXEWiV1vUwKzelS+ob0fjTv06lmmobIWVuNCSzbrQ
         KkCrWue+LeVBDkHyrfJjzfFrWEdilu2VMKfPWlIBlU6Rdehr7a3zLldrJbYpINZmawfE
         lL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbO4DsAt8CxKG4i91W3NGmTVIE15ne8gq0c0KIsB80H3c8Tqc7s9zo9FQnAuqmrsGpC2Oo20lN8cEi6iTQ8c+g/5hZi4ofxR7H9uS5ObM=
X-Gm-Message-State: AOJu0YxVnb4y+5iRCNiKOrI0QqSiRVTvfq4/7KdquOYi30m3kTOTWa4Q
	Jpk+LrNApHrsJfDQh/7biYxpFaXWr2E5bfwVmYegFp+E8jrrkLetYcOAEjHKAyOVeb/bOdsEeuZ
	piRE84qXBo6uSCfykcZSJBqNQcCDfKqf9DZesU14Q8rN6TRVlqtwoKzgs4OeYufJT
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978324qvb.49.1708450709580;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPEiisDHYagQqfgdyTO0C+ZU+atUpAKG/0i+pMgPq3cIPMfW9JW9MVlTXN5kfFRL0jV660rA==
X-Received: by 2002:a05:6214:e61:b0:68f:6260:f723 with SMTP id jz1-20020a0562140e6100b0068f6260f723mr7978308qvb.49.1708450709254;
        Tue, 20 Feb 2024 09:38:29 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id nc9-20020a0562142dc900b0068f58a8e09csm3498212qvb.108.2024.02.20.09.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:38:28 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: bigeasy@linutronix.de, davem@davemloft.net, dccp@vger.kernel.org,
 dsahern@kernel.org, edumazet@google.com, juri.lelli@redhat.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-users@vger.kernel.org, mleitner@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com, tglozar@redhat.com,
 tglx@linutronix.de, kuniyu@amazon.com
Subject: Re: [PATCH v3 1/1] tcp/dcpp: Un-pin tw_timer
In-Reply-To: <20240219185537.13666-1-kuniyu@amazon.com>
References: <20240219095729.2339914-2-vschneid@redhat.com>
 <20240219185537.13666-1-kuniyu@amazon.com>
Date: Tue, 20 Feb 2024 18:38:25 +0100
Message-ID: <xhsmhmsrvf33i.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 19/02/24 10:55, Kuniyuki Iwashima wrote:
> From: Valentin Schneider <vschneid@redhat.com>
>> @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, int timeo)
>>  		if (state == DCCP_TIME_WAIT)
>>  			timeo = DCCP_TIMEWAIT_LEN;
>>  
>> -		/* tw_timer is pinned, so we need to make sure BH are disabled
>> -		 * in following section, otherwise timer handler could run before
>> -		 * we complete the initialization.
>> -		 */
>> -		local_bh_disable();
>> -		inet_twsk_schedule(tw, timeo);
>> -		/* Linkage updates.
>> -		 * Note that access to tw after this point is illegal.
>> -		 */
>> +	       local_bh_disable();
>
> This line seems not correctly indented, same for TCP change.
>
>
>
>> +
>> +		// Linkage updates
>>  		inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
>> +		inet_twsk_schedule(tw, timeo);
>> +		// Access to tw after this point is illegal.
>
> Also please use /**/ style for these comments, same for TCP too.
>

Will do, thanks!

