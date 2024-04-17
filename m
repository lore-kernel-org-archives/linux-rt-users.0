Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E713C9B2
	for <linux-rt-users@vger.kernel.org>; Wed, 17 Apr 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375732; cv=none; b=GHCmr6ftBgwc7ifVCJkJ/D6emQNr+48JKgHC45J6OysZMOtwRaGeuq2DxWX4+P2/OiBtiB5VjEYlSLv7omioIQhVeG0TwUGItJdFhhESs82a+jSXOqxNlUwU7kUaKYvZcIyYq3h9LUH8Tvx68VAZAnm5gID/VKwnAKVvOoEtaGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375732; c=relaxed/simple;
	bh=BE1ZWTtOKfkeyvL6DrPKLRx+o75ySdhROgvGPUTwEsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ER4XkLXkTUmnKSeEoAwojUOJrrrhkgr8/tNPYqO85jJGgM9FzWBb5nI1/JoRKxp9YvNzgen03X46PW1QshGjmizz7dmyUQ0nA73+gKElUjM004Rv2luXreAHhzMk2sGOkO0Kb6IwwH9ne7upRFZGUxKNoODB9tx12u3r80R7LvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMdQI4Q9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMdQI4Q9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713375729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ciJVdbf5KW00md9ONk3n+c12FOmnIbDPcUPKUFPEOxY=;
	b=TMdQI4Q9iPCn/FAfKAlWBei4x6YNdHn4hd3rR1XDsFznnP8RdPu80hsEVozwqF3CRLDSlQ
	u35S2ZxphyTI7uZJIRHM/ambzYC+Fd8m6giOj2IHAem5+ay/OEDsetazbhAu3FmMNhwShR
	fJtd5/yZsFzgoAzg7+S2bH6nKdtUKX0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-7U1WCUyDNy2kQLtBuS1XHQ-1; Wed, 17 Apr 2024 13:42:07 -0400
X-MC-Unique: 7U1WCUyDNy2kQLtBuS1XHQ-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5aa18a128c6so6344eaf.3
        for <linux-rt-users@vger.kernel.org>; Wed, 17 Apr 2024 10:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375726; x=1713980526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ciJVdbf5KW00md9ONk3n+c12FOmnIbDPcUPKUFPEOxY=;
        b=Y1kKt0MJeIbWgW7eyRfMOxwH+/NDIa9eovKdAP5/QlTI8dQ33aKVN71pQVJTNbonst
         9Zxev042fTMNFFGzX8nvY+KaDy34wSX/8OnR3F/PIgvMLNOZ2fu7D8T1UMeyCio+MRC7
         rz6QGj7Et2OB4wayJ/yREgWt0qWbpxALccWokJ8tokXefHDwepF0bvz0XDft3UfWN2GU
         BGvdpSXlHWCJpPJTI8grRfYvUzzxE3u7Exh0D4GBRJ4NsR6NxzBpE9I/LodLyqOMhNl5
         XTZEvmF+42jAYAtPZuyHwQ5GBl4g++zXGtWqGUypZ/t4CUyNktvIAbdfZ1n5+lNnmiFJ
         gusg==
X-Gm-Message-State: AOJu0YzWE94U8clabNcWiWzYZUv59qPf1L+MuupP7DZFU0xOfehA2YxB
	1s+ylwzEsuiU28craK0nF8VBu5qzYyF3k1O/o7vV7CmJWN3PhQVc9YR97ZCNLswrAWSJ3VyMoCk
	rX0ZdzWYGm//XrE0aO6Y/l5R2/oiPCUW8to09k++HdAu0ZOJmLq7voE026zHAKQqCfY8kQQRM
X-Received: by 2002:a05:6358:2697:b0:186:27ce:63aa with SMTP id d23-20020a056358269700b0018627ce63aamr17842474rwc.24.1713375726005;
        Wed, 17 Apr 2024 10:42:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuyO7oP9iE0WcZzKTsqSr80Y0NYtYJXV5311ex0gjHuPGc6m++dCd1YTNmA8f4gfr0QP3LlQ==
X-Received: by 2002:a05:6358:2697:b0:186:27ce:63aa with SMTP id d23-20020a056358269700b0018627ce63aamr17842442rwc.24.1713375725383;
        Wed, 17 Apr 2024 10:42:05 -0700 (PDT)
Received: from thinkpad2021 ([71.217.37.202])
        by smtp.gmail.com with ESMTPSA id h20-20020a0cab14000000b0069b58b97ed2sm7005143qvb.28.2024.04.17.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:42:05 -0700 (PDT)
Date: Wed, 17 Apr 2024 13:42:03 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Miguel Miranda <mmikernel@gmail.com>
Cc: RT <linux-rt-users@vger.kernel.org>
Subject: Re: Seeking input on beginner-level bugs related to preempt_RT
Message-ID: <ZiAJ60Ugb-1MaTkQ@thinkpad2021>
References: <27cfdcdc-f0d0-42ae-9b53-937828a4fd7d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27cfdcdc-f0d0-42ae-9b53-937828a4fd7d@gmail.com>

On Fri, Apr 12, 2024 at 05:00:39PM -0600, Miguel Miranda wrote:
> Hello everyone,
> 

Welcome.

> I am currently looking for beginner-level bugs related to preempt_RT for the
> Linux kernel Bug Fixing Spring Unpaid 2024.

What is your experience level? Have you built and run an rt kernel
before? (Selected Fully Preemptive in kconfig?)

> Although I am not an expert in
> RT, I have been trying to identify some bugs and our mentors have suggested
> using ring testers such as syzkaller and test frameworks like
> kernelselftests to find and reproduce these bugs on our own.

A lot of the bugs we encounter are around locking. RT changes
the way locks are handled in the kernel. That is one avenue I would
encourage you to study.

Not sure if anyone has actually used syzkaller on the preempt-rt
patchset. Never used it before, but I would be interested in it's
results.

You can read about kselftests here:

https://elixir.bootlin.com/linux/latest/source/Documentation/dev-tools/kselftest.rst

> 
> I have a few questions and would appreciate any input you may have. Firstly,
> is there a specific CI ring or channel that lists KTODOs, or a preferred
> platform where bugs related to PREEMPT_RT are reported? Secondly, I have
> been following the LKML and have seen some console_blast.sh results, but I
> am not sure where to find this console_blast. Lastly, I have come across
> some recent discussions about printk() related work, but I'm unsure if there
> is a list to avoid rework.

John Ogness sent me that script and I posted in another email on this
list. I forget which one.

John specifically asked for a very large core machine to do the testing
on with a uart 8250 interface. That might be difficult for you to
procure but I have included it below. Please make sure to use the
correct line endings or Bash will not like it. :)

#!/bin/sh
set -e

# This script is intended to be started with no arguments.
#
# It then calls itself to create a pinned process for each CPU. Those
# child processes will run in infinite loops of show-task-states via
# /proc/sysrq-trigger. This generates lots of contention on the console.
#
# Finally, it waits 10 seconds before crashing the system.

if [ $# -eq 0 ]; then
	cpus=$(($(nproc) - 1))
	for i in $(seq 0 $cpus); do
		$0 $i &
	done

	sleep 15
	echo c > /proc/sysrq-trigger
	exit 0
fi

# Setup the CPU mask for the provided CPU number. The real taskset(1)
# could simply use -c, but the busybox(1) variant does not support this.
mask=$(printf "0x%x\n" $((1 << $1)))
taskset -p $mask $$

# Wait a moment before beginning blast.
sleep 2

while true; do
	echo t > /proc/sysrq-trigger
done


-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat

