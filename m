Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7911EEE0
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2024 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680960; cv=none; b=oM+GptRROPUsRJ3iccDsRvc84M4A2GT2CseC6m6LkTdWm+tELUeTYqXNnX2N70Gvw39oiUrqJewqo2HpN/c/yy9Q5HNpWgUg8x/Lp+GfkeMX/2nLzNDL7MJzU6P4sHcd+VKmHodciOAcM7xaw0z/sdtMt3A6mKHaeXWT4aWwcdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680960; c=relaxed/simple;
	bh=5cxuE4PKcDoVz8K1p/cAclSemIvBZlwsMEeUYbTDq48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQmSBMjf5ptLwKSxn+dGILE9AJ+1d/tkOr0q+TCfARDN/7dtqC5ctPkXWJ0kIOvp4sqBof5pyX9ZmALwEh4Zklbrr4wj+8wARGaTD8B9Qo7wItONUjQBH+JTbsDfYpdWXR92H2Ut1KgoD0oxT9ibIKTg4eq06qiKQZHzwKwO4p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q2uCjIpm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q2uCjIpm"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-533521cd1c3so5003606e87.1
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2024 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724680957; x=1725285757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NyQI2+zYYES2psL5SX3gnl+wC8mrL0RNw7hfzKkkYHQ=;
        b=Q2uCjIpmxUKErrTsz2yURqJdzZhpRWawVJAYWuBAB9qLSttTsqMquq1NXqBHIYDN0V
         d5YTaBoOavCSsRRGv7IZpZRotFVyDmOtJyaC7sTRdWeFO0jr90KsjPHa5oYMH328YoVn
         jIWw0Orj6+U4PSKL33Z0qSLGqkjDrD+LNf/wYbQN6nukbgyVJTH8aJsgCeDJAeYO2iyK
         HhaOIkcF0V6ZwQJd4u41ORdLumh1i27Ec2/NZZN3BkbN6fI/7DlJlDOFjoLqOOujiMxI
         SVRsBSIulTuoGXOZr7j/l4dlKWQzJE60citWXZHaCBi1mLUHhhC6f5b9qOOg+5SEud9v
         jDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680957; x=1725285757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NyQI2+zYYES2psL5SX3gnl+wC8mrL0RNw7hfzKkkYHQ=;
        b=BIn40XVFZvzXenpdNvgdEviljNahzg/kFh6xqQlciCgWYa83EOgkGT0kjFV34uuaXE
         Gj1JqA+OQbdlkcF4RLuOJNX1Hay06Bfk19qXZEePM+5QrCMaIVwU+ddsgukX3Rl/hg7f
         CWqc/WA+v4frCDUuY4UMh+RA/mybBCO6KbSccB1SXJ0vpShq6dzwdUGJl9to6SHMLcgi
         PiDAnNzInKlJbzVPcfmht+wwClnO05ikEPT8LpXW7JLgWzcXV1A6wbZQ0XWXn3aRnCJZ
         B5rQ/vAbXw6fMLayH7IPHpeltY6eEnzDC/wnsiTPgq5VblWIpjlp8GjxwFQKRljS701X
         d/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4ZEJIoFlUBOSot9IovZl1I4bZWEGz+X9hmQIiXZuZUE3MG91TRIUNWU2JeF2BhyymPlDjt8wt0wjhBZjkaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwicQXH1Y9A4mko+ieCNdVyBN23WuyfPbz/C5t4RwoU9GmJxs2r
	q+650tKO5SzWv7IDEwfoK3wQAuX77pHDgeRRw1za0dr9ZPA/jKj89VvGwqCIeMQ=
X-Google-Smtp-Source: AGHT+IGYZx51trJdpSW+7hoCpVTra+ptnGwftP0C7+GW8iO7xDwwV8anDSrRrmbckv9Qe476xmYPOw==
X-Received: by 2002:a05:6512:3d20:b0:52e:73f5:b7c4 with SMTP id 2adb3069b0e04-5343887e063mr7763644e87.37.1724680956222;
        Mon, 26 Aug 2024 07:02:36 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f5085absm665433866b.224.2024.08.26.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:02:36 -0700 (PDT)
Date: Mon, 26 Aug 2024 16:02:34 +0200
From: Petr Mladek <pmladek@suse.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>

On Fri 2024-08-23 15:06:57, Derek Barbosa wrote:
> Hi,
> 
> On Fri, Aug 23, 2024 at 12:19:13PM +0200, Petr Mladek wrote:
> > Could you please also share the kernel command line? I can't find it
> > anywhere.
> > 
> > Especially I am interested whether it:
> > 
> >   + wanted to show backtraces on all CPUs via "panic_print" parameter.
> 
> Sure, here's the output of cat /proc/cmdline on the stock kernel
> 
> BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.11.0-0.rc3.20240814git6b0f8db921ab.32.eln142.x86_64 
> root=/dev/mapper/cs_rt--qe--06-root ro 
> crashkernel=1G-4G:192M,4G-64G:256M,64G-:512M 
> resume=/dev/mapper/cs_rt--qe--06-swap rd.lvm.lv=cs_rt-qe-06/root rd.lvm.lv=cs_rt-qe-06/swap 
> console=ttyS0,115200
> 
> >   + did a crashdump or a reboot.
>  
> Yes, with kexec-tools and kdump configured, we succesfully booted into the
> kdump kernel and rebooted every time as well as generated vmcores.
>
> In fact, examining said vmvcore-dmesg.txt log, we are able to see the final
> trace printed. It is simply through the serial console that we are unable to.

I see. This probably explains why the result of the stock kernel was so bad.

There are two tricks which increases the chance to see panic
messages on legacy consoles:

    1. bust_spinlocks() causes that con->write() callbacks ignore
       port->lock.

       This helps only when console_trylock() succeeds in printk().
       Also the serial port must be in a state which allows to see
       the data written by con->write().

       This does not help in NMI


    2. console_flush_on_panic() ignores even console_lock()
       It tries to call console drivers even in NMI context.

       This would likely allow to see the panic bracktrace even
       on stock kernel. But it _not_ called when crashdump is
       called.

> I will attach the vmcore-dmesg.txt. I also just did another run of
> console_blast, capturing the output from invocation to reboot.
> >
> >   + used also another console (graphics).
> 
> No, I solely used a serial console at ttyS0 at 115200 baud.

I see.

> > Do you miss the backtrace from the panic-CPU or non-panic-CPUs or
> > both?
> 
> I am not 100% certain. I included the two attachments, which may have your
> answer.
> >
> > The dump of the backtraces on non-panic-CPUs might have been affected
> > by the regression fixed earlier this week via
> > https://lore.kernel.org/r/20240812072703.339690-1-takakura@valinux.co.jp
> 
> Excellent. Is this included in the latest rt-devel tree? I can build that kernel
> and run it through the gambit of tests again.

Not needed. The tests were not affected by the bug because you did not use
"panic_printk" parameter on the command line.

> > Did the system reboot in the end?
> > Or does it got stuck somewhere?
> 
> The system always reboots.

Great.

> If you have any other questions, please let me know. I would be happy to re-do
> these tests with different kernels, configs + other variables and controls.

It might be interesting to redo the 1st test without the crashdump.
I wonder if console_flush_on_panic() would allow to see the panic
backtrace with the stock kernel.

But it is not important. The most important thing is that the new
nbcon consoles are clearly better and more reliable at least in
the tested scenarios.

Best Regards,
Petr
