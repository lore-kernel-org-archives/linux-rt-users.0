Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D525C6FE
	for <linux-rt-users@vger.kernel.org>; Mon, 10 Feb 2025 19:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739217050; cv=none; b=QQrXSjKzBR+E2zgjEDAVbwFWtQoQOfSDLH42Oot7/+g6yOV9Z4YaOb1WPFl0Nut8QjfSXp/lSOmTT8i7f9ync3nRDPAlg5TTR+xUQONyJU5fqHChKHwQO7oOFjWF72Jv1a1t7P103WNd/n4Vy6ihmYay943Z70BeB73Pf1JiBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739217050; c=relaxed/simple;
	bh=jmucw4jw6B6nLuyVu8bmxYd15BjeAdIetN+7IVrI3lk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LMjFBKV6umlyizekanAYOxhvDcTI+TtnuE41ARbtiKY/F5amZFIXQHmi9NlhxKD16fDOdNTJEvdNX2txMwHCE5o0VKgF3w5fM5K+n5HBqpJqGHnaR30YV9qmIzeaEeH0Y/IDWsrXPeMAi5oShNZs9SIqNUo7XEMSf/oHDHwy05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iQ6TI5FN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iQ6TI5FN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739217048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oaxhONQGeiXJ7X8wdHBtGq3Vs36OHTn1MKKD/pCnyxc=;
	b=iQ6TI5FNMxDGYLs4bEShMShzap1lUZolqj980GvjEXQ3hCUhg3R8OR3H2Ii3TsQfOkkQmK
	Ga9o1Pznlh1LAqsTHiJ8hSugP7RUf7wY9lp9xN0q/jXhuEPL9zpXZcPdYp3Sv+je8zjvm6
	g8Z+gTqNR3hZW32nXBC4/cC2l302ZGc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-p51VKDWWNUGotElUZjNIKA-1; Mon, 10 Feb 2025 14:50:46 -0500
X-MC-Unique: p51VKDWWNUGotElUZjNIKA-1
X-Mimecast-MFC-AGG-ID: p51VKDWWNUGotElUZjNIKA
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c05b713968so510325785a.3
        for <linux-rt-users@vger.kernel.org>; Mon, 10 Feb 2025 11:50:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739217046; x=1739821846;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oaxhONQGeiXJ7X8wdHBtGq3Vs36OHTn1MKKD/pCnyxc=;
        b=VhP6fa5rvh4tIiRg0Q7rHLTSliDkNC+15Ow0kbHV2uimFFVwP4lJWI5d5METh/YUw6
         pWJuFCVgQz92HiomYhEFQyztDtlU+p++Kl1QD5kevn4pEX9dSNpijByM98qUQp1IpyO6
         7yr8gjC6cHnBb2XVib50olbkk6S56yfMkLsHULEMZYplwpIVh6X14nOKVgvMmkd1nfzJ
         nQy1nqLlmLJOUZjQABUnEewNrddh+X6iBFiqHY/6JJrpo3ANRPD4B2M4OO2dIDDzjRuH
         nReSCHlBbhfKTnuyUN2c42oonM+9LnGlQsA4er7S22eDBJhVWIg7IpivOeF+kMGEEXQ4
         YKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEYOBM9abxX6oP7rtA5/B3tbeGZHDq+WlLPmcc4fQHm6/ujwENuNwNk4qPErrv42wcIepUyeGeaDR6dd+7yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzSi0X7bGTI6B7k6TqlxDsgBX9Ire+xPgOxwof0gjPZF+NyM+Z9
	L0VcPCp9FNFGnW50aRfqPeMs19u8Z7WbCZguqJKh2PrvB5qFG0SY3md0UtbIZYOLYMhSxVmUHj0
	8siiPFwdBHk6jHMcO5sececoQnLDfqW/iwFz7uJxqPfHAHtk33z6QzfETj+XlNQVR
X-Gm-Gg: ASbGncuuqsTkYNsBv6Sv716bxYIzDCdzc5I5MssejLXpEF6fZ+ty9047XRwaAmhnAPN
	7ZadR7DZl1g09IDGclwhe8+QUHZJ8vmSsymNfsk0hc5vm0o3hryEPDYa/ssCCrNzuD4tF3uAQvT
	7QcmRr0OoDHgUwGp5Lofr0j5ciaescck4/YtJCJzatQJ8TcD5zgk+PnFLE7tkJ5L58OXmFA6p8o
	kAB+Tkilka1ssGRBcszUIRx6tJbXQYcZBR10L8aKz3KeZgKDBd8L3N8PFf3peHawO0lMcY=
