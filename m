Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D707A140
	for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2024 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710244871; cv=none; b=OSXm1OkF4awISfciMrW/gCUC90am+LlTN3H6Xksy2caasIIR2xZOAmah3RGDoPM18R7gLVy8iZ9/jLZzG1q607gFZ5rNPhk0CvPVcNhkEdCd6SFrGK90YfE+a7kQ/QCZmqvT/fnY4QnsnXV/FzKGmHlkq6Vnl6XWnFtJzkvCI48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710244871; c=relaxed/simple;
	bh=hGSxYcy2fOmsIuKrt2NPXSbTPZJhdsaSTmIGLdcYMuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeXnp6kyNmBHV5/u85fadzy4bFAs4vTyG5CAiviDGmcxZHCwruYkzsqsQ9N9G3W7WFFOg2c5D5izah00DH5DF7qh9FF+AtA2M+xE2FO6iLOKkjrIhxz8bTdy56jqBcxjjObiWZNF5prWhDW3veKxi+4m+5BtEZlVbuDEyTNEDw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FEA61007;
	Tue, 12 Mar 2024 05:01:45 -0700 (PDT)
Received: from [10.57.95.176] (unknown [10.57.95.176])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07AC73F73F;
	Tue, 12 Mar 2024 05:01:06 -0700 (PDT)
Message-ID: <6fe2a26b-ece8-42d8-8b6f-95fe98e84a32@arm.com>
Date: Tue, 12 Mar 2024 12:01:05 +0000
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Alternative to updating has_smi_counter?
To: Rodrigo Queiro <rodrigoq@google.com>
Cc: linux-rt-users@vger.kernel.org,
 Daniel Bristot de Oliveira <bristot@redhat.com>
References: <CAMnS4ZDigjkexNdJT3ZhLcmAMeodTKsPi+b91sSjE5sky7ZfqQ@mail.gmail.com>
 <7f10669d-fffa-40f1-86e2-db3033957b19@redhat.com>
 <CAMnS4ZALUHVuH7YAGNA1+A8n7Tc+pLpso0Ywr4Z39UcC4g6e5w@mail.gmail.com>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <CAMnS4ZALUHVuH7YAGNA1+A8n7Tc+pLpso0Ywr4Z39UcC4g6e5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2024 10:43 am, Rodrigo Queiro wrote:
> Thanks! Are you aware of a complete beginners guide on how to send
> changes for review? I'm afraid I've only used the GitHub or
> company-internal workflows, so I'm not sure how to submit the attached
> change.

https://www.kernel.org/doc/html/latest/process/submitting-patches.html 
may be helpful.

[snip]

