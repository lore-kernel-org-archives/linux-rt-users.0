Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C2A194A45
	for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724684932; cv=none; b=EYbwfTafzedb1P9KazL3lWWJtKWR6d+mp6xdIIs9YCPOyRYpBmtlA84yQ1NvQuimfZjKTzjss5AW2H+m3MY7MzTc2cx+R9c6oLT1SgC1cfaW0tHtoklLC/efJ88FCUsrh9Zw6qA08WhrkLNwcO1WK2uPI73h2/aQ1Faz5M6/Tnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724684932; c=relaxed/simple;
	bh=MTJMukaLubbeBjK2VCNHy37sPDU+QxLDErb2ug+AOlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCfXAIQfOcqF5qz1Kw2Dj6T7xJtlRecQS1FTUrNHr93YreL9uhjoj2+lQ7p7NbVvuwkKeFfP+MsTUnumFLyIgPzIfuGpvZ3TUgtMiYLJpSrEWCz+amOCxOP+ol7YFAocxA4vOdIqyGWC5vFq6mJdss2zzJPiV/dCs4eRJt/UXOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dq1AzZmM; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dq1AzZmM"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8692bbec79so554615466b.3
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Aug 2024 08:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724684927; x=1725289727; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yP9jwrqY8Nokmykhfmjq9A1OmczZ3ZsJp132H7d1xU8=;
        b=Dq1AzZmMPQPwA4mIIodEeNY5FR1hiHWa+JlL2aglhksg8chuKlfwPvsyXrFpBmG9F+
         2HuD/VkHPyg/MHnE7j26dtVjwPQqisZo6Bmjw4LEyAuhw+sOfxnZsCODVqFC8c/NavWs
         8+MulLugJ4sWDvZ5oJVYVnfaVpuI+HmcxfZR7UkQVek7VGz54Eiei0+AHED4jvUlzhfx
         OMVl8LbjMdo4ETYgB4IgOf6kcKQwGGcj9p9ukAwycBSDUmO5rsQiYLmuTmNM87aDv0A+
         jKjsZZ5smHjJCZflp9hfWMT9jjvD7ozNjiZHBivNe2xPT3QBhw8uxRT4pxJMsGepzU8r
         4M0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724684927; x=1725289727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yP9jwrqY8Nokmykhfmjq9A1OmczZ3ZsJp132H7d1xU8=;
        b=b0lPG4BFLuF1lQR3ysSNi0aogk/4tHMVjEsu+wR528bmbSdpfhezKV3Z8Tj6nqNCyS
         g0+/jqW3sNacUuA0Aq/2oXXGEXqHpKDsGAG8KPODPGHgzHEi3hkoJLFq9xBH19C75+nY
         YXATy5HjJ/gT+oNNErtp6eKcZHy1j1lujQMoYV8iChZ8f21J+cNRidm5UzOcLb8Ii2RY
         Lh3KywvG5n2qlY70yrsxM4syUVtGxWQ46lIalnuRQ427g4VED7+r1eAeQmVvguzBuuzC
         RNyJQehLvij+97qHl5aUmMGpWZJdFqx2YRMhpxIyUAmHKQEEHvGS8r4e6vZzZdewxtmL
         7HCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7xS9MoDFnA9VzOVWwoI+g6SBAthbzCF3Q6shWKo2WX6j23FosaNL6Jyyn1yqJP2t/JpEupALJ6gwLrqI9Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LVdvJLOaWmVpcA9jkD5SJuV4xiQDT7tCyruAacHarSHXY9wt
	uwtTGeppzX1TNlWZWNZ7I2c7WCNICc6oMkRwh/DJfANWGUbhK2QaQfpSTIX3mGY=
X-Google-Smtp-Source: AGHT+IEsyoTCPsG2sCg/eK1b8PXETcwDGShijC+bkpt/aEJ18QP5ty/R1n/xTchmybueHHEM2XGwMQ==
X-Received: by 2002:a17:907:c0d:b0:a86:c9f5:68df with SMTP id a640c23a62f3a-a86c9f57dbcmr284463466b.44.1724684927276;
        Mon, 26 Aug 2024 08:08:47 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f43661dsm674517666b.100.2024.08.26.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 08:08:47 -0700 (PDT)
Date: Mon, 26 Aug 2024 17:08:45 +0200
From: Petr Mladek <pmladek@suse.com>
To: Derek Barbosa <debarbos@redhat.com>
Cc: pmaldek@suse.com, williams@redhat.com, john.ogness@linutronix.de,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: test 1: was: Re: A Comparison of printk between upstream and
 linux-rt-devel
Message-ID: <Zsyafduo2UItzLAK@pathway.suse.cz>
References: <ZsdoD6PomBRsB-ow@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZshiIdUFQs4CKW2t@pathway.suse.cz>
 <Zsjd0WUNIU8_kprt@debarbos-thinkpadt14sgen2i.remote.csb>
 <ZsyK-s2D8eqqBrXU@pathway.suse.cz>
 <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsyVXMqM2SK0aYyV@debarbos-thinkpadt14sgen2i.remote.csb>

On Mon 2024-08-26 10:46:52, Derek Barbosa wrote:
> On Mon, Aug 26, 2024 at 04:02:34PM +0200, Petr Mladek wrote:
> > > If you have any other questions, please let me know. I would be happy to re-do
> > > these tests with different kernels, configs + other variables and controls.
> > 
> > It might be interesting to redo the 1st test without the crashdump.
> > I wonder if console_flush_on_panic() would allow to see the panic
> > backtrace with the stock kernel.
> 
> Sure. 
> 
> I disabled the systemd kdump service unit via systemctl, and performed a reboot
> to ensure that the crashkernel would not be armed.
> 
> Performing a trial run of console_blast.sh shows results similar to what was
> documented previously, with the difference being we don't reboot after the test
> is completed and the kernel has effectively "crashed" via the sysrq-trigger.
>
> I have appended the serial console output as an attachment. You will see that we
> do not get a final trace printed.
>
> [   98.341743] sysrq: Show State
> [   98.341746] sysrq: Show State
> [   98.341805] sysrq: Show State
> [   98.341808] sysrq: Show State
> [   98.341812] task:systemd         state:S
> [   98.341814] task:systemd         state:S
> [   98.341814]  stack:0     pid:1     tgid:1     ppid:0      flags:0x00000002
> [   98.341818]  stack:0     pid:1     tgid:1     ppid:0      flags:0x00000002
[...]
> [  111.777491]  ? __pfx_hrtimer_wakeup+0x10/0x10
> ** 8555 printk messages dropped **
> [  111.807996]  ? __lruvec_stat_mod_folio+0x86/0xd0
> 

I see. I guess that the panic CPU ended in a deadlock in
console_flush_on_panic() after it ignored the console_lock().
Otherwise, it would have flushed the last messages and rebooted.

Best Regards,
Petr
