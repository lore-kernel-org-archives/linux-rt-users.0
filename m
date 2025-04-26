Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7871A5BB5
	for <linux-rt-users@vger.kernel.org>; Sat, 26 Apr 2025 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745663212; cv=none; b=BLxEdMI8LIXhY5sBqlqEoilnMK6msvXZ5PwrOMo6no5HKkUwFNRuVjqy75+T0eKMH6KbPdmkxsCZqSwhBfKWgy/zcEGy9kCA+QMlgWLglKbclS+nGwDVbcAnQCJvInDddEvLtslItPkALOD2FgVPUQIJ3vCoJ4mjxoapSdAj64E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745663212; c=relaxed/simple;
	bh=zQkmlXkykBNZKlDSk/lFIY1d0S3JG8M53m2xaeo01Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BjVQfHDkqQXkUfPL0nBwLMk6iaJzAW7YxNT3GA/BVuVhE1j43T5IBn/jfeaWnyh0kodS6CZebSaoGa//k2/odicMFO2aqi7lccqhv2s9TLW8zSkd9kEhkwn1LT5DfnBKZN/ZaFJ9C3NeCpZhKK0i2XRlhcGDKUK2LTEVWgPLCRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sPJrzi2N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJhX61DC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sPJrzi2N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJhX61DC"
Date: Sat, 26 Apr 2025 12:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745663209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0I0rJ18MUU9G1HSZlc10kBbzCFUah309qHiQYa7V7s=;
	b=sPJrzi2NCeLErYw0n11wBm/fERJH54PbNjjxZ7j0tmgixdzHU2M9+wGGS+im1Z8gnrhhXE
	swzPKJK1dGx8bjFwXYxcMT+5z5DFPkDQ81BO2fWMhzOFM0oRPJ0LC1/5XHRFZ931vx9/3f
	GZLEVk5dfi/GPBoxuiQbUCIitQFoxfCI8rlO5fDBdJKlqNSzVi6+UZJ4Rbp0zX2ycGD7+/
	R1ql6VDYgI74li/zBOZssJmfForU3iOif7lhUESHDOR25yPUNJh1r5SPgZsB3Dc71ZiYQY
	ibnOt3lQPk965aQXkE+pe1KhPATY2LIoQxTnagkX33LMAQtfc3ySJeF/h9mihg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745663209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0I0rJ18MUU9G1HSZlc10kBbzCFUah309qHiQYa7V7s=;
	b=jJhX61DCefZINUSm/dNgVcoLbyXJpDvSk4Z7aJzbKiAx5mFVFX6z2WpzT6pX8BCculjsEn
	beWX1CrHaEQwETAA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Sheng Liu <liu.stor@gmail.com>
Cc: linux-rt-users@vger.kernel.org
Subject: Re: How can an RT application know if it is running in nohz_full
 mode?
Message-ID: <aAy05nSkkqRJ8HXu@lx-t490>
References: <CAPJipUVDP2sT3cwj_K-tB1-Zpmc0uGKsg=9=qxbj3SaQmo+T_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPJipUVDP2sT3cwj_K-tB1-Zpmc0uGKsg=9=qxbj3SaQmo+T_w@mail.gmail.com>

Hi,

On Fri, 25 Apr 2025, Sheng Liu wrote:
>
> If an RT process needs to run in an interrupt-free environment on an
> isolated CPU, how can it determine if the nohz_full conditions are met,
> similar to how the kernel uses can_stop_full_tick()?
>
> Would it be feasible to add a variable in procfs, which can be read by
> other programs and notify the RT process throught a shared memory flag.
>

This is overly-engineeded with no extra benefit.  A simple cgroup setup
and some basic /sys/fs/cgroup/ file reads should do the job just fine.

Assuming a recent kernel, let's say you want to isolate the CPUs 0-1,
right now, on your own laptop.  Open a shell and do:

    CGROUP=rtisolated

    echo "+cpuset" > /sys/fs/cgroup/cgroup.subtree_control
    mkdir /sys/fs/cgroup/${CGROUP}.slice
    pushd /sys/fs/cgroup/${CGROUP}.slice
    echo 0-1 > cpuset.cpus
    echo isolated > cpuset.cpus.partition
    echo 0 > cpuset.mems
    cat cpuset.cpus.partition		# should print "isolated"
    popd

On the same shell, spawn a /bin/bash process in that 'rtisolated' cgroup:

    systemd-run					\
     	--slice=${CGROUP}			\
     	--unit=isolated-shell			\
     	--pty					\
     	/bin/bash

    Running as unit: isolated-shell.service
    Press ^] three times within 1s to disconnect TTY.

Now, from that isolated shell, do:

    echo $$				# Bash own PID
    302713

    taskset --cpu-list --pid $$		# should print CPUs 0 and 1
    pid 302713's current affinity list: 0,1

Now, also from that isolated shell, do:

    cat /proc/$$/cgroup
    cat /proc/self/cgroup

Both "cat"s should print something like:

    0::/rtisolated.slice/isolated-shell.service

which can be easily done and verified from any C code as well, before
starting the RT loop (where multiple initiatory steps need to be done
anyway).

Running systemd-cgls, from outside that isolated shell, should also print
something like:

    CGroup /:
    -.slice
    ├─user.slice
    │ └─ ...
    ├─init.scope
    │ └─1 /sbin/init
    ├─system.slice
    │ └─ ...
    └─rtisolated.slice
      └─isolated-shell.service
        └─302713 /bin/bash
      ^^  ^^

Hope this helps a bit.

Good luck,

--
Ahmed S. Darwish
Linutronix GmbH