X-Received: by 2002:a05:620a:2684:b0:7c0:69a0:d9ee with SMTP id af79cd13be357-7c069a0db1bmr15388685a.33.1739217045872;
        Mon, 10 Feb 2025 11:50:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIgF41Yqu3F0nVSs3O98uthg1vXJ+rkZJmdB7epQh6vv3TSpDvPqgYfAR2jwjwKncN6IJAXw==
X-Received: by 2002:a05:620a:2684:b0:7c0:69a0:d9ee with SMTP id af79cd13be357-7c069a0db1bmr15384985a.33.1739217045473;
        Mon, 10 Feb 2025 11:50:45 -0800 (PST)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec129sm562072085a.18.2025.02.10.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 11:50:44 -0800 (PST)
Date: Mon, 10 Feb 2025 14:50:43 -0500 (EST)
From: John Kacur <jkacur@redhat.com>
To: "John B. Wyatt IV" <jwyatt@redhat.com>
cc: Clark Williams <williams@redhat.com>, linux-rt-users@vger.kernel.org, 
    kernel-rts-sst <kernel-rts-sst@redhat.com>, 
    "John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: Re: [PATCH 0/2] Add cpupower idle-state functionality
In-Reply-To: <20250128014551.15058-1-jwyatt@redhat.com>
Message-ID: <21714eaf-d3d8-81bd-cc27-7a8aeb0bf971@redhat.com>
References: <20250128014551.15058-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Mon, 27 Jan 2025, John B. Wyatt IV wrote:

> This patch series adds idle-state functionality to control cpu power
> usage and to test idle states.
> 
> The number of cpus was needed in the cpupower file; I extracted out the
> previously local to tuna-cli.py functionality to a separate file so the
> cpu code can be used in any file in Tuna and reduce duplications. The
> nics code was similar so it was also extracted to reduce the number of
> global variables.
> 
> Sincerely,
> John Wyatt
> Software Engineer, Core Kernel
> Red Hat
> 
> John B. Wyatt IV (2):
>   tuna: extract cpu and nics determination code into a utils.py file
>   tuna: Add idle-state control functionality
> 
>  tuna-cmd.py      |  67 +++++++++-------
>  tuna/cpupower.py | 202 +++++++++++++++++++++++++++++++++++++++++++++++
>  tuna/utils.py    |  27 +++++++
>  3 files changed, 267 insertions(+), 29 deletions(-)
>  create mode 100755 tuna/cpupower.py
>  create mode 100644 tuna/utils.py
> 
> -- 
> 2.48.1
> 
> 
> 
./tuna-cmd.py idle-set -h
usage: tuna-cmd.py idle-set [-h] [-c CPU-LIST]
                            (-s IDLESTATEDISABLEDSTATUS | -i | -d 
IDLESTATEINDEX | -e IDLESTATEINDEX)

Query and set all idle states on a given CPU list. Requires libcpupower to 
be
installed

options:
  -h, --help            show this help message and exit
  -c CPU-LIST, --cpus CPU-LIST
                        CPU-LIST affected by commands
  -s IDLESTATEDISABLEDSTATUS, --status IDLESTATEDISABLEDSTATUS
                        Print if cpu idle state of the cpus in CPU-LIST is
                        enabled or disabled. If CPU-LIST is not specified,
                        default to all cpus.
  -i, --idle-info       Print general idle information on cpus in 
CPU-LIST. If
                        CPU-LIST is not specified, default to all cpus.
  -d IDLESTATEINDEX, --disable IDLESTATEINDEX
                        Disable cpus in CPU-LIST's cpu idle (cpu sleep 
state).
                        If CPU-LIST is not specified, default to all cpus.
  -e IDLESTATEINDEX, --enable IDLESTATEINDEX
                        Enable cpus in CPU-LIST's cpu idle (cpu sleep 
state).
                        If CPU-LIST is not specified, default to all cpus.

These names are kind of awkward, isn't IDLESTATE good enough, why 
IDLESTATEINDEX?

For the -s option, why do we need to put the IDLESTATEDISABLEDSTATUS, if 
we omit that can't we just get a result like running "cpupower idle-info"?
Could you rename IDLESTATEDISABLEDSTATUS to just IDLESTATE_STATUS?

Thanks

John Kacur

